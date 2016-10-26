"""
Copyright 2016 Cisco Systems Inc

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
"""

from flask import Flask, request, abort
import json 
import urllib2
import hmac
import hashlib

app = Flask(__name__)

#Secret provided in the Github webhook config. Change this to your own secret phrase
SECRET_TOKEN = "EventsToSparkRoom"

@app.route('/', methods =['POST'])

def githubCommits():
    '''This function validates if the request is properly signed by Github.
       (If not, this is a spoofed webhook).
       Then collects the webhook payload sent from Github and parses the parameters you want to send to Spark Room.
    '''
    headers = request.headers
    incoming_signature = headers.get('X-Hub-Signature')
    signature = 'sha1=' + hmac.new(SECRET_TOKEN, request.data, hashlib.sha1).hexdigest()
    
    if incoming_signature is None:
       abort(401)
    
    elif signature == incoming_signature:
        
        json_file = request.json
        
        
        if 'push' == headers.get('X-GitHub-Event'):
            commit = json_file['commits'][0]
            commit_id = commit['id']
            commit_message = commit['message']
            commit_time = commit['timestamp']
            commit_url = commit['url']
            commit_author_name = commit['author']['name']
            committer_name = commit['committer']['name']
            pusher_name = json_file['pusher']['name']
            repo_name = json_file['repository']['name']
            results = """**Author**: {0}\n\n**Committer**: {1}\n\n**Pusher**: {2}\n\n**Commit Message**: {3}\n\n**Commit id**: {4}\n\n**Time**: {5}\n\n**Repository**: {6}\n\n**Commit Link**: {7}<br><br>""".format(commit_author_name,committer_name,pusher_name,commit_message,commit_id,commit_time,repo_name,commit_url)
            toSpark(results)
            return 'Ok'
            
        elif 'commit_comment' == headers.get('X-GitHub-Event'):
            comment_raw = json_file['comment']
            comment_url = comment_raw['html_url']
            comment_user = comment_raw['user']['login']
            commit_id = comment_raw['commit_id']
            comment = comment_raw['body']
            comment_repo = json_file['repository']['name']
            results = """**User**: {0}\n\n**Comment on Commit**: {1}\n\n**Comment url**: {2}\n\n**Commit id**: {3}\n\n**Repository**: {4}<br><br>""".format(comment_user,comment,comment_url,commit_id,comment_repo)
            toSpark(results)
            return 'Ok'
     
    else:
        print "Spoofed Hook"
        abort(401)
        
        
# POST Function  that sends the commits & comments in markdown to a Spark room    
def toSpark(commits):
    url = 'https://api.ciscospark.com/v1/messages'
    headers = {'accept':'application/json','Content-Type':'application/json','Authorization': 'Bearer BOT_TOKEN'}
    values =   {'roomId':'YOUR_ROOM_ID', 'markdown': commits }
    data = json.dumps(values)
    req = urllib2.Request(url = url , data = data , headers = headers)
    response = urllib2.urlopen(req)
    the_page = response.read()
    return the_page

if __name__ == '__main__':
    app.run(host='0.0.0.0' , port=8080, debug=True)

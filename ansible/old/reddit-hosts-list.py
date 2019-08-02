#!/usr/bin/env python

import json
import argparse
import subprocess

parser = argparse.ArgumentParser(description='Reddit app inventory script')
parser.add_argument('-l',"--list", action='store_true',  help='List hosts in JSON format')
args = parser.parse_args()


if args.list:
   #get gcp instances public ip's
   inv = { "_meta": {
                "hostvars": {
                   "appserver": {
                    },
                   "dbserver": {
                    }
                 }   
            },
            "app": {
            },
            "db": {
            },
            "all": {
                "children": [
                ]
            },
    }
   

   # reddit app instance
   filter_by_tag = 'reddit-app'
   output = subprocess.Popen( ["gcloud", "compute", "instances", "list",\
                              "--format=json", "--filter=tags.items=" + filter_by_tag ],\
                               stdout=subprocess.PIPE ) 
   
   parsed = json.loads((output.communicate()[0]))
   ip =  parsed[0]["networkInterfaces"][0]["accessConfigs"][0]["natIP"]
   
   inv["_meta"]["hostvars"]["appserver"]["ansible_host"] = ip
   inv["app"]["hosts"] = [ "appserver" ]
   inv["all"]["children"].append('app')
    
   #reddit database instance
   filter_by_tag = 'reddit-db'
   output = subprocess.Popen( ["gcloud", "compute", "instances", "list",\
                              "--format=json", "--filter=tags.items=" + filter_by_tag ],\
                               stdout=subprocess.PIPE ) 
   
   parsed = json.loads((output.communicate()[0]))
   ip =  parsed[0]["networkInterfaces"][0]["accessConfigs"][0]["natIP"]
   
   inv["_meta"]["hostvars"]["dbserver"]["ansible_host"] = ip
   inv["db"]["hosts"] = [ "dbserver" ]
   inv["all"]["children"].append('db')


   print json.dumps(inv, indent=4)

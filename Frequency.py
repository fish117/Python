#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Nov 23 20:54:24 2017

@author: wuhao
"""

#2. count frequency of hashtags
import json
from collections import Counter
from pprint import pprint

with open('/Users/wuhao/Desktop/【LEE】Business Analytics Programming/Project Starbucks/tweet_stream_Starbucks_10.json') as f:
    data = json.load(f)
    pprint(data[9])
 
# 2. most frequently #hashtag   
hashtags_list = []
for item in data:
    hashtag = item['entities']['hashtags']
    for x in hashtag:
        hashtags_list.append(x['text'])
print(hashtags_list)
c = Counter(hashtags_list)
c.most_common(10)

# 3. most frequently @usernames
username_list = []
for item in data:
    mentions = item['user']['name']
    username_list.append(mentions)
c = Counter(username_list)
c.most_common(10)

# 4. most frequently person with id
userid_list = []
for item in data:
    mentions = item['user']['id']
    userid_list.append(mentions)
c = Counter(userid_list)
c.most_common(10)

# 5. most influential tweet TBD
count_list = []
for item in data:
    mentions = item['retweet_count']+item['reply_count']+item['quote_count']
    count_list.append(mentions)
count_list.sort()
count_list

c = Counter(count_list)

c.most_common(10)
    
    
    
    

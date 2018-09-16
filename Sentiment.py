#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Nov 23 10:15:27 2017

@author: wuhao
"""

from textblob import TextBlob
with open('/Users/wuhao/Desktop/【LEE】Business Analytics Programming/Project Starbucks/tweet_stream_Starbucks_10000.json') as infile:
    content = infile.read()
    sentences = content.split('\n')

print(len(sentences), sentences[0], sentences[-1], sep="\n")

sub_list = []
pol_list = []
for s in sentences:
    tb = TextBlob(s)
    sub_list.append(tb.sentiment.subjectivity)
    pol_list.append(tb.sentiment.polarity)
#print(sub_list)

#graph
import matplotlib.pyplot as plt

plt.hist(sub_list, bins=20) #, normed=1, alpha=0.75)
plt.xlabel('subjectivity score')
plt.ylabel('sentence count')
plt.grid(True)
plt.savefig('subjectivity.pdf')
plt.show()

plt.hist(pol_list, bins=20) #, normed=1, alpha=0.75)
plt.xlabel('polarity score')
plt.ylabel('sentence count')
plt.grid(True)
plt.savefig('polarity.pdf')
plt.show()
#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Nov 23 09:49:39 2017

@author: wuhao
"""

# define punctuation and digits

import string
p = string.punctuation
d = string.digits

from wordcloud import WordCloud
import matplotlib.pyplot as plt
import nltk


def remove_punctuations(text):
    words = []
    for s1 in text:
        table_p = str.maketrans(p, len(p) * " ")
        #print(type(table_p))
        #print(s1.translate(table_p))
        words.append(s1.translate(table_p))
        #newwords = []
        #for item in words:
            #a = item.split()
            #for x in a:
                #newwords.append(x.lower())
    return words


def remove_digits(text):
    words = []
    for s2 in text:
       table_d = str.maketrans(d, len(d) * " ")
       #print(type(table_d))
       #print(s2.translate(table_d))
       words.append(s2.translate(table_d))
       #newwords = []
       #for item in words:
            #a = item.split()
            #for x in a:
                #newwords.append(x)
    return words


def remove_stopwords(text):
    #words = []
    words_clear = []
    stopwords = nltk.corpus.stopwords.words('english')
    new_stopwords = ['https',' ','false','null','pbs','twimg','profile_images','id','id str','id_str','url','urls','indices','rt','co','setting','desktop','jcajwqjqxv']
    for x in new_stopwords:
        stopwords.append(x)
    #print(type(stopwords), len(stopwords), stopwords, sep="\n")
    for w in text:
        if w not in stopwords and len(w) > 1:
            words_clear.append(w)
    #words_clear = [w for w in words if w not in stopwords and len(w) > 1]
            #newwords = []
            #for item in words_clear:
                #a = item.split()
                #for x in a:
                    #newwords.append(x)
    return words_clear

def frenquency_graph(lst):
    freq = nltk.FreqDist(lst)
    if lst == words5:
        print('text without stopwords')
        freq.plot(20)
    else:
        print('raw text')
        freq.plot(20)


# REALIZATION of Pre-Processing
import json
with open('/Users/wuhao/Desktop/【LEE】Business Analytics Programming/Project Starbucks/tweet_stream_Starbucks_10000.json') as f:
    words1 = []
    content = json.load(f)
    for status in content:
        tweet = status['text']
        text = tweet.split()
        for item in text:
            words1.append(item.lower())
    print(words1)

    
    words2 = remove_punctuations(words1)
    #words2
    
    words3 = remove_digits(words2)
    #words3
    
    words4 = []
    for item in words3:
        a = item.split()
        for x in a:
            words4.append(x)
    #words4
    
    words5 = remove_stopwords(words4)
    #words5    

# Frequency_graph    
    frenquency_graph(words1)
    frenquency_graph(words5)

##########################################################################################
# Wordcloud with stopwords
#text = open('/Users/wuhao/Desktop/【LEE】Business Analytics Programming/Project Starbucks/tweet_stream_Starbucks_100.json').read()
text1 = ''
for word in words1:
    #if len(word) == 1 or word in stopwords:
    #continue
    text1 += ' {}'.format(word)
    
# Generate a word cloud image
wordcloud = WordCloud().generate(text1)

# lower max_font_size
wordcloud = WordCloud(max_font_size=40).generate(text1) 

# Display the generated image:
plt.figure()
plt.imshow(wordcloud)
plt.axis("off")
plt.show()


# Wordcloud without stopwords
text2 = ''
for word in words5:
    #if len(word) == 1 or word in stopwords:
    #continue
    text2 += ' {}'.format(word)
wordcloud2 = WordCloud().generate(text2)
#plt.imshow(wordcloud2)
#plt.axis('off')
wordcloud2 = WordCloud(max_font_size=40).generate(text2)
plt.figure()
plt.imshow(wordcloud2)
plt.axis('off')
plt.show()


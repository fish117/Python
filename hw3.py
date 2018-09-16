
#2017/11/13  Iris Xu (HW3)  72432412
       
#2a.Takes input as the filename in the current directory (as a string)
#2b.Returns a dictionary, which each key is word length and its value is the number of words with that length.
def make_length_wordcount(filename):
    infile=open(filename)
    Lines=infile.read()
    lines=Lines.lower()
    word=lines.split()
    dict1={}
    for i in word:
        
        if len(i) in dict1:
            dict1[len(i)]+=1
        else:
            dict1[len(i)]=1
    
    return dict1
make_length_wordcount('test.txt')
#a.Takes input as the filename in the current directory (as a string)
#b.Returns a dictionary, which each key is a word and its value is the number of occurrences of that word.

def  make_word_count(filename):
    infile=open(filename)
    Lines=infile.read()
    lines=Lines.lower()
    word=lines.split()
    dict2={}
    for i in word:
    
        if i in dict2:
            dict2[i]+=1
        else:
            dict2[i]=1
    return dict2   
make_word_count('test.txt')
#4a.Takes input as the filename in the current directory (as a string)
#4b.Uses the two functions implemented as above – make_length_wordcount() and make_word_count() - to construct (i) length-wordcount dictionary and (ii) word count dictionary.
def analyse_text(filename):
    lcd=make_length_wordcount(filename)
    wcd=make_word_count(filename)
    file=filename[0:-4]
    output=open('{}_analyzed_chang_xu.txt'.format(file),'w')
    
    for key in sorted(lcd):
        output.write('Words of length {} : {}\n'.format(key,lcd[key]))
    for key in sorted(wcd):
        output.write('{} : {}\n'.format(key,wcd[key]))   
    output.close()

analyse_text('test.txt')
analyse_text('frankenstein.txt') 
analyse_text("nasdaq.txt") 
analyse_text("raven.txt")

def  make_length_wordcount(file_name):
    lcd=dict()
    infile=open('file_name','r')
    words=infile.split()
   
    for word in words:
        length=len(word)
        if not len(word) in lcd:
            lcd[length]=1
        else:
            lcd[length]+=1
    return lcd
def  make_word_count(file_name):
    wcd=dict()
    infile=open('file_name','r')
    text=infile.read().lower()
    words=text.split()
    
    for word in words:
        
        if not word in wcd:
            wcd[word]=1
        else:
            wcd[word]+=1
    return wcd  
def analyze_text(file_name):
     length_wordcount_dictionary=make_length_wordcount(file_name)
     word_count_dictionary=make_word_count(file_name)
     newfile=open('{}_analyzed_FIRST_LAST.txt'.format(filename.split('.')[0])
     newfile.write(length_wordcount_dictionary)
     newfile.write(word_count_dictionary)
     
#See http://pymotw.com/2/BaseHTTPServer/
# There is an example of a web server
from BaseHTTPServer import BaseHTTPRequestHandler
import urlparse
import nltk
import pymysql
import json
import StringIO
from nltk.tokenize import sent_tokenize
# import re

class GetHandler(BaseHTTPRequestHandler):
     
    def do_GET(self):
        
        def formatter(msg):
            # msg = msg.decode("utf-8")
            # msg = msg.encode('ascii','xmlcharrefreplace') 
            buf = StringIO.StringIO(msg)
            return buf.readlines()

        def saveToDatabase(user_id,title,description,body):
            connect = pymysql.connect(host="localhost",port=3306,user="root",password="",db="writingTutor")
            cur = connect.cursor()
            #Insert title and the essay discription into the essay table
            query='INSERT INTO `essays`(essay_name,essay_description) VALUES ("{!s}","{!s}")'.format(title,description)
            # print(query) 
            cur.execute(query)
            connect.commit()
            essay_id = cur.lastrowid

            query=('INSERT INTO `user_essay_link`(`fk_user_id`, `fk_essay_id`, `reviewed_status`) '+ 
            'VALUES ({!s},{!s},0)').format(str(user_id),str(essay_id))
            print(query) 
            cur.execute(query)
            connect.commit()
            paragraph_count=1
            paragraph_id = 0  
            newP_count = 1
            #Format of body ['paragraph1\n','paragraph2\n']
            for line in body:
                    line = line.decode("utf-8")
                    line = line.encode('ascii','xmlcharrefreplace') 
                    print(str(line))
                    sentence = nltk.sent_tokenize(line)
                    sentence_count = 1
                    for i in sentence: 
                        newline = ("\n" in i) or (i == body[-1])           
                        print "LAST:" +body[-1]
                        print "CURR:" +i
                        if (newline or newP_count == 1): 
                            query=('INSERT INTO `paragraphs`(fk_essay_id,paragraph_number,paragraph_comment) '+ 
                            'VALUES ("{!s}","{!s}","{!s}")'.format(essay_id,paragraph_count,"None"))
                            print(query) 
                            cur.execute(query)
                            connect.commit()
                            paragraph_count=paragraph_count+1 
                            paragraph_id = cur.lastrowid
                            print("Parid:"+str(paragraph_id))
                            newP_count=newP_count+1
							
                        taglist = [] 
                        sent = i
                        tokenized = nltk.word_tokenize(sent) 
                        tagged = nltk.pos_tag(tokenized)
                        numberOfWords = 0 
                        for taggedWord in tagged:
                            (word,tag)=taggedWord        
                            taglist.append(tag) 
                            # counts number of words in sentence
                            numberOfWords=len(tagged) 
                        i = i.replace('"','\\"')
                        query='INSERT INTO `sentences`(fk_paragraph_id,sentence_number,sentence,tags,total_words,sentence_comment) VALUES ("{!s}","{!s}","{!s}","{!s}","{!s}","{!s}")'.format(paragraph_id-1 if ((newline and newP_count>2)) else paragraph_id,sentence_count,i,taglist,numberOfWords,"None")
                        print(query) 
                        cur.execute(query)
                        connect.commit()
                        sentence_count=sentence_count+1

                        # if numberOfWords > 50:
                        #     query='INSERT INTO `sentences`(fk_paragraph_id,sentence_number,sentence,tags,total_words,sentence_comment) VALUES ("{!s}","{!s}","{!s}","{!s}","{!s}","{!s}")'.format(paragraph_id-1 if ((newline and sentence_count>2)) else paragraph_id,sentence_count,i,taglist,numberOfWords,"Sentence is too long. Vary your essay with the different sentence structures. For example you can use simple sentences to catch the reader's attention, compound sentences to join two related ideas, and complex sentences if ...")
                    
                        #     print(query) 
                        #     cur.execute(query)
                        #     connect.commit()
                        #     sentence_count=sentence_count+1
                        # else if numberOfWords < 3:
                        #     query='INSERT INTO `sentences`(fk_paragraph_id,sentence_number,sentence,tags,total_words,sentence_comment) VALUES ("{!s}","{!s}","{!s}","{!s}","{!s}","{!s}")'.format(paragraph_id-1 if ((newline and sentence_count>2)) else paragraph_id,sentence_count,i,taglist,numberOfWords,"Sentence is too short. Vary your essay with the different sentence structures. Add more meaning to your sentence.")
                    
                        #     print(query) 
                        #     cur.execute(query)
                        #     connect.commit()
                        #     sentence_count=sentence_count+1
                        # else:
                        #     query='INSERT INTO `sentences`(fk_paragraph_id,sentence_number,sentence,tags,total_words,sentence_comment) VALUES ("{!s}","{!s}","{!s}","{!s}","{!s}","{!s}")'.format(paragraph_id-1 if ((newline and sentence_count>2)) else paragraph_id,sentence_count,i,taglist,numberOfWords,"")
                    
                        #     print(query) 
                        #     cur.execute(query)
                        #     connect.commit()
                        #     sentence_count=sentence_count+1
                            
            cur.close()
            connect.close()
   
        def getEssay(essay):
            connect = pymysql.connect(host="localhost",port=3306,user="root",password="",db="writingTutor")
            cur = connect.cursor()
            """
            query=("SELECT group_concat(sentence SEPARATOR '|'),group_concat(sentence_id SEPARATOR '|') " +
                ",group_concat(sentence_comment SEPARATOR '|'),group_concat(sentence_quality SEPARATOR '|') "+
                "FROM sentences,paragraphs,essays WHERE paragraph_id=fk_paragraph_id AND essay_id=fk_essay_id AND essay_id={!s} " +
                "GROUP BY paragraph_id ORDER BY (sentence_number);").format(essay)
            """
            query=("SELECT essay_name,sentence, sentence_id, sentence_comment, sentence_quality,paragraph_id "+
                "FROM sentences, paragraphs, essays WHERE paragraph_id = fk_paragraph_id "+
                "AND essay_id = fk_essay_id AND essay_id = {!s} ORDER BY (sentence_id);").format(essay)
        
            cur.execute(query)
            results = json.dumps(cur.fetchall())
            print("RES:"+str(results)) 
            cur.close()
            connect.close()
            return results

            # basis 1: gets essays for user in question 
            # basis 2: gets students' unannotated essays
            # basis 3: gets all annotated essays by tutors
        def getUserEssayLink(user,basis):
            connect = pymysql.connect(host="localhost",port=3306,user="root",password="",db="writingTutor")
            cur = connect.cursor()
            basis = int(basis)
            query = ""
            if (basis == 1):
                query='SELECT essay_id,essay_name FROM essays,user_essay_link,users WHERE essay_id=fk_essay_id AND user_id=fk_user_id AND user_id=%s' %user
            elif(basis == 2):
                query=('SELECT essay_id,essay_name FROM essays,users,user_type,user_essay_link '+
                'WHERE user_type_id=1 AND reviewed_status=0 AND fk_user_type_id=user_type_id AND fk_user_id=user_id AND fk_essay_id=essay_id')
            elif(basis == 3):
                query=('SELECT essay_id,essay_name FROM essays,users,user_type,user_essay_link '+ 
                'WHERE reviewed_status=1 AND fk_user_type_id=user_type_id AND fk_user_id=user_id AND fk_essay_id=essay_id AND NOT (fk_user_id=%s)' %user)
            print query
            cur.execute(query)
            results = json.dumps(cur.fetchall())
            print("RES:"+str(results)) 
            cur.close()
            connect.close()
            return results

        # def updateEssay(essay,title,description,body):
        #     connect = pymysql.connect(host="localhost",port=3306,user="root",password="",db="writingTutor")
        #     cur = connect.cursor()
        #     query=("DELETE * FROM essays WHERE essay_id={!s}").format(essay)
        #     cur.execute(query)
        #     connect.commit()
        #     saveToDatabase(title,description,body)
        #     cur.close()
        #     connect.close()
            

        parsed_path = urlparse.urlparse(self.path)
         
        var_query_string = parsed_path.query;
        var_query_string_parsed = urlparse.parse_qs(var_query_string)
        # print("VQS:"+str(var_query_string))
        # print("VQSP:"+str(var_query_string_parsed))
        # message = var_query_string
        if 'sentence' in var_query_string_parsed.keys():
            extracted_sentence = str(var_query_string_parsed["sentence"][0])
            
            self.wfile.write("<results></results>")

        if 'essay' in var_query_string_parsed.keys():
            print("VQSP:"+str(var_query_string_parsed))
            essays = var_query_string_parsed["essay"]
            titles = var_query_string_parsed["title"]
            user_id = var_query_string_parsed["userid"]
            
            for essay in essays: 
                essay = formatter(essay)
                print(essay)
                saveToDatabase(user_id[0],titles[0],"None...",essay)

            self.wfile.write("printed just to show it ran")

        if 'essay_by_id' in var_query_string_parsed.keys():
            # print("VQSP:"+int(var_query_string_parsed))
            essay = var_query_string_parsed["essay_by_id"]
            print(essay[0]) #prints essay id to terminal
            self.wfile.write(getEssay(essay[0]))  

        if 'essays_of_user' in var_query_string_parsed.keys():
            # print("VQSP:"+int(var_query_string_parsed))
            user_essay = var_query_string_parsed["essays_of_user"]
            basis = var_query_string_parsed["basis"] 
            self.wfile.write(getUserEssayLink(user_essay[0],basis[0])) 

        if 'test' in var_query_string_parsed.keys():
            # print("VQSP:"+int(var_query_string_parsed))
            test = var_query_string_parsed["test"]
            print(test[0])
            self.wfile.write(formatter(test[0])) 
  
        return

        

if __name__ == '__main__':
    from BaseHTTPServer import HTTPServer
    server = HTTPServer(('localhost', 8080), GetHandler)
    # server = HTTPServer(('localhost', 1049), GetHandler)
    print 'Starting server, use <Ctrl-C> to stop'
    server.serve_forever()

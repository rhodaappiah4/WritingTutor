import csv
import pymysql

def enQuote(arr):
    arr = eval(arr)
    quotedList = []
    for item in arr:
        quotedList.append("'"+item+"'")
    return str(quotedList)

connect = pymysql.connect(host="localhost",port=3306,user="root",password="",db="writingTutor")
cur = connect.cursor()
max_sentence = "SELECT MAX(total_words) FROM sentences"
q=cur.execute(max_sentence)
maximum = cur.fetchone()
maximum=maximum[0]
print maximum
cur.close()
header = ""
count = 0
while (count<maximum):
    header += 'tag'+str(count+1)+','
    count=count+1
header += 'sentence_quality,sentence_score'
cur = connect.cursor()
query="SELECT tags, sentence_quality, sentence_score FROM sentences"
cur.execute(query)
f = open("weka_database.csv", 'wt')
try:
    writer = csv.writer(f)
    # writer.writerow( (i[0] for i in cur.description) )
    headerTuple = tuple(header.strip().split(','))
    print (headerTuple)
    writer.writerow(headerTuple)
    for results in cur.fetchall():
    	(var_tag,var_quality,var_score) = results
        print "VARTAG:"+var_tag
        print "ENQ:"+enQuote(var_tag)
        var_result = eval (enQuote(var_tag))
        # var_result = '"'+var_tag+'"'
        for i in range(len(var_result),maximum):    
            var_result.append('')
        var_result.append(var_quality)
        var_result.append(var_score)
        # print(maximum)
        writer.writerow( (var_result) )

finally:
    f.close()
cur.close()
connect.close()




# coding=utf-8
import binascii,json, urllib2,MySQLdb,sys
'''
Created on 2014年

@author: Administrator
'''




db = MySQLdb.connect("192.168.60.190","root","123456","hotal")


cursor = db.cursor()
cursor.execute('SET NAMES utf8;')
cursor.execute('SET CHARACTER SET utf8;')
cursor.execute('SET character_set_connection=utf8;')
cursor.execute("USE hotal")
sql = ""
b=[]
fp=open("/tmpd/1.txt","r");

for eachline in fp:
    b = eachline.split()
    
     
    if b[18] != '(empty)':
        if b[20] != '(empty)':
            sql = "INSERT INTO firewallb(\
           idauto, dt, dtstr, timeSeconds, priority, \
           operation, messageCode, protocol, srcIp, destIp, \
           srcIPNumber, destIPNumber, srcPort, destPort, destService,\
           direction, flags,command, slot1min,slot5min, \
           slot30min,slot60min) \
           VALUES (\
            %d,'%s', '%s', %d ,'%s', \
            '%s', '%s','%s','%s','%s', \
            %d , %d , %d , %d ,'%s', \
           '%s', '%s','%s',%d,%d,\
           %d,%d)" % \
           (int(b[0]),b[1]+" "+b[2],b[3]+" "+b[4],int(b[5]),b[6],\
            b[7],b[8],b[9],b[10],b[11],\
            int(b[12]),int(b[13]),int(b[14]),int(b[15]),b[16],\
            b[17],b[18]+" "+b[19],b[20]+" "+b[21],\
            int(b[22]),int(b[23]),int(b[24]),int(b[25])) 
        else:
            sql = "INSERT INTO firewallb(\
           idauto, dt, dtstr, timeSeconds, priority, \
           operation, messageCode, protocol, srcIp, destIp, \
           srcIPNumber, destIPNumber, srcPort, destPort, destService,\
           direction, flags,command, slot1min,slot5min, \
           slot30min,slot60min) \
           VALUES (\
            %d,'%s', '%s', %d ,'%s', \
            '%s', '%s','%s','%s','%s', \
            %d , %d , %d , %d ,'%s', \
           '%s', '%s','%s',%d,%d,\
           %d,%d)" % \
           (int(b[0]),b[1]+" "+b[2],b[3]+" "+b[4],int(b[5]),b[6],\
            b[7],b[8],b[9],b[10],b[11],\
            int(b[12]),int(b[13]),int(b[14]),int(b[15]),b[16],\
            b[17],b[18]+" "+b[19],b[20],int(b[21]),\
            int(b[22]),int(b[23]),int(b[24]))
    else:   
        if  b[19] !='(empty)':
            sql = "INSERT INTO firewallb(\
           idauto, dt, dtstr, timeSeconds, priority, \
           operation, messageCode, protocol, srcIp, destIp, \
           srcIPNumber, destIPNumber, srcPort, destPort, destService,\
           direction, flags,command, slot1min,slot5min, \
           slot30min,slot60min) \
           VALUES (\
            %d,'%s', '%s', %d ,'%s', \
            '%s', '%s','%s','%s','%s', \
            %d , %d , %d , %d ,'%s', \
           '%s', '%s','%s',%d,%d,\
           %d,%d)" % \
           (int(b[0]),b[1]+" "+b[2],b[3]+" "+b[4],int(b[5]),b[6],\
            b[7],b[8],b[9],b[10],b[11],\
            int(b[12]),int(b[13]),int(b[14]),int(b[15]),b[16],\
            b[17],b[18],b[19]+" "+b[20],int(b[21]),\
            int(b[22]),int(b[23]),int(b[24])) 
        else:
            sql = "INSERT INTO firewallb(\
           idauto, dt, dtstr, timeSeconds, priority, \
           operation, messageCode, protocol, srcIp, destIp, \
           srcIPNumber, destIPNumber, srcPort, destPort, destService,\
           direction, flags,command, slot1min,slot5min, \
           slot30min,slot60min) \
           VALUES (\
            %d,'%s', '%s', %d ,'%s', \
            '%s', '%s','%s','%s','%s', \
            %d , %d , %d , %d ,'%s', \
           '%s', '%s','%s',%d,%d,\
           %d,%d)" % \
           (int(b[0]),b[1]+" "+b[2],b[3]+" "+b[4],int(b[5]),b[6],\
            b[7],b[8],b[9],b[10],b[11],\
            int(b[12]),int(b[13]),int(b[14]),int(b[15]),b[16],\
            b[17],b[18],b[19],int(b[20]),int(b[21]),\
            int(b[22]),int(b[23])) 
    
    try:
 
        cursor.execute(sql)
 
        db.commit()
    except:
        print sql
        continue
      # db.rollback()

 
      # db.close()
       


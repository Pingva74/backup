#!/bin/python
import os
import zipfile
import ftplib
 

zf = zipfile.ZipFile("backup.zip", "w")
for dirname, subdirs, files in os.walk("/home/alex/bin"):
    zf.write(dirname)
    for filename in files:
        zf.write(os.path.join(dirname, filename))
zf.close()
 
host = "192.168.0.114"
ftp_user = "alex"
ftp_password = "123qaz"
filename = "backup.zip"
 
con = ftplib.FTP(host, ftp_user, ftp_password)
f = open(filename, "rb")
send = con.storbinary("STOR "+ filename, f)
remdir = list(con.nlst())
print(remdir)
if 'backup5.zip' in remdir:
    con.delete('backup5.zip')
    print ('backup5')
if 'backup4.zip' in remdir:
    con.rename('backup4.zip', 'backup5.zip')
    print ('backup4')
if 'backup3.zip' in remdir:
    con.rename('backup3.zip', 'backup4.zip')
    print ('backup3')
if 'backup2.zip' in remdir:
    con.rename('backup2.zip', 'backup3.zip')
    print ('backup2')
if 'backup1.zip' in remdir:
    con.rename('backup1.zip', 'backup2.zip')
    print ('backup1')
if 'backup.zip' in remdir:
    con.rename('backup.zip', 'backup1.zip')
    print ('backup')

print ('-------------------')
print (remdir)

con.close

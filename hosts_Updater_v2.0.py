#0 get `hosts` from https://raw.githubusercontent.com/racaljk/hosts/master/hosts as `githosts`
import requests,shutil,os,time,datetime
res = requests.get("https://raw.githubusercontent.com/racaljk/hosts/master/hosts")
savefile = open("githosts","w")
savefile.write(res.content)
savefile.close()
print ("[status]:"+"get host from github finished !! "  +"(https://raw.githubusercontent.com/racaljk/hosts/master/hosts)")

#1 Intercept the top half of the contents from the local hosts file
import os
temp = open("temp",'w')
file = open("/etc/hosts")
ant = "# Modified Hosts Start"

while 1:
    line = file.readline()

    if ant in line:
        print("[status]:"+"put first part to temp")
        break
    temp.write(line)
    if not line:
        break
file.close()
temp.close()

#2 append the contents witch between the `start` and `end` tags in the githosts to file temp

start = "# Modified Hosts Start"
end = "# Modified Hosts End"
file = open("githosts")
flag = 0

temp = open("temp",'a+')
update = ""
while 1:
    line = file.readline()
    if start in line:
        flag = 1
    if flag == 1:
        temp.write(line)
    if not line:
        break
        pass
    pass # do something
file.close()
temp.close()
print("[status]:"+"add new host part to temp")
print("[status]:"+update)

# 3. change the old `hosts` file
def getCurTime():
    nowTime = time.localtime()
    year = str(nowTime.tm_year)
    month = str(nowTime.tm_mon)
    if len(month) < 2:
        month = '0' + month
    day =  str(nowTime.tm_yday)
    if len(day) < 2:
        day = '0' + day
    return (year + month + day)

os.remove("githosts")
curtime = getCurTime()
backup_path = "/etc/hosts.bak/hosts." + curtime
shutil.copyfile("/etc/hosts", backup_path)
os.remove("/etc/hosts")
shutil.copyfile("temp", "/etc/hosts")
os.remove("temp");
print("[status]:"+"udpate hosts file successfull")

From: aschilt@cox.net (Andrew A. Schilt)
Date: Sat, 01 Apr 2006 15:05:22 +0000
Subject: [lm-sensors] pwmconfig error
Message-Id: <003e01c6559d$b3368940$6401a8c0@Sony1800>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

While running pwmconfig on the latest Fedora Core 5 I received the following
error messages in the script.  I was using the bash shell.

------------------------------
select (1-n):
1) 9191-0290/pwm2      3) Change INTERVAL     5) Save and quit
2) 9191-0290/pwm1      4) Just quit           6) Show configuration
select (1-n): 5

Saving configuration to /etc/fancontrol...
/usr/sbin/pwmconfig: line 468: tempfile: command not found
/usr/sbin/pwmconfig: Cannot create temporary file 
[root at Sony1800 ~]# rpm -qa | grep lm_sensors
lm_sensors-2.9.2-1
[root at Sony1800 ~]#
-----------------------------




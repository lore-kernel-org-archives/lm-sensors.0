From: wing549@earthlink.com (wing549@earthlink.com)
Date: Thu, 19 May 2005 06:23:44 +0000
Subject: help lmsensors
Message-Id: <3E075D5E.1070309@earthlink.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

help, i have a Abit KX7-333r motherboard, i ran sensors-detect and put 
in the modules and it didnt work, then someone on irc, ended up telling 
me to run this options force command, wich worked, but then i messed up 
my linux and had to reformat and install, (i played with fsck :p) well 
now when i run make it gives me this....
[root@localhost lm_sensors-2.7.0]# make
grep: /lib/modules/2.4.18-18.7.x/build/Makefile: No such file or directory
grep: /lib/modules/2.4.18-18.7.x/build/include/linux/autoconf.h: No such 
file or directory
make: *** No rule to make target 
`/lib/modules/2.4.18-18.7.x/build/include/linux/errno.h', needed by 
`prog/detect/i2cdetect.rd'.  Stop.


please help, thanks

ps
i know it works on this motherboard, what is strange though is that when 
  i run sensors it does not give me readings, only worked though gkrellm

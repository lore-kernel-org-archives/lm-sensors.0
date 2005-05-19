From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: Ticket # 1526
Message-Id: <20040118191822.43f7a2d7.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> About the docs :
> FAQ section 4.20 (lm_sensors 2.8.3):
> 
> 4.20 Sensors says `Can't access procfs/sysfs file'
> =========================
> 
>    * (release 2.6.0 and later) Did you `modprobe i2c-proc'? Check
>      `lsmod'.
> 
>    * (release 2.5.5 and earlier) Did you 'modprobe sensors'? Check
>      'lsmod'.
> 
>    * If you did `sensors -s', did you run it as root?
> 
>    * Do you have `/proc' support in your kernel (is `/proc' there?)

You're right, it was damn outdated. I've updated it, if you want to take
a look:
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/lm_sensors-FAQ.html#Section%204.20

> About the rest, sorry for trouble, I usaly tries to find the problem
> myself before I'm going to ask someone for help, I did a little check
> out in my kernel config and ISA was disabled, (...)

The problem was reported many times, so we've changed how dependancies
are handled. Linux 2.6.2 should be better with regards to this topic.

This still doesn't explain why the eeprom driver doesn't work on your
system. Maybe you don't care, but I'm curious, so it'd be great if you
could answer the questions I was asking to you in the ticket:
1* What are the permissions of file /sys/bus/i2c/devices/0-0050/eeprom?
2* Can you send us the contents of this file for analysis?

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

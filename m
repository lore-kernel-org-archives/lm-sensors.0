From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: beeping issues
Message-Id: <20030721094037.55d98610.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi folks,

The three of you reported a similar problem when using lm_sensors. You
complained about your PC beeping as soon as you load the w83781d module.
All of you have an Asus motherboard (P4B533, P4B266 and P4S8X,
respectively) with an AS99127F monitoring chipset.

We lack documentation about the AS99127F, which explains why we are
having difficulties understanding why what happens happens.

I would like you do to some tests to help us find out what the problem
is. Here is a wishlist:

1* The output of sensors (while the PC is beeping).
2* The output of "cat /proc/sys/dev/sensors/as99127f-i2c-0-2d/beep" (or
whatever the file is at for you).
3* Does the beeping stop if you echo "0" to that file?
4* Does the beeping stop if you echo "0 32768" to that file?
5* Does the beeping stop if you echo "0 0" to that file?
6* The output of "cat /proc/sys/dev/sensors/as99127f-i2c-0-2d/alarms"
(or whatever the file is at for you).
7* The output of "i2cdump 0 0x2d" (or whatever the values are supposed
to be on your system). You better unload w83781d before running this
command.

Thanks for your help, I hope we'll find some way to solve the problem. 

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

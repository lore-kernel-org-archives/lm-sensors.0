From: tomov@molbio.mgh.harvard.edu (Vesko T. Tomov)
Date: Thu, 19 May 2005 06:25:53 +0000
Subject: Help getting hardware monitoring on Intel 855PM 82801DBM
Message-Id: <1114109876.6001.26.camel@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

This is a question related to the following thread:
http://archives.andrew.net.au/lm-sensors/msg30983.html .  I have a
similar laptop, Clevo M37EW (Sager NP3790) and followed the advice of
Rudolf Marek and Jean Delvare in an attempt to get temperature
monitoring working.  (1) I activated the SMBus throught the quirks.c
file, (2) ran sensors-detect, (3) found SPD EEPROM which told me that I
have 1024 MB of RAM installed.  I then ran i2cdetect and got a slightly
different output:

# /usr/sbin/i2cdetect -a 0
WARNING! This program can confuse your I2C bus, cause data loss and
worse!
I will probe file /dev/i2c-0.
I will probe address range 0x00-0x7f.
Continue? [Y/n]
        0    1    2    3   4    5    6   7   8    9   a    b     c   d
e    f
00: XX XX XX XX XX XX XX XX 08 XX XX XX XX XX XX XX
10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
30: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
40: XX XX XX XX 44 XX XX XX XX XX XX XX XX XX XX XX
50: XX UU XX XX XX XX XX XX XX XX XX XX XX XX XX XX
60: XX XX XX XX XX XX XX XX XX 69 XX XX XX XX XX XX
70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX

My (ignorant) question is whether the reading at address 0x51 might mean
that some hardware monitoring functionality could be possible.  My guess
is NO, but I just wanted to be sure before I gave up all hope!   

Thanks!!

Vesko



-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050421/3d6ef99b/attachment.html

From: afe0108@yahoo.com (*)
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: support for ivtv drivers?
Message-Id: <20030722041815.57457.qmail@web41801.mail.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello, thanks for your work on i2c!  I have a driver request for i2c
2.8.0, when you have the time to work on it, or if enough other people
request it.  It's for the ivtv drivers, which are for the WinTV PVR-250
(TV card with hardware decoding) which are also used by MythTV:

http://ivtv.sourceforge.net/
http://sourceforge.net/projects/ivtv/

This creates modules named:
msp3400.o saa7115.o tveeprom.o ivtv.o saa7127.o

I think perhaps the msp3400 is also not the same as the one included
with linux.

I tried this weekend to port them using your documention, and got them
to compile, but when I try loading them there are unresolved symbols.
This is the only thing stopping me from going to the 2.5/2.6 kernels.
The ivtv drivers are officially beta, but they seem very stable to me,
and I think there are quite a few people using this card.

Thanks!
Jonah


__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com

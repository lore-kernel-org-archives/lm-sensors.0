From: marcansoft@marcansoft.com (Marcansoft)
Date: Thu, 19 May 2005 06:24:58 +0000
Subject: as99127f PWM kinda working
Message-Id: <40A74A47.6010601@marcansoft.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi! I've been fiddling around with the (in)famous 0x59 register and 
found out the following values do work as a form of coarse pwm:

0x80 - seems to turn fans off after some time(1-2 minutes)... might be 
some form of auto-fan-control based on temp? hmm (Qfan? this mobo is an 
old ASUS, it isn't marketed as Qfan. Maybe some beta pre-attemp at Qfan 
that was dropped at the BIOS)
0x81 - off
0x82 - slightly "on-ner" than off, but my fans do not get to move. I can 
hear the high-pitched PWM sound that motors give off at too-low-pwm.
0x83 - now they do move. Estimate about 70% speed or so.
0x84-0x8f - full on

Changing the high nibble doesn't seem to do much except the high bit 
(0x80) must be set for PWM to work, else the current pwm doesn't seem to 
change.

My mobo is an ASUS A7V266-E. This behaviour is similar to what I got 
with speedfan under Windows, where 0-15% would be off, 15-2x% (can't 
remember the exact value) would be 70% and higher would be full on.

If you need any more information please contact me! By the way, thanks 
for making temperature readings working under Linux, now fix those 2.6 
kernel problems! ;)

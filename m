From: rene.mayrhofer@gibraltar.at (Rene Mayrhofer)
Date: Thu, 19 May 2005 06:24:21 +0000
Subject: vt1211 fan speed control
Message-Id: <3F8C6A50.5080604@gibraltar.at>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear lm-sensors folks, dear Mark,

I own a VIA EPIA M-6000 mainboard, whose hardware sensors are supported 
since lm-sensors 2.8.0 (vt1211) - the version I'm currently using. 
Although I still have to find a formula to get correct CPU temperature 
readings, accessing the sensor values works without a problem (I 
suspected lm-sensors to be the source of some random crashes, but can 
now rule that out).
Maybe it is a stupid question, but does the vt1211 kernel module also 
support writing to the chip registers ? During my quick skim through the 
source code, it appears that it should. But when I try to write values 
to /proc/sys/dev/sensors/vt1211-isa-6000/pwm1 (which reads 255 0), only 
the second value can be modified. After writing something there, it 
always reads 255 (0|1). Maybe I am doing something completely wrong 
here, but the feature list of the vt1211 says that it is able to control 
the speed of the connected fans in 256 steps, so (from parsing through 
the source) I figured that pwm* would be the variables to change. Is 
that supported ? Should changing pwm* work and really change the fan 
speeds ? If not, how can I make that happen (supposing that the vt1211 
fan speed control output are connected on the EPIA, but since it's also 
from VIA itself, that seems likely) ? I am willing to play with the chip 
if VIA is willing to provide a data sheet - some Windows tools like 
Speedfan claim that they are able to control fan speeds on a vt1211. 
However, I would need some pointers how to do that within the lm-sensors 
codes since I've never really looked at them in detail.

with best regards,
Rene

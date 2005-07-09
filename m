From: gabriel.euzet@gmail.com (Gabe)
Date: Sat, 09 Jul 2005 20:24:12 +0000
Subject: [lm-sensors] VT8231 - epia 800
Message-Id: <d5dcbca205070911232ea979f4@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I get the module from http://www.stanford.edu/~amarsh/vt8231/ and compile 
it. All seems to work. But I can get correct values from command "sensors" 
(I've tried th config file from the web site too) :

vt8231-isa-6000
Adapter: ISA adapter
VCore1: +0.30 V (min = +0.13 V, max = +0.14 V) ALARM
+5V: +0.34 V (min = +0.41 V, max = +0.46 V) ALARM
+12V: +1.10 V (min = +0.92 V, max = +1.15 V)
+3.3V: +0.29 V (min = +0.27 V, max = +0.30 V)
fan1: 0 RPM (min = 3006 RPM, div = 2)
fan2: 6182 RPM (min = 3006 RPM, div = 2)
ERROR: Can't get TEMP2 data!
Proc Temp: -0.8?C (high = -1?C, hyst = -1?C)
ERROR: Can't get TEMP4 data!
ERROR: Can't get TEMP5 data!
ERROR: Can't get TEMP6 data!
ERROR: Can't get TEMP7 data!
vid: +1.850 V (VRM Version 9.1)

although, the bios says :

FAN1 : 6241 - 6301 RPM
FAN2 : 0 RPM
12V : 12.13 - 12.19 V
5V : 5.06 - 5.08 V
2.5V : 2.48 V
Vcore : 1.65 V
Internal Vcc : 3.28 V

only fan1 semms correct.

Does somebody have the same card and a correct sensors.conf ?
An other idea to help me ?

Thanks.
Gabe
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050709/213c807e/attachment.html

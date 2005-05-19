From: stefan@networksolutions.se (Stefan Andersson)
Date: Thu, 19 May 2005 06:24:11 +0000
Subject: Problems.
Message-Id: <005601c35d84$f18690a0$c44f5e51@cerebro>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi.. I'm having trouble getting a fair reading ..
I have a ASUS P4S533-X

sensors-detect tells me to use the sis-645 , it87 , i2c-isa modules ...

and then i get this reading:

root@chibisuke:~# sensors
it87-isa-0290
Adapter: ISA adapter
Algorithm: ISA algorithm
VCore 1:   +1.55 V  (min =  +1.42 V, max =  +1.56 V)
VCore 2:   +1.66 V  (min =  +2.40 V, max =  +2.60 V)   ALARM
+3.3V:     +6.04 V  (min =  +3.12 V, max =  +3.44 V)   ALARM
+5V:       +4.99 V  (min =  +4.72 V, max =  +5.24 V)
+12V:      +0.00 V  (min = +11.36 V, max = +12.60 V)   ALARM
-12V:     -27.36 V  (min = -12.63 V, max = -11.41 V)   ALARM
-5V:      -13.64 V  (min =  -5.28 V, max =  -4.81 V)   ALARM
Stdby:     +0.00 V  (min =  +4.72 V, max =  +5.24 V)   ALARM
VBat:      +3.23 V
fan1:     2732 RPM  (min =    0 RPM, div = 2)
fan2:        0 RPM  (min = 3000 RPM, div = 2)          ALARM
fan3:        0 RPM  (min = 3000 RPM, div = 2)          ALARM
Temp1/MB:    +75?C  (min =  +20?C, max =  +40?C)
Temp2/CPU:   +86?C  (min =  +25?C, max =  +45?C)
Temp3:      +127?C  (min =  +25?C, max =  +45?C)


It's not very accurate =)
I hope you can make any sense of this.
If not just ask me ! =)
Thanks !
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20030808/9f426343/attachment.html

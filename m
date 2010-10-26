From: Ed W <lists@wildgooses.com>
Date: Tue, 26 Oct 2010 09:25:53 +0000
Subject: [lm-sensors] Coretemp misreading?
Message-Id: <4CC69EA1.4050501@wildgooses.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi, I have a pair of (identical) new supermicro machines and had some 
significant issues getting accurate temps out of them.  Bios updates 
(betas) have fixed most of them, but I'm finally stuck with the CPU 
temps reading exceptionally high using the kernel coretemp module

Board is the supermicro X8SIE-LN4F.  Processor is an intel L3426 (ie the 
45W part).

Sensors 3.1.2 reads (loaded):

coretemp-isa-0000
Adapter: ISA adapter
Core 0:      +81.0C  (high = +94.0C, crit = +100.0C)

coretemp-isa-0001
Adapter: ISA adapter
Core 1:      +79.0C  (high = +94.0C, crit = +100.0C)

coretemp-isa-0002
Adapter: ISA adapter
Core 2:      +81.0C  (high = +94.0C, crit = +100.0C)

coretemp-isa-0003
Adapter: ISA adapter
Core 3:      +77.0C  (high = +94.0C, crit = +100.0C)

Idle the temps are around 55-60C

There is no bios CPU temp to compare against, all I get is a "Low" 
reading normally, going up to a "Med" reading when the temps are as 
above (there is also a "high", but unknown when that kicks in)

Additionally there are some temps shown through the sensors module 
(these were affected by the bios fixes)

temp1:       +36.0C  (high = +60.0C, hyst = +55.0C)  sensor = thermistor
temp2:       +78.5C  (high = +95.0C, hyst = +92.0C)  sensor = diode
temp3:       +30.0C  (high = +80.0C, hyst = +75.0C)  sensor = thermistor


The bottom one coincides with the bios "System Temp" and is believed to 
be the thermistor at the back of the board.  Unknown what the other two 
are.  The Temp2 tends to look a little like the average of the CPU temps 
though?


Basic sanity check though.  I take the lid off the machine and the 
heatsink is completely cold at idle and slightly warm under load...  I 
have reseated the heatsink on one of the machines as a sanity check, no 
difference.  Both machines are reporting the same range of temperatures 
under similar loads.  I checked temps using kernel 2.6.32 and 2.6.36 
with similar results

My best guess is that the CPU temp sensor is mis-reading.  However, is 
this possible?  I understand the CPU temp is specified as an inversion 
from the max value and hence in any case if the observed temp is wrong 
then the point is still that my "margin" for safety is something like 
the 94C - 81C = 13C from max temp?

This machine needs to last long term, I'm currently a bit worried about 
the reported temps - can anyone please shed some light on whether this 
is just a bad reading and should be ignored?

Thanks

Ed W

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

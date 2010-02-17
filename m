From: Lutz Ballaschke <Lutz.Ballaschke@ebcsoft.de>
Date: Wed, 17 Feb 2010 17:35:21 +0000
Subject: [lm-sensors] Super I/O chip: missing VID base address
Message-Id: <1266428121.8626.73.camel@vierstein>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi there,

i have to program parts of the super I/O chip F71862 from Fintek on a
Jetway J7F2 x86 mini-ITX board. There is an existing linux driver
(f71882fg) which supports the hardware monitoring function of that chip
(FAN, TEMP, PWM) but not the VID function. 
So i started coding to get this VID function working. Unfortunately i
got disappointed the moment i tried to read the base address out of the
VID configuration register: the value is 

0x00 

which i suppose is not the actual IO address, is it? Confused by the
datasheet telling the same i wondered if that means i can't use VID
function or just have to find out the default base address (like 0x3F8
is default for UART which is also part of the F71862 chip)
Any idea?

Thank you very much,

Lutz Ballaschke


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

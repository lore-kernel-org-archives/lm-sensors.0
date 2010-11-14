From: Julian Brunner <julianbrunner@googlemail.com>
Date: Sun, 14 Nov 2010 21:40:13 +0000
Subject: [lm-sensors] Further documentation for w83627hf module
Message-Id: <AANLkTimY3Eu++=eQjR-VG0oOtW_1ko7AkGdcXo=8kBs3@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I'm trying to write an lm-sensors configuration for the mainboard
"Kontron 986LCD-M/mITX", which uses the "Winbond W83627THF" sensor
chip.

I contacted the manufacturer to request information about how the
sensors/fans/voltages are connected to the chip and how to convert the
raw values to sensible information. They sent me a table listing which
sensor/fan/voltage is connected to which pin on the chip, together
with the used resistors and conversion formulas. They table also has a
column saying on which lm-sensors output the sensor/fan/voltage should
appear (inX, fanX, tempX).

Unfortunately, the values that are reported don't match up (for
example, +5V is supposed to appear on in2, although values near 3.26V
are reported). Now, I guess it's possible that they used a different
module or a different version of the same module (to drive the sensor
chip) when they created the table.

So I started looking for information on the "w83627hf" module that I'm
running, to find out which input pins of the sensor chip are mapped to
which lm-sensors outputs. Unfortunately, the documentation I found for
this module (for example, the one at
http://www.lm-sensors.org/browser/lm-sensors/trunk/doc/chips/w83627hf?rev222
(I also checked the one of "w83781d" mentioned there)) doesn't seem to
contain any information on how the sensor chip inputs translate to
lm-sensor outputs.

So, I'd be very thankful for any advice on where to look for
information regarding this mapping from sensor chip inputs to
lm-sensor outputs.

Thanks in advance,
 Julian Brunner

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

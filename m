From: Jeff Sadowski <jeff.sadowski@gmail.com>
Date: Tue, 08 Feb 2011 03:08:42 +0000
Subject: [lm-sensors] Intel BOXDH57DD driver?
Message-Id: <AANLkTimuGHXHLovH57zR3tC3v1Gf7gyPgr10Zoc7i-kR@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Kernel version:
2.6.35
lmsensors version
sensors version 3.1.2 with libsensors version 3.1.2


I'd like to write a driver for my motherboards Temperature/Voltage
monitoring. I have an Intel BOXDH57DD motherboard. When I run
"sensors-detect" I get

Driver `to-be-written':
 * ISA bus, address 0x680
   Chip `Nuvoton W83677HG-I Super IO Sensors' (confidence: 9)

I've looked on the net for some more information and found some links
to this mailing list. In one post the guy did a "modprobe w83627ehf
force_id=0xa510" and was able to read some of his info I did this as
well and see some of my sensors. Now I'd like to improve upon this. I
downloaded the source code for w83627ehf and have been rummaging
through it and looking at how it is put together.

I also took notes of what my motherboard showed in the bios

CPU Core Temperature 32.0 C
PCH Temperature 59.00 C
VR Temperature 56.00 C
Memory Temperature 24.50 C
+12V  12.203V
+5V  5.189V
+3.3V  3.427V
+1.5V  1.476V
CPU 1 Vccp  1.84V
CPU Fan 0977

It looked like it was going to be a real pain to add another
temperature sensor to the w83627ehf driver and I was wondering if
there is a way to write a non kernel module driver. I'd like to get to
the raw reported info and I could dissect it do calculations on it and
then report that. I have some experience writing drivers but not a
lot. I wrote my own driver for my desktop aviator 2040 (posted on
ubuntuorums.org) and I wrote a driver for my Vernier Go!Temp with help
from Vernier (posted on fedoraforums.org). I think I could help with a
kernel module as well but I'd need to do some real studying of your
project. I could not follow the w83627ehf driver source code. It was
too complicated for me to follow without knowing more info.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: andrea.gozzi@linuxrevolution.eu (Andrea Gozzi)
Date: Thu, 20 Jul 2006 06:31:25 +0000
Subject: [lm-sensors] M/B Sensor not working correctly
Message-Id: <1153377085.14535.13.camel@osmosis.gnet.eu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi.
I'm having some troubles with my motherboard sensor that seems to be
badly configured.
The board in question is a _VIA Technologies, Inc. VT8378 [KM400/A]_ and
I'm using the _it87-isa-0290_ driver.

These are two outputs of 'sensors', just a few seconds apart:

Adapter: ISA adapter
VCore 1:   +1.52 V  (min =  +1.42 V, max =  +1.57 V)
VCore 2:   +2.50 V  (min =  +2.40 V, max =  +2.61 V)
fan1:     1757 RPM  (min = 1298 RPM, div = 8)
fan2:     5113 RPM  (min = 4017 RPM, div = 8)
M/B Temp:    +65?C  (low  =   +15?C, high =   +40?C)   sensor = diode
CPU Temp:    +51?C  (low  =   +25?C, high =   +60?C)   sensor = diode


Adapter: ISA adapter
VCore 1:   +1.54 V  (min =  +1.42 V, max =  +1.57 V)
VCore 2:   +2.51 V  (min =  +2.40 V, max =  +2.61 V)
fan1:     1776 RPM  (min = 1298 RPM, div = 8)
fan2:     5113 RPM  (min = 4017 RPM, div = 8)
M/B Temp:    +86?C  (low  =   +15?C, high =   +40?C)   sensor = diode
CPU Temp:    +52?C  (low  =   +25?C, high =   +60?C)   sensor = diode

I would say there is definitely something wrong with the M/B sensor.
I tried changing the type to 'thermistor' but then the sensor was
displaying a fixed temperature of 127?C.
BTW the cpu's sensor works all right, I checked with the BIOS values.

Any suggestions to make the M/B sensor work?
Thanks

Andrea



-- 
Andrea Gozzi <andrea.gozzi at linuxrevolution.eu>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: This is a digitally signed message part
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060720/18274a41/attachment.bin 

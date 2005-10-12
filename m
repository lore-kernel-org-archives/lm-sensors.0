From: roger@planbit.co.uk (Roger Lucas)
Date: Wed, 12 Oct 2005 16:22:17 +0000
Subject: [lm-sensors] Running lm-sensors on EPIA 5000 with Debian SARGE 2.6
Message-Id: <20051012133202.9303523324@box1.planbit.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I am working with Debian SARGE on a 2.6.8-2 kernel installation and, thanks
to Aaron Marsh, I now have a working vt8231 driver in my system.  (If anyone
has had problems compiling it for Debian Sarge then I can happily mail you a
copy of mine
).

 

I noticed that the vt8231 driver would not start if the i22-viapro module
was installed. I suspect this is because they both try and control the same
PCI device (the VT8231 chip) and therefore you can only have one installed
at a time.  If you install the i2c-viapro first then the vt8231 driver never
gets started and you never get the temp/voltage information.

 

The i2c-viaprobe driver allows the i2c bus to be accessed, so if it is
installed then I can see the RAMs that are on the bus.  If I remove the
i2c-viapro and install the vt8231 then I get the voltage and temperature
information.

 

Here are my questions:

 

1)       Does anyone know what the plan is for combining the vt8231 and
i2c-viapro modules so that a single module can access both the I2C bus and
the temperature/voltage information at the same time ?

2)       Does anyone know the CORRECT information for the scaling
coefficients for the temperature and voltage ?

 

If it helps any, below are the raw numbers that I get from my box:

 

edensnake:~# cat /sys/bus/i2c/drivers/vt8231/1-6000/*_input

0                                  // fan1

0                                  // fan2

204                               // in0

202                               // in1

201

120

213

201                               // in5

2040                             //temp2

747                               //temp3

0

0

0

0                                  // temp7

edensnake:~# 

 

They seem reasonable given the range that things should be running over, but
I don?t want to try and guess at the correct conversion table.  I have tried
the table from Aaron Marsh?s site
(http://www.stanford.edu/~amarsh/vt8231/sensors.conf) but that gives me the
result below, which looks a bit wrong to me
 (although they do seem to
fairly closely match what others have seen:
http://archives.andrew.net.au/lm-sensors/msg18667.html)

 

edensnake:~# sensors

vt8231-isa-6000

Adapter: ISA adapter

VCore1:    +0.30 V  (min =  -0.05 V, max =  +0.39 V)

+5V:       +0.23 V  (min =  -0.08 V, max =  +0.56 V)

+12V:      +1.09 V  (min =  -0.18 V, max =  +1.34 V)

fan1:        0 RPM  (min =    0 RPM, div = 2)

fan2:        0 RPM  (min =    0 RPM, div = 2)

ERROR: Can't get TEMP2 data!

Proc Temp:  -1.4?C  (high =    -3?C, hyst =    -1?C)

ERROR: Can't get TEMP4 data!

ERROR: Can't get TEMP5 data!

ERROR: Can't get TEMP6 data!

ERROR: Can't get TEMP7 data!

vid:      +2.050 V  (VRM Version 8.2)

edensnake:~#

 

Thanks in advance,

 

Roger Lucas

-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20051012/6e02b885/attachment.html

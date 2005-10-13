From: roger@planbit.co.uk (Roger Lucas)
Date: Thu, 13 Oct 2005 16:14:09 +0000
Subject: [lm-sensors] Running lm-sensors on EPIA 5000 with Debian SARGE 2.6
Message-Id: <20051013132410.A106423295@box1.planbit.co.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051012133202.9303523324@box1.planbit.co.uk>
In-Reply-To: <20051012133202.9303523324@box1.planbit.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have done some more digging including probing voltages on the Eden 5000
MoBo.

 

IN0 is connected to the 12v rail using a potential divider from R54/R55.
The scaling factor is 0.1754.

IN1 is connected to the 5v rail using a potential divider from R51/R52.  The
scaling factor is 0.4167.

IN2 is connected to the 2.5v rail using a potential divider from R56/R57.
The scaling factor is 0.833.

IN3 is directly connected to the Vcore rail (1.2v).  The scaling factor is
1.000.

IN4 is unknown

IN5 is connected to the 3.3v rail within the VT8231.  The scaling factor is
0.6296.

 

The information in the sensors.conf file from Aaron Marsh is basically
correct here, but the INx values are in the wrong sequence.  This is
probably because he has set them up for a different motherboard.

 

The temperature information in TEMP2 appears to be useless as it is the
full-scale value and never changes.

 

The information in TEMP3 seems to be very different to that from any
information I could find on the WWW.  After placing a temperature probe at
the base of the CPU heatsink, then heating the whole heatsink with a
hairdryer and waiting for everything to stabilise, I was able to generate a
graph of the TEMP3 value against the register value (see below chart).

 


Temp (centigrade)

Register Value


33.9

725


34.1

712


34.8

735


35.5

732


36.5

745


40

760


41.6

780


42.5

780


44

807


45.6

817


46.1

825


46.3

812


47.1

820


47.9

830


50

865


52.9

862


53

887


53.9

870


55

882


56

890


57.1

907


58

925


61

935


62

942


63

962


64.2

950


65.5

975


66.9

980


70.5

997


70.5

997

 

This is basically linear (y=mx+c).  If temp=y, register=x then m=0.128 and
c=-58.

 

I?m not posting a sensors.conf file as I cannot get the ?sensors?+?vt8231?
combination to work properly.  For some reason, sensors insists on scaling
all the input values by 1/1000 and vt8231.c handles reads/writes of the max
and min settings differently (it divides all writes to max or min by 10
before applying them).  I cannot see any reason for this behaviour ? if
someone can enlighten me then please do, but it seems a bit weird from where
I am standing.  Also, ?sensors? complains about not being able to access
procfs/sysfs for writing even though the file system exists and is writable
(I have written the files directly when testing), even though it does manage
to write some of the max/min settings.

 

Given that lm-sensors is going through a major re-write through kernel
2.6.11 and the vt8231/viapro functionality isn?t integrated, it seems
pointless to expend major effort here as it will soon be obsolete ? I am
using a script and accessing the /sys/bus/i2c/
.. files directly to
determine what is going on.  I plan to move to the 2.6.11+ kernel as soon as
Debian takes it to stable from testing (I cannot install testing on my board
as the install crashes).

 

Hopefully this is of some use to someone, as I couldn?t find this kind of
information when I was looking.

 

Regards,

 

Roger

 

  _____  

From: lm-sensors-bounces@lm-sensors.org
[mailto:lm-sensors-bounces@lm-sensors.org] On Behalf Of Roger Lucas
Sent: 12 October 2005 15:22
To: lm-sensors@lm-sensors.org
Subject: [lm-sensors] Running lm-sensors on EPIA 5000 with Debian SARGE 2.6

 

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
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20051013/291d02a8/attachment-0001.html

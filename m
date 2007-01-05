From: r.marek@assembler.cz (Rudolf Marek)
Date: Fri, 05 Jan 2007 22:50:28 +0000
Subject: [lm-sensors] Tyan S2696 and ADT7470
Message-Id: <459ED634.70709@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <E1H1lxZ-0002Zb-00@smtp.tt-solutions.com>
In-Reply-To: <E1H1lxZ-0002Zb-00@smtp.tt-solutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Thanks for the reports. Unfortunately none of us - Me, Jean or David does not
have any time to write new drivers. We may help answering the questions or give
the hints to start the development but that is all we can do now.

Maybe you or your company can fund the driver devel? Hw/Money/whatever?

For a start someone could look at all those ADT74XX devices, compare the
datasheets and check if they are register compatible? Or at least some of them.
Then the driver could be developed.

>  First of all, I'm using 2.6.20-rc3 with the svn version of lm-sensors and
> the patches
> 
> http://lists.lm-sensors.org/pipermail/lm-sensors/2006-December/018420.html
> http://lists.lm-sensors.org/pipermail/lm-sensors/2006-October/018128.html
> 
> (coretemp and *_msr visibility). The kernel was built with standard Debian
> options using gcc 4.1.

Ok


>  Now my problem is that I'm trying to set up lm-sensors on a machine using
> Tyan Tempest i5000XT motherboard (also known as S2696, please see
> http://www.tyan.com/products/html/tempesti5000xt.html). It has, according
> both to the specifications and sensors-detect output, not one but 2
> hardware monitoring chips: W83627EHG and ADT7470:
> 
> 	# sensors-detect
> 	...
> 	Now follows a summary of the probes I have just done.
> 	Just press ENTER to continue:
> 
> 	Driver `to-be-written' (should be inserted):
> 	  Detects correctly:
> 	  * Bus `SMBus I801 adapter at 18c0'
> 	    Busdriver `i2c-i801', I2C address 0x2e
> 	    Chip `Analog Devices ADT7470' (confidence: 5)
> 	  * Chip `Intel AMB FB-DIMM thermal sensor' (confidence: 9)

Wow :) Even the FB-DIMM are there.

> 
> 	Driver `w83627ehf' (should be inserted):
> 	  Detects correctly:
> 	  * ISA bus, address 0xc00
> 	    Chip `Winbond W83627EHF/EHG Super IO Sensors' (confidence: 9)
> 
> 	Driver `coretemp' (should be inserted):
> 	  Detects correctly:
> 	  * Chip `Intel Core family thermal sensor' (confidence: 9)
> 
> Unfortunately it looks that the case fans -- which create the deafening
> noise making the machine all but unusable currently -- are connected to
> ADT7470 and not the W83627EHG because
> 
> 	# sensors
> 	coretemp-isa-0000
> 	Adapter: ISA adapter
> 	temp1:       +29 C  (high =   +85 C)
> 
> 	coretemp-isa-0001
> 	Adapter: ISA adapter
> 	temp1:       +33 C  (high =   +85 C)
> 
> 	coretemp-isa-0002
> 	Adapter: ISA adapter
> 	temp1:       +32 C  (high =   +85 C)
> 
> 	coretemp-isa-0003
> 	Adapter: ISA adapter
> 	temp1:       +33 C  (high =   +85 C)
> 
> 	w83627ehf-isa-0c00
> 	Adapter: ISA adapter
> 	VCore:     +1.21 V  (min =  +0.00 V, max =  +1.74 V)
> 	in1:       +8.29 V  (min = +13.46 V, max = +13.36 V) ALARM
> 	AVCC:      +3.31 V  (min =  +3.87 V, max =  +4.02 V) ALARM
> 	3VCC:      +3.33 V  (min =  +2.91 V, max =  +2.93 V) ALARM
> 	in4:       +1.26 V  (min =  +2.00 V, max =  +1.87 V) ALARM
> 	in5:       +1.60 V  (min =  +1.86 V, max =  +1.50 V) ALARM
> 	in6:       +5.02 V  (min =  +3.23 V, max =  +4.56 V) ALARM
> 	VSB:       +3.28 V  (min =  +0.69 V, max =  +3.06 V) ALARM
> 	VBAT:      +1.52 V  (min =  +2.16 V, max =  +2.48 V) ALARM
> 	in9:       +1.09 V  (min =  +0.78 V, max =  +1.52 V)
> 	Case Fan:    0 RPM  (min = 3515 RPM, div = 128) ALARM
> 	CPU Fan:  2083 RPM  (min = 5921 RPM, div = 4) ALARM
> 	Aux Fan:     0 RPM  (min =  811 RPM, div = 128) ALARM
> 	fan5:        0 RPM  (min = 168750 RPM, div = 8) ALARM
> 	Sys Temp:    +39 C  (high =   -65 C, hyst =   -75 C)   ALARM
> 	CPU Temp:  +34.5 C  (high = +80.0 C, hyst = +75.0 C)
> 	AUX Temp:  +33.5 C  (high = +80.0 C, hyst = +75.0 C)
> 
> (notice the zeros for the case and aux fans). Unsurprisingly, running
> pwmconfig or writing directly to the files mentioned in Documentation/
> hwmon/w83627ehf doesn't affect these fans. More surprisingly, it doesn't
> seem to affect the CPU fan(s) neither but I don't care much about it as
> they're not very noisy anyhow. I care a lot about the 2 case fans though so
> I'd just like to ask if I am doing something wrong with w83627ehf or is it
> just that my guess that these fans are handled by ADT470 is correct?

Yes they are handled via this chip, the temperature used to drive those chips is
obtained from some other simple sensors, strategically placed on different
places on motherboard.

>  And, in the latter case, is there any hope for ADT7470 support? I'd be
> very willing to help as much as I can but unfortunately I don't really know
> much about this stuff so I'm afraid I have no chance without some/lots of
> guidance. Of course, I'd be also happy to provide any additional
> information that might help.

If you know how to code in C it should not be a problem to write a driver.

You can use also following commands to reprogram the fans to manual mode:

http://www.analog.com/en/prod/0,2877,ADT7470,00.html

CHeck page 23 of datasheet.

Register 0x68 0x69 are controlling the manual/auto mode
Registers 0x32-0x34 controls the duty cycle.

This sequence will put the chip into manual mode (first two lines)
Last 4 lines set the duty cycle to 50%. This should shut up the fans.

i2cset -y 0 0x2e 0x68 0x0
i2cset -y 0 0x2e 0x69 0x0
i2cset -y 0 0x2e 0x32 0x80
i2cset -y 0 0x2e 0x33 0x80
i2cset -y 0 0x2e 0x34 0x80
i2cset -y 0 0x2e 0x35 0x80

Inspect the fans to see if they are still spinning sufficiently after this!

Hope it helps for a start.

Rudolf




From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:23 +0000
Subject: ticket 1415
Message-Id: <20031031055254.GA20640@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F95168B.5040305@yahoo.com.au>
In-Reply-To: <3F95168B.5040305@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Trevor:

Please, send only plain text email!

* TN <tnuro@yahoo.com.au> [2003-10-31 10:20:49 +1100]:

>    The  temperature readings I am getting are definately too low, despite
>    variances  like  bios  loading  vs  linux  loading while observing the
>    readings, as I take the readings as soon as the OS or bios has booted,
>    and so I don't believe the CPU can change temperatures by such a large
>    gap in such a short time.

I have a power measuring device which tells me that one of my computers
uses ~55 watts at idle but ~80 watts when in the BIOS screen.  Cup your
hand over a 25 watt light bulb and turn it on, then you'll believe...

>    lm-sensors on my P4 2.8 says about 30c. Bios says about 40-42, which I
>    believe  is  more  like  it,  maybe even then a little low based on my
>    experience with all our other machines.
>    I've  had  a  quick rummage around in the w83627hf.c code, and I can't
>    see  anywhere  where  the CPUTIN offset register is added into the raw
>    reading  from CPUTIN, and neither can I see the other offset registers
>    for  SYSTIN & VTIN being added in to SYSIN, VTIN. Am I blind & haven't
>    read the code right ?

The way I read the datasheet, the value of the offset registers are added to
the raw temp readings by the sensor chip itself.  This is bizarre, I've never
seen another chip do that.  I haven't tested this theory yet though...

>    When I do a isadump on reg 0x55, bank 4, my CPUTIN offset is 0x11.
>    What  has  written  this  value  into this register, is it the bios or
>    somewhere in the lm-sensors modules ?

Just checking, but you did this?

# isadump 0x295 0x296 4 0x4e

Mine reads 0x11 too.  But, the reported value of 38C looks ok for me.  Also,
my VTIN offset is 0xfe, which is ridiculous unless it's interpreted as a 
signed value (two's complement)... in which case it's -2.  And furthermore,
what's the scaling?  Two of the temps report 9 bits for LSB of 0.5C.  So
are those offset regs 1C/bit or 0.5C/bit?

Who knows?  The datasheet is very ambiguous about all that.  Some time this
weekend I'll modify the driver to poke some values in there and see what
happens.

In any event, whatever programmed h/w offset is redundant anyway because
you can get the same result by modifying the compute lines of sensors.conf.

And BTW: here is my current sensors.conf with some comments about what
I'll be working on...

# P4C800E-Deluxe

chip "w83627thf-*"

# VOLTAGES
	label in0 "VCORE"
	#(TODO) the following compute line is b0rk...
	#compute in0 (0.488 * @ / 100) + 0.69 , (@ - 0.69) * 100 / 0.488

	label in1 "+12V"
	compute in1 3.8 * @ ,  @ / 3.8
	set in1_min 12.0 * 0.90
	set in1_max 12.0 * 1.10

	label in2 "+3.3V"
	set in2_min 3.3 * 0.95
	set in2_max 3.3 * 1.05

	label in3 "+5V"
	compute in3 1.68 * @ , @ / 1.68
	set in3_min 5.0 * 0.95
	set in3_max 5.0 * 1.05

	ignore in4
	ignore in5
	ignore in6

	label in7 "5VSB"
	compute in7 1.68 * @ , @ / 1.68
	set in7_min 5.0 * 0.95
	set in7_max 5.0 * 1.05

	# (TODO) driver needs to enable this one...
	label in8 "VBat"
	set in8_min 3.0 * 0.80
	set in8_max 3.0 * 1.20

# FANS
	label fan1 "Chassis Fan"
	ignore fan1
	set fan1_div 8
	set fan1_min 1500

	label fan2 "CPU Fan"
	set fan2_div 4
	set fan2_min 2000

	label fan3 "Power Fan"
	set fan3_div 8
	set fan3_min 1500

# TEMPS
	label temp1 "M/B Temp"
	set temp1_over 50
	set temp1_hyst 45

	label temp2 "CPU Temp"
	set temp2_over 60
	set temp2_hyst 55

	label temp3 "PWR Temp"
	ignore temp3
	set temp1_over 50
	set temp1_hyst 45

# OTHER
	# (TODO) vid technically not supported...
	ignore vid

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

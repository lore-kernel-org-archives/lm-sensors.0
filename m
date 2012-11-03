From: Ian Pilcher <arequipeno@gmail.com>
Date: Sat, 03 Nov 2012 18:23:37 +0000
Subject: Re: [lm-sensors] Temperature sensors changed by BIOS update
Message-Id: <k73nev$2d3$1@ger.gmane.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------020702020502000903030409"
List-Id: <lm-sensors.vger.kernel.org>
References: <k554s3$g79$1@ger.gmane.org>
In-Reply-To: <k554s3$g79$1@ger.gmane.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------020702020502000903030409
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On 10/11/2012 03:33 AM, Guenter Roeck wrote:
> Ok, then I guess it is more likely that the change was triggered by the BIOS
> update. Interesting.

Attached is a config file for Intel DQ67SW boards with newer BIOSes.

-- 
========================================================================
Ian Pilcher                                         arequipeno@gmail.com
Sometimes there's nothing left to do but crash and burn...or die trying.
========================================================================

--------------020702020502000903030409
Content-Type: text/plain; charset=UTF-8;
 name="dq67sw-new.conf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dq67sw-new.conf"

################################################################################
#
#
#	lm_sensors configuration for Intel DQ67SW (with newer BIOS)
#
#	NOTES:
#
#		Temperature input mappings were changed by a BIOS update
#		between SWQ6710H.86A.0050.2011.0401.1409 (01-Apr-2011) and
#		SWQ6710H.86A.0065.2012.0917.1519 (17-Sep-2012).
#
#		Minimum and maximum values are the defaults from BIOS version
#		SWQ6710H.86A.0065.2012.0917.1519 (17-Sep-2012).
#
#		Intel Desktop Utilities 3.2.3.052 appears to get its default
#		values from the BIOS.
#
#		"FRONT" and "REAR" fan labels correspond to the motherboard
#		headers, but not necessarily the actual fan locations.
#
#		Minimum fan RPMs should be adjusted to reflect the behavior of
#		the installed fans.
#
#		"Memory DIMM Temperature" is presumably measured by a diode
#		somewhere in the vicinity of the DIMM slots; "System Temperature
#		might be a better name.  If this is correct, 90 degrees seems
#		like an extremely high threshhold for this reading.
#
#		All hysteresis values are set to 75 degrees, which seems to be
#		the default for the chip/driver.
#
#
################################################################################

chip "nct6775-*"

	ignore	cpu0_vid

	########################################################################
	#
	#	Voltages
	#
	########################################################################

	#
	# Processor Vcc
	#
	label	in0		"VCORE"
	set	in0_min		0.2
	set	in0_max		1.6

	#
	# +12 Volts
	#
	label	in1		"+12V"
	compute	in1		16*@, @/16
	set	in1_min		10.8
	set	in1_max		13.2

	#
	# AVCC(?) - Not shown in BIOS or IDU; min/max taken from +3.3V
	#
	label	in2		"AVCC"
	set	in2_min		3.1
	set	in2_max		3.5

	#
	# +3.3 Volts
	#
	label	in3		"+3.3V"
	set	in3_min		3.1
	set	in3_max		3.5

	#
	# +5 Volts
	#
	label	in4		"+5V"
	compute	in4		4*@, @/4
	set	in4_min		4.7
	set	in4_max		5.3

	#
	# Memory Vcc
	#
	label	in5		"+1.5V"
	set	in5_min		1.4
	set	in5_max		1.6

	#
	# PCH Vcc
	#
	label	in6		"PCH"
	set	in6_min		0.6
	set	in6_max		1.6

	#
	# +3.3 Volt Standby
	#
	label	in7		"VSB"
	set	in7_min		3.0
	set	in7_max		3.6

	#
	# VBAT(?) - Not shown in BIOS or IDU; min/max taken from old BIOS
	#
	label	in8		"VBAT"
	#set	in8_min		2.7
	#set	in8_max		3.3

	########################################################################
	#
	#	Fans
	#
	########################################################################

	ignore	fan4

	#
	# Chassis Inlet Fan
	#
	label	fan1		"FRONT"
	set	fan1_min	250		# from IDU (BIOS does not set)

	#
	# Processor Fan
	#
	label	fan2		"CPU"
	set	fan2_min	250		# from IDU (BIOS does not set)

	#
	# Chassis Outlet Fan
	#
	label	fan3		"REAR"
	set	fan3_min	250		# from IDU (BIOS does not set)

	########################################################################
	#
	#	Temperatures
	#
	########################################################################

	ignore	temp3
	ignore	temp8

	#
	# Memory DIMM Temperature
	#
	label	temp1		"DIMM"
	set	temp1_max	90
	set	temp1_max_hyst	75

	#
	# VR Temperature
	#
	label	temp2		"VR"
	set	temp2_max	90
	set	temp2_max_hyst	75

	#
	# Processor Temperature
	#
	label	temp6		"CPU"
	set	temp6_max	99
	set	temp6_max_hyst	75

	#
	# PCH Temperature
	#
	label	temp7		"PCH"
	set	temp7_max	114
	set	temp7_max_hyst	75

--------------020702020502000903030409
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------020702020502000903030409--


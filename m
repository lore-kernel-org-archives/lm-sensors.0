From: Ian Pilcher <arequipeno@gmail.com>
Date: Mon, 11 Apr 2011 22:21:29 +0000
Subject: [lm-sensors] Intel DQ67SW configuration
Message-Id: <invuta$76b$1@dough.gmane.org>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------090703080309090903070906"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------090703080309090903070906
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Configuration file is attached.

-- 
========================================================================
Ian Pilcher                                         arequipeno@gmail.com
"If you're going to shift my paradigm ... at least buy me dinner first."
========================================================================

--------------090703080309090903070906
Content-Type: text/plain;
 name="dq67sw.conf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="dq67sw.conf"

################################################################################
#
#
#	lm_sensors configuration for Intel DQ67SW
#
#	NOTES:
#
#		BIOS = SWQ6710H.86A.0050.2011.0401.1409 (01-Apr-2011)
#
#		IDU = Intel Desktop Utilities version 3.1.3.030
#			(Windows 7 Professional SP1, 64-bit)
#
#		The minimum, maximum, and hysteresis values are generally the
#		more conservative of the IDU- or BIOS-provided values.
#
#		"FRONT" and "REAR" fan labels correspond to the motherboard
#		headers, but not necessarily the actual fan locations.
#
#		Minimum fan RPMs should be adjusted to reflect the behavior of
#		the installed fans.
#
#		"Memory DIMM Temperature" is presumably measured by a diode
#		somewhere in the vicinity of the DIMM slots; "System Temperature
#		might be a better name.
#
#		80 degrees Celcius might be a bit high for the "Memory DIMM
#		Temperature" limit.
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
	set	in0_min		0.2		# from IDU (BIOS = 0.00)
	set	in0_max		1.6		# from IDU (BIOS = 1.74)

	#
	# +12 Volts
	#
	label	in1		"+12V"
	compute	in1		16*@, @/16
	set	in1_min		10.8		# from IDU (BIOS does not set)
	set	in1_max		13.2		# from IDU (BIOS does not set)

	#
	# AVCC(?) - Not shown in BIOS or IDU
	#
	label	in2		"AVCC"
	set	in2_min		3.1		# same as +3.3V (BIOS = 2.98)
	set	in2_max		3.5		# same as +3.3V (BIOS = 3.63)

	#
	# +3.3 Volts
	#
	label	in3		"+3.3V"
	set	in3_min		3.1		# from IDU (BIOS = 2.98)
	set	in3_max		3.5		# from IDU (BIOS = 3.63)

	#
	# +5 Volts
	#
	label	in4		"+5V"
	compute	in4		4*@, @/4
	set	in4_min		4.7		# from IDU (BIOS does not set)
	set	in4_max		5.3		# from IDU (BIOS does not set)

	#
	# SDRAM Vcc
	#
	label	in5		"+1.5V"
	set	in5_min		1.4		# from IDU (BIOS does not set)
	set	in5_max		1.6		# from IDU (BIOS does not set)

	#
	# PCH Vcc
	#
	label	in6		"PCH"
	set	in6_min		0.6		# from IDU (BIOS does not set)
	set	in6_max		1.6		# from IDU (BIOS does not set)

	#
	# +3.3 Volt Standby
	#
	label	in7		"VSB"
	set	in7_min		3.0		# from IDU (BIOS = 2.98)
	set	in7_max		3.6		# from IDU (BIOS = 3.63)

	#
	# VBAT(?) - Not shown in BIOS or IDU
	#
	label	in8		"VBAT"
	#set	in8_min		2.7		# from BIOS
	#set	in8_max		3.3		# from BIOS

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

	ignore	temp8

	#
	# Memory DIMM Temperature
	#
	label	temp1		"DIMM"
	set	temp1_max	80		# same as VR (IDU = 90)
	set	temp1_max_hyst	75		# same as VR

	#
	# VR Temperature
	#
	label	temp2		"VR"
	set	temp2_max	80		# from BIOS (IDU = 90)
	set	temp2_max_hyst	75		# from BIOS

	#
	# Processor Temperature
	#
	label	temp3		"CPU"
	set	temp3_max	80		# from BIOS (IDU = 87)
	set	temp3_max_hyst	75		# from BIOS

	#
	# PCH Temperature
	#
	label	temp4		"PCH"


--------------090703080309090903070906
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------090703080309090903070906--


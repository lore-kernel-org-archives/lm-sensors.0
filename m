From: Who Carez? <responder@pacanka.com>
Date: Mon, 27 Aug 2012 13:28:00 +0000
Subject: [lm-sensors] Configuration file for Intel DQ67EP Mini-ITX board
Message-Id: <503B75E0.8080006@pacanka.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------010904060108000208060502"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------010904060108000208060502
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: quoted-printable

Hello,

Attached, you will find the .conf file I use for my DQ67EP. Here are the=20
results I get, with i3-2100t.

First raw:

Adapter: ISA adapter
in0:            +0.76 V  (min =3D  +0.00 V, max =3D  +1.74 V)
in1:            +0.77 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
in2:            +3.41 V  (min =3D  +2.98 V, max =3D  +3.63 V)
in3:            +3.41 V  (min =3D  +2.98 V, max =3D  +3.63 V)
in4:            +1.28 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
in5:            +1.47 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
in6:            +1.04 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
in7:            +3.30 V  (min =3D  +2.98 V, max =3D  +3.63 V)
in8:            +3.20 V  (min =3D  +2.70 V, max =3D  +3.30 V)
fan1:             0 RPM  (min =3D    0 RPM, div =3D 128)
fan2:           937 RPM  (min =3D    0 RPM, div =3D 32)  ALARM
fan3:             0 RPM  (min =3D    0 RPM, div =3D 128)
fan4:             0 RPM  (div =3D 128)
SYSTIN:         +35.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  ALAR=
M  sensor=20
=3D diode
CPUTIN:         +38.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sens=
or =3D diode
PECI Agent 0:   +36.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sens=
or =3D=20
Intel PECI
PCH_CHIP_TEMP:  +51.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)
PECI Agent 1:    +0.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)
cpu0_vid:      +0.000 V
intrusion0:    OK

and now, with the attached file:

Adapter: ISA adapter
Vcore:        +0.77 V  (min =3D  +0.60 V, max =3D  +1.60 V)
+12V:        +12.29 V  (min =3D +11.14 V, max =3D +12.93 V)
AVCC:         +3.41 V  (min =3D  +2.98 V, max =3D  +3.63 V)
+3.3V:        +3.41 V  (min =3D  +2.98 V, max =3D  +3.63 V)
+5V:          +5.12 V  (min =3D  +4.70 V, max =3D  +5.31 V)
+1.5V:        +1.47 V  (min =3D  +1.40 V, max =3D  +1.60 V)
PCH:          +1.04 V  (min =3D  +0.60 V, max =3D  +1.60 V)
3VSB:         +3.30 V  (min =3D  +2.98 V, max =3D  +3.63 V)
Vbat:         +3.20 V  (min =3D  +2.70 V, max =3D  +3.30 V)
Rear fan:       0 RPM  (min =3D  251 RPM, div =3D 128)
CPU fan:      958 RPM  (min =3D  251 RPM, div =3D 32)
DIMM temp:    +36.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor=
 =3D diode
VR temp:      +38.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor=
 =3D diode
CPU temp:     +36.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  sensor=
 =3D Intel PECI
PCH temp:     +52.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)
intrusion0:  OK

Please see the file.

If you have any questions, just reply. :)

HTH,

[d]

--------------010904060108000208060502
Content-Type: text/plain; charset=windows-1252;
 name="inteldq67ep.conf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="inteldq67ep.conf"

# Created for board DQ67EP using information from Intel Desktop Utilities and BIOS
# "FRONT" and "REAR" fan labels correspond to the motherboard
# headers, but not necessarily the actual fan locations.

chip "nct6775-isa-0290"

# Fans
        label fan1 "Rear fan"
        set fan1_min 250 # From IDU

        label fan2 "CPU fan"
        set fan2_min 250 # From IDU

	# There is no fan3 on the board
	ignore fan3

	# There is no fan4 on the board
	ignore fan4

# Voltages

	# Processor Vcc
	label	in0		"Vcore"
	set	in0_min 	0.6 # From IDU
	set	in0_max 	1.6 # From IDU
	
	# This should be "12 Volts", but computations are strange
	label	in1		"+12V"
	compute	in1		16*@, @/16
	set	in1_min		11.1 # From IDU
	set	in1_max		12.9 # From IDU

	# AVCC(?) - Not shown in BIOS or IDU
	label	in2		"AVCC"
	set	in2_min		3.1		# same as +3.3V
	set	in2_max		3.5		# same as +3.3V

	# +3.3 Volts
	label	in3		"+3.3V"
	set	in3_min		3.1		# from IDU
	set	in3_max		3.5		# from IDU

	# +5 Volts
	label	in4		"+5V"
	compute	in4		4*@, @/4
	set	in4_min		4.7		# from IDU
	set	in4_max		5.3		# from IDU

	# Memory Vcc ("SDRAM Vcc" in IDU)
	label	in5		"+1.5V"
	set	in5_min		1.4		# from IDU
	set	in5_max		1.6		# from IDU

	# PCH Vcc
	label	in6		"PCH"
	set	in6_min		0.6		# from IDU
	set	in6_max		1.6		# from IDU

	# +3.3 Volt Standby
	label	in7		"3VSB"
	set	in7_min		3.1		# from IDU
	set	in7_max		3.5		# from IDU

	# VBAT(?) - Not shown in BIOS or IDU
	label	in8		"Vbat"

	# It shows +2.050 V, seems to be not used
	ignore	cpu0_vid

#	Temperatures

	# Labeled as "SYSTIN"
	# Guess!
	label	temp1		"DIMM temp"
	set	temp1_max 	80		# From IDU
	set	temp1_max_hyst 	75		# From IDU

	# Labeled as "CPUTIN"
	label	temp2		"VR temp"
	set	temp2_max 	80		# From IDU
	set	temp2_max_hyst 	75		# From IDU

	# Labeled as "PECI Agent 0"
	# Guess!
	label	temp3		"CPU temp"
	set	temp3_max 	80		# From IDU
	set	temp3_max_hyst 	75		# From IDU

	# Labeled as "PCH_CHIP_TEMP"
	label	temp7		"PCH temp"

	# Labeled as "PECI Agent 1"
	# Not used
	ignore	temp8


--------------010904060108000208060502
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------010904060108000208060502--

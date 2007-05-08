From: "Sasha Alexandr" <tsassgirl@hotmail.com>
Date: Tue, 08 May 2007 20:13:29 +0000
Subject: [lm-sensors] MSI-6580/845PE Max v2.0 sensors.conf file
Message-Id: <BAY140-F269F3E6237D16DA3E7E094B9440@phx.gbl>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi people! To whom it may concern: keep up the excellent work on the 
lm_sensors project :)
Here's my tiny contribution, my sensors.conf file. While it is relatively 
simple, I had a near-impossible time finding close matches to my own machine 
for comparison, so for others with the same/similar machine, I hope that 
this helps you :)
The resulting outputs match my BIOS screen perfectly, though I am not 100% 
certain what 'Vcore_2' is reading -- either CPU core voltage #2, or maybe 
North Bridge voltage?
And all the other readings are available in the BIOS except Rear Case Fan, 
which the BIOS doesn't report, but IS readable with lm_sensors.
Enjoy!

# File begins:
# Machine: MSI-6580 i845PE Max V2.0 w/Intel P4 Williamette 1.8 Ghz
# Stock CPU Speed = 1804 Mhz Overclocked to 2410 Mhz
# i82801 ICH4 (North Bridge?)
# BIOS - AMIBIOS 63-4000-001109-00101111-040201-845GE/PE-16580000
# Contrib: Sasha GrapefruiTgirl - tsassgirl at hotmail dot com
#----------------------------------------------------------------
# setting up temp sensor types (thermistor is default):
# 1 = PII/Celeron Diode
# 2 = 3904 transistor;
# 3435 = thermistor with Beta
# adjust vrm if your vid is wrong; see doc/vid
# CPU Temp reading is offset 10'C from BIOS reading; fixed
# 3.0V and 3.3V are switched around in BIOS and LM_sensors; fixed
# Other sensors appear unused; ignore them if desired;
#----------------------------------------------------------------

    chip          "w83627hf-isa-0290"
    set vrm 9.0

    label vid     "(BIOS) VCore ID"
    label clock	  "CPU MHz"

    label temp1   "System Temp"
	set temp1_over 45
	set temp1_hyst 40

    label temp2   "Northbridge Temp"
	set temp2_over 55
	set temp2_hyst 52

    label temp3   "CPU Temp"
	compute temp3 (@ - 10),(@ + 10)
	set temp3_over 55
	set temp3_hyst 52

    label fan1    "CPU Fan RPM"
	set fan1_div 4
	set fan1_min 2000

    label fan2    "Rear Fan RPM"
	set fan2_div 4
	set fan2_min 2000

    ignore fan3

    label in0    "CPU VCore 1"
	set in0_min vid * 0.95
	set in0_max vid * 1.025

    label in1    "CPU VCore 2"
	set in1_min vid * 0.95
	set in1_max vid * 1.025

    label in2    "+3.0V CMOS Bat"
        set in2_min 3.0 * 0.95
	set in2_max 3.0 * 1.05

    label in3    "+5V"
	compute in3 ((6.8/10)+1)*@ , @/((6.8/10)+1)
	set in3_min 5.0 * 0.95
	set in3_max 5.0 * 1.05

    label in4    "+12V"
	compute in4 ((28/10)+1)*@ , @/((28/10)+1)
	set in4_min 12 * 0.90
	set in4_max 12 * 1.10

    label in5    "-12V"
	compute in5 (5.14 * @) - 14.91 , (@ + 14.91) / 5.14
	set in5_max -12 * 0.90
	set in5_min -12 * 1.10

    label in6    "-5V"
	compute in6 (3.14 * @) - 7.71 , (@ +  7.71) / 3.14
        set in6_max -5 * 0.95
	set in6_min -5 * 1.05

    label in7    "+5.0V SB"
	compute in7 ((6.8/10)+1)*@ , @/((6.8/10)+1)
        set in7_min 5 * 0.95
	set in7_max 5 * 1.10

    label in8    "+3.3V"
	set in8_min 3.3 * 0.980
	set in8_max 3.3 * 1.02

# EOF

_________________________________________________________________
http://www.imagine-windowslive.com/Themes/Messenger/Reward/Default.aspx?Locale=en-CA#


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

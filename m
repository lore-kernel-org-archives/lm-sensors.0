From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:25:36 +0000
Subject: Asus P4C800-E Deluxe/Winbond W83627THF issue
Message-Id: <20050206205855.GA4565@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <200502022021.06992.wik@blueyonder.co.uk>
In-Reply-To: <200502022021.06992.wik@blueyonder.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rik:

* Rik Ryall <wik@blueyonder.co.uk> [2005-02-02 20:21:06 +0000]:
> I'm running Suse 9.2 Pro with a 2.6.8 kernel (2.6.8-24.11-smp to be precise) 
> and whilst I've made /some/ progress with getting sensors to work, I seem to 
> be getting less positive results than I did on my previous 2.4-based build.

Looks like Jean already helped you to get the right versions.

I have the very same mainboard, and here's my sensors(1) output:
(Note: I have an external temperature probe on temp3, you may want to ignore)

w83627thf-isa-0290
Adapter: ISA adapter
VCORE:     +1.57 V  (min =  +1.46 V, max =  +1.60 V)              
+12V:     +11.73 V  (min = +10.82 V, max = +13.19 V)              
+3.3V:     +3.25 V  (min =  +3.14 V, max =  +3.47 V)              
+5V:       +5.08 V  (min =  +4.76 V, max =  +5.24 V)              
V5SB:      +4.95 V  (min =  +4.76 V, max =  +5.24 V)              
CPU Fan:  2250 RPM  (min = 1997 RPM, div = 4)                     
Power Fan:1962 RPM  (min = 1493 RPM, div = 8)                     
M/B Temp:    +28?C  (high =   +50?C, hyst =   +40?C)   sensor = thermistor           
CPU Temp:  +36.0?C  (high =   +75?C, hyst =   +65?C)   sensor = thermistor           
AMB Temp:  +20.5?C  (high =   +40?C, hyst =   +35?C)   sensor = thermistor           
vid:      +1.525 V  (VRM Version 9.0)
alarms:   
beep_enable:
          Sound alarm enabled

Here's the relevant part of my /etc/sensors.conf:

chip "w83627thf-*"

# OTHER
	set vrm 9.0

# VOLTAGES
	label in0 "VCORE"
	set in0_min vid * 0.95
	set in0_max vid * 1.05

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

	label in7 "V5SB"
	compute in7 1.68 * @ , @ / 1.68
	set in7_min 5.0 * 0.95
	set in7_max 5.0 * 1.05

	#label in8 "VBat"
	#set in8_min 3.0 * 0.80
	#set in8_max 3.0 * 1.20
	ignore in8

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
	set temp1_hyst 40
	label temp2 "CPU Temp"
	set temp2_over 75
	set temp2_hyst 65
	label temp3 "AMB Temp"
	set temp3_over 40
	set temp3_hyst 35
	#label temp3 "PWR Temp"
	#ignore temp3
	#set temp3_over 60
	#set temp3 hyst 50

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

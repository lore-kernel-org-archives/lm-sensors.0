From: "Dominik Egert" <dominik.egert@gmx.de>
Date: Wed, 05 Mar 2014 08:55:43 +0000
Subject: Re: [lm-sensors] sensors.conf for Gigabyte B75-D3V
Message-Id: <000f01cf3850$b1c04260$1540c720$@gmx.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----=_NextPart_000_0010_01CF3859.13901C10"
List-Id: <lm-sensors.vger.kernel.org>
References: <005901cf33ae$ccc48130$664d8390$@gmx.de>
In-Reply-To: <005901cf33ae$ccc48130$664d8390$@gmx.de>
To: lm-sensors@vger.kernel.org

This is a multipart message in MIME format.

------=_NextPart_000_0010_01CF3859.13901C10
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit

Hello,

i've corrected the errors and the beeping stopped. - Thank you for helping
me out. 
Also I answered your questions. - See below.
And I somehow mixed up the temps. - Should be correct now.

I've attached the new config file.

Greetings.


> Hi Dominik,
> 
> On Fri, 28 Feb 2014 11:18:46 +0100, Dominik Egert wrote:
> > Sorry for the malformed configuration file. - I am really having
> > trouble with the configuration, as it seems.
> > After checking back to the machine running this configuration, I
> > noticed it was beeping. - Unstoppable beeping every time I set the
> > min/max values by calling sensors -s
> >
> > Could you give me a hint on what I am doing wrong, please.
> > (BTW: I recognized the in0_min and in0_max are not taken into
> > account.)
> 
> Bug in your config file, see below. Possibly responsible for the beeping
BTW.
> 
> > Sensors -v: sensors version 3.3.2 with libsensors version 3.3.2 (on
> > Debian, from package)
> >
> > Sorry for this long mail.
> >
> > The config:
> > ######################
> > # libsensors configuration file
> > # -----------------------------
> > #
> > #  For the Gigabyte B75-D3V Rev: 1.2
> > #
> > #
> > #
> >
> >
> > ##############################################
> > chip "it8728-isa-0a30"
> >
> > ########
> > # Fans
> > label fan1 "CPU-Fan"
> > set fan1_min 1000
> >
> > label fan2 "System Fan 1"
> > set fan2_min 450
> >
> > ignore fan3 #"System Fan 2"
> > set fan3_min 450
> 
> You shouldn't set a minimum for a fan you ignore. If it triggers an alarm,
you
> won't see it.

Removed and corrected.

> 
> >
> > label fan4 "System Fan 3"
> > set fan4_min 450
> >
> > ignore fan5 #"Chassis Fan"
> >
> > ################
> > # Temperatures
> > label temp1 "CPU Chip Temperature"
> > set temp1_min 10
> > set temp1_max 60
> > set temp1_offset 55
> 
> This offset looks plain wrong.
> 

Removed and corrected.

> >
> > ignore temp2 #"Unknown"
> 
> What value did it display?

It always shows 25. - No matter if room-temp is at 5 or at 30. 
I guess this is no sensible reading.

> 
> > label temp3 "System Temperature"
> 
> PECI sensors are typically for the CPU or the PCH chipset, so I very much
> doubt this can be the (ambient) system temperature.

Ok. - Maybe this is the Chipset-Temp. - It's close to the ambient temp I
measured with an external thermometer.
That's why I thought it could be the ambient temp.
After investigating, I mixed them up. - see new config file.

> 
> > set temp3_min 10
> > set temp3_max 55
> > set temp3_offset 50
> 
> PECI offsets should be set by the BIOS, you shouldn't have to do that.
> 

Removed and corrected.

> >
> > ############
> > # Voltages
> 
> I am curious how you found the mappings and scaling factors?
> 

It seems the typical scaling factors for it87xx-chips on gigabyte-boards.
At least that's what I found on the net.
So I gave it a shot and tested the calculators on different inputs until I
got sensible readings.
Then I took my multimeter and checked if the values matched or were close to
the calculated values.

> > label in0 "Vtt"
> > set in0_min 1.020
> > set in0_max 1.080
> >
> > label in1 "+3.3V"
> > set in1_min 3.135
> > set in1_max 3.465
> > compute in1 1.635*@,@/1.635
> >
> > label in2 "+12V"
> > set in2_min 11.400
> > set in2_max 12.600
> > compute in2 6.0*@,@/6.0
> >
> > label in3 "+5V"
> > set in3_min 4.750
> > set in3_max 5.250
> > compute in3 2.5*@,@/2.5
> >
> > label in4 "Vaxg IGD"
> > set in4_min 0.800
> > set in4_max 1.000
> >
> > label in5 "CPU Vcore"
> > set in5_min 0.750
> > set in5_max 1.150
> >
> > label in6 "Dram Voltage"
> > set in6_min 1.450
> > set in6_max 1.550
> >
> > label in7 "3.3 VSB"
> > set in7_min 3.150
> > set in7_max 3.450
> 
> These limits should not be stricter than the ones of +3.3V. They should be
> the same.

Corrected.
> 
> >
> > label in8 "Vbat"
> > set in0_min 2.700
> > set in0_max 3.300
> 
> You really mean in8_min and and in8_max here!
> 

Yes, correct. - Thank you. I did not see this.
Corrected.

> >
> > # Other sensor readings
> > label intrusion0 "Chassis Open"
> > set intrusion0_alarm 0
> >
> >
> > ##############################################
> > chip "coretemp-*"
> >
> > label temp1 "CPU Chip Temperature"
> 
> Technically this is the "CPU Package Temperature".

Renamed, thank you.

> 
> > label temp2 "CPU Core 1 Temperature"
> > label temp3 "CPU Core 2 Temperature"
> >
> >
> > ##############################################
> > chip "pkg-*"
> >
> > label temp1 "ACPI Thermal CPU"
> >
> >
> 
> This value has nothing to do with ACPI, so the label is wrong. You might
as
> well drop this section anyway, as this driver will soon stop instantiating
a
> hwmon device.

OK. - corrected.

> 
> > ##############################################
> > chip "acpitz-virtual-0"
> >
> > label temp1 "ACPI Thermal Zone 0 Temp1"
> > label temp2 "ACPI Thermal Zone 0 Temp2"
> > ######################
> >
> >
> > The Output of sensors, sensors -u, sensors -s, sensors -u After
> > sensors -s the beeping starts. - But why?
> 
> Either because of the wrong in0 limits, or because of the odd temperature
> offsets, or because of the unmet fan3_min (can't tell as long as it is
ignored in
> the configuration file - remove the ignore statement for diagnostics.)
> 
> --
> Jean Delvare
> http://jdelvare.nerim.net/wishlist.html

------=_NextPart_000_0010_01CF3859.13901C10
Content-Type: application/octet-stream;
	name="GB-B75-D3V.conf"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="GB-B75-D3V.conf"

# libsensors configuration file=0A=
# -----------------------------=0A=
#=0A=
#  For the Gigabyte B75-D3V Rev: 1.2=0A=
#=0A=
#=0A=
#=0A=
=0A=
	######################################=0A=
	# VOLTAGES                           #=0A=
	# These figures are from estimations #=0A=
	# based on values provided in BIOS.  #=0A=
	# This means that some of them may   #=0A=
	# be mixed up.                       #=0A=
	######################################=0A=
=0A=
=0A=
##############################################=0A=
chip "it8728-isa-0a30"=0A=
=0A=
########=0A=
# Fans=0A=
label fan1 "CPU-Fan"=0A=
set fan1_min 1000=0A=
=0A=
label fan2 "System Fan 1"=0A=
set fan2_min 450=0A=
=0A=
label fan3 "System Fan 2"=0A=
set fan3_min 450=0A=
=0A=
label fan4 "System Fan 3"=0A=
set fan4_min 450=0A=
=0A=
ignore fan5 #"Chassis Fan" # It is not connected, no pinout available.=0A=
=0A=
=0A=
################=0A=
# Temperatures=0A=
label temp1 "System Temperature"=0A=
set temp1_min 10=0A=
set temp1_max 60=0A=
=0A=
ignore temp2 =0A=
#label temp2 "Unknown" # Does not seem to give sensible data (Always =
shows 25)=0A=
=0A=
label temp3 "Chipset Temperature"=0A=
set temp3_min 10=0A=
set temp3_max 55=0A=
=0A=
=0A=
############=0A=
# Voltages=0A=
label in0 "Vtt"=0A=
set in0_min 1.020=0A=
set in0_max 1.080=0A=
=0A=
label in1 "+3.3V"=0A=
set in1_min 3.3 * 0.95=0A=
set in1_max 3.3 * 1.05=0A=
compute in1 1.635*@,@/1.635=0A=
=0A=
label in2 "+12V"=0A=
set in2_min 12.0 * 0.95=0A=
set in2_max 12.0 * 1.05=0A=
compute in2 6.0*@,@/6.0=0A=
=0A=
label in3 "+5V"=0A=
set in3_min 5.0 * 0.95=0A=
set in3_max 5.0 * 1.05=0A=
compute in3 2.5*@,@/2.5=0A=
=0A=
label in4 "Vaxg IGD"=0A=
set in4_min 0.800=0A=
set in4_max 1.000=0A=
=0A=
label in5 "CPU Vcore"=0A=
set in5_min 0.750=0A=
set in5_max 1.150=0A=
=0A=
label in6 "Dram Voltage"=0A=
set in6_min 1.450=0A=
set in6_max 1.550=0A=
=0A=
label in7 "3.3 VSB"=0A=
set in7_min 3.3 * 0.95=0A=
set in7_max 3.3 * 1.05=0A=
=0A=
label in8 "Vbat"=0A=
=0A=
# Other sensor readings=0A=
label intrusion0 "Chassis Open"=0A=
#set intrusion0_alarm 0=0A=
=0A=
=0A=
##############################################=0A=
chip "coretemp-*"=0A=
=0A=
label temp1 "CPU Package Temperature"=0A=
label temp2 "CPU Core 1 Temperature"=0A=
label temp3 "CPU Core 2 Temperature"=0A=
=0A=
=0A=
##############################################=0A=
chip "pkg-*"=0A=
=0A=
# This does not work.=0A=
ignore temp1=0A=
=0A=
=0A=
##############################################=0A=
chip "acpitz-virtual-0"=0A=
=0A=
ignore temp1=0A=
#label temp1 "ACPI Thermal Zone 0 Temp1" # Shows always 27.8=0A=
=0A=
ignore temp2=0A=
#label temp2 "ACPI Thermal Zone 0 Temp2" # Shows always 29.8=0A=

------=_NextPart_000_0010_01CF3859.13901C10
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
------=_NextPart_000_0010_01CF3859.13901C10--


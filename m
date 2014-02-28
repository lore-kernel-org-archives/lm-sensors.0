From: "Dominik Egert" <dominik.egert@gmx.de>
Date: Fri, 28 Feb 2014 10:18:46 +0000
Subject: Re: [lm-sensors] sensors.conf for Gigabyte B75-D3V
Message-Id: <001801cf346e$77f781f0$67e685d0$@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <005901cf33ae$ccc48130$664d8390$@gmx.de>
In-Reply-To: <005901cf33ae$ccc48130$664d8390$@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

> On Thu, Feb 27, 2014 at 08:55:47PM +0100, Jean Delvare wrote:
> > Hi Guenter,
> >=20
> > On Thu, 27 Feb 2014 09:52:42 -0800, Guenter Roeck wrote:
> > > On Thu, Feb 27, 2014 at 06:20:54PM +0100, Jean Delvare wrote:
> > > > First time I see this. I don't know which driver does this but this
> > > > looks pretty wrong, "pkg" is way too generic as a device name. This
> > > > should be fixed quickly.
> > >
> > > Not sure, but it might come in through
drivers/thermal/x86_pkg_temp_thermal.c.
> > > It registers thermal zones named pkg-temp-<processor id>.
> >=20
> > A name with a dash, that's bad. What about catching (and rejecting)
> > these in hwmon_device_register_with_groups?
> >=20
> They are calling hwmon_device_register(), so we don't see the name
> and it would not help. The entire hwmon initialization sequence
> from thermal is kind of upside down (hwmon device registration
> and attribute handline is pretty much independent of each other),
> so changing to the new API would be all but impossible.
>=20
> Anyway, I think it is a good idea to add a validation to the new API.
> I'll implement it and submit a patch when I find a few minutes.
>=20
> Of course even that won't help much to prevent hyper-generic names
> like the above from being introduced. pkg ? what pkg ?


Hi everyone,

Maybe this helps your development process.

Sorry for the malformed configuration file. - I am really having trouble
with the configuration, as it seems.=20
After checking back to the machine running this configuration, I noticed it
was beeping. - Unstoppable beeping every time I set the min/max values by
calling sensors -s

Could you give me a hint on what I am doing wrong, please.
(BTW: I recognized the in0_min and in0_max are not taken into account.)
Sensors -v: sensors version 3.3.2 with libsensors version 3.3.2 (on Debian,
from package)

Sorry for this long mail.

The config:
######################
# libsensors configuration file
# -----------------------------
#
#  For the Gigabyte B75-D3V Rev: 1.2
#
#
#


##############################################
chip "it8728-isa-0a30"

########
# Fans
label fan1 "CPU-Fan"
set fan1_min 1000

label fan2 "System Fan 1"
set fan2_min 450

ignore fan3 #"System Fan 2"
set fan3_min 450

label fan4 "System Fan 3"
set fan4_min 450

ignore fan5 #"Chassis Fan"

################
# Temperatures
label temp1 "CPU Chip Temperature"
set temp1_min 10
set temp1_max 60
set temp1_offset 55

ignore temp2 #"Unknown"

label temp3 "System Temperature"
set temp3_min 10
set temp3_max 55
set temp3_offset 50

############
# Voltages
label in0 "Vtt"
set in0_min 1.020
set in0_max 1.080

label in1 "+3.3V"
set in1_min 3.135
set in1_max 3.465
compute in1 1.635*@,@/1.635

label in2 "+12V"
set in2_min 11.400
set in2_max 12.600
compute in2 6.0*@,@/6.0

label in3 "+5V"
set in3_min 4.750
set in3_max 5.250
compute in3 2.5*@,@/2.5

label in4 "Vaxg IGD"
set in4_min 0.800
set in4_max 1.000

label in5 "CPU Vcore"
set in5_min 0.750
set in5_max 1.150

label in6 "Dram Voltage"
set in6_min 1.450
set in6_max 1.550

label in7 "3.3 VSB"
set in7_min 3.150
set in7_max 3.450

label in8 "Vbat"
set in0_min 2.700
set in0_max 3.300

# Other sensor readings
label intrusion0 "Chassis Open"
set intrusion0_alarm 0


##############################################
chip "coretemp-*"

label temp1 "CPU Chip Temperature"
label temp2 "CPU Core 1 Temperature"
label temp3 "CPU Core 2 Temperature"


##############################################
chip "pkg-*"

label temp1 "ACPI Thermal CPU"


##############################################
chip "acpitz-virtual-0"

label temp1 "ACPI Thermal Zone 0 Temp1"
label temp2 "ACPI Thermal Zone 0 Temp2"
######################


The Output of sensors, sensors -u, sensors -s, sensors -u
After sensors -s the beeping starts. - But why?
######################
coretemp-isa-0000
Adapter: ISA adapter
CPU Chip Temperature:    +38.0=B0C  (high =3D +85.0=B0C, crit =3D +105.0=B0=
C)
CPU Core 1 Temperature:  +38.0=B0C  (high =3D +85.0=B0C, crit =3D +105.0=B0=
C)
CPU Core 2 Temperature:  +36.0=B0C  (high =3D +85.0=B0C, crit =3D +105.0=B0=
C)

it8728-isa-0a30
Adapter: ISA adapter
Vtt:                   +1.07 V  (min =3D  +0.00 V, max =3D  +3.06 V)
+3.3V:                 +3.36 V  (min =3D  +0.00 V, max =3D  +5.00 V)
+12V:                 +11.95 V  (min =3D  +0.00 V, max =3D +18.36 V)
+5V:                   +5.07 V  (min =3D  +0.00 V, max =3D  +7.65 V)
Vaxg IGD:              +0.88 V  (min =3D  +0.00 V, max =3D  +3.06 V)
CPU Vcore:             +0.89 V  (min =3D  +0.00 V, max =3D  +3.06 V)
Dram Voltage:          +1.54 V  (min =3D  +0.00 V, max =3D  +3.06 V)
3.3 VSB:               +3.36 V  (min =3D  +0.00 V, max =3D  +6.12 V)
Vbat:                  +3.19 V
CPU-Fan:              2122 RPM  (min =3D    0 RPM)
System Fan 1:         1201 RPM  (min =3D    0 RPM)
System Fan 3:         1203 RPM  (min =3D    0 RPM)
CPU Chip Temperature:  +25.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C=
)  sensor =3D
thermistor
System Temperature:    +29.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C=
)  sensor =3D
Intel PECI
Chassis Open:         OK

acpitz-virtual-0
Adapter: Virtual device
ACPI Thermal Zone 0 Temp1:  +27.8=B0C  (crit =3D +106.0=B0C)
ACPI Thermal Zone 0 Temp2:  +29.8=B0C  (crit =3D +106.0=B0C)

pkg-temp-0-virtual-0
Adapter: Virtual device
temp1:        +37.0=B0C
######################

######################
coretemp-isa-0000
Adapter: ISA adapter
CPU Chip Temperature:
  temp1_input: 37.000
  temp1_max: 85.000
  temp1_crit: 105.000
  temp1_crit_alarm: 0.000
CPU Core 1 Temperature:
  temp2_input: 37.000
  temp2_max: 85.000
  temp2_crit: 105.000
  temp2_crit_alarm: 0.000
CPU Core 2 Temperature:
  temp3_input: 37.000
  temp3_max: 85.000
  temp3_crit: 105.000
  temp3_crit_alarm: 0.000

it8728-isa-0a30
Adapter: ISA adapter
Vtt:
  in0_input: 1.068
  in0_min: 0.000
  in0_max: 3.060
  in0_alarm: 0.000
  in0_beep: 0.000
+3.3V:
  in1_input: 3.355
  in1_min: 0.000
  in1_max: 5.003
  in1_alarm: 0.000
  in1_beep: 0.000
+12V:
  in2_input: 11.952
  in2_min: 0.000
  in2_max: 18.360
  in2_alarm: 0.000
  in2_beep: 0.000
+5V:
  in3_input: 5.070
  in3_min: 0.000
  in3_max: 7.650
  in3_alarm: 0.000
  in3_beep: 0.000
Vaxg IGD:
  in4_input: 0.876
  in4_min: 0.000
  in4_max: 3.060
  in4_alarm: 0.000
  in4_beep: 0.000
CPU Vcore:
  in5_input: 0.888
  in5_min: 0.000
  in5_max: 3.060
  in5_alarm: 0.000
  in5_beep: 0.000
Dram Voltage:
  in6_input: 1.536
  in6_min: 0.000
  in6_max: 3.060
  in6_alarm: 0.000
  in6_beep: 0.000
3.3 VSB:
  in7_input: 3.360
  in7_min: 0.000
  in7_max: 6.120
  in7_alarm: 0.000
  in7_beep: 0.000
Vbat:
  in8_input: 3.192
CPU-Fan:
  fan1_input: 2122.000
  fan1_min: 0.000
  fan1_alarm: 0.000
  fan1_beep: 1.000
System Fan 1:
  fan2_input: 1196.000
  fan2_min: 0.000
  fan2_alarm: 0.000
  fan2_beep: 1.000
System Fan 3:
  fan4_input: 1201.000
  fan4_min: 0.000
  fan4_alarm: 0.000
  fan4_beep: 1.000
CPU Chip Temperature:
  temp1_input: 25.000
  temp1_max: 127.000
  temp1_min: 127.000
  temp1_alarm: 0.000
  temp1_type: 4.000
  temp1_offset: 0.000
  temp1_beep: 1.000
System Temperature:
  temp3_input: 29.000
  temp3_max: 127.000
  temp3_min: 127.000
  temp3_alarm: 0.000
  temp3_type: 6.000
  temp3_offset: 97.000
  temp3_beep: 1.000
Chassis Open:
  intrusion0_alarm: 0.000

acpitz-virtual-0
Adapter: Virtual device
ACPI Thermal Zone 0 Temp1:
  temp1_input: 27.800
  temp1_crit: 106.000
ACPI Thermal Zone 0 Temp2:
  temp2_input: 29.800
  temp2_crit: 106.000

pkg-temp-0-virtual-0
Adapter: Virtual device
temp1:
  temp1_input: 37.000
######################

Here comes sensors -s (No output, but beeping starts....)

######################
coretemp-isa-0000
Adapter: ISA adapter
CPU Chip Temperature:
  temp1_input: 38.000
  temp1_max: 85.000
  temp1_crit: 105.000
  temp1_crit_alarm: 0.000
CPU Core 1 Temperature:
  temp2_input: 38.000
  temp2_max: 85.000
  temp2_crit: 105.000
  temp2_crit_alarm: 0.000
CPU Core 2 Temperature:
  temp3_input: 36.000
  temp3_max: 85.000
  temp3_crit: 105.000
  temp3_crit_alarm: 0.000

it8728-isa-0a30
Adapter: ISA adapter
Vtt:
  in0_input: 1.068
  in0_min: 2.700
  in0_max: 3.060
  in0_alarm: 0.000
  in0_beep: 0.000
+3.3V:
  in1_input: 3.355
  in1_min: 3.139
  in1_max: 3.473
  in1_alarm: 0.000
  in1_beep: 0.000
+12V:
  in2_input: 11.952
  in2_min: 11.376
  in2_max: 12.600
  in2_alarm: 0.000
  in2_beep: 0.000
+5V:
  in3_input: 5.070
  in3_min: 4.740
  in3_max: 5.250
  in3_alarm: 0.000
  in3_beep: 0.000
Vaxg IGD:
  in4_input: 0.876
  in4_min: 0.804
  in4_max: 0.996
  in4_alarm: 0.000
  in4_beep: 0.000
CPU Vcore:
  in5_input: 0.888
  in5_min: 0.756
  in5_max: 1.152
  in5_alarm: 0.000
  in5_beep: 0.000
Dram Voltage:
  in6_input: 1.536
  in6_min: 1.452
  in6_max: 1.548
  in6_alarm: 0.000
  in6_beep: 0.000
3.3 VSB:
  in7_input: 3.360
  in7_min: 3.144
  in7_max: 3.456
  in7_alarm: 0.000
  in7_beep: 0.000
Vbat:
  in8_input: 3.192
CPU-Fan:
  fan1_input: 2122.000
  fan1_min: 1000.000
  fan1_alarm: 0.000
  fan1_beep: 1.000
System Fan 1:
  fan2_input: 1207.000
  fan2_min: 450.000
  fan2_alarm: 0.000
  fan2_beep: 1.000
System Fan 3:
  fan4_input: 1203.000
  fan4_min: 450.000
  fan4_alarm: 0.000
  fan4_beep: 1.000
CPU Chip Temperature:
  temp1_input: 25.000
  temp1_max: 60.000
  temp1_min: 10.000
  temp1_alarm: 0.000
  temp1_type: 4.000
  temp1_offset: 55.000
  temp1_beep: 0.000
System Temperature:
  temp3_input: -18.000
  temp3_max: 55.000
  temp3_min: 10.000
  temp3_alarm: 0.000
  temp3_type: 6.000
  temp3_offset: 50.000
  temp3_beep: 0.000
Chassis Open:
  intrusion0_alarm: 0.000

acpitz-virtual-0
Adapter: Virtual device
ACPI Thermal Zone 0 Temp1:
  temp1_input: 27.800
  temp1_crit: 106.000
ACPI Thermal Zone 0 Temp2:
  temp2_input: 29.800
  temp2_crit: 106.000

pkg-temp-0-virtual-0
Adapter: Virtual device
temp1:
  temp1_input: 37.000
######################

Originally I just wanted to share this config for other users, but it seems
quite hard to get it running correctly.

Greetings
Dominik



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Daimonos Tereutes <tereutes@nainwak.com>
Date: Sun, 04 Jan 2009 17:57:07 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add a driver for the ADT7475
Message-Id: <4960F873.4080803@nainwak.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------050100080602020900000509"
List-Id: <lm-sensors.vger.kernel.org>
References: <20080610194818.GA21150@cosmic.amd.com>
In-Reply-To: <20080610194818.GA21150@cosmic.amd.com>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------050100080602020900000509
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Matt Roberds a =E9crit :
> On Tue, 23 Dec 2008, Daimonos Tereutes wrote:
>> I'm using the patch for ADT7475 since the begining on an ASUS M2N32 WS
>> Professional without problem.
>=20
> It looks like you might be using a modified version of this
> sensors3.conf :
> http://www.lm-sensors.org/wiki/Configurations/Asus/M2N-SLI%20Deluxe
>=20
> On your board, it seems like it8716 in2 (+3.3 V) works, and it8716 temp=
3
> is chassis temp.  Also, the assignment of fans (CPU/chassis/power
> supply) to chip inputs is a little different.  If you have verified tha=
t
> the labels are correct, can you post your sensors3.conf here on the
> list?  This will help it get to the wiki as a reference for others.
>=20
> Thanks!
>=20
> Matt Roberds
>=20
Hello,
Sorry for late reply, I was away from computer.

My starting point was indeed
http://www.lm-sensors.org/wiki/Configurations/Asus/M2N-SLI%20Deluxe

I added some names based on dissasembly of ACPI following instructions on=
 this
page : http://www.lm-sensors.org/wiki/AsusFormulaHacking

And some other based on different messages on the lm_sensors list.

Hopes it will help someone.

Fran=E7ois

--------------050100080602020900000509
Content-Type: text/plain;
 name="sensors3.conf"
Content-Disposition: inline;
 filename="sensors3.conf"
Content-Transfer-Encoding: quoted-printable

chip "it8716-*"

# Voltages

    label  in0  "VCore"
    ignore in1  #"VDDR"    # Allways 0V
    label  in2  "+3.3V"    # 3.3 V is monitored by adt7475 too
    label  in3  "+5V"      # VCC
    label  in4  "+12V"
    label  in5  "VDDR"     # VDDR? (~1.83V)
    ignore in6             # Allways 0V
    label  in7  "5VSB"     # Not in BIOS
    label  in8  "VBat"     # Not in BIOS

    # Vcore, VDDR, and Vbat are connected directly, so no compute
    # line is needed for these. For +5V, +12V and 5VSB, the default
    # resistors seem to have been used.
# Those formulae are from http://www.lm-sensors.org/wiki/Configurations/A=
sus/M2N-SLI%20Deluxe
#    compute in3  ((6.8/10)+1)*@ , @/((6.8/10)+1)
#    compute in4  ((30/10)+1)*@  , @/((30/10)+1)
#    compute in5  (84*@)/50, (@/84)*50
# Those formulae are from ACPI disassembly. The results are similare
    compute in3  (84*@)/50, (@/84)*50
    compute in4  (40*@)/10, (@/40)*10
    compute in5  @/2, @*2
    compute in7  ((6.8/10)+1)*@, @/((6.8/10)+1)

   # The BIOS won't set any limit for voltages.

   # CPU is an Athlon X2 BE-2350, with Cool'n'Quiet activated so the rath=
er wide range of Voltage
   set in0_min 1.05 * 0.95
   set in0_max 1.25 * 1.05

   set in2_min 3.3 * 0.95
   set in2_max 3.3 * 1.05
   set in3_min   5 * 0.95
   set in3_max   5 * 1.05
   set in4_min  12 * 0.95
   set in4_max  12 * 1.05
   set in7_min   5 * 0.95
   set in7_max   5 * 1.05

# Temperatures

# Not sure.  temp1 always reads close to what k8temp reports for Core0,
# and to what the BIOS reports as the CPU temperature.  temp2 is between
# temp1 and temp3; it is close to what the BIOS reports as the motherboar=
d
# temperature.  temp3 always reads approximate ambient temperature.

    label temp1 "CPU Temp"
    label temp2 "MB Temp"
    label temp3 "Chassis Temp"


# Fans

    label  fan1 "CPU Fan"
    label  fan2 "Chassis Fan 1"
    label  fan3 "Chassis Fan 2"

# QFAN is on in BIOS, fan1 is a 4 pin fan, but fan2 and fan3 are 3 pin fa=
ns
# and only show when RPM is above 1000.
    set fan1_min 1200
    set fan2_min 300
    set fan3_min 300

chip "adt7475-*"

# Note: this section depends on some further hacks I have made to
# Jordan Crouse's driver

# Voltages

    ignore in1
    label  in2  "+3.3V"

# Temperatures

# temp1 and temp3 don't appear to be hooked up; temp2 is on board the
# adt7475 chip itself.

    ignore temp1
    label  temp2  "ADT7475 Temp"
    ignore temp3

# Fans

    label  fan1 "Chassis Fan 3"
    label  fan2 "Chassis Fan 4"
    label  fan3 "Power Supply Fan" # Only one in BIOS
    label  fan4 "Chassis Fan 5"

# fan3 is take from ACPI dissasembly
# other fan are simply numbered in order, I never saw anything but 0 RPM
# for these. According to MB manual there aren't even connected
    # Ignore fans you don't have
    set fan3_min 600


chip "k8temp-*"

   label temp1 "core0 temp0"
   label temp2 "core0 temp1"
   label temp3 "core1 temp0"
   label temp4 "core1 temp1"

# 21=C2=B0C offset taken from message on lm_sensors list
# not sure if it is correct or if CPU is boggus, but
# temps are similar to others probes temp.
   compute temp1 (@+21), (@-21)=20
   compute temp2 (@+21), (@-21)=20
   compute temp3 (@+21), (@-21)
   compute temp4 (@+21), (@-21)=20

--------------050100080602020900000509
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------050100080602020900000509--

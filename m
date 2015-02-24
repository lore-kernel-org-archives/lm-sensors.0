From: cedric <cedric321@hotmail.fr>
Date: Tue, 24 Feb 2015 16:50:49 +0000
Subject: Re: [lm-sensors] Test with Chip IT8620E on a Gigabyte GA-H97M-HD3 version 2
Message-Id: <BLU436-SMTP582851EA0D8E10A4DD84CD90160@phx.gbl>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------000808050609080703010705"
List-Id: <lm-sensors.vger.kernel.org>
References: <BLU436-SMTP1351904A8E5B1CC00D893290240@phx.gbl>
In-Reply-To: <BLU436-SMTP1351904A8E5B1CC00D893290240@phx.gbl>
To: lm-sensors@vger.kernel.org

--------------000808050609080703010705
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable


Le 24/02/2015 14:21=2C Jean Delvare a =E9crit :
> Most certainly wrong (scaling is never needed for fan speed) unless=20
> the IT8620E uses a different clock frequency than all other chips.=20
> Rather unlikely if you ask me. So I think your fan has some form of=20
> automatic speed control=2C either integrated or done by the chipset=2C an=
d=20
> it spins faster in the BIOS simply because the CPU is busier in the=20
> BIOS. If I am correct then just put some load on the CPU under Linux=20
> and you'll get the same fan speed as in the BIOS without the compute=20
> statement above.=20

With CPU load near 50%:

It seems that the fan speed at +-100 RPM is the same that in BIOS at the=20
same temperature.

Without CPU load:

acpitz-virtual-0
Adapter: Virtual device

coretemp-isa-0000
Adapter: ISA adapter
CPU Temp:     +24.0=B0C  (high =3D +80.0=B0C=2C crit =3D +100.0=B0C)
Core 0:       +24.0=B0C  (high =3D +80.0=B0C=2C crit =3D +100.0=B0C)
Core 1:       +22.0=B0C  (high =3D +80.0=B0C=2C crit =3D +100.0=B0C)

it8728-isa-0a30
Adapter: ISA adapter
+3.3V:        +3.32 V  (min =3D  +3.14 V=2C max =3D  +3.46 V)
+12V:        +12.09 V  (min =3D +10.80 V=2C max =3D +13.23 V)
+5V:          +5.10 V  (min =3D  +4.76 V=2C max =3D  +5.25 V)
CPU VRIN:     +1.72 V  (min =3D  +1.62 V=2C max =3D  +1.78 V)
VDRAM:        +1.50 V  (min =3D  +1.43 V=2C max =3D  +1.57 V)
3VSB:         +3.38 V  (min =3D  +3.14 V=2C max =3D  +3.48 V)
Vbat:         +2.90 V
CPU Fan:     1161 RPM  (min =3D   10 RPM)
System Temp:  +26.0=B0C  (low  =3D +10.0=B0C=2C high =3D +60.0=B0C)  sensor=
 =3D thermistor

Thank you again.
C=E9dric.

--------------000808050609080703010705
Content-Type: text/plain; charset="UTF-8"; name="sensors3.conf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="sensors3.conf"

chip "coretemp-isa-0000"

# ark.intel.com Tcase for a G3258
# maxi 72 degrees C

label temp1 "CPU Temp"

chip "acpitz-virtual-0"

ignore temp1 # stays always at 27.8 degrees C
ignore temp2 # stays always at 29.8 degrees C

chip "it8728-*"

ignore in0 # 0.01V ???

label in1 "+3.3V"
set in1_min 3.3 * 0.95
set in1_max 3.3 * 1.05
compute in1 1.648 * @, @ / 1.648

label in2 "+12V"
set in2_min 12 * 0.9
set in2_max 12 * 1.1
compute  in2  @ * 5.96, @ / 5.96

label in3 "+5V"
set in3_min 5 * 0.95
set in3_max 5 * 1.05
compute in3 2.529 * @, @ / 2.529

ignore in4 # 0.01V ???

label in5 "CPU VRIN"
compute  in5  @ * 0.990, @ / 0.990
set in5_min 1.7 * 0.95
set in5_max 1.7 * 1.05

label in6 "VDRAM"
set in6_min 1.5 * 0.95
set in6_max 1.5 * 1.05
     
label in7 "3VSB"
set in7_min 3.14
set in7_max 3.47

label in8 "Vbat"

# TEMP

label temp1 "System Temp"
set temp1_min 10
set temp1_max 60

ignore temp2 # -128 degrees C
ignore temp3 # Intel PECI

# FAN

label fan1 "CPU Fan"

ignore fan2 
ignore fan3
ignore fan4
ignore fan5

ignore intrusion0

--------------000808050609080703010705
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------000808050609080703010705--

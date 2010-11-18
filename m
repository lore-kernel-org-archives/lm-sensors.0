From: CHaoSlayeR <chaoslayer@chaoslayer.de>
Date: Thu, 18 Nov 2010 23:49:14 +0000
Subject: [lm-sensors] sensors.conf for GigaByte GA-770TA-UD3 (IT8720F rev. 8)
Message-Id: <4CE5BB7A.7040100@chaoslayer.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------060808080304010502030604"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------060808080304010502030604
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi *,

right away an additional config for another motherboard:

# dmidecode 2.9
SMBIOS 2.4 present.

Handle 0x0001, DMI type 1, 27 bytes
System Information
        Manufacturer: Gigabyte Technology Co., Ltd.
        Product Name: GA-770TA-UD3
        Version:
        Serial Number:
        UUID: 36434630-3439-3743-4342-4245FFFFFFFF
        Wake-up Type: Power Switch
        SKU Number:
        Family:


The config is attached.

Here is some example output:

it8720-isa-0228
Adapter: ISA adapter
Vcore:           +1.22 V  (min =3D  +0.78 V, max =3D  +1.50 V)
Vdram:           +1.52 V  (min =3D  +1.42 V, max =3D  +1.57 V)
+3.3V:           +3.33 V  (min =3D  +3.14 V, max =3D  +3.47 V)
+5V:             +5.08 V  (min =3D  +4.76 V, max =3D  +5.24 V)
+12V:           +12.05 V  (min =3D +11.41 V, max =3D +12.62 V)
5VSB:            +5.03 V  (min =3D  +4.76 V, max =3D  +5.24 V)
Vbat:            +3.25 V
CPU Fan:        1691 RPM  (min =3D 1000 RPM)
SYS Temp:        +50.0=B0C  (low  =3D +127.0=B0C, high =3D +127.0=B0C)  s=
ensor =3D
thermistor
CPU Casing Temp: +40.0=B0C  (low  =3D +127.0=B0C, high =3D +70.0=B0C)  se=
nsor =3D
thermal diode


Please feel free to include this config at the list of available
motherboard configurations.


Cheers,

	Ancoron

--------------060808080304010502030604
Content-Type: text/plain;
 name="GA-770TA-UD3-sensors.conf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="GA-770TA-UD3-sensors.conf"

chip "it8720-isa-*"
### Voltages

   # in5 is mysterious.

   label  in0  "Vcore"
   label  in1  "Vdram"   # "DDR3" in BIOS
   label  in2  "+3.3V"
   label  in3  "+5V"     # Not in BIOS
   label  in4  "+12V"
   ignore in5
   ignore in6
   label  in7  "5VSB"    # Not in BIOS
   label  in8  "Vbat"    # Not in BIOS
   ignore cpu0_vid

   # Vcore, Vdram, +3.3V and Vbat are connected directly, so no compute
   # line is needed for these. +5V and 5VSB are internal so we use the
   # standard scaling factor. Scaling for +12V is apparently not standard,
   # factor 3.963 is guessed from BIOS and EasyTune values (3.943 was
   # another candidate.)
   compute  in3  @ * (6.8/10+1), @ / (6.8/10+1)
   compute  in4  @ * 3.963,      @ / 3.963
   compute  in7  @ * (6.8/10+1), @ / (6.8/10+1)

   # The BIOS won't set any limit for voltages.

   set in0_min  0.825 * 0.95
   set in0_max  1.425 * 1.05
   set in1_min  1.5   * 0.95
   set in1_max  1.5   * 1.05
   set in2_min  3.3   * 0.95
   set in2_max  3.3   * 1.05
   set in3_min  5     * 0.95
   set in3_max  5     * 1.05
   set in4_min 12     * 0.95
   set in4_max 12     * 1.05
   set in7_min  5     * 0.95
   set in7_max  5     * 1.05

### Temperatures

   # The BIOS only shows 2 temperature values:
   # - temp1: the system temprature
   # - temp2: the CPU temperature

   label temp1 "SYS Temp"
   label temp2 "CPU Casing Temp"
   ignore temp3

### Fans

   label  fan1 "CPU Fan"
   ignore fan2
   ignore fan3
   # ignore fan4 # doesn't exist on GA-770TA-UD3
   ignore fan5

   # Adjust for your own fans
   set fan1_min 1000
   # set fan3_min 3000

--------------060808080304010502030604
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------060808080304010502030604--

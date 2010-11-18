From: Ancoron Luciferis <ancoron@chaoslayer.de>
Date: Thu, 18 Nov 2010 23:37:49 +0000
Subject: [lm-sensors] sensors.conf for GigaByte GA-790XTA-UD4
Message-Id: <4CE5B8CD.4060808@chaoslayer.de>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="------------000508060300050709030201"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

This is a multi-part message in MIME format.
--------------000508060300050709030201
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi *,

I just want to share the configuration that works nicely for the
mentioned motherboard:

# dmidecode 2.9
SMBIOS 2.4 present.

Handle 0x0001, DMI type 1, 27 bytes
System Information
        Manufacturer: Gigabyte Technology Co., Ltd.
        Product Name: GA-790XTA-UD4
        Version:
        Serial Number:
        UUID: 36434630-3439-3533-3433-3734FFFFFFFF
        Wake-up Type: Power Switch
        SKU Number:
        Family:


The sensors.conf file is attached.

Here is some sample output:

it8720-isa-0228
Adapter: ISA adapter
Vcore:           +1.20 V  (min =3D  +0.78 V, max =3D  +1.50 V)
Vdram:           +1.49 V  (min =3D  +1.42 V, max =3D  +1.57 V)
+3.3V:           +3.34 V  (min =3D  +3.14 V, max =3D  +3.47 V)
+5V:             +5.11 V  (min =3D  +4.76 V, max =3D  +5.24 V)
+12V:           +11.92 V  (min =3D +11.41 V, max =3D +12.62 V)
5VSB:            +5.08 V  (min =3D  +4.76 V, max =3D  +5.24 V)
Vbat:            +3.26 V
CPU Fan:         690 RPM  (min =3D  300 RPM)
SYS Fan 2:       873 RPM  (min =3D  300 RPM)
SYS Temp:        +43.0=B0C  (low  =3D  +0.0=B0C, high =3D +50.0=B0C)  sen=
sor =3D
thermistor
CPU Casing Temp: +27.0=B0C  (low  =3D  +0.0=B0C, high =3D +65.0=B0C)  sen=
sor =3D
thermal diode
NB Temp:         +37.0=B0C  (low  =3D  +0.0=B0C, high =3D +55.0=B0C)  sen=
sor =3D
thermistor


Please feel free to upload this to the available configurations.


Cheers,

	Ancoron


--------------000508060300050709030201
Content-Type: text/plain;
 name="GA-790XTA-UD4-sensors.conf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="GA-790XTA-UD4-sensors.conf"

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

   # The BIOS only shows 2 temperature values, so temp1 and temp3
   # might not be actually both used, and I don't know which one
   # is reported by the BIOS as the system temperature.

   label temp1 "SYS Temp"
   set   temp1_min 0
   set   temp1_max 50 # Tropical ambient max plus a bit

   label temp2  "CPU Casing Temp"
   set   temp2_min 0
   set   temp2_max 65 # BIOS "CPU Warning Temperature" - 5

   label temp3 "NB Temp"
   set   temp3_min 0
   set   temp3_max 55 # BIOS "CPU Warning Temperature" - 15

### Fans

   label fan1 "CPU Fan"
   ignore fan2
   label fan3 "SYS Fan 2"
   # ignore fan4 # doesn't exist on GA-790XTA-UD4
   ignore fan5

   # Adjust for your own fans
   set fan1_min 300
   set fan3_min 300


--------------000508060300050709030201
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--------------000508060300050709030201--

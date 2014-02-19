From: ianp <braveheart_leo@yahoo.com>
Date: Wed, 19 Feb 2014 01:23:43 +0000
Subject: [lm-sensors] W83627DHG-P sensor shows a single voltage monitor for +5V and +12V on in4?
Message-Id: <1392773023.4498.YahooMailNeo@web160503.mail.bf1.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

I'm running Xubuntu 12.04.4 on an Asrock G41C-GS board.


$ uname -a

Linux box 3.12-11.dmz.1-liquorix-amd64 #1 ZEN SMP PREEMPT Sat Feb 15 21:48:=
42 UTC 2014 x86_64 x86_64 x86_64 GNU/Linux

$ apt-show-versions |grep sensors
libsensors4/precise uptodate 1:3.3.1-2ubuntu1
lm-sensors/precise uptodate 1:3.3.1-2ubuntu1

I found out that this sensor, W83627DHG-P, shows a single voltage monitor f=
or +5V and +12V on in4, at least on this board, using this configuration:

chip "w83627dhg-*"
### Voltages
=A0=A0 label=A0 in0=A0 "Vcore"
=A0=A0 ignore in1
=A0=A0 label=A0 in2=A0 "AVcc"
=A0=A0 #ignore in3=A0 # "+3.3V"
=A0=A0 #label=A0 in4=A0 "+5V" # uncomment for +5V monitoring
=A0=A0 label=A0 in4=A0 "+12V" # uncomment for +12V monitoring
=A0=A0 ignore in5
=A0=A0 label=A0 in6=A0 "Vram"
=A0=A0 label=A0 in7=A0 "3Vsb"
=A0=A0 #ignore in8=A0 # "Vbat"
=A0=A0 ignore cpu0_vid

=A0=A0 #compute=A0 in4=A0 @*((20/10)+1), @/((20/10)+1) # uncomment for +5V =
monitoring
=A0=A0 compute=A0 in4=A0 @*((60/10)+1), @/((60/10)+1) # uncomment for +12V =
monitoring

=A0=A0 set in0_min 1.125 * 0.95
=A0=A0 set in0_max 1.125 * 1.05
=A0=A0 set in2_min 3.3 * 0.95
=A0=A0 set in2_max 3.3 * 1.05
=A0=A0 #set in4_min=A0=A0 5 * 0.95 # uncomment for +5V monitoring
=A0=A0 #set in4_max=A0=A0 5 * 1.05 # uncomment for +5V monitoring
=A0=A0 set in4_min=A0 12 * 0.95 # uncomment for +12V monitoring
=A0=A0 set in4_max=A0 12 * 1.05 # uncomment for +12V monitoring
=A0=A0 set in6_min 1.8
=A0=A0 set in6_max 1.9
### Temperatures
=A0=A0 label=A0 temp1=A0 "N/B Temp"
=A0=A0 label=A0 temp2=A0 "CPU Temp"
=A0=A0 ignore temp3

=A0=A0 set temp1_max 60
=A0=A0 set temp1_max_hyst 55
=A0=A0 set temp2_max 60
=A0=A0 set temp2_max_hyst 55
### Fans
=A0=A0 label=A0 fan1=A0 "CHA Fan"
=A0=A0 label=A0 fan2=A0 "CPU Fan"
=A0=A0 label=A0 fan3=A0 "PSU Fan"
=A0=A0 ignore fan4
=A0=A0 ignore fan5

=A0=A0 set fan1_min 0
=A0=A0 set fan2_min 900
=A0=A0 set fan3_min 0

$ sensors
w83627dhg-isa-0290
Adapter: ISA adapter
Vcore:=A0=A0=A0=A0=A0=A0=A0 +1.11 V=A0 (min =3D=A0 +1.07 V, max =3D=A0 +1.1=
8 V)
AVcc:=A0=A0=A0=A0=A0=A0=A0=A0 +3.30 V=A0 (min =3D=A0 +2.98 V, max =3D=A0 +3=
.63 V)
+3.3V:=A0=A0=A0=A0=A0=A0=A0 +3.30 V=A0 (min =3D=A0 +2.98 V, max =3D=A0 +3.6=
3 V)
+12V:=A0=A0=A0=A0=A0=A0=A0 +11.59 V=A0 (min =3D +11.42 V, max =3D +12.60 V)
Vram:=A0=A0=A0=A0=A0=A0=A0=A0 +1.90 V=A0 (min =3D=A0 +1.80 V, max =3D=A0 +1=
.90 V)
3Vsb:=A0=A0=A0=A0=A0=A0=A0=A0 +3.50 V=A0 (min =3D=A0 +2.98 V, max =3D=A0 +3=
.63 V)
Vbat:=A0=A0=A0=A0=A0=A0=A0=A0 +3.33 V=A0 (min =3D=A0 +2.70 V, max =3D=A0 +3=
.30 V)=A0 ALARM
CHA Fan:=A0=A0=A0=A0=A0=A0=A0 0 RPM=A0 (min =3D=A0=A0=A0 0 RPM, div =3D 128)
CPU Fan:=A0=A0=A0=A0 1704 RPM=A0 (min =3D=A0 902 RPM, div =3D 8)
PSU Fan:=A0=A0=A0=A0=A0=A0=A0 0 RPM=A0 (min =3D=A0=A0=A0 0 RPM, div =3D 128)
N/B Temp:=A0=A0=A0=A0 +41.0=B0C=A0 (high =3D +60.0=B0C, hyst =3D +55.0=B0C)=
=A0 sensor =3D thermistor
CPU Temp:=A0=A0=A0=A0 +37.5=B0C=A0 (high =3D +60.0=B0C, hyst =3D +55.0=B0C)=
=A0 sensor =3D thermistor


Uncommenting and commenting the relevant lines for +5V monitoring, I get:

$ sensors
w83627dhg-isa-0290
Adapter: ISA adapter
Vcore:=A0=A0=A0=A0=A0=A0=A0 +1.11 V=A0 (min =3D=A0 +1.07 V, max =3D=A0 +1.1=
8 V)
AVcc:=A0=A0=A0=A0=A0=A0=A0=A0 +3.30 V=A0 (min =3D=A0 +2.98 V, max =3D=A0 +3=
.63 V)
+3.3V:=A0=A0=A0=A0=A0=A0=A0 +3.30 V=A0 (min =3D=A0 +2.98 V, max =3D=A0 +3.6=
3 V)
+5V:=A0=A0=A0=A0=A0=A0=A0=A0=A0 +4.97 V=A0 (min =3D=A0 +6.12 V, max =3D=A0 =
+6.12 V)=A0 ALARM
Vram:=A0=A0=A0=A0=A0=A0=A0=A0 +1.90 V=A0 (min =3D=A0 +1.80 V, max =3D=A0 +1=
.90 V)
3Vsb:=A0=A0=A0=A0=A0=A0=A0=A0 +3.50 V=A0 (min =3D=A0 +2.98 V, max =3D=A0 +3=
.63 V)
Vbat:=A0=A0=A0=A0=A0=A0=A0=A0 +3.33 V=A0 (min =3D=A0 +2.70 V, max =3D=A0 +3=
.30 V)=A0 ALARM
CHA Fan:=A0=A0=A0=A0=A0=A0=A0 0 RPM=A0 (min =3D=A0=A0=A0 0 RPM, div =3D 128)
CPU Fan:=A0=A0=A0=A0 1654 RPM=A0 (min =3D=A0 902 RPM, div =3D 8)
PSU Fan:=A0=A0=A0=A0=A0=A0=A0 0 RPM=A0 (min =3D=A0=A0=A0 0 RPM, div =3D 128)
N/B Temp:=A0=A0=A0=A0 +41.0=B0C=A0 (high =3D +60.0=B0C, hyst =3D +55.0=B0C)=
=A0 sensor =3D thermistor
CPU Temp:=A0=A0=A0=A0 +37.5=B0C=A0 (high =3D +60.0=B0C, hyst =3D +55.0=B0C)=
=A0 sensor =3D thermistor
intrusion0:=A0 ALARM


To corroborate this behavior, I dumped the monitoring data in Windows using=
 hwmonitor v1.24

CPUID HWMonitor Report
-------------------------------------------------------------------------

Binaries
-------------------------------------------------------------------------

HWMonitor version=A0=A0=A0 1.2.4.0

Monitoring
-------------------------------------------------------------------------

Mainboard Model=A0=A0=A0 =A0=A0=A0 G41C-GS (0x000001B6 - 0x004E5333)

LPCIO
-------------------------------------------------------------------------

LPCIO Vendor=A0=A0=A0 =A0=A0=A0 Winbond
LPCIO Model=A0=A0=A0 =A0=A0=A0 W83627DHG-P
LPCIO Vendor ID=A0=A0=A0 =A0=A0=A0 0x5CA3
LPCIO Chip ID=A0=A0=A0 =A0=A0=A0 0xB0
LPCIO Revision ID=A0=A0=A0 0x73
Config Mode I/O address=A0=A0=A0 0x2E
Config Mode LDN=A0=A0=A0 =A0=A0=A0 0xB
Config Mode registers=A0=A0=A0=20
=A0=A0=A0 =A0=A0=A0 00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F=20
=A0=A0=A0 00=A0=A0=A0 FF FF FF FF FF FF FF 0B FF FF FF FF FF FF FF FF=20
=A0=A0=A0 10=A0=A0=A0 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF=20
=A0=A0=A0 20=A0=A0=A0 B0 73 FF 00 44 00 00 FF 70 00 00 00 D2 21 00 FF=20
=A0=A0=A0 30=A0=A0=A0 01 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF=20
=A0=A0=A0 40=A0=A0=A0 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF=20
=A0=A0=A0 50=A0=A0=A0 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF=20
=A0=A0=A0 60=A0=A0=A0 02 90 FF FF FF FF FF FF FF FF FF FF FF FF FF FF=20
=A0=A0=A0 70=A0=A0=A0 00 FF FF FF FF FF FF FF FF FF FF FF FF FF FF FF=20
Register space=A0=A0=A0 =A0=A0=A0 LPC, base address =3D 0x0290


Hardware Monitors
-------------------------------------------------------------------------

Hardware monitor=A0=A0=A0 Winbond W83627DHG
=A0=A0=A0 Voltage 0=A0=A0=A0 1.11 Volts [0x8B] (CPU VCORE)
=A0=A0=A0 Voltage 1=A0=A0=A0 0.69 Volts [0x56] (VIN1)
=A0=A0=A0 Voltage 2=A0=A0=A0 3.30 Volts [0xCE] (+3.3V)
=A0=A0=A0 Voltage 3=A0=A0=A0 4.97 Volts [0xCF] (+5V)
=A0=A0=A0 Voltage 4=A0=A0=A0 11.54 Volts [0xCF] (+12V)
=A0=A0=A0 Voltage 5=A0=A0=A0 1.69 Volts [0xD3] (VIN5)
=A0=A0=A0 Voltage 6=A0=A0=A0 1.90 Volts [0xED] (VIN6)
=A0=A0=A0 Temperature 0=A0=A0=A0 40=B0C (104=B0F) [0x28] (SYSTIN)
=A0=A0=A0 Temperature 1=A0=A0=A0 39=B0C (101=B0F) [0x4D] (CPUTIN)
=A0=A0=A0 Temperature 2=A0=A0=A0 46=B0C (113=B0F) [0x5B] (AUXTIN)
=A0=A0=A0 Fan 1=A0=A0=A0 =A0=A0=A0 2250 RPM [0x4B] (CPUFANIN0)
Hardware registers=A0=A0=A0=20
Register space=A0=A0=A0 =A0=A0=A0 LPC, base address =3D 0x0290
bank 0=A0=A0=A0=20
=A0=A0=A0 =A0=A0=A0 00 01 02 03 04 05 06 07 08 09 0A 0B 0C 0D 0E 0F=20
=A0=A0=A0 00=A0=A0=A0 04 FF 04 B3 11 00 37 20 01 B3 01 FF 3C 3C 0A 0A=20
=A0=A0=A0 10=A0=A0=A0 04 FF 10 00 00 01 01 3C 43 07 00 00 2D FF FF DA=20
=A0=A0=A0 20=A0=A0=A0 8B 56 CE CF CF D3 ED 28 FF 4B FF DA 00 B4 72 E3=20
=A0=A0=A0 30=A0=A0=A0 BA E3 BA EA 50 2B 0B EF D8 37 32 FF BB FF 05 FF=20
=A0=A0=A0 40=A0=A0=A0 03 02 14 FF FF 00 3F F5 2D 00 00 C4 90 95 00 A3=20
=A0=A0=A0 50=A0=A0=A0 FF FF 00 FF FF FF 00 80 C1 7F FF FF 19 A0 00 05=20
=A0=A0=A0 60=A0=A0=A0 04 7F 40 00 01 01 3C FF 01 FF 01 FF FF FF FF 00=20
=A0=A0=A0 70=A0=A0=A0 00 00 00 00 00 0E 7F 7F 7F 7F 7F 7F 00 28 FF FF=20
=A0=A0=A0 80=A0=A0=A0 04 FF 04 B3 11 00 37 20 01 B3 01 FF 3C 3C 0A 0A=20
=A0=A0=A0 90=A0=A0=A0 04 FF 10 00 00 01 01 3C 43 07 00 00 2D FF FF DA=20
=A0=A0=A0 A0=A0=A0=A0 8B 56 CE CF CF D3 ED 28 FF 4B FF DA 00 B4 72 E3=20
=A0=A0=A0 B0=A0=A0=A0 BA E3 BA EA 50 2B 0B EF D8 37 32 FF BB FF 05 FF=20
=A0=A0=A0 C0=A0=A0=A0 03 00 10 FF FF 00 3F F5 2D 00 00 C4 90 95 00 A3=20
=A0=A0=A0 D0=A0=A0=A0 FF FF 00 FF FF FF 00 80 C1 7F FF FF 19 A0 00 05=20
=A0=A0=A0 E0=A0=A0=A0 04 7F 40 00 01 01 3C FF 01 FF 01 FF FF FF FF 00=20
=A0=A0=A0 F0=A0=A0=A0 00 00 00 00 00 0E 7F 7F 7F 7F 7F 7F 00 28 FF FF=20
bank 1=A0=A0=A0=20
=A0=A0=A0 50=A0=A0=A0 26 80 00 32 00 37 01 20 00 00 00 00 00 00 0E FF=20
bank 2=A0=A0=A0=20
=A0=A0=A0 50=A0=A0=A0 2D 80 00 4B 00 50 1E 02 FF FF FF FF FF FF FF FF=20
bank 3=A0=A0=A0=20
=A0=A0=A0 50=A0=A0=A0 06 07 07 00 04 02 02 01 06 00 00 00 7C 00 00 00=20
bank 4=A0=A0=A0=20
=A0=A0=A0 50=A0=A0=A0 3A 13 FF 00 00 00 00 08 2A 02 14 AA 09 60 20 7F=20



As you can see from above, +5V and +12V share the same address (0xCF).

My question is, how do you work around this apprently shared voltage monito=
ring in lm-sensors? I wish to show +5V and +12V monitors seperately like ho=
w hwmonitor does.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

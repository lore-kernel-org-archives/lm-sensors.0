From: mds@mds.gotdns.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: Impossible tu use CPU Temp    with superkaramba  (
Message-Id: <42177537.4070006@mds.gotdns.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200502141702.04783.jackie_lola@yahoo.fr>
In-Reply-To: <200502141702.04783.jackie_lola@yahoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

we don't know anything about 'superkaramba' or 'TDE' but
your temp2 and temp3 sensors are configured to be ignored in sensors.conf.
you may wish to take out those lines.
Any one of the three, temp1-temp3, could be your CPU temperature.
Khali may be able to help you further in french :)

jackie wrote:
> Superkaramaba can't display the CPU Temp , with two differents themes=20
> for superkaramba : TDE and Mi-karamba.
>=20
> It' s like if superkaramba was looking for a wrong sensor adress, with=20
> CPU Temp !!! isn't it ?
>=20
> Can you give me a little help.
>=20
> Here is the output of sensors command.
>=20
> ip-10:/home/jackie # sensors
>=20
> eeprom-i2c-0-51
>=20
> Adapter: SMBus I801 adapter at e800
>=20
> Memory type: DDR SDRAM DIMM
>=20
> Memory size (MB): 512
>=20
> asb100-i2c-0-2d
>=20
> Adapter: SMBus I801 adapter at e800
>=20
> VCore 1: +1.60 V (min =3D +1.46 V, max =3D +1.60 V)
>=20
> ALARM
>=20
> +3.3V: +3.33 V (min =3D +3.14 V, max =3D +3.47 V)
>=20
> +5V: +5.05 V (min =3D +4.76 V, max =3D +5.24 V)
>=20
> +12V: +11.61 V (min =3D +10.82 V, max =3D +13.19 V)
>=20
> -12V (reserved):
>=20
> -12.13 V (min =3D -0.00 V, max =3D -0.00 V)
>=20
> -5V (reserved):
>=20
> -5.09 V (min =3D -0.00 V, max =3D -0.00 V)
>=20
> CPU Fan: 2884 RPM (min =3D 1997 RPM, div =3D 4)
>=20
> M/B Temp: +30?C (high =3D +45?C, hyst =3D +40?C)
>=20
> CPU Temp (Intel):
>=20
> +38?C (high =3D +60?C, hyst =3D +50?C)
>=20
> vid: +1.525 V
>=20
> alarms:
>=20
> ip-10:/home/jackie #
>=20
> Here is my superkaramba theme : TDE tpower
>=20
> #Written by Chip2003
>=20
> #Published under GPL on www.kde-look.org
>=20
> #This is part of TDE - T Desktop Enhancements
>=20
> #This Theme - TPower - shows various information about power status and=20
> temperatures, as CPU and case temperatures, Fan RPM, voltages. For some=20
> values, you need the program 'sensors'!
>=20
> # general
>=20
> KARAMBA Xx5 Y=98 W#0 H=185 interval 00 locked=FAlse
>=20
> image x=3D0 y=3D0 path=3D"image/back.png"
>=20
> defaultfont font=3D"Arial" fontsize=10 color=3D0,0,0 align=3D"right"
>=20
> <GROUP> x=19 y$
>=20
> # CPU
>=20
> # "type" depends on your mainboard. Run 'sensors' to show all possible=20
> values (Must be installed, of course ...)
>=20
> # range is up to 70 degrees celsius. change 'max' value if needed.
>=20
> image x=3D0 y=3D0 path=3D"image/tile.png"
>=20
> image x=3D7 y=11 path=3D"image/cpu.png"
>=20
> image x` y=11 path=3D"image/fan_s.png"
>=20
> image x=127 y=3D9 path=3D"image/thermometer_k.png"
>=20
> text x=110 y=15 sensor=3Dsensor type=3D"CPU Fan" format=3D"%v" align=3D"r=
ight"=20
> color=3D0,0,0 fontsize=10 font=3D"Arial"
>=20
> text x=178 y=15 sensor=3Dsensor type=3D"CPU Temp (Intel)" format=3D"%v C"=
=20
> align=3D"right" color=3D0,0,0 fontsize=10 font=3D"Arial"
>=20
> </GROUP>
>=20
> # Chassis
>=20
> <GROUP> x=19 yi
>=20
> image x=3D0 y=3D0 path=3D"image/tile.png"
>=20
> image x=3D7 y=3D7 path=3D"image/computer.png"
>=20
> #image x` y=11 path=3D"image/fan_s.png"
>=20
> image x=127 y=3D9 path=3D"image/thermometer_k.png"
>=20
> text x=178 y=15 sensor=3Dsensor type=3D"M/B Temp" format=3D"%v C" color=
=3D0,0,0=20
> align=3D"right" fontsize=10 font=3D"Arial"
>=20
> #text x=110 y=15 sensor=3Dsensor type=3D"fan1" format=3D"%v" align=3D"rig=
ht"=20
> color=3D0,0,0 fontsize=10 font=3D"Arial"
>=20
> </GROUP>
>=20
> # Voltages
>=20
> <GROUP> x=19 y=114
>=20
> image x=3D0 y=3D0 path=3D"image/tile.png"
>=20
> image x=10 y=3D7 path=3D"image/power.png"
>=20
> text x=170 y=3D8 sensor=3Dsensor type=3D"+12V" format=3D"+%v V" color=3D0=
,0,0=20
> align=3D"right" fontsize=10 font=3D"Arial"
>=20
> text x=170 y  sensor=3Dsensor type=3D"VCore 1" format=3D"+%v V" color=3D0=
,0,0=20
> align=3D"right" fontsize=10 font=3D"Arial"
>=20
> text x=90 y=3D8 sensor=3Dsensor type=3D"+3.3V" format=3D"+%v V" align=3D"=
right"=20
> color=3D0,0,0 fontsize=10 font=3D"Arial"
>=20
> text x=90 y  sensor=3Dsensor type=3D"+5V" format=3D"+%v V" align=3D"right=
"=20
> color=3D0,0,0 fontsize=10 font=3D"Arial"
>=20
> </GROUP>
>=20
> I have tried a lot of possibilities to define CPU Temp (Intel)
>=20
> Before I'd two CPU temp sensors : Intel and AMD.
>=20
> I've modified my /etc/sensors.conf
>=20
> ( part asb100 ) to ignore uninstalled fans and sensors, especially CPU=20
> Temp (AMD).
>=20
> Well done in the new sensor output.
>=20
> #
>=20
> # This example was tested vs. Asus P4S333
>=20
> #
>=20
> chip "asb100-*"
>=20
> set vrm 9.0
>=20
> label in0 "VCore 1"
>=20
> set in0_min vid * 0.95
>=20
> set in0_max vid * 1.05
>=20
> label in1 "VCore 2"
>=20
> ignore in1
>=20
> set in1_min vid * 0.95
>=20
> set in1_max vid * 1.05
>=20
> label in2 "+3.3V"
>=20
> set in2_min 3.3 * 0.95
>=20
> set in2_max 3.3 * 1.05
>=20
> label in3 "+5V"
>=20
> compute in3 1.68 * @ , @ / 1.68
>=20
> set in3_min 5.0 * 0.95
>=20
> set in3_max 5.0 * 1.05
>=20
> label in4 "+12V"
>=20
> compute in4 3.8 * @ , @ / 3.8
>=20
> set in4_min 12 * 0.90
>=20
> set in4_max 12 * 1.10
>=20
> label in5 "-12V (reserved)"
>=20
> #ignore in5
>=20
> compute in5 -@ * 3.97 , -@ / 3.97
>=20
> set in5_max -12 * 0.90
>=20
> set in5_min -12 * 1.10
>=20
> label in6 "-5V (reserved)"
>=20
> #ignore in6
>=20
> compute in6 -@ * 1.666 , -@ / 1.666
>=20
> set in6_max -5 * 0.95
>=20
> set in6_min -5 * 1.05
>=20
> label temp1 "M/B Temp"
>=20
> set temp1_over 45
>=20
> set temp1_hyst 40
>=20
> label temp2 "CPU Temp (Intel)"
>=20
> #ignore temp2
>=20
> set temp2_over 60
>=20
> set temp2_hyst 50
>=20
> # PWRTMP connector on P4S333, for external sensor
>=20
> label temp3 "Power Temp"
>=20
> ignore temp3
>=20
> set temp3_over 45
>=20
> set temp3_hyst 40
>=20
> # Used for Athlon diode, ignore for P4S333
>=20
> label temp4 "CPU Temp (AMD)"
>=20
> ignore temp4
>=20
> set temp4_over 60
>=20
> set temp4_hyst 50
>=20
> label fan1 "CPU Fan"
>=20
> set fan1_div 4
>=20
> set fan1_min 2000
>=20
> label fan2 "Chassis Fan"
>=20
> set fan2_div 2
>=20
> set fan2_min 4000
>=20
> ignore fan2
>=20
> label fan3 "Power Fan"
>=20
> set fan3_div 2
>=20
> set fan3_min 4000
>=20
> ignore fan3
>=20
> Here is my.../etc/sysconfig/lm_sensors
>=20
> # /etc/sysconfig/sensors - Defines modules loaded by=20
> /etc/rc.d/init.d/lm_sensors
>=20
> # Copyright (c) 1998 - 2001 Frodo Looijaard <frodol@dds.nl>
>=20
> #
>=20
> .
>=20
> # See also the lm_sensors homepage at:
>=20
> # http://www2.lm-sensors.nu/~lm78/index.html
>=20
> #
>=20
> # This file is used by /etc/rc.d/init.d/lm_sensors and defines the=20
> modules to
>=20
> # be loaded/unloaded. This file is sourced into /etc/rc.d/init.d/lm_senso=
rs.
>=20
> #
>=20
> # The format of this file is a shell script that simply defines the modul=
es
>=20
> # in order as normal variables with the special names:
>=20
> # MODULE_0, MODULE_1, MODULE_2, etc.
>=20
> #
>=20
> # List the modules that are to be loaded for your system
>=20
> #
>=20
> # Generated by sensors-detect on Sun Feb 13 15:14:37 2005
>=20
> MODULE_0=3Di2c-i801
>=20
> MODULE_1=3Dasb100
>=20
> MODULE_2=EEprom
>=20
> I've an ASUS P4PE-X, with Intel Celeron.
>=20
> What i did with sensors-detect.
>=20
> I tried various options, before, but i dont 'understand what this file=20
> is doing.
>=20
> ip-10:/home/jackie # sensors-detect
>=20
> This program will help you determine which I2C/SMBus modules you need to
>=20
> load to use lm_sensors most effectively. You need to have i2c and
>=20
> lm_sensors installed before running this program.
>=20
> Also, you need to be `root', or at least have access to the /dev/i2c-*
>=20
> files, for most things.
>=20
> If you have patched your kernel and have some drivers built in, you can
>=20
> safely answer NO if asked to load some modules. In t
>=20
> his case, things may seem a bit confusing, but they will still work.
>=20
> It is generally safe and recommended to accept the default answers to all
>=20
> questions, unless you know what you're doing.
>=20
> We can start with probing for (PCI) I2C or SMBus adapters.
>=20
> You do not need any special privileges for this.
>=20
> Do you want to probe now? (YES/no): YES
>=20
> Probing for PCI bus adapters...
>=20
> Use driver `i2c-i801' for device 00:1f.3: Intel 8280
>=20
> 1DB ICH4
>=20
> Probe succesfully concluded.
>=20
> We will now try to load each adapter module in turn.
>=20
> Module `i2c-i801' already loaded.
>=20
> If you have undetectable or unsupported adapters, you can have them
>=20
> scanned by manually loading the modules before runni
>=20
> ng this script.
>=20
> To continue, we need module `i2c-dev' to be loaded.
>=20
> If it is built-in into your kernel, you can safely skip this.
>=20
> i2c-dev is not loaded. Do you want to load it now? (YES/no): YES
>=20
> Module loaded succesfully.
>=20
> We are now going to do the adapter probings. Some adapters may hang halfw=
ay
>=20
> through; we can't really help that. Also, some chips will be double=20
> detected;
>=20
> we choose the one with the highest confidence value in that case.
>=20
> If you found that the adapter hung after probing a certain address, you c=
an
>=20
> specify that address to remain unprobed. That often
>=20
> includes address 0x69 (clock chip).
>=20
> Next adapter: SMBus I801 adapter at e800 (Algorithm unavailable)
>=20
> Do you want to scan it? (YES/no/selectively): YES
>=20
> Client found at address 0x08
>=20
> Client at address 0x2d can not be probed - unload all client drivers firs=
t!
>=20
> Client found at address 0x44
>=20
> Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
>=20
> Client at address 0x48 can not be probed - unload all client drivers firs=
t!
>=20
> Client at address 0x49 can not be probed - unload all client drivers firs=
t!
>=20
> Client at address 0x51 can not be probed - unload all client drivers firs=
t!
>=20
> Some chips are also accessible through the ISA bus.
>=20
> ISA probes are typically a bit more dangerous, as we have to write
>=20
> to I/O ports to do this. This is usually safe though.
>=20
> Do you want to scan the ISA bus? (YES/no): no
>=20
> Some Super I/O chips may also contain sensors. Super I/O probes are
>=20
> typically a bit more dangerous, as we have to write to I/O ports to do
>=20
> this. This is usually safe though.
>=20
> Do you want to scan for Super I/O sensors? (YES/no): YES
>=20
> Probing for `ITE 8702F Super IO Sensors' Failed! (0x8708)
>=20
> Probing for `ITE 8705F Super IO Sensors' Failed! (0x8708)
>=20
> Probing for `ITE 8712F Super IO Sensors' Failed! (0x8708)
>=20
> Probing for `Nat. Semi. PC87351 Super IO Fan Sensors
>=20
> 'Failed! (skipping family)
>=20
> Probing for `SMSC 47B27x Super IO Fan Sensors' Failed! (skipping family)
>=20
> Probing for `VT1211 Super IO Sensors' Failed! (0x87)
>=20
> Probing for `Winbond W83627HF Super IO Sensors' Failed! (0x87)
>=20
> Probing for `Winbond W83627THF Super IO Sensors' Failed! (0x87)
>=20
> Probing for `Winbond W83637HF Super IO Sensors' Failed! (0x87)
>=20
> Probing for `Winbond W83697HF Super IO Sensors' Failed! (0x87)
>=20
> Probing for `Winbond W83697SF/UF Super IO PWM' Failed! (0x87)
>=20
> Probing for `Winbond W83L517D Super IO' Failed! (0x87)
>=20
> Do you want to scan for secondary Super I/O sensors? (YES/no): YES
>=20
> Probing for `ITE 8702F Super IO Sensors' Failed! (skipping family)
>=20
> Probing for `Nat. Semi. PC87351 Super IO Fan Sensors' Failed! (skipping=20
> family)
>=20
> Probing for `SMSC 47B27x Super IO Fan Sensors' Failed! (skipping family)
>=20
> Probing for `VT1211 Super IO Sensors' Failed! (skipping family)
>=20
> Sorry, no chips were detected.
>=20
> Either your sensors are not supported, or they are connected to an I2C=20
> bus adapter that we do not support.
>=20
> See doc/FAQ, doc/lm_sensors-FAQ.html, or
>=20
> http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc
>=20
> /lm_sensors-FAQ.html (FAQ #4.24.3) for further information.
>=20
> If you find out what chips are on your board, see
>=20
> http://secure.netroedge.com/~lm78/newdrivers.html for driver status.
>=20
> I'm going to read these informations...
>=20
> I dont undersatand why superkaramba don't display only CPU temp,=20
> althought i have it with sensors. ( only six months with Linux )
>=20
> A little help please ! Ayuda por favor !
>=20
> Jacqueline
>=20


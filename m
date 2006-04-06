From: mcinc1993@gmail.com (Jean Dumas)
Date: Thu, 06 Apr 2006 17:22:43 +0000
Subject: [lm-sensors] Reading ASUS P5GD1-VM sensors
Message-Id: <44354E63.5090703@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Reading the P5GD1-VM sensors


I have been using lmsensors for quite a while now but recently stumbled=20
across an ASUS P5GD1-VM MotherBoard at work.


I installed the i2c and lmsensors, read the quick installation=20
documentation, ran the suggested utilities and was able to identify the=20
sensor chip as a Winbound w83627ehf.


I then applied all the recommendations, updated the files as specified,=20
restarted my machine and came out empty handed. No sensors detected.=20
Spent quite a bit of time googling to get further information about the=20
w83627ehf Super IO Chip, but results were unsuccessful.


Came back to the lmsensors site, further read the lmsensors=20
documentation and tried to use alternate quasi equivalent chip. Again=20
came out empty handed.


Because I have a multi-OS system I ran SiSoftware Sandra in Windows 2K=20
(this is at work, I can not avoid using this OS for the time being) and=20
reading through the output report I came across the following bit of=20
information:


Environment Monitor 1

Model: Winbound W83782D ISA


Of course Asus Probe reads all parameters correctly, so why was it that=20
I could not do it in Slackware 10.2 using a 2.4.31 kernel.


Went back to the lmsensors documentation again and found advice at the=20
end of the new drivers page which gave a clear example of how to force a=20
chip driver.



*FORCING A CHIP DRIVER:*
If we do not support a chip, you may often get partial support by=20
'forcing' the driver for a similar chip to load. Follow these=20
instructions (running as root) to force an i2c driver:

   1.

      Run 'prog/detect/i2cdetect' with no arguments to determine the i2c
      bus number the chip is on (often 0).

   2.

      Run 'prog/detect/i2cdetect /n/' where /n/ is the bus number (often
      0) to locate the i2c address of the chip (often 0x2d).

   3.

      Get the name of the similar chip and associated driver (module)
      from the table above (for example lm78 chip and driver).

   4.

      Load the driver as follows: 'modprobe /driver/
      force_/chip/=3D/bus/,/address/' (for example 'modprobe lm78
      force_lm78=3D0,0x2d'). For an ISA-bus device, use magic bus number
      '9191'.

   5.

      Run 'lsmod' and check the syslog or dmesg to verify the driver
      loaded.

   6.

      Run 'sensors -s' and then 'sensors' to verify the driver is
      reporting results and see if some of the results make sense.

   7.

      Adjust settings in /etc/sensors.conf as necessary; rerun 'sensors
      -s' and 'sensors'.

   8.

      Contact us with the results.

Steps 3 to 7 proved very useful indeed


Based on this info I did a forced chip driver installation as follows


I used the w83781d module which is essentially (I think) fully=20
compatible with the w83782d identified by SySoftware Sandra in Windows.=20
Notice tha Sandra saw it as an ISA bus chip, so I opted for the ISA=20
magic number in the force command parameters.


During the lmsensors installation, the utility had identified the=20
address of the Super IO chip as being 0x0290, so this is what I used for=20
the address parameter in the command. This is how I proceeded


I opened a terminal and typed

/sbin/modprobe w83781d force_w83781d=9191,0x0290


then I ran


sensors -s


and then


sensors


which yielded the following output


root at JeanPC:~# sensors

eeprom-i2c-0-50

Adapter: SMBus I801 adapter at 0400

Memory type: DDR SDRAM DIMM

Memory size (MB): 512


eeprom-i2c-0-52

Adapter: SMBus I801 adapter at 0400

Memory type: DDR SDRAM DIMM

Memory size (MB): 512


arp-i2c-0-61

Adapter: SMBus I801 adapter at 0400


w83781d-isa-0290

Adapter: ISA adapter

VCore 1: +2.90 V (min =3D +1.74 V, max =3D +1.94 V)

VCore 2: +3.68 V (min =3D +1.74 V, max =3D +1.94 V)

+3.3V: +3.34 V (min =3D +3.14 V, max =3D +3.46 V)

+5V: +5.61 V (min =3D +4.74 V, max =3D +5.24 V)

+12V: +15.50 V (min =3D +11.36 V, max =3D +12.58 V)

-12V: -11.06 V (min =3D -12.59 V, max =3D -11.33 V)

-5V: -0.05 V (min =3D -5.25 V, max =3D -4.74 V)

fan1: 2191 RPM (min =3D 10227 RPM, div =3D 4)

fan2: 2393 RPM (min =3D -1 RPM, div =3D 4)

fan3: 0 RPM (min =3D 8333 RPM, div =3D 2)

temp1: +39?C (high =3D +4?C, hyst =3D +64?C) ALARM

temp2: +42.0?C (high =3D +80?C, hyst =3D +75?C)

temp3: +38.0?C (high =3D +80?C, hyst =3D +75?C)

vid: +1.850 V (VRM Version 8.2)

alarms: Chassis intrusion detection ALARM

beep_enable:

Sound alarm disabled


Finally and to my amazement, after a good week of frustrations and=20
intense googling I could actually read my sensors.


I modified my rc.modules file (this is a Slackware Distro) to include=20
the force driver command //sbin/modprobe w83781d=20
force_w83781d=9191,0x0290 /and my //etc/sysconfig/lm_sensors/ file to=20
adjust my MODULE_4 name to w83781d/ (I am not sure editing the=20
lm_sensors file is very important but I did not take any chances)./


Rebooted my system, checked my dmesg output, checked lsmod, ran sensors=20
and got a valid sensors output. Reconfigured my Gkrellm and voila, my=20
sensors reading were displayed and results were coherent with the ASUS=20
Probe readings in my other OS.


If this is not an already known quick fix to the problems associated=20
with reading the ASUS P5GD1-VM MotherBoard sensors, I hope this bit of=20
text can help other people which might be attempting to correctly read=20
the Winbound w83627ehf chip on a 2.4.31kernel. Otherwise I still wanted=20
to share this knowledge with your community.


I would like to thank the lmsensors team for providing the Linux/Unix=20
community with these very useful drivers and software.




--=20
Jean Dumas=20


email : mcinc1993 at gmail.com
	mcinc1993 at hotmail.com






-------------- next part --------------
A non-text attachment was scrubbed...
Name: mcinc1993.vcf
Type: text/x-vcard
Size: 203 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060406=
/8a5284c1/mcinc1993.vcf

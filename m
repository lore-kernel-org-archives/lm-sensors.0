From: pgaige@cadesis.com (=?ISO-8859-1?Q?Gaig=E9_Pierre?=)
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: support for p4s8x motherboard
Message-Id: <3EFB6831.9040403@cadesis.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3EFA15C6.5020503@cadesis.com>
In-Reply-To: <3EFA15C6.5020503@cadesis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Ok, After a good nigth and a reboot of my machine, the sensors-detect=20
behave completly different.
I've included the results below.
But now the problem comes when I try to load the w83781d module as it is=20
suggested, my motherboard plays continously some beep beep that I have=20
never heard before ;-)
notice that I haven't try to load the modules at boot time.
Don't know what to do now ...

thanks again.

*******************************************************************
result of sensors-detect
*******************************************************************
[root@PC pierre]# sensors-detect
  This program will help you to determine which I2C/SMBus modules you=20
need to
  load to use lm_sensors most effectively.
  You need to have done a `make install', issued a `depmod -a' and made sure
  `/etc/conf.modules' (or `/etc/modules.conf') contains the appropriate
  module path before you can use some functions of this utility. Read
  doc/modules for more information.
  Also, you need to be `root', or at least have access to the=20
/dev/i2c[-/]* files
  for some things. You can use prog/mkdev/mkdev.sh to create these /dev=20
files
  if you do not have them already.
  If you have patched your kernel and have some drivers built-in you can
  safely answer NO if asked to load some modules. In this case, things may
  seem a bit confusing, but they will still work.

  BIOS vendor (ACPI): ASUS
  System vendor (DMI): System Manufacturer
  BIOS version (DMI): ASUS P4S8X ACPI BIOS Revision 1004
  We can start with probing for (PCI) I2C or SMBus adapters.
  You do not need any special privileges for this.
  Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-sis645' for device 00:00.0: Silicon Integrated Systems=20
SIS648
Probe succesfully concluded.

  We will now try to load each adapter module in turn.
Load `i2c-sis645' (say NO if built into your kernel)? (YES/no):
Module loaded succesfully.
  Do you now want to be prompted for non-detectable adapters? (yes/NO):
  To continue, we need module `i2c-dev' to be loaded.
  If it is built-in into your kernel, you can safely skip this.
  i2c-dev is not loaded. Do you want to load it now? (YES/no):
  Module loaded succesfully.

  We are now going to do the adapter probings. Some adapters may hang=20
halfway
  through; we can't really help that. Also, some chips will be double=20
detected;
  we choose the one with the highest confidence value in that case.
  If you found that the adapter hung after probing a certain address,=20
you can
  specify that address to remain unprobed. That often
  includes address 0x69 (clock chip).

Next adapter: SMBus SiS645 adapter at 0xe600 (Non-I2C SMBus adapter)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x08
Client found at address 0x10
Client found at address 0x2d
Probing for `Myson MTP008'... Failed!
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Failed!
Probing for `National Semiconductor LM85'... Failed!
Probing for `Analog Devices ADM1027 or ADT7463'... Failed!
Probing for `SMSC EMC6D100 and EMC6D101'... Failed!
Probing for `National Semiconductor LM87'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83791D'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Success!
     (confidence 8, driver `w83781d'), other addresses: 0x48 0x49
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `Genesys Logic GL518SM Revision 0x00'... Failed!
Probing for `Genesys Logic GL518SM Revision 0x80'... Failed!
Probing for `Genesys Logic GL520SM'... Failed!
Probing for `Genesys Logic GL525SM'... Failed!
Probing for `Analog Devices ADM9240'... Failed!
Probing for `Dallas Semiconductor DS1780'... Failed!
Probing for `National Semiconductor LM81'... Failed!
Probing for `Analog Devices ADM1026'... Failed!
Probing for `Analog Devices ADM1025'... Failed!
Probing for `Analog Devices ADM1024'... Failed!
Probing for `Analog Devices ADM1022'... Failed!
Probing for `Texas Instruments THMC50'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client found at address 0x30
Client found at address 0x48
Probing for `National Semiconductor LM75'... Failed!
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `Philips Semiconductors PCF8591'... Success!
     (confidence 1, driver `pcf8591')
Client found at address 0x49
Probing for `National Semiconductor LM75'... Success!
     (confidence 3, driver `lm75')
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `Philips Semiconductors PCF8591'... Success!
     (confidence 1, driver `pcf8591')
Client found at address 0x50
Probing for `Serial EEPROM'... Success!
     (confidence 8, driver `eeprom')
Probing for `DDC monitor'... Failed!

  Some chips are also accessible through the ISA bus. ISA probes are
  typically a bit more dangerous, as we have to write to I/O ports to do
  this.  Do you want to scan the ISA bus? (YES/no):
Probing for `National Semiconductor LM78'
   Trying address 0x0290... Failed!
Probing for `National Semiconductor LM78-J'
   Trying address 0x0290... Failed!
Probing for `National Semiconductor LM79'
   Trying address 0x0290... Failed!
Probing for `Winbond W83781D'
   Trying address 0x0290... Failed!
Probing for `Winbond W83782D'
   Trying address 0x0290... Failed!
Probing for `Winbond W83627HF'
   Trying address 0x0290... Failed!
Probing for `Winbond W83697HF'
   Trying address 0x0290... Failed!
Probing for `Silicon Integrated Systems SIS5595'
   Trying general detect... Failed!
Probing for `VIA Technologies VT82C686 Integrated Sensors'
   Trying general detect... Failed!
Probing for `VIA Technologies VT8231 Integrated Sensors'
   Trying general detect... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'
   Trying address 0x0290... Failed!
Probing for `IPMI BMC KCS'
   Trying address 0x0ca0... Failed!
Probing for `IPMI BMC SMIC'
   Trying address 0x0ca8... Failed!

  Some Super I/O chips may also contain sensors. Super I/O probes are
  typically a bit more dangerous, as we have to write to I/O ports to do
  this.  Do you want to scan for Super I/O sensors? (YES/no):
Probing for `SMSC 47M1xx Super IO Fan Sensors'
   Failed!
Probing for `VT1211 Super IO Sensors'
   Failed! (0x68)
Probing for `Winbond W83627HF Super IO Sensors'
   Failed! (0x68)
Probing for `Winbond W83627THF Super IO Sensors'
   Failed! (0x68)
Probing for `Winbond W83697HF Super IO Sensors'
   Failed! (0x68)

  Now follows a summary of the probes I have just done.
  Just press ENTER to continue:

Driver `w83781d' (should be inserted):
   Detects correctly:
   * Bus `SMBus SiS645 adapter at 0xe600' (Non-I2C SMBus adapter)
     Busdriver `i2c-sis645', I2C address 0x2d (and 0x48 0x49)
     Chip `Asus AS99127F' (confidence: 8)

Driver `pcf8591' (may not be inserted):
   Misdetects:
   * Bus `SMBus SiS645 adapter at 0xe600' (Non-I2C SMBus adapter)
     Busdriver `i2c-sis645', I2C address 0x48
     Chip `Philips Semiconductors PCF8591' (confidence: 1)
   * Bus `SMBus SiS645 adapter at 0xe600' (Non-I2C SMBus adapter)
     Busdriver `i2c-sis645', I2C address 0x49
     Chip `Philips Semiconductors PCF8591' (confidence: 1)

Driver `lm75' (may not be inserted):
   Misdetects:
   * Bus `SMBus SiS645 adapter at 0xe600' (Non-I2C SMBus adapter)
     Busdriver `i2c-sis645', I2C address 0x49
     Chip `National Semiconductor LM75' (confidence: 3)

Driver `eeprom' (should be inserted):
   Detects correctly:
   * Bus `SMBus SiS645 adapter at 0xe600' (Non-I2C SMBus adapter)
     Busdriver `i2c-sis645', I2C address 0x50
     Chip `Serial EEPROM' (confidence: 8)


  I will now generate the commands needed to load the I2C modules.
  Sometimes, a chip is available both through the ISA bus and an I2C bus.
  ISA bus access is faster, but you need to load an additional driver module
  for it. If you have the choice, do you want to use the ISA bus or the
  I2C/SMBus (ISA/smbus)?

WARNING! If you have some things built into your kernel, the
below list will contain too many modules. Skip the appropriate ones!
To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
modprobe i2c-sis645
# I2C chip drivers
modprobe w83781d
modprobe eeprom
# Next 2 lines are optional
sleep 3
/usr/local/bin/sensors -s
#----cut here----

To make the sensors modules behave correctly, add these lines to either
/etc/modules.conf or /etc/conf.modules:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

Do you want to generate /etc/sysconfig/lm_sensors? (YES/no):
Copy prog/init/lm_sensors.init to /etc/rc.d/init.d/lm_sensors
for initialization at boot time.


Mark M. Hoffman wrote:
> * Gaig? Pierre <pgaige@cadesis.com> [2003-06-25 23:36:06 +0200]:
>=20
>>Hello,
>>
>>I have a P4S8X motherboard from Asustek.
>>My system is Mandrake 9.1 with the latest 2.4.21 kernel from Mandrake=20
>>Update. I have just install the latest i2c and lm_sensors from CVS but I =

>>am not able to make them work (Your web site announce that these=20
>>combination - 648/961 - should be supported with the CVS version). I am=20
>=20
>=20
> Your lspci output says 648/963.  Shouldn't matter though, that is
> supported in CVS also.
>=20
>=20
>>not a developper so I can't help you much but here is the results of the =

>>different commands.
>>I hope it can help you improve your code.
>>Thanks.
>=20
>=20
> I suggest that you answer "no" to the question "Do you want to be prompted
> for non-detectable adapters" when using sensors-detect.
>=20
> I tried to repeat your results here (on my 645/961) but I could not.
> My only other advice is to make sure that you have removed any sensors
> or i2c packages which come with your distribution.
>=20
>=20
>>*******************************************************************
>>result of sensors-detect
>>*******************************************************************
>>[root@PC SOURCES]# sensors-detect
>> This program will help you to determine which I2C/SMBus modules you=20
>>need to
>> load to use lm_sensors most effectively.
>> You need to have done a `make install', issued a `depmod -a' and made su=
re
>> `/etc/conf.modules' (or `/etc/modules.conf') contains the appropriate
>> module path before you can use some functions of this utility. Read
>> doc/modules for more information.
>> Also, you need to be `root', or at least have access to the=20
>>/dev/i2c[-/]* files
>> for some things. You can use prog/mkdev/mkdev.sh to create these /dev=20
>>files
>> if you do not have them already.
>> If you have patched your kernel and have some drivers built-in you can
>> safely answer NO if asked to load some modules. In this case, things may
>> seem a bit confusing, but they will still work.
>>
>> BIOS vendor (ACPI): ASUS
>> System vendor (DMI): System Manufacturer
>> BIOS version (DMI): ASUS P4S8X ACPI BIOS Revision 1004
>> We can start with probing for (PCI) I2C or SMBus adapters.
>> You do not need any special privileges for this.
>> Do you want to probe now? (YES/no):
>>Probing for PCI bus adapters...
>>Use driver `i2c-sis645' for device 00:00.0: Silicon Integrated Systems=20
>>SIS648
>>Probe succesfully concluded.
>>
>> We will now try to load each adapter module in turn.
>>Module `i2c-sis645' already loaded.
>> Do you now want to be prompted for non-detectable adapters? (yes/NO): yes
>>Load `i2c-elektor' (say NO if built into your kernel)? (YES/no):
>>modprobe: Can't locate module i2c-elektor
>>Loading failed... skipping.
>>Load `i2c-elv' (say NO if built into your kernel)? (YES/no):
>>/lib/modules/2.4.21-0.18mdkcustom/kernel/drivers/i2c/i2c-elv.o:=20
>>init_module: No such device
>>Hint: insmod errors can be caused by incorrect module parameters,=20
>>including invalid IO or IRQ parameters.
>>      You may find more information in syslog or the output from dmesg
>>modprobe: insmod=20
>>/lib/modules/2.4.21-0.18mdkcustom/kernel/drivers/i2c/i2c-elv.o failed
>>modprobe: insmod i2c-elv failed
>>Loading failed... skipping.
>>Load `i2c-philips-par' (say NO if built into your kernel)? (YES/no):
>>Module loaded succesfully.
>>Load `i2c-velleman' (say NO if built into your kernel)? (YES/no):
>>/lib/modules/2.4.21-0.18mdkcustom/kernel/drivers/i2c/i2c-velleman.o:=20
>>init_module: No such device
>>Hint: insmod errors can be caused by incorrect module parameters,=20
>>including invalid IO or IRQ parameters.
>>      You may find more information in syslog or the output from dmesg
>>modprobe: insmod=20
>>/lib/modules/2.4.21-0.18mdkcustom/kernel/drivers/i2c/i2c-velleman.o failed
>>modprobe: insmod i2c-velleman failed
>>Loading failed... skipping.
>> To continue, we need module `i2c-dev' to be loaded.
>> If it is built-in into your kernel, you can safely skip this.
>>i2c-dev is already loaded.
>>
>> We are now going to do the adapter probings. Some adapters may hang=20
>>halfway
>> through; we can't really help that. Also, some chips will be double=20
>>detected;
>> we choose the one with the highest confidence value in that case.
>> If you found that the adapter hung after probing a certain address,=20
>>you can
>> specify that address to remain unprobed. That often
>> includes address 0x69 (clock chip).
>>Segmentation fault
>>
>>
>>*******************************************************************
>>Information supplied by dmesg
>>*******************************************************************
>>i2c-elv.o: i2c ELV parallel port adapter module version 2.8.0-CVS (2003xx=
xx)
>>i2c-velleman.o: i2c Velleman K8000 adapter module version 2.8.0-CVS=20
>>(2003xxxx)
>>Unable to handle kernel paging request at virtual address 00040031
>> printing eip:
>>e255baa5
>>*pde =3D 00000000
>>Oops: 0000
>>sg snd-pcm-oss snd-mixer-oss ppdev i2c-dev i2c-philips-par i2c-algo-bit=20
>>i2c-sis645 ohci1394 ieee1394 snd-intel8x0 snd-pcm snd-timer snd-mpu401-ua=
rt
>>snd-rawmidi snd-seq-device snd-ac97-codec snd-page-alloc snd ehci-hcd=20
>>emu10k1-gp gameport i2c-core udf sr_mod floppy binfmt_misc lp nvidia=20
>>parport_pc parport ipt_TOS ipt_MASQUERADE ipt_LOG ipt_REJECT ipt_state=20
>>iptable_mangle ip_nat_irc ip_nat_ftp iptable_nat ip_conntrack_irc=20
>>ip_conntrack_ftp ip_conntrack iptable_filter ip_tables audigy ac97_codec =

>>sound soundcore ppp_async ppp_generic slhc sis900 af_packet=20
>>nls_iso8859-15 acm ntfs supermount
>>ide-cd cdrom ide-scsi scsi_mod usbmouse keybdev mousedev adiusbadsl=20
>>scanner hid input usb-ohci usbcore rtc ext3 jbd
>>CPU:    0
>>EIP:    0010:[<e255baa5>]    Tainted: PF
>>EFLAGS: 00210206
>>EIP is at read_bus_i2c+0x55/0xc0 [i2c-core]
>>eax: 00040009   ebx: 00000006   ecx: fffffffb   edx: e255e29e
>>esi: 00000000   edi: d71c2000   ebp: 00000c00   esp: d1891f44
>>ds: 0018   es: 0018   ss: 0018
>>Process sensors-detect (pid: 16192, stackpage=D1891000)
>>Stack: d1891f94 c013515d c0340e6c d3e35f00 00000c00 d71c2000 d1891f98=20
>>c0163e63
>>       d71c2000 d1891f88 00000000 00000c00 d1891f84 00000000 d6dfe620=20
>>00000000
>>       00000000 00000000 0826b7d0 d3e35ee0 00001000 d1891fbc c01438c4=20
>>d3e35ee0
>>Call Trace:
>> [<c013515d>] do_brk+0xfd/0x1e0 [kernel]
>> [<c0163e63>] proc_file_read+0xa3/0x1c0 [kernel]
>> [<c01438c4>] sys_read+0x84/0x100 [kernel]
>> [<c0109093>] system_call+0x33/0x40 [kernel]
>>
>>Code: 8b 50 28 85 d2 74 46 8b 40 24 85 c0 74 36 50 50 68 9f e2 55
>>
>>*******************************************************************
>>Result of lspci
>>*******************************************************************
>>00:00.0 Host bridge: Silicon Integrated Systems [SiS]: Unknown device=20
>>0648 (rev 02)
>>00:01.0 PCI bridge: Silicon Integrated Systems [SiS] SiS 530 Virtual=20
>>PCI-to-PCI bridge (AGP)
>>00:02.0 ISA bridge: Silicon Integrated Systems [SiS]: Unknown device=20
>>0963 (rev 04)
>>00:02.1 SMBus: Silicon Integrated Systems [SiS]: Unknown device 0016
>>00:02.3 FireWire (IEEE 1394): Silicon Integrated Systems [SiS] FireWire=20
>>Controller
>>00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE]
>>00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS]=20
>>SiS7012 PCI Audio Accelerator (rev a0)
>>00:03.0 USB Controller: Silicon Integrated Systems [SiS] SiS7001 USB=20
>>Controller (rev 0f)
>>00:03.1 USB Controller: Silicon Integrated Systems [SiS] SiS7001 USB=20
>>Controller (rev 0f)
>>00:03.2 USB Controller: Silicon Integrated Systems [SiS] SiS7001 USB=20
>>Controller (rev 0f)
>>00:03.3 USB Controller: Silicon Integrated Systems [SiS] SiS7002 USB 2.0
>>00:04.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900=20
>>10/100 Ethernet (rev 91)
>>00:0c.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev =
0a)
>>00:0c.1 Input device controller: Creative Labs SB Live! MIDI/Game Port=20
>>(rev 0a)
>>00:0e.0 RAID bus controller: Promise Technology, Inc. PDC20376 (rev 02)
>>01:00.0 VGA compatible controller: nVidia Corporation NV28 [GeForce4 Ti=20
>>4200 AGP 8x] (rev a1)
>>
>>
>>
>=20
>=20
> Regards,
>=20


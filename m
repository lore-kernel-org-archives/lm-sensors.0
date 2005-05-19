From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:02 +0000
Subject: support for p4s8x motherboard
Message-Id: <20030626031859.GB22687@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <3EFA15C6.5020503@cadesis.com>
In-Reply-To: <3EFA15C6.5020503@cadesis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

* Gaig? Pierre <pgaige@cadesis.com> [2003-06-25 23:36:06 +0200]:
> Hello,
>=20
> I have a P4S8X motherboard from Asustek.
> My system is Mandrake 9.1 with the latest 2.4.21 kernel from Mandrake=20
> Update. I have just install the latest i2c and lm_sensors from CVS but I =

> am not able to make them work (Your web site announce that these=20
> combination - 648/961 - should be supported with the CVS version). I am=20

Your lspci output says 648/963.  Shouldn't matter though, that is
supported in CVS also.

> not a developper so I can't help you much but here is the results of the =

> different commands.
> I hope it can help you improve your code.
> Thanks.

I suggest that you answer "no" to the question "Do you want to be prompted
for non-detectable adapters" when using sensors-detect.

I tried to repeat your results here (on my 645/961) but I could not.
My only other advice is to make sure that you have removed any sensors
or i2c packages which come with your distribution.

>=20
> *******************************************************************
> result of sensors-detect
> *******************************************************************
> [root@PC SOURCES]# sensors-detect
>  This program will help you to determine which I2C/SMBus modules you=20
> need to
>  load to use lm_sensors most effectively.
>  You need to have done a `make install', issued a `depmod -a' and made su=
re
>  `/etc/conf.modules' (or `/etc/modules.conf') contains the appropriate
>  module path before you can use some functions of this utility. Read
>  doc/modules for more information.
>  Also, you need to be `root', or at least have access to the=20
> /dev/i2c[-/]* files
>  for some things. You can use prog/mkdev/mkdev.sh to create these /dev=20
> files
>  if you do not have them already.
>  If you have patched your kernel and have some drivers built-in you can
>  safely answer NO if asked to load some modules. In this case, things may
>  seem a bit confusing, but they will still work.
>=20
>  BIOS vendor (ACPI): ASUS
>  System vendor (DMI): System Manufacturer
>  BIOS version (DMI): ASUS P4S8X ACPI BIOS Revision 1004
>  We can start with probing for (PCI) I2C or SMBus adapters.
>  You do not need any special privileges for this.
>  Do you want to probe now? (YES/no):
> Probing for PCI bus adapters...
> Use driver `i2c-sis645' for device 00:00.0: Silicon Integrated Systems=20
> SIS648
> Probe succesfully concluded.
>=20
>  We will now try to load each adapter module in turn.
> Module `i2c-sis645' already loaded.
>  Do you now want to be prompted for non-detectable adapters? (yes/NO): yes
> Load `i2c-elektor' (say NO if built into your kernel)? (YES/no):
> modprobe: Can't locate module i2c-elektor
> Loading failed... skipping.
> Load `i2c-elv' (say NO if built into your kernel)? (YES/no):
> /lib/modules/2.4.21-0.18mdkcustom/kernel/drivers/i2c/i2c-elv.o:=20
> init_module: No such device
> Hint: insmod errors can be caused by incorrect module parameters,=20
> including invalid IO or IRQ parameters.
>       You may find more information in syslog or the output from dmesg
> modprobe: insmod=20
> /lib/modules/2.4.21-0.18mdkcustom/kernel/drivers/i2c/i2c-elv.o failed
> modprobe: insmod i2c-elv failed
> Loading failed... skipping.
> Load `i2c-philips-par' (say NO if built into your kernel)? (YES/no):
> Module loaded succesfully.
> Load `i2c-velleman' (say NO if built into your kernel)? (YES/no):
> /lib/modules/2.4.21-0.18mdkcustom/kernel/drivers/i2c/i2c-velleman.o:=20
> init_module: No such device
> Hint: insmod errors can be caused by incorrect module parameters,=20
> including invalid IO or IRQ parameters.
>       You may find more information in syslog or the output from dmesg
> modprobe: insmod=20
> /lib/modules/2.4.21-0.18mdkcustom/kernel/drivers/i2c/i2c-velleman.o failed
> modprobe: insmod i2c-velleman failed
> Loading failed... skipping.
>  To continue, we need module `i2c-dev' to be loaded.
>  If it is built-in into your kernel, you can safely skip this.
> i2c-dev is already loaded.
>=20
>  We are now going to do the adapter probings. Some adapters may hang=20
> halfway
>  through; we can't really help that. Also, some chips will be double=20
> detected;
>  we choose the one with the highest confidence value in that case.
>  If you found that the adapter hung after probing a certain address,=20
> you can
>  specify that address to remain unprobed. That often
>  includes address 0x69 (clock chip).
> Segmentation fault
>=20
>=20
> *******************************************************************
> Information supplied by dmesg
> *******************************************************************
> i2c-elv.o: i2c ELV parallel port adapter module version 2.8.0-CVS (2003xx=
xx)
> i2c-velleman.o: i2c Velleman K8000 adapter module version 2.8.0-CVS=20
> (2003xxxx)
> Unable to handle kernel paging request at virtual address 00040031
>  printing eip:
> e255baa5
> *pde =3D 00000000
> Oops: 0000
> sg snd-pcm-oss snd-mixer-oss ppdev i2c-dev i2c-philips-par i2c-algo-bit=20
> i2c-sis645 ohci1394 ieee1394 snd-intel8x0 snd-pcm snd-timer snd-mpu401-ua=
rt
> snd-rawmidi snd-seq-device snd-ac97-codec snd-page-alloc snd ehci-hcd=20
> emu10k1-gp gameport i2c-core udf sr_mod floppy binfmt_misc lp nvidia=20
> parport_pc parport ipt_TOS ipt_MASQUERADE ipt_LOG ipt_REJECT ipt_state=20
> iptable_mangle ip_nat_irc ip_nat_ftp iptable_nat ip_conntrack_irc=20
> ip_conntrack_ftp ip_conntrack iptable_filter ip_tables audigy ac97_codec =

> sound soundcore ppp_async ppp_generic slhc sis900 af_packet=20
> nls_iso8859-15 acm ntfs supermount
> ide-cd cdrom ide-scsi scsi_mod usbmouse keybdev mousedev adiusbadsl=20
> scanner hid input usb-ohci usbcore rtc ext3 jbd
> CPU:    0
> EIP:    0010:[<e255baa5>]    Tainted: PF
> EFLAGS: 00210206
> EIP is at read_bus_i2c+0x55/0xc0 [i2c-core]
> eax: 00040009   ebx: 00000006   ecx: fffffffb   edx: e255e29e
> esi: 00000000   edi: d71c2000   ebp: 00000c00   esp: d1891f44
> ds: 0018   es: 0018   ss: 0018
> Process sensors-detect (pid: 16192, stackpage=D1891000)
> Stack: d1891f94 c013515d c0340e6c d3e35f00 00000c00 d71c2000 d1891f98=20
> c0163e63
>        d71c2000 d1891f88 00000000 00000c00 d1891f84 00000000 d6dfe620=20
> 00000000
>        00000000 00000000 0826b7d0 d3e35ee0 00001000 d1891fbc c01438c4=20
> d3e35ee0
> Call Trace:
>  [<c013515d>] do_brk+0xfd/0x1e0 [kernel]
>  [<c0163e63>] proc_file_read+0xa3/0x1c0 [kernel]
>  [<c01438c4>] sys_read+0x84/0x100 [kernel]
>  [<c0109093>] system_call+0x33/0x40 [kernel]
>=20
> Code: 8b 50 28 85 d2 74 46 8b 40 24 85 c0 74 36 50 50 68 9f e2 55
>=20
> *******************************************************************
> Result of lspci
> *******************************************************************
> 00:00.0 Host bridge: Silicon Integrated Systems [SiS]: Unknown device=20
> 0648 (rev 02)
> 00:01.0 PCI bridge: Silicon Integrated Systems [SiS] SiS 530 Virtual=20
> PCI-to-PCI bridge (AGP)
> 00:02.0 ISA bridge: Silicon Integrated Systems [SiS]: Unknown device=20
> 0963 (rev 04)
> 00:02.1 SMBus: Silicon Integrated Systems [SiS]: Unknown device 0016
> 00:02.3 FireWire (IEEE 1394): Silicon Integrated Systems [SiS] FireWire=20
> Controller
> 00:02.5 IDE interface: Silicon Integrated Systems [SiS] 5513 [IDE]
> 00:02.7 Multimedia audio controller: Silicon Integrated Systems [SiS]=20
> SiS7012 PCI Audio Accelerator (rev a0)
> 00:03.0 USB Controller: Silicon Integrated Systems [SiS] SiS7001 USB=20
> Controller (rev 0f)
> 00:03.1 USB Controller: Silicon Integrated Systems [SiS] SiS7001 USB=20
> Controller (rev 0f)
> 00:03.2 USB Controller: Silicon Integrated Systems [SiS] SiS7001 USB=20
> Controller (rev 0f)
> 00:03.3 USB Controller: Silicon Integrated Systems [SiS] SiS7002 USB 2.0
> 00:04.0 Ethernet controller: Silicon Integrated Systems [SiS] SiS900=20
> 10/100 Ethernet (rev 91)
> 00:0c.0 Multimedia audio controller: Creative Labs SB Live! EMU10k1 (rev =
0a)
> 00:0c.1 Input device controller: Creative Labs SB Live! MIDI/Game Port=20
> (rev 0a)
> 00:0e.0 RAID bus controller: Promise Technology, Inc. PDC20376 (rev 02)
> 01:00.0 VGA compatible controller: nVidia Corporation NV28 [GeForce4 Ti=20
> 4200 AGP 8x] (rev a1)
>=20
>=20
>=20

Regards,

--=20
Mark M. Hoffman
mhoffman@lightlink.com

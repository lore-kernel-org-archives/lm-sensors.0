From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:27 +0000
Subject: lm_sensors on Dell Poweredge 1400/2 proc/Linux 2.4.9
Message-Id: <3C17DBF6.96559126@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200112011735.MAA26327@thebook.com>
In-Reply-To: <200112011735.MAA26327@thebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

You appear to have two LM81's, at 0x2c and 2d.
Your piix4 bus driver is reporting chips at EVERY address
which isn't correct, it's probably some misbehaved chip
on the bus.
It's unlikely you should use the lm75 or ltc1710 drivers.

The ALARM outputs in sensors are correct, in that the
values are outside the min/max ranges.

You should add limits to the lm81 section of sensors.conf
and run 'sensors -s'. See the mtp008 section in that file
for an example of how to configure the two chips separately
if that is necessary.

mds



John Murtari wrote:
>=20
> Folks,
>         We are a web hosting provider and have several recent
> Dell Servers. Currently running RedHat 7.2, Kernel 2.4.9 --
> we downloaded the packages from your site ic2-2.6.2 & lm_sensors-2.6.2,
> went with the separate compile option.  Had to just download the
> kernel sources and rebuild/run the kernel first -- then built both
> your packages (as you suggest), and it went fine.
>=20
>         The info from "sensors" seems to make sense and we were
> fascinated by running a loop on just one of the CPUS and watching
> it's temperature rise (and also fan speed?).
>=20
>         Only thing we are wondering about is the number of ALARMS
> conditions on the CPUs.  The system is brand new and seems to be
> fine.  Would appreciate any guidance you might have.
>=20
>         Neat little product!
>=20
> ---- below, output from sensors_detect, sensors, /proc/cpuinfo & /proc/pc=
i,
> ----- and /etc/sensors.conf
>=20
>                                           John
> ___________________________________________________________________
> John Murtari                              Software Workshop Inc.
> jmurtari@thebook.com 315.635-1968(x-211)  "TheBook.Com" (TM)
> http://www.thebook.com/
>=20
> (SU-recover1)/export/tools/board_monitor/lm_sensors-2.6.2>prog/detect/sen=
sors_detect=08=08=08=08=08=08=08=1B[Pd=08=1B[1@-d=08
>  This program will help you to determine which I2C/SMBus modules you need=
 to
>  load to use lm_sensors most effectively.
>  You need to have done a `make install', issued a `depmod -a' and made su=
re
>  `/etc/conf.modules' (or `/etc/modules.conf') contains the appropriate
>  module path before you can use some functions of this utility. Read
>  doc/modules for more information.
>  Also, you need to be `root', or at least have access to the /dev/i2c[-/]=
* files
>  for some things. You can use prog/mkdev/mkdev.sh to create these /dev fi=
les
>  if you do not have them already.
>  If you have patched your kernel and have some drivers built-in you can
>  safely answer NO if asked to load some modules. In this case, things may
>  seem a bit confusing, but they will still work.
>=20
>  IF THIS IS AN IBM THINKPAD, PRESS CTRL-C NOW!
>  IBM Thinkpads have a severely broken i2c/SMBus implementation,  just sca=
nning
>  the bus will break your thinkpad forever!
>=20
>  We can start with probing for (PCI) I2C or SMBus adapters.
>  You do not need any special privileges for this.
>  Do you want to probe now? (YES/no):
> Probing for PCI bus adapters...
> Use driver `i2c-piix4' for device 00:0f.0: ServerWorks OSB4 South Bridge
> Probe succesfully concluded.
>=20
>  We will now try to load each adapter module in turn.
> Load `i2c-piix4' (say NO if built into your kernel)? (YES/no):
> Module loaded succesfully.
>  Do you now want to be prompted for non-detectable adapters? (yes/NO):
>  To continue, we need module `i2c-dev' to be loaded.
>  If it is built-in into your kernel, you can safely skip this.
>  i2c-dev is not loaded. Do you want to load it now? (YES/no):
>  Module loaded succesfully.
>=20
>  We are now going to do the adapter probings. Some adapters may hang half=
way
>  through; we can't really help that. Also, some chips will be double dete=
cted;
>  we choose the one with the highest confidence value in that case.
>  If you found that the adapter hung after probing a certain address, you =
can
>  specify that address to remain unprobed. That often
>  includes address 0x69 (clock chip).
>=20
> Next adapter: SMBus OSB4/CSB5 adapter at 0580 (Non-I2C SMBus adapter)
> Do you want to scan it? (YES/no/selectively):
> Client found at address 0x00
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x01
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x02
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x03
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x04
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x05
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x06
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x07
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x08
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x09
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x0a
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x0b
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x0c
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x0d
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x0e
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x0f
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x10
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x11
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x12
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x13
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x14
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x15
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x16
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x17
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x18
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Probing for `Analog Devices ADM1021'... Success!
>     (confidence 6, driver `adm1021')
> Probing for `Maxim MAX1617'... Success!
>     (confidence 3, driver `adm1021')
> Probing for `Maxim MAX1617A'... Failed!
> Probing for `TI THMC10'... Failed!
> Probing for `National Semiconductor LM84'... Failed!
> Probing for `Genesys Logic GL523SM'... Failed!
> Client found at address 0x19
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Probing for `Analog Devices ADM1021'... Failed!
> Probing for `Maxim MAX1617'... Failed!
> Probing for `Maxim MAX1617A'... Failed!
> Probing for `TI THMC10'... Failed!
> Probing for `National Semiconductor LM84'... Failed!
> Probing for `Genesys Logic GL523SM'... Failed!
> Client found at address 0x1a
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Probing for `Analog Devices ADM1021'... Failed!
> Probing for `Maxim MAX1617'... Failed!
> Probing for `Maxim MAX1617A'... Failed!
> Probing for `TI THMC10'... Failed!
> Probing for `National Semiconductor LM84'... Failed!
> Probing for `Genesys Logic GL523SM'... Failed!
> Client found at address 0x1b
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x1c
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x1d
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x1e
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x1f
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x20
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
> Client found at address 0x21
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
> Client found at address 0x22
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
> Client found at address 0x23
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
> Client found at address 0x24
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
> Client found at address 0x25
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
> Client found at address 0x26
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
> Client found at address 0x27
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
> Client found at address 0x28
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `National Semiconductor LM80'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
> Client found at address 0x29
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `National Semiconductor LM80'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Probing for `Analog Devices ADM1021'... Failed!
> Probing for `Maxim MAX1617'... Failed!
> Probing for `Maxim MAX1617A'... Failed!
> Probing for `TI THMC10'... Failed!
> Probing for `National Semiconductor LM84'... Failed!
> Probing for `Genesys Logic GL523SM'... Failed!
> Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
> Client found at address 0x2a
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `National Semiconductor LM80'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Probing for `Analog Devices ADM1021'... Failed!
> Probing for `Maxim MAX1617'... Failed!
> Probing for `Maxim MAX1617A'... Failed!
> Probing for `TI THMC10'... Failed!
> Probing for `National Semiconductor LM84'... Failed!
> Probing for `Genesys Logic GL523SM'... Failed!
> Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
> Client found at address 0x2b
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `National Semiconductor LM80'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Probing for `Analog Devices ADM1021'... Failed!
> Probing for `Maxim MAX1617'... Failed!
> Probing for `Maxim MAX1617A'... Failed!
> Probing for `TI THMC10'... Failed!
> Probing for `National Semiconductor LM84'... Failed!
> Probing for `Genesys Logic GL523SM'... Failed!
> Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
> Client found at address 0x2c
> Probing for `Myson MTP008'... Failed!
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `National Semiconductor LM80'... Failed!
> Probing for `National Semiconductor LM87'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Probing for `Genesys Logic GL518SM Revision 0x00'... Failed!
> Probing for `Genesys Logic GL518SM Revision 0x80'... Failed!
> Probing for `Genesys Logic GL520SM'... Failed!
> Probing for `Analog Devices ADM9240'... Failed!
> Probing for `Dallas Semiconductor DS1780'... Failed!
> Probing for `National Semiconductor LM81'... Success!
>     (confidence 7, driver `adm9240')
> Probing for `Analog Devices ADM1025'... Failed!
> Probing for `Analog Devices ADM1024'... Failed!
> Probing for `Analog Devices ADM1022'... Failed!
> Probing for `Texas Instruments THMC50'... Failed!
> Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
> Client found at address 0x2d
> Probing for `Myson MTP008'... Failed!
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `National Semiconductor LM80'... Failed!
> Probing for `National Semiconductor LM87'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Probing for `Genesys Logic GL518SM Revision 0x00'... Failed!
> Probing for `Genesys Logic GL518SM Revision 0x80'... Failed!
> Probing for `Genesys Logic GL520SM'... Failed!
> Probing for `Genesys Logic GL525SM'... Failed!
> Probing for `Analog Devices ADM9240'... Failed!
> Probing for `Dallas Semiconductor DS1780'... Failed!
> Probing for `National Semiconductor LM81'... Success!
>     (confidence 7, driver `adm9240')
> Probing for `Analog Devices ADM1025'... Failed!
> Probing for `Analog Devices ADM1024'... Failed!
> Probing for `Analog Devices ADM1022'... Failed!
> Probing for `Texas Instruments THMC50'... Failed!
> Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
> Client found at address 0x2e
> Probing for `Myson MTP008'... Failed!
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `National Semiconductor LM80'... Failed!
> Probing for `National Semiconductor LM87'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Probing for `Analog Devices ADM9240'... Failed!
> Probing for `Dallas Semiconductor DS1780'... Failed!
> Probing for `National Semiconductor LM81'... Failed!
> Probing for `Analog Devices ADM1025'... Failed!
> Probing for `Analog Devices ADM1024'... Failed!
> Probing for `Analog Devices ADM1022'... Failed!
> Probing for `Texas Instruments THMC50'... Failed!
> Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
> Client found at address 0x2f
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `National Semiconductor LM80'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Probing for `Analog Devices ADM9240'... Failed!
> Probing for `Dallas Semiconductor DS1780'... Failed!
> Probing for `National Semiconductor LM81'... Failed!
> Probing for `Analog Devices ADM1022'... Failed!
> Probing for `Texas Instruments THMC50'... Failed!
> Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
> Client found at address 0x30
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x31
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x32
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x33
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x34
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x35
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x36
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x37
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x38
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x39
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x3a
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x3b
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x3c
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x3d
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x3e
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x3f
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x40
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x41
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x42
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x43
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x44
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x45
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x46
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x47
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x48
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `National Semiconductor LM75'... Success!
>     (confidence 3, driver `lm75')
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Probing for `Dallas Semiconductor DS1621'... Failed!
> Client found at address 0x49
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `National Semiconductor LM75'... Success!
>     (confidence 3, driver `lm75')
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Probing for `Dallas Semiconductor DS1621'... Failed!
> Client found at address 0x4a
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `National Semiconductor LM75'... Success!
>     (confidence 3, driver `lm75')
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Probing for `Dallas Semiconductor DS1621'... Failed!
> Client found at address 0x4b
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `National Semiconductor LM75'... Success!
>     (confidence 3, driver `lm75')
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Probing for `Dallas Semiconductor DS1621'... Failed!
> Client found at address 0x4c
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `National Semiconductor LM75'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Probing for `Dallas Semiconductor DS1621'... Failed!
> Probing for `Analog Devices ADM1021'... Success!
>     (confidence 6, driver `adm1021')
> Probing for `Maxim MAX1617'... Success!
>     (confidence 3, driver `adm1021')
> Probing for `Maxim MAX1617A'... Failed!
> Probing for `TI THMC10'... Failed!
> Probing for `National Semiconductor LM84'... Failed!
> Probing for `Genesys Logic GL523SM'... Failed!
> Client found at address 0x4d
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `National Semiconductor LM75'... Success!
>     (confidence 3, driver `lm75')
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Probing for `Dallas Semiconductor DS1621'... Failed!
> Probing for `Analog Devices ADM1021'... Failed!
> Probing for `Maxim MAX1617'... Failed!
> Probing for `Maxim MAX1617A'... Failed!
> Probing for `TI THMC10'... Failed!
> Probing for `National Semiconductor LM84'... Failed!
> Probing for `Genesys Logic GL523SM'... Failed!
> Client found at address 0x4e
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `National Semiconductor LM75'... Success!
>     (confidence 3, driver `lm75')
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Probing for `Dallas Semiconductor DS1621'... Failed!
> Probing for `Analog Devices ADM1021'... Failed!
> Probing for `Maxim MAX1617'... Failed!
> Probing for `Maxim MAX1617A'... Failed!
> Probing for `TI THMC10'... Failed!
> Probing for `National Semiconductor LM84'... Failed!
> Probing for `Genesys Logic GL523SM'... Failed!
> Client found at address 0x4f
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `National Semiconductor LM75'... Success!
>     (confidence 3, driver `lm75')
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Probing for `Dallas Semiconductor DS1621'... Failed!
> Client found at address 0x50
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Probing for `Serial EEPROM (PC-100 DIMM)'... Success!
>     (confidence 8, driver `eeprom')
> Probing for `DDC monitor'... Failed!
> Client found at address 0x51
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Probing for `Serial EEPROM (PC-100 DIMM)'... Success!
>     (confidence 8, driver `eeprom')
> Client found at address 0x52
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Probing for `Serial EEPROM (PC-100 DIMM)'... Success!
>     (confidence 8, driver `eeprom')
> Client found at address 0x53
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Probing for `Serial EEPROM (PC-100 DIMM)'... Success!
>     (confidence 1, driver `eeprom')
> Client found at address 0x54
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Probing for `Serial EEPROM (PC-100 DIMM)'... Success!
>     (confidence 1, driver `eeprom')
> Client found at address 0x55
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Probing for `Serial EEPROM (PC-100 DIMM)'... Success!
>     (confidence 1, driver `eeprom')
> Client found at address 0x56
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Probing for `Serial EEPROM (PC-100 DIMM)'... Success!
>     (confidence 1, driver `eeprom')
> Client found at address 0x57
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Probing for `Serial EEPROM (PC-100 DIMM)'... Success!
>     (confidence 1, driver `eeprom')
> Client found at address 0x58
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Probing for `LTC1710'... Success!
>     (confidence 1, driver `ltc1710')
> Client found at address 0x59
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Probing for `LTC1710'... Success!
>     (confidence 1, driver `ltc1710')
> Client found at address 0x5a
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Probing for `LTC1710'... Success!
>     (confidence 1, driver `ltc1710')
> Client found at address 0x5b
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x5c
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x5d
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x5e
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x5f
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x60
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x61
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x62
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x63
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x64
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x65
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x66
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x67
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x68
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x69
> Client found at address 0x6a
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x6b
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x6c
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x6d
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x6e
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x6f
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x70
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x71
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x72
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x73
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Probing for `FSC poseidon chip'... Failed!
> Probing for `FSC Scylla chip'... Failed!
> Client found at address 0x74
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x75
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x76
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x77
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x78
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x79
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x7a
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x7b
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x7c
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x7d
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x7e
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Client found at address 0x7f
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
>=20
>  Some chips are also accessible through the ISA bus. ISA probes are
>  typically a bit more dangerous, as we have to write to I/O ports to do
>  this.  Do you want to scan the ISA bus? (YES/no):
> Probing for `National Semiconductor LM78'
>   Trying address 0x0290... Failed!
> Probing for `National Semiconductor LM78-J'
>   Trying address 0x0290... Failed!
> Probing for `National Semiconductor LM79'
>   Trying address 0x0290... Failed!
> Probing for `Winbond W83781D'
>   Trying address 0x0290... Failed!
> Probing for `Winbond W83782D'
>   Trying address 0x0290... Failed!
> Probing for `Winbond W83627HF'
>   Trying address 0x0290... Failed!
> Probing for `Winbond W83697HF'
>   Trying address 0x0290... Failed!
> Probing for `Silicon Integrated Systems SIS5595'
>   Trying general detect... Failed!
> Probing for `VIA Technologies VT 82C686 Integrated Sensors'
>   Trying general detect... Failed!
> Probing for `ITE IT8705F / IT8712F / SiS 950'
>   Trying address 0x0290... Failed!
>=20
>  Now follows a summary of the probes I have just done.
>  Just press ENTER to continue:
>=20
> Driver `adm1021' (should be inserted but causes problems):
>   Detects correctly:
>   * Bus `SMBus OSB4/CSB5 adapter at 0580' (Non-I2C SMBus adapter)
>     Busdriver `UNKNOWN', I2C address 0x18
>     Chip `Analog Devices ADM1021' (confidence: 6)
>   * Bus `SMBus OSB4/CSB5 adapter at 0580' (Non-I2C SMBus adapter)
>     Busdriver `UNKNOWN', I2C address 0x4c
>     Chip `Analog Devices ADM1021' (confidence: 6)
>   Misdetects:
>   * Bus `SMBus OSB4/CSB5 adapter at 0580' (Non-I2C SMBus adapter)
>     Busdriver `UNKNOWN', I2C address 0x18
>     Chip `Maxim MAX1617' (confidence: 3)
>   * Bus `SMBus OSB4/CSB5 adapter at 0580' (Non-I2C SMBus adapter)
>     Busdriver `UNKNOWN', I2C address 0x4c
>     Chip `Maxim MAX1617' (confidence: 3)
>=20
> Driver `adm9240' (should be inserted):
>   Detects correctly:
>   * Bus `SMBus OSB4/CSB5 adapter at 0580' (Non-I2C SMBus adapter)
>     Busdriver `UNKNOWN', I2C address 0x2c
>     Chip `National Semiconductor LM81' (confidence: 7)
>   * Bus `SMBus OSB4/CSB5 adapter at 0580' (Non-I2C SMBus adapter)
>     Busdriver `UNKNOWN', I2C address 0x2d
>     Chip `National Semiconductor LM81' (confidence: 7)
>=20
> Driver `lm75' (should be inserted):
>   Detects correctly:
>   * Bus `SMBus OSB4/CSB5 adapter at 0580' (Non-I2C SMBus adapter)
>     Busdriver `UNKNOWN', I2C address 0x48
>     Chip `National Semiconductor LM75' (confidence: 3)
>   * Bus `SMBus OSB4/CSB5 adapter at 0580' (Non-I2C SMBus adapter)
>     Busdriver `UNKNOWN', I2C address 0x49
>     Chip `National Semiconductor LM75' (confidence: 3)
>   * Bus `SMBus OSB4/CSB5 adapter at 0580' (Non-I2C SMBus adapter)
>     Busdriver `UNKNOWN', I2C address 0x4a
>     Chip `National Semiconductor LM75' (confidence: 3)
>   * Bus `SMBus OSB4/CSB5 adapter at 0580' (Non-I2C SMBus adapter)
>     Busdriver `UNKNOWN', I2C address 0x4b
>     Chip `National Semiconductor LM75' (confidence: 3)
>   * Bus `SMBus OSB4/CSB5 adapter at 0580' (Non-I2C SMBus adapter)
>     Busdriver `UNKNOWN', I2C address 0x4d
>     Chip `National Semiconductor LM75' (confidence: 3)
>   * Bus `SMBus OSB4/CSB5 adapter at 0580' (Non-I2C SMBus adapter)
>     Busdriver `UNKNOWN', I2C address 0x4e
>     Chip `National Semiconductor LM75' (confidence: 3)
>   * Bus `SMBus OSB4/CSB5 adapter at 0580' (Non-I2C SMBus adapter)
>     Busdriver `UNKNOWN', I2C address 0x4f
>     Chip `National Semiconductor LM75' (confidence: 3)
>=20
> Driver `eeprom' (should be inserted):
>   Detects correctly:
>   * Bus `SMBus OSB4/CSB5 adapter at 0580' (Non-I2C SMBus adapter)
>     Busdriver `UNKNOWN', I2C address 0x50
>     Chip `Serial EEPROM (PC-100 DIMM)' (confidence: 8)
>   * Bus `SMBus OSB4/CSB5 adapter at 0580' (Non-I2C SMBus adapter)
>     Busdriver `UNKNOWN', I2C address 0x51
>     Chip `Serial EEPROM (PC-100 DIMM)' (confidence: 8)
>   * Bus `SMBus OSB4/CSB5 adapter at 0580' (Non-I2C SMBus adapter)
>     Busdriver `UNKNOWN', I2C address 0x52
>     Chip `Serial EEPROM (PC-100 DIMM)' (confidence: 8)
>   * Bus `SMBus OSB4/CSB5 adapter at 0580' (Non-I2C SMBus adapter)
>     Busdriver `UNKNOWN', I2C address 0x53
>     Chip `Serial EEPROM (PC-100 DIMM)' (confidence: 1)
>   * Bus `SMBus OSB4/CSB5 adapter at 0580' (Non-I2C SMBus adapter)
>     Busdriver `UNKNOWN', I2C address 0x54
>     Chip `Serial EEPROM (PC-100 DIMM)' (confidence: 1)
>   * Bus `SMBus OSB4/CSB5 adapter at 0580' (Non-I2C SMBus adapter)
>     Busdriver `UNKNOWN', I2C address 0x55
>     Chip `Serial EEPROM (PC-100 DIMM)' (confidence: 1)
>   * Bus `SMBus OSB4/CSB5 adapter at 0580' (Non-I2C SMBus adapter)
>     Busdriver `UNKNOWN', I2C address 0x56
>     Chip `Serial EEPROM (PC-100 DIMM)' (confidence: 1)
>   * Bus `SMBus OSB4/CSB5 adapter at 0580' (Non-I2C SMBus adapter)
>     Busdriver `UNKNOWN', I2C address 0x57
>     Chip `Serial EEPROM (PC-100 DIMM)' (confidence: 1)
>=20
> Driver `ltc1710' (should be inserted):
>   Detects correctly:
>   * Bus `SMBus OSB4/CSB5 adapter at 0580' (Non-I2C SMBus adapter)
>     Busdriver `UNKNOWN', I2C address 0x58
>     Chip `LTC1710' (confidence: 1)
>   * Bus `SMBus OSB4/CSB5 adapter at 0580' (Non-I2C SMBus adapter)
>     Busdriver `UNKNOWN', I2C address 0x59
>     Chip `LTC1710' (confidence: 1)
>   * Bus `SMBus OSB4/CSB5 adapter at 0580' (Non-I2C SMBus adapter)
>     Busdriver `UNKNOWN', I2C address 0x5a
>     Chip `LTC1710' (confidence: 1)
>=20
>  I will now generate the commands needed to load the I2C modules.
>  Sometimes, a chip is available both through the ISA bus and an I2C bus.
>  ISA bus access is faster, but you need to load an additional driver modu=
le
>  for it. If you have the choice, do you want to use the ISA bus or the
>  I2C/SMBus (ISA/smbus)?
>=20
> WARNING! If you have some things built into your kernel, the
> below list will contain too many modules. Skip the appropriate ones!
> To load everything that is needed, add this to some /etc/rc* file:
>=20
> #----cut here----
> # I2C adapter drivers
> # modprobe unknown adapter SMBus OSB4/CSB5 adapter at 0580 using Non-I2C =
SMBus adapter
> # I2C chip drivers
> modprobe adm1021
> modprobe adm9240
> modprobe lm75
> modprobe eeprom
> modprobe ltc1710
> #----cut here----
>=20
> To make the sensors modules behave correctly, add these lines to either
> /etc/modules.conf or /etc/conf.modules:
>=20
> #----cut here----
> # I2C module options
> alias char-major-89 i2c-dev
> options adm1021 ignore=3D0,0x18,0,0x4c
> #----cut here----
> (SU-recover1)/export/tools/board_monitor/lm_sensors-2.6.2>modprobe adm1021
> (SU-recover1)/export/tools/board_monitor/lm_sensors-2.6.2>modprobe adm9240
> (SU-recover1)/export/tools/board_monitor/lm_sensors-2.6.2>modprobe lm75
> (SU-recover1)/export/tools/board_monitor/lm_sensors-2.6.2>modprobe eeprom
> (SU-recover1)/export/tools/board_monitor/lm_sensors-2.6.2>modprobe ltc1710
> (SU-recover1)/export/tools/board_monitor/lm_sensors-2.6.2>sen=08=1B[K=08=
=1B[K=08=1B[Kprog/sensors/sensors -2
> prog/sensors/sensors: invalid option -- 2
> Try `sensors -h' for more information
> (SU-recover1)/export/tools/board_monitor/lm_sensors-2.6.2>prog/sensors/se=
nsors -2=08=1B[Ks
> (SU-recover1)/export/tools/board_monitor/lm_sensors-2.6.2>prog/sensors/se=
nsors -s=08=1B[K=08=1B[K=08
> lm81-i2c-0-2c
> Adapter: SMBus OSB4/CSB5 adapter at 0580
> Algorithm: Non-I2C SMBus adapter
> 2.5V:      +2.46 V  (min =3D  +2.22 V, max =3D  +2.72 V)
> Vccp1:     +1.72 V  (min =3D  +2.40 V, max =3D  +2.93 V)   ALARM
> 3.3V:      +3.30 V  (min =3D  +2.93 V, max =3D  +3.59 V)
> 5V:        +5.05 V  (min =3D  +4.45 V, max =3D  +5.44 V)
> 12V:      +11.43 V  (min =3D +10.68 V, max =3D +13.06 V)
> Vccp2:     +1.47 V  (min =3D  +2.40 V, max =3D  +2.93 V)   ALARM
> fan1:     2777 RPM  (min =3D 3000 RPM, div =3D 2)          ALARM
> fan2:        0 RPM  (min =3D 3000 RPM, div =3D 2)          ALARM
> temp:      +26.0?C  (limit =3D  +60?C, hysteresis =3D  +50?C)
> vid:      +1.75 V
> alarms:   Chassis intrusion detection
>=20
> lm81-i2c-0-2d
> Adapter: SMBus OSB4/CSB5 adapter at 0580
> Algorithm: Non-I2C SMBus adapter
> 2.5V:      +0.00 V  (min =3D  +2.22 V, max =3D  +2.72 V)   ALARM
> Vccp1:     +1.72 V  (min =3D  +2.40 V, max =3D  +2.93 V)   ALARM
> 3.3V:      +0.94 V  (min =3D  +2.93 V, max =3D  +3.59 V)   ALARM
> 5V:        +4.89 V  (min =3D  +4.45 V, max =3D  +5.44 V)
> 12V:      +11.37 V  (min =3D +10.68 V, max =3D +13.06 V)
> Vccp2:     +1.47 V  (min =3D  +2.40 V, max =3D  +2.93 V)   ALARM
> fan1:     2689 RPM  (min =3D 3000 RPM, div =3D 2)          ALARM
> fan2:        0 RPM  (min =3D 3000 RPM, div =3D 2)          ALARM
> temp:      +26.0?C  (limit =3D  +60?C, hysteresis =3D  +50?C)
> vid:      +1.75 V
> alarms:   Chassis intrusion detection
>=20
> lm75-i2c-0-48
> Adapter: SMBus OSB4/CSB5 adapter at 0580
> Algorithm: Non-I2C SMBus adapter
> temp:       -0.5?C  (limit =3D  -0.5?C, hysteresis =3D  -0.5?C)
>=20
> lm75-i2c-0-49
> Adapter: SMBus OSB4/CSB5 adapter at 0580
> Algorithm: Non-I2C SMBus adapter
> temp:       -0.5?C  (limit =3D  -0.5?C, hysteresis =3D  -0.5?C)
>=20
> lm75-i2c-0-4a
> Adapter: SMBus OSB4/CSB5 adapter at 0580
> Algorithm: Non-I2C SMBus adapter
> temp:       -0.5?C  (limit =3D  -0.5?C, hysteresis =3D  -0.5?C)
>=20
> lm75-i2c-0-4b
> Adapter: SMBus OSB4/CSB5 adapter at 0580
> Algorithm: Non-I2C SMBus adapter
> temp:       -0.5?C  (limit =3D  -0.5?C, hysteresis =3D  -0.5?C)
>=20
> lm75-i2c-0-4d
> Adapter: SMBus OSB4/CSB5 adapter at 0580
> Algorithm: Non-I2C SMBus adapter
> temp:       -0.5?C  (limit =3D  -0.5?C, hysteresis =3D  -0.5?C)
>=20
> lm75-i2c-0-4e
> Adapter: SMBus OSB4/CSB5 adapter at 0580
> Algorithm: Non-I2C SMBus adapter
> temp:       -0.5?C  (limit =3D  -0.5?C, hysteresis =3D  -0.5?C)
>=20
> lm75-i2c-0-4f
> Adapter: SMBus OSB4/CSB5 adapter at 0580
> Algorithm: Non-I2C SMBus adapter
> temp:       -0.5?C  (limit =3D  -0.5?C, hysteresis =3D  -0.5?C)
>=20
> eeprom-i2c-0-50
> Adapter: SMBus OSB4/CSB5 adapter at 0580
> Algorithm: Non-I2C SMBus adapter
> Memory type:            SDRAM DIMM SPD
> SDRAM Size (MB):        512
>=20
> eeprom-i2c-0-51
> Adapter: SMBus OSB4/CSB5 adapter at 0580
> Algorithm: Non-I2C SMBus adapter
> Memory type:            SDRAM DIMM SPD
> SDRAM Size (MB):        512
>=20
> eeprom-i2c-0-52
> Adapter: SMBus OSB4/CSB5 adapter at 0580
> Algorithm: Non-I2C SMBus adapter
> Memory type:            SDRAM DIMM SPD
> SDRAM Size (MB):        128
>=20
> eeprom-i2c-0-53
> Adapter: SMBus OSB4/CSB5 adapter at 0580
> Algorithm: Non-I2C SMBus adapter
>=20
> eeprom-i2c-0-54
> Adapter: SMBus OSB4/CSB5 adapter at 0580
> Algorithm: Non-I2C SMBus adapter
>=20
> eeprom-i2c-0-55
> Adapter: SMBus OSB4/CSB5 adapter at 0580
> Algorithm: Non-I2C SMBus adapter
>=20
> eeprom-i2c-0-56
> Adapter: SMBus OSB4/CSB5 adapter at 0580
> Algorithm: Non-I2C SMBus adapter
>=20
> eeprom-i2c-0-57
> Adapter: SMBus OSB4/CSB5 adapter at 0580
> Algorithm: Non-I2C SMBus adapter
>=20
> ltc1710-i2c-0-58
> Adapter: SMBus OSB4/CSB5 adapter at 0580
> Algorithm: Non-I2C SMBus adapter
>=20
> ltc1710-i2c-0-59
> Adapter: SMBus OSB4/CSB5 adapter at 0580
> Algorithm: Non-I2C SMBus adapter
>=20
> ltc1710-i2c-0-5a
> Adapter: SMBus OSB4/CSB5 adapter at 0580
> Algorithm: Non-I2C SMBus adapter
>=20
> ----- out of cpuinfo
> (SU-recover1)/export/tools/board_monitor/lm_sensors-2.6.2/prog>cat /proc/=
cpuinfo
> processor       : 0
> vendor_id       : GenuineIntel
> cpu family      : 6
> model           : 8
> model name      : Pentium III (Coppermine)
> stepping        : 10
> cpu MHz         : 927.174
> cache size      : 256 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 2
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mc=
a cmov pat pse36 mmx fxsr sse
> bogomips        : 1848.11
>=20
> processor       : 1
> vendor_id       : GenuineIntel
> cpu family      : 6
> model           : 8
> model name      : Pentium III (Coppermine)
> stepping        : 10
> cpu MHz         : 927.174
> cache size      : 256 KB
> fdiv_bug        : no
> hlt_bug         : no
> f00f_bug        : no
> coma_bug        : no
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 2
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mc=
a cmov pat pse36 mmx fxsr sse
> bogomips        : 1848.11
>=20
> ---- output of /proc/pci
>=20
> PCI devices found:
>   Bus  0, device   0, function  0:
>     Host bridge: ServerWorks CNB20LE Host Bridge (rev 6).
>       Master Capable.  LatencyH.
>   Bus  0, device   0, function  1:
>     Host bridge: ServerWorks CNB20LE Host Bridge (#2) (rev 6).
>       Master Capable.  LatencyH.
>   Bus  0, device   2, function  0:
>     Ethernet controller: Intel Corporation 82557 [Ethernet Pro 100] (rev =
8).
>       IRQ 16.
>       Master Capable.  Latency2.  Min Gnt=3D8.Max LatV.
>       Non-prefetchable 32 bit memory at 0xfe102000 [0xfe102fff].
>       I/O at 0xecc0 [0xecff].
>       Non-prefetchable 32 bit memory at 0xfe000000 [0xfe0fffff].
>   Bus  0, device  14, function  0:
>     VGA compatible controller: ATI Technologies Inc Rage XL (rev 39).
>       Master Capable.  Latency2.  Min Gnt=3D8.
>       Non-prefetchable 32 bit memory at 0xfc000000 [0xfcffffff].
>       I/O at 0xe800 [0xe8ff].
>       Non-prefetchable 32 bit memory at 0xfe101000 [0xfe101fff].
>   Bus  0, device  15, function  0:
>     ISA bridge: ServerWorks OSB4 South Bridge (rev 80).
>   Bus  0, device  15, function  1:
>     IDE interface: ServerWorks OSB4 IDE Controller (rev 0).
>       Master Capable.  Latencyd.
>       I/O at 0x8b0 [0x8bf].
>   Bus  0, device  15, function  2:
>     USB Controller: ServerWorks OSB4/CSB5 OHCI USB Controller (rev 4).
>       IRQ 10.
>       Master Capable.  Latency2.  Max Lat=80.
>       Non-prefetchable 32 bit memory at 0xfe100000 [0xfe100fff].
>   Bus  1, device   2, function  0:
>     SCSI storage controller: Adaptec 7899P (rev 1).
>       IRQ 30.
>       Master Capable.  Latency2.  Min Gnt@.Max Lat%.
>       I/O at 0xdc00 [0xdcff].
>       Non-prefetchable 64 bit memory at 0xf9001000 [0xf9001fff].
>   Bus  1, device   2, function  1:
>     SCSI storage controller: Adaptec 7899P (#2) (rev 1).
>       IRQ 31.
>       Master Capable.  Latency2.  Min Gnt@.Max Lat%.
>       I/O at 0xd800 [0xd8ff].
>       Non-prefetchable 64 bit memory at 0xf9000000 [0xf9000fff].
>=20
> ----- output of sensors.conf
>=20
> # Sensors configuration file used by 'libsensors'
> #------------------------------------------------
> #
> ##########################################################################
> #                                                                        #
> #    PLEASE READ THIS HELPFUL HINT!!!                                    #
> #                                                                        #
> #       The 'set' lines (generally for min and max values)               #
> #       do not take effect until you run 'sensors -s' as root !!!        #
> #       We suggest you put 'sensors -s' in a /etc/rc.d/... file          #
> #       to be run at boot time after the modules are inserted !!!        #
> #                                                                        #
> ##########################################################################
> #
> #
> # OVERVIEW
> # --------
> # This configuration file will be used by all userspace applications
> # linked to libsensors. It is NOT used by the lm_sensors drivers directly.
> #
> # This config file consists of two parts: the heavily commented LM78
> # example, and the real parts. Search for '####' if you want to skip
> # to the real stuff.
> #
> # Hash marks introduce comments, which continue until the end of a line
> #
> # Identifiers consisting of only digits and letters can be used
> # unquoted; other identifiers must be quoted. Escape characters within
> # quotes operate like those in C.
> #
> #
> # CHIP LINES
> # ----------
> # A 'chip' line specifies what the following 'label', 'compute', 'set' and
> # 'ignore' lines refer to. In this case, until the
> # next 'chip' line, everything refers to all lm78, lm78-j and lm79
> # chips. Other examples are *-isa-* for everything on the ISA bus, and
> # lm78-j-i2c-*-4e for all lm78-j chips on address 0x4e of any I2C bus.
> #
> # If more chip statements match a specific chip, they are all considered.
> # Later lines overrule earlier lines, so if you set the in0 label for
> # lm78-* to "This", and later on the in0 label for lm78-isa-* to "That",
> # "That" is used for LM78 chips on the ISA bus, and "This" for LM78
> # chips on a non-ISA bus.
> #
> #       chip "lm78-*" "lm78-j-*" "lm79-*"
> #
> #
> # FEATURE NAMES
> # -------------
> # Feature names are used in 'label', 'compute', 'set', and 'ignore' lines.
> # Example feature names are 'in0', 'temp2', 'in3_min', and 'temp3_over'.
> # These features are defined for each chip in lib/chips.c.
> #
> # Undefined features will be silently ignored in 'label' and 'compute' li=
nes.
> # Undefined features in 'set' lines will result in 'Unknonw feature name'
> # when running 'sensors -s'.
> #
> # Unfortunately, feature names starting with a number must be in
> # double quotes or you get 'parse error, expecting 'NAME''.
> #
> # If you have trouble, verify the features in lib/chips.c!!!
> #
> #
> # LABEL LINES
> # -----------
> # A label line describes what a certain feature stands for on your
> # mainboard. Programs can retrieve these names and display them.
> # If no label is specified for a certain feature, the default name
> # (ie. 'fan1' for fan1) is used.
> #
> # If you specify a label for in1, this label is also used for in1_min and
> # in1_max, unless they have their own labels declared. There are several
> # of these logical groups.
> #
> # These are as advised in the LM78 and LM79 data sheets, and used on most
> # boards we have seen.
> #
> #       label in0 "VCore 1"
> #       label in1 "VCore 2"
> #       label in2 "+3.3V"
> #       label in3 "+5V"
> #       label in4 "+12V"
> #       label in5 "-12V"
> #       label in6 "-5V"
> #
> #
> # COMPUTE LINES
> # -------------
> # A compute line describes how to scale a certain feature. There are
> # two expressions in it: the first describes how the /proc value must
> # be translated to a user value, the second how a user value must be
> # translated to a /proc value. '@' is the value to operate on. You may
> # refer to other readable features (like '2 * vid').
> #
> # Like for the label statement, there are logical groups here. They are
> # sometimes a bit different, though. For example, fan1_div is in the
> # logical label group of fan1 (it gets the same label if none is declared
> # for it), but it is not in the compute group of fan1 (as it uses a
> # completely different system of values).
> #
> #
> # VOLTAGE COMPUTATION DETAILS
> # ---------------------------
> # Most voltage sensors in sensor chips have a range of 0 to 4.096 Volts.
> # This is generally sufficient for the 3.3 and CPU (2.5V, for example)
> # supply voltages, so the sensor chip reading is the actual voltage.
> #
> # Other supply voltages must be scaled with an external resistor network.
> # The chip driver generally reports the 'raw' value 0 - 4.09 V, and the
> # userspace application must convert this raw value to an actual voltage.
> # The 'compute' lines provide this facility.
> #
> # Unfortunately the resistor values vary among motherboard types.
> # Therefore you may have to adjust the computations in this file
> # to match your motherboard.
> #
> # For positive voltages (in3, in4), two resistors are used, with the foll=
owing
> # formula (R1,R2: resistor values, Vs: read voltage, Vin: pin voltage)
> #       R1 =3D R2 * (Vs/Vin - 1)
> # For negative voltages (in5, in6) two resistors are used, with the follo=
wing
> # formula (Rin,Rf: resistor values, Vs: read voltage, Vin: pin voltage)
> #       Rin =3D (Vs * Rf) / Vin
> #
> # Note: Some chips use a different formula, see it87 section for example.
> #
> # Here are the official LM78 and LM79 data sheet values.
> #             Vs     R1,Rin   R2,Rf    Vin
> #       in3   +5.0      6.8    10     +2.98
> #       in4  +12.0     30      10     +3.00
> #       in5  -12.0    240      60     +3.00
> #       in6   -5.0    100      60     +3.00
> #
> # These would lead to these declarations:
> #       compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
> #       compute in4 ((30/10)+1)*@  ,  @/((30/10)+1)
> #       compute in5 -(240/60)*@    ,  -@/(240/60)
> #       compute in6 -(100/60)*@    ,  -@/(100/60)
> #
> # On almost any mainboard we have seen, the Winbond compute values lead to
> # much better results, though.
> #
> #             Vs     R1,Rin   R2,Rf    Vin
> #       in4  +12.0     28      10     +3.00
> #       in5  -12.0    210      60.4   +3.00
> #       in6   -5.0     90.9    60.4   +3.00
> #
> # These leads to these declarations:
> #       compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
> #       compute in4 ((28/10)+1)*@  ,  @/((28/10)+1)
> #       compute in5 -(210/60.4)*@  ,  -@/(210/60.4)
> #       compute in6 -(90.9/60.4)*@ ,  -@/(90.9/60.4)
> #
> #
> # SET LINES
> # ---------
> # Set statements set things like limits. Complete expressions can be
> # used. Not everything can sensibly be set: setting 'in0', for example,
> # is impossible! These settings are put through the compute translations;
> # so if we specify '12.8' for in6, '3.2' will actually be written!
> #
> # Important note: In the 'sensors' program, these only take effect
> # after running 'sensors -s'!!!
> #
> # Here are some examples:
> #
> #       set in0_max vid*1.05
> #       set in0_min vid*0.95
> #       set temp1_over 40
> #       set temp1_hyst 37
> #
> # Think of tempx_over as 'alarm set' and tempx_hyst as 'alarm clear'
> # thresholds. In most cases the 'over' value should be higher than
> # the 'hyst' value by several degrees.
> #
> #
> # IGNORE LINES
> # ------------
> # Ignore statements tell certain features are not wanted. User programs c=
an
> # still read them if they really want, though; this is just an advisory
> # marking. 'in0' would also invalidate 'in0_max' and 'in0_min'.
> # 'ignore' does not disable anything in the actual sensor chip; it
> # simply advises the user program to not access that data.
> #
> #       ignore in0
> #
> #
> # BUS LINES
> # ---------
> # There is one other feature: the 'bus' statement. An example is below.
> #
> #       bus "i2c-0" "SMBus PIIX4 adapter at e800" "Non-I2C SMBus adapter"
> #
> # If we refer from now on to 'i2c-0' in 'chip' lines, this will run-time
> # be matched to this bus. So even if the PIIX4 is called 'i2c-5' at that
> # moment, because five other adapters were detected first, 'i2c-0' in
> # the config file would always only match this physical bus. In the above
> # config file, this feature is not needed; but the next lines would
> # only affect the LM75 chips on the PIIX4 adapter:
> #
> #       chip "lm75-i2c-0-*"
> #
> # You should really use the output of /proc/bus/chips to generate bus lin=
es,
> # because one mistyped characted will inhibit the match. Wildcards are not
> # yet supported; spaces at the end are ignored, though.
> #
> #
> ##########################################################################
> #### Here begins the real configuration file
>=20
> chip "lm78-*" "lm78-j-*" "lm79-*" "w83781d-*"
>=20
> # These are as advised in the LM78 and LM79 data sheets, and used on almo=
st
> # any mainboard we have seen.
>=20
>     label in0 "VCore 1"
>     label in1 "VCore 2"
>     label in2 "+3.3V"
>     label in3 "+5V"
>     label in4 "+12V"
>     label in5 "-12V"
>     label in6 "-5V"
>=20
> # For positive voltages (in3, in4), two resistors are used, with the foll=
owing
> # formula (R1,R2: resistor values, Vs: read voltage, Vin: pin voltage)
> #   R1 =3D R2 * (Vs/Vin - 1)
> # For negative voltages (in5, in6) two resistors are used, with the follo=
wing
> # formula (Rin,Rf: resistor values, Vs: read voltage, Vin: pin voltage)
> #   Rin =3D (Vs * Rf) / Vin
> #
> # Here are the official LM78 and LM79 data sheet values.
> #       Vs     R1,Rin   R2,Rf    Vin
> # in3   +5.0      6.8    10     +2.98
> # in4  +12.0     30      10     +3.00
> # in5  -12.0    240      60     +3.00
> # in6   -5.0    100      60     +3.00
> #
> # These would lead to these declarations:
> # compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
> # compute in4 ((30/10)+1)*@  ,  @/((30/10)+1)
> # compute in5 -(240/60)*@    ,  -@/(240/60)
> # compute in6 -(100/60)*@    ,  -@/(100/60)
> #
> # On almost any mainboard we have seen, the Winbond compute values lead to
> # much better results, though.
> #
> #       Vs     R1,Rin   R2,Rf    Vin
> # in4  +12.0     28      10     +3.00
> # in5  -12.0    210      60.4   +3.00
> # in6   -5.0     90.9    60.4   +3.00
> #
> # These leads to these declarations:
>=20
>     compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
>     compute in4 ((28/10)+1)*@  ,  @/((28/10)+1)
>     compute in5 -(210/60.4)*@  ,  -@/(210/60.4)
>     compute in6 -(90.9/60.4)*@ ,  -@/(90.9/60.4)
>=20
> # Here, we assume the VID readings are valid, and we use a max. 5% deviat=
ion
>=20
>     set in0_min vid*0.95
>     set in0_max vid*1.05
>     set in1_min vid*0.95
>     set in1_max vid*1.05
>     set in2_min 3.3 * 0.95
>     set in2_max 3.3 * 1.05
>     set in3_min 5.0 * 0.95
>     set in3_max 5.0 * 1.05
>     set in4_min 12 * 0.95
>     set in4_max 12 * 1.05
>     set in5_min -12 * 0.95
>     set in5_max -12 * 1.05
>     set in6_min -5 * 0.95
>     set in6_max -5 * 1.05
>=20
> # examples for lm78, lm78j, lm79 temperature limits;
> #    set temp_over 40
> #    set temp_hyst 37
>=20
> # examples for w83781d temperature limits
> #    set temp1_over 40
> #    set temp1_hyst 37
> #    set temp2_over 52
> #    set temp2_hyst 47
> #    set temp3_over 52
> #    set temp3_hyst 47
>=20
> chip "sis5595-*"
>=20
>     label in0 "VCore 1"
>     label in1 "VCore 2"
>     label in2 "+3.3V"
>     label in3 "+5V"
>     label in4 "+12V"
>=20
>     compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
>     compute in4 ((28/10)+1)*@  ,  @/((28/10)+1)
>=20
>     set in0_min 2.0 * 0.95
>     set in0_max 2.0 * 1.05
>     set in1_min 2.0 * 0.95
>     set in1_max 2.0 * 1.05
>     set in2_min 3.3 * 0.95
>     set in2_max 3.3 * 1.05
>     set in3_min 5.0 * 0.95
>     set in3_max 5.0 * 1.05
>     set in4_min 12 * 0.95
>     set in4_max 12 * 1.05
>=20
> #
> # SiS5595 temperature calculation
> # The driver currently includes a calculation due to the wide
> # variation in thermistor types on SiS5595 motherboards.
> # The driver currently has a calculation of t =3D (.83x + 52.12).
> # One user reports the correct formula of t =3D (.345x - 12).
> # So you want to put a compute line in sensors.conf that has
> # the inverse of the driver formula, and put your formula on top of it.
> # The inverse of the driver formula is x =3D (1.20t - 62.77)
> # So the final formula is newt =3D (.345(1.20t - 62.77)) - 12).
> # Put this in the sensors.conf file as
> # compute temp ((.345 * ((1.20 * @) - 62.77)) - 12), ...
> # where ... is the inverse function I leave to you.
> #
> # Look in your 'Vendor.ini' file to see which one is present
> # on your motherboard. Look for the line like:
> #       [Temp1]
> #            ThermistorType     =3D NTC-10KC15-1608-1P
> # Fix up a 'compute' line to match your thermistor type.
> # Warning. You still don't have enough information to do this.
> #            ThermistorType     =3D NTC-10KC15-1608-1P (10K at 25C; Beta =
=3D 3435)
> #   compute temp ((X * ((1.20 * @) - 62.77)) - Y), ...
> #            ThermistorType     =3D NTC-103KC15-1608-1P  (??)
> #   compute temp ((X * ((1.20 * @) - 62.77)) - Y), ...
> #            ThermistorType     =3D NTC-103AT-2 (10K at 25C; Beta =3D 343=
5)
> #   compute temp ((X * ((1.20 * @) - 62.77)) - Y), ...
> #            ThermistorType     =3D NTC-103JT   (10K at 25C; Beta =3D 343=
5)
> #   compute temp ((X * ((1.20 * @) - 62.77)) - Y), ...
>=20
> # examples for sis5595 temperature limits;
> # for sis5595, temp_hyst is really the low limit, not a hysteresis value
> #    set temp_over 40
> #    set temp_hyst 37
>=20
> chip "w83782d-*" "w83783s-*" "w83627hf-*"
>=20
> # Same as above for w83781d except that in5 and in6 are computed differen=
tly.
> # Rather than an internal inverting op amp, the 82d/83s use standard posi=
tive
> # inputs and the negative voltages are level shifted by a 3.6V reference.
> # The math is convoluted, so we hope that your motherboard
> # uses the recommended resistor values.
>=20
>     label in0 "VCore 1"
>     label in1 "VCore 2"
>     label in2 "+3.3V"
>     label in3 "+5V"
>     label in4 "+12V"
>     label in5 "-12V"
>     label in6 "-5V"
>     label in7 "V5SB"
>     label in8 "VBat"
>=20
>     compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
>     compute in4 ((28/10)+1)*@  ,  @/((28/10)+1)
>     compute in5 (5.14 * @) - 14.91  ,  (@ + 14.91) / 5.14
>     compute in6 (3.14 * @) -  7.71  ,  (@ +  7.71) / 3.14
>     compute in7 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
>=20
> # set limits to  5% for the critical voltages
> # set limits to 10% for the non-critical voltages
> # set limits to 20% for the battery voltage
>=20
>     set in0_min vid*0.95
>     set in0_max vid*1.05
>     set in1_min vid*0.95
>     set in1_max vid*1.05
>     set in2_min 3.3 * 0.95
>     set in2_max 3.3 * 1.05
>     set in3_min 5.0 * 0.95
>     set in3_max 5.0 * 1.05
>     set in4_min 12 * 0.90
>     set in4_max 12 * 1.10
>     set in5_min -12 * 0.90
>     set in5_max -12 * 1.10
>     set in6_min -5 * 0.95
>     set in6_max -5 * 1.05
>     set in7_min 5 * 0.95
>     set in7_max 5 * 1.05
>     set in8_min 3.0 * 0.80
>     set in8_max 3.0 * 1.20
>=20
> # set up sensor types (thermistor is default)
> # 1 =3D PII/Celeron Diode; 2 =3D 3904 transistor;
> # 3435 =3D thermistor with Beta =3D 3435
> # If temperature changes very little, try 1 or 2.
> #   set sensor1 1
> #   set sensor2 2
> #   set sensor3 3435
>=20
> # examples for temperature limits
> #    set temp1_over 40
> #    set temp1_hyst 37
> #    set temp2_over 52
> #    set temp2_hyst 47
> #    set temp3_over 52
> #    set temp3_hyst 47
>=20
> chip "as99127f-*"
>=20
> # Same as above for w83782d except that in5 and in6 negative voltages
> # are computed as in the w83781d.
> # Asus won't release a datasheet so this is guesswork.
> # New in5 and temp2 calculations courtesy Guntram Blohm.
>=20
>     label in0 "VCore 1"
>     label in1 "VCore 2"
>     label in2 "+3.3V"
>     label in3 "+5V"
>     label in4 "+12V"
>     label in5 "-12V"
>     label in6 "-5V"
>=20
>     compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
>     compute in4 ((28/10)+1)*@  ,  @/((28/10)+1)
>     compute in5 -(240/60.4)*@ ,  -@/(240/60.4)
>     compute in6 -(90.9/60.4)*@ ,  -@/(90.9/60.4)
>=20
>     compute temp2 (@*30/43)+25, (@-25)*43/30
>=20
> # set limits to  5% for the critical voltages
> # set limits to 10% for the non-critical voltages
> # set limits to 20% for the battery voltage
>=20
>     set in0_min vid*0.95
>     set in0_max vid*1.05
>     set in1_min vid*0.95
>     set in1_max vid*1.05
>     set in2_min 3.3 * 0.95
>     set in2_max 3.3 * 1.05
>     set in3_min 5.0 * 0.95
>     set in3_max 5.0 * 1.05
>     set in4_min 12 * 0.90
>     set in4_max 12 * 1.10
>     set in5_min -12 * 0.90
>     set in5_max -12 * 1.10
>     set in6_min -5 * 0.95
>     set in6_max -5 * 1.05
>=20
> # examples for temperature limits
> #    set temp1_over 40
> #    set temp1_hyst 37
> #    set temp2_over 52
> #    set temp2_hyst 47
> #    set temp3_over 52
> #    set temp3_hyst 47
>=20
> chip "gl518sm-*"
>=20
> # Factors and labels taken from GL518SM datasheet, they seem to give
> # reasonable values with EISCA connected Fan78
>=20
>   label vdd "+5V"
>   label vin1 "+3.3V"
>   label vin2 "+12V"
>   label vin3 "Vcore"
>=20
> # vin2 depends on external resistors (4,7k and 15k assumed here)
> # vin1 and vin3 require no scaling
>=20
>   compute vin2 (197/47)*@  ,  @/(197/47)
>=20
>   set vdd_min 4.8
>   set vdd_max 5.2
>   set vin1_min 3.20
>   set vin1_max 3.40
>   set vin2_min 11.0
>   set vin2_max 13.0
>   set vin3_min 2.10
>   set vin3_max 2.30
>   set fan1_off 0
>   set fan2_min 0
>   set iterate 0
>=20
> chip "gl520sm-*"
>=20
> # Factors and labels taken from GL520SM datasheet
>=20
>   label vdd "+5V"
>   label vin1 "+3.3V"
>   label vin2 "+12V"
>   label vin3 "Vcore"
>   label vin4 "-12V"
>=20
> # vin1 and vin3 require no scaling
> # vin2 depends on external resistors (4,7k and 15k assumed)
>=20
> # vin4 =3D ((R1+R2)/R2)*@ - (R1/R2)*vdd
> #
> #       -12 --| R1 |---t---| R2 |-- +5
> #                      |
> #                    vin4
> #
>=20
>   compute vin2 (197/47)*@  ,  @/(197/47)
>   compute vin4 (5*@)-(4*vdd) , (@+4*vdd)/5
>=20
>   set vdd_min 4.8
>   set vdd_max 5.2
>   set vin1_min 3.20
>   set vin1_max 3.40
>   set vin2_min 11.0
>   set vin2_max 13.0
>   set vin3_min 2.10
>   set vin3_max 2.30
>   set two_temps 1
>=20
> chip "lm80-*"
>=20
> # The values below should be correct if you own a qdi BX (brilliant1)
> # mainboard. If not, please contact us, so we can figure out better readi=
ngs.
> # Many thanks go to Peter T. Breuer <ptb@it.uc3m.es> for helping us figure
> # out how to handle the LM80.
>=20
> # For positive voltages (in0..in4), two resistors are used, with the foll=
owing
> # formula (R1,R2: resistor values, Vs: read voltage, Vin: pin voltage)
> #   R1 =3D R2 * (Vs/Vin - 1)
> # For negative voltages (in5, in6) two resistors are used, with the follo=
wing
> # formula (R3,R4: resistor values, Vs: read voltage, Vin: pin voltage,
> # V5: +5V)
> #   R3 =3D R4 * (Vs - Vin) / (Vin - V5)
>=20
> # Here are the official LM78 and LM79 data sheet values.
> #       Vs      R1,R3   R2,R4    Vin
> #       +2.5V    23.7    75     +1.9
> #       +3.3V    22.1    30     +1.9
> #       +5.0     24      14.7   +1.9
> #      +12.0    160      30.1   +1.9
> #      -12.0    160      35.7   +1.9
> #       -5.0     36      16.2   +1.9
>=20
> # Now curiously enough, VCore is connected with (unknown) resistors, which
> # translate a +2.8V to +1.9V. So we use that in the computations below.
>=20
>     label in0 "+5V"
>     label in1 "VTT"
>     label in2 "+3.3V"
>     label in3 "+Vcore"
>     label in4 "+12V"
>     label in5 "-12V"
>     label in6 "-5V"
>=20
>     compute in0 (24/14.7 + 1) * @ ,       @ / (24/14.7 + 1)
>     compute in2 (22.1/30 + 1) * @ ,       @ / (22.1/30 + 1)
>     compute in3 (2.8/1.9) * @,            @ * 1.9/2.8
>     compute in4 (160/30.1 + 1) * @,       @ / (160/30.1 + 1)
>     compute in5 (160/35.7)*(@ - in0) + @, (@ + in0 * 160/35.7)/ (1 + 160/=
35.7)
>     compute in6 (36/16.2)*(@ - in0) + @,  (@ + in0 * 36/16.2) / (1 + 36/1=
6.2)
>=20
>     set in0_min 5 * 0.95
>     set in0_max 5 * 0.95
> # What is your VTT? It is probably not this value...
>     set in1_min 2*0.95
>     set in1_max 2*1.05
>     set in2_min 3.3 * 0.95
>     set in2_max 3.3 * 1.05
> # What is your VCore? It is probably not this value...
>     set in3_min 1.9 * 0.95
>     set in3_max 1.9 * 1.05
>     set in4_min 12 * 0.95
>     set in4_max 12 * 1.05
>     set in5_min -12 * 1.05
>     set in5_max -12 * 0.95
>     set in6_min -5 * 1.05
>     set in6_max -5 * 0.95
>=20
> # examples for lm80 temperature limits
> # WARNING - nonstandard names and functions for the lm80!!!
> # All 4 of these limits apply to the single temperature sensor.
> # "hot" is like the standard alarm for most chips.
> # "os" is the threshold for the overtemperature shutdown output.
> # "os" may or may not do anything on your motherboard but it should
> #  be set higher than the "hot" thresholds.
> # Note that the /proc file 'temp" also has five entries instead of
> # the usual three.
> #    set temp_hot_hyst 45
> #    set temp_hot_max  52
> #    set temp_os_hyst  57
> #    set temp_os_max   62
>=20
> chip "maxilife-cg-*" "maxilife-co-*" "maxilife-as-*"
>=20
>    label fan1  "HDD Fan"
>    label fan2  "PCI Fan"
>    label fan3  "CPU Fan"
>    ignore fan4
>=20
>    label temp2 "PCI Temp"
>    label temp4 "HDD Temp"
>    label temp5 "CPU Temp"
>    ignore temp6
>=20
>    label vid1  "V+12"
>    ignore vid5
>=20
> # vid1 need to be scaled by 6.337 other voltages
> # require no scaling
>=20
>    compute vid1 6.337*@ , @/6.337
>=20
> chip "maxilife-cg-*"
>=20
>    ignore temp1
>    label temp3  "BX Temp"
>=20
>    label vid2   "Vcpu1"
>    label vid3   "Vcpu2"
>    ignore vid4
>=20
> chip "maxilife-co-*"
>=20
>    label temp1  "CPU 1 Temp"
>    label temp3  "CPU 2 Temp"
>=20
>    label vid2   "Vcpu1"
>    label vid3   "Vcpu2"
>    label vid4   "VcacheL2"
>=20
> chip "maxilife-as-*"
>=20
>    ignore temp1
>    ignore temp3
>=20
>    label vid2   "Vcpu"
>    ignore vid3
>    ignore vid4
>=20
> chip "maxilife-nba-*"
>=20
>    label fan1  "CPU Fan"
>    label fan2  "PCI Fan"
>    label fan3  "HDD Fan"
>    label fan4  "Heat Sink Fan"
>=20
>    label temp1  "CPU 1 Temp"
>    label temp2  "CPU 2 Temp"
>    label temp3  "PCI/Ambient Temp"
>    label temp4  "HDD Temp"
>    label temp5  "Motherboard Temp"
>    label temp6  "CPU Reference Temp"
>=20
>    label vid1  "V+12"
>    label vid2  "Vcpu1"
>    label vid3  "Vcpu2"
>    label vid4  "VcacheL2"
>    label vid5  "V-12"
>=20
> chip "via686a-*"
>=20
> # VIA is very specific about the voltage sensor inputs, and our labels
> # reflect what they say.  Unfortunately, they are not at all specific abo=
ut
> # how to convert any of the register values to real units.  Fortunately,
> # Jonathan Yew <j.teh@iname.com> and Alex van Kaam <darkside@chello.nl>
> # came through with some data for temp conversion and formulae for voltage
> # conversion. However, the conversions should be regarded as our best gue=
ss-
> # YMMV.
>=20
> # On the Tyan S1598, the 2.5V sensor reads 0 and is not displayed in the =
BIOS.
> # Linas Vepstas <linas@linas.org> reports that this sensor shows nothing =
of
> # interest on the Abit KA7 (Athlon), and is also not displayed in the BIO=
S.
> # Likewise, Johannes Drechsel-Burkhard <jdb@chello.at> reports that this
> # sensor is unavailable in the BIOS of his MSI K7T Pro (Thunderbird).  So,
> # if you have one of these boards you may want to uncomment the 'ignore 2=
.5V'
> # line below.
>=20
>     label "2.0V" "CPU core"
>     label "2.5V" "+2.5V"
>     #ignore "2.5V"
>     label "3.3V" "I/O"
>     label "5.0V" "+5V"
>     label "12V" "+12V"
>=20
>     label fan1  "CPU Fan"
>     label fan2  "P/S Fan"
>=20
> # VIA suggests that temp3 is an internal temp sensor for the 686a.  Howev=
er,
> # on the Tyan S1598 as well as the Abit KA7 (Athalon), the absolute values
> # of the readings from that sensor are not valid.  The readings do seem to
> # correlate with temp changes, but the conversion factor may be quite
> # different from temp1 & temp2 (as noted above, VIA has not provided
> # conversion info).  So, you may wish to 'ignore temp3'.
>=20
> # Johannes Drechsel-Burkhard <jdb@chello.at> notes that on his MSI K7T Pr=
o,
> # temp1 is the CPU temp and temp2 is the SYS temp.
>=20
>     label temp1 "SYS Temp"
>     label temp2 "CPU Temp"
>     label temp3 "SBr Temp"
>     #ignore temp3
>=20
> # Set your CPU core limits here.  For the other voltage sensors, the
> # built-in defaults should be fine.
>=20
>     set in0_min 2.0
>     set in0_max 2.5
>=20
> # Set your temp limits here.  Remember, 'tempX_over' is the temp at which=
 an
> # alarm is triggered, and 'tempX_hyst' is the temp at which an alarm turn=
s off.
> # Setting tempX_hyst to a few degrees below the corresponding tempX_over
> # prevents an oscillation between alarm on and off states.  This kind of
> # oscillation is known as hyteresis, thus the name.  (You typically get t=
he
> # most serious and troublesome hysteresis when a sensor triggers somethin=
g to
> # reduce the temp, thus creating a negative feedback loop.  Even without =
that,
> # we would still get some oscillation when the temp hovers around the lim=
it
> # due to noise.)
>=20
>     set temp1_hyst 40
>     set temp1_over 45
>     set temp2_hyst 55
>     set temp2_over 60
>     set temp3_hyst 60
>     set temp3_over 65
>=20
> # You could set your fan limits too, but the defaults should be fine.
>=20
>     #set fan1_min 5000
>     #set fan2_min 5000
>=20
> # For at least one Tyan S1598, the following corrections make the sensors
> # readings more in-line with the BIOS readings on boot.  Try these, and
> # adjust as necessary.
>=20
>   #compute "2.0V" 1.02*@ ,  @/1.02
>   #compute "3.3V" 1.02*@  ,  @/1.02
>   #compute "5.0V" 1.009*@  ,  @/1.009
>   #compute "12V" 1.04*@ ,  @/1.04
>=20
> chip "mtp008-*"
>=20
> # The values below should be correct if you own a Tyan S1834D motherboard.
> # If not, please contact us, so we can figure out better readings.
> # FOR TYAN S2510 SEE END OF THIS SECTION.
>=20
> # For positive voltages outside the 0..4.09V range (in2..in4), two resist=
ors
> # are used, with the following formula (R1,R2: resistor values, Vs: read
> # voltage, Vin: pin voltage)
> #   Vin =3D Vs * (R2 / (R1 + R2))
> # For negative voltages (in5) two resistors are used, with the following
> # formula (R3,R4: resistor values, Vs: read voltage, Vin: pin voltage)
> #   Vin =3D ((4.096 - Vs) * (R3 / (R3 + R4))) + Vs
>=20
> # Here are the official MTP008 data sheet values:
> #       Vs      R1,R3   R2,R4    Vin
> #      +12.0    28000   10000   +3.16
> #      -12.0   232000   56000   +0.96
> #       -5.0   120000   56000   +1.20
>=20
>     label in0 "VCore1"
>     label in1 "+3.3V"
>     label in2 "+12V"
>     label in3 "Vcore2"
>     ignore in4
>     label in5 "-12V"
>     label in6 "Vtt"
>=20
>     label fan1 "CPU1 Fan"
>     label fan2 "CPU2 Fan"
>     label fan3 "fan3"
>=20
>     label temp1 "CPU1 Temp"
>     label temp2 "CPU2 Temp"
>     ignore temp3
>=20
>     compute in2 @ * 38 / 10,            @ * 10 / 38
>     compute in5 (@ * 36 - 118.61) / 7,  (118.61 + 7 * @) / 36
>=20
> # examples for temperature limits
> #    set temp1_over 40
> #    set temp1_hyst 37
> #    set temp2_over 52
> #    set temp2_hyst 47
> #    set temp3_over 52
> #    set temp3_hyst 47
>=20
> # End of standard mtp008 configuration
>=20
> # TYAN S2510 INFORMATION
> # This motherboard has two mtp008's which are hooked up differently,
> # so they must be configured separately.
> # For this motherboard, COMMENT OUT the above mtp008 section and
> # UNCOMMENT the following two sections.
> #
> #chip "mtp008-i2c-*-2c"
> #    label in0 "VCore1"
> #    set in0_min 1.60
> #    set in0_max 1.80
> #    label in1 "+3.3V"
> #    label in2 "+12V"
> #    label in3 "Vcore2"
> #    set in3_min 1.60
> #    set in3_max 1.80
> #    ignore in4
> #    label in5 "-12V"
> #    label in6 "Vtt"
> #    label fan1 "CPU1 Fan"
> #    label fan2 "CPU2 Fan"
> #    label fan3 "fan3"
> #    label temp1 "CPU1 Temp"
> #    label temp2 "CPU2 Temp"
> #    ignore temp3
> #    compute in2 @ * 38 / 10,           @ * 10 / 38
> #    compute in5 (@ * 36 - 118.61) / 7, (118.61 + 7 * @) / 36
> #
> #chip "mtp008-i2c-*-2e"
> #    ignore in0
> #    label in1 "+3.3V"
> #    ignore in2
> #    label in3 "+5V"
> #    set in3_min 4.50
> #    set in3_max 5.50
> #    ignore in4
> #    label in5 "+3.3V"
> #    ignore in6
> #    label fan1 "fan4"
> #    label fan2 "fan5"
> #    label fan3 "fan6"
> #    ignore temp1
> #    label temp2 "MB Temp"
> #    set temp2_over 52
> #    set temp2_hyst 47
> #    ignore temp3
>=20
> chip "adm1025-*"
>=20
> # These are as advised in the data sheet
>=20
>     label in0 "+2.5V"
>     label in1 "VCCP"
>     label in2 "+3.3V"
>     label in3 "+5V"
>     label in4 "+12V"
>     label in5 "VCC"
>=20
>     label temp1 "SYS Temp"
>     label temp2 "CPU Temp"
>=20
> chip "lm87-*"
> #
> # This chip has non-standard entries in lib/chips.c so
> # the feature names are quite different from other chips.
> # For this chip, libsensors anticipates the correct labeling.
> # This is great if it's correct but makes it a little more
> # difficult if you want to change it.
> #
> # This may not have been a good idea, so it may be changed in the future.
> # Here is an entry with everything commented out so you can
> # uncomment the appropriate line if you want to change it.
> #
> # Warning - feature names starting with a number must be enclosed
> # with double quotes.
> #
> #   label "2.5V" "xxx"
> #   label Vccp1 "xxx"
> #   label "3.3V" "xxx"
> #   label "5V" "xxx"
> #   label "12V" "xxx"
> #   label Vccp2 "xxx"
> #   label AIN1 "xxx"
> #   label AIN2 "xxx"
> #   label fan1 "xxx"
> #   label fan2 "xxx"
> #   label temp1 "xxx"
> #   label CPU_Temp "xxx"
> #   label CPU2_Temp "xxx"
> #
> #   set AmbTemp_min xxx
> #   set Vccp1_min xxx
> #   set "3.3V_min" xxx
> #   set "5V_min" xxx
> #   set "12V_min" xxx
> #   set Vccp2_min xxx
> #   set AIN1_min xxx
> #   set AIN2_min xxx
> #
> #   set AmbTemp_max xxx
> #   set Vccp1_max xxx
> #   set "3.3V_max" xxx
> #   set "5V_max" xxx
> #   set "12V_max" xxx
> #   set Vccp2_max xxx
> #   set AIN1_max xxx
> #   set AIN2_max xxx
> #
> #   set fan1_min xxx
> #   set fan2_min xxx
> #   set temp1_min xxx
> #   set temp1_max xxx
> #   set temp2_min xxx
> #   set temp2_max xxx
> #   set temp3_min xxx
> #   set temp3_max xxx
> #   set fan1_div xxx
> #   set fan2_div xxx
>=20
> #   compute "2.5V" xxx
> #   compute Vccp1 xxx
> #   compute "3.3V" xxx
> #   compute "5V" xxx
> #   compute "12V" xxx
> #   compute Vccp2 xxx
> #   compute AIN1 xxx
> #   compute AIN2 xxx
> #   compute temp1 xxx
> #   compute CPU_Temp xxx
> #   compute CPU2_Temp xxx
>=20
> chip "adm9240-*" "ds1780-*" "lm81-*"
> #
> # These chips have non-standard entries in lib/chips.c so
> # the feature names are quite different from other chips.
> # For these chips, libsensors anticipates the correct labeling.
> # This is great if it's correct but makes it a little more
> # difficult if you want to change it.
> #
> # This may not have been a good idea, so it may be changed in the future.
> # Here is an entry with everything commented out so you can
> # uncomment the appropriate line if you want to change it.
> #
> # Warning - feature names starting with a number must be enclosed
> # with double quotes.
> #
> #   label "2.5V" "xxx"
> #   label Vccp1 "xxx"
> #   label "3.3V" "xxx"
> #   label "5V" "xxx"
> #   label "12V" "xxx"
> #   label Vccp2 "xxx"
> #   label fan1 "xxx"
> #   label fan2 "xxx"
> #   label temp "xxx"
> #
> #   set Vccp1_min xxx
> #   set "2.5V_min" xxx
> #   set "3.3V_min" xxx
> #   set "5V_min" xxx
> #   set "12V_min" xxx
> #   set Vccp2_min xxx
> #
> #   set Vccp1_max xxx
> #   set "2.5V_max" xxx
> #   set "3.3V_max" xxx
> #   set "5V_max" xxx
> #   set "12V_max" xxx
> #   set Vccp2_max xxx
> #
> #   set fan1_min xxx
> #   set fan2_min xxx
> #   set temp1_hyst xxx
> #   set temp1_over xxx
> #   set fan1_div xxx
> #   set fan2_div xxx
>=20
> #   compute "2.5V" xxx
> #   compute Vccp1 xxx
> #   compute "3.3V" xxx
> #   compute "5V" xxx
> #   compute "12V" xxx
> #   compute Vccp2 xxx
> #   compute temp xxx
>=20
> chip "adm1024-*"
> #
> # These settings work for me, adjust for your system
> #
>     label fan1 "CPU1 fan"
>     label fan2 "CPU2 fan"
>     label temp "SYS Temp"
>     label temp1 "CPU2 Temp"
>     label temp2 "CPU1 Temp"
>     ignore "2.5V" # This register is also used for temp2
>     ignore "Vccp1"
>     ignore "Vccp2"
>=20
> chip "it87-*"
>=20
> # The values below have been tested on Asus CUSI, CUM motherboards.
>=20
> # Voltage monitors as advised in the It8705 data sheet
>=20
>     label in0 "VCore 1"
>     label in1 "VCore 2"
>     label in2 "+3.3V"
>     label in3 "+5V"
>     label in4 "+12V"
>     label in5 "-12V"
>     label in6 "-5V"
>     label in7 "Stdby"
>=20
>     set in0_min 1.5 * 0.95
>     set in0_max 1.5 * 1.05
>     set in1_min 2.4
>     set in1_max 2.6
>     set in2_min 3.3 * 0.95
>     set in2_max 3.3 * 1.05
>     set in3_min 5.0 * 0.95
>     set in3_max 5.0 * 1.05
>     set in4_min 12 * 0.95
>     set in4_max 12 * 1.05
>     set in5_min -12 * 0.95
>     set in5_max -12 * 1.05
>     set in6_min -5 * 0.95
>     set in6_max -5 * 1.05
>     set in7_min 5 * 0.95
>     set in7_max 5 * 1.05
>=20
>     # vid not monitored by IT8705F
>     ignore  vid
>=20
> # For this family of chips the negative voltage equation is different from
> # the lm78.  The chip uses two external resistor for scaling but one is
> # tied to a positive reference voltage.  See ITE8705/12 datasheet (SIS950
> # data sheet is wrong)
> # Vs =3D (1 + Rin/Rf) * Vin - (Rin/Rf) * Vref.
> # Vref =3D 4.096 volts, Vin is voltage measured, Vs is actual voltage.
>     compute in2 (1 + 1)*@ ,       @/(1 + 1)
>     compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
>     compute in4 ((30/10) +1)*@  , @/((30/10) +1)
> # The next two are negative voltages (-12 and -5).
> # The following formulas must be used. Unfortunately the datasheet
> # does not give recommendations for Rin, Rf, but we can back into
> # them based on a nominal +2V input to the chip, together with a 4.096V V=
ref.
> # Formula:
> #    actual V =3D (Vmeasured * (1 + Rin/Rf)) - (Vref * (Rin/Rf))
> #    For -12V input use Rin/Rf =3D 6.68
> #    For -5V input use Rin/Rf =3D 3.33
> # Then you can convert the forumula to a standard form like:
>     compute in5 (7.67 * @) - 27.36  ,  (@ + 27.36) / 7.67
>     compute in6 (4.33 * @) - 13.64  ,  (@ + 13.64) / 4.33
> #
>     compute in7 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
>=20
> # Temperature
>=20
>     label temp1       "Temp1/MB"
>     set   temp1_over  40
>     set   temp1_hyst  20
>=20
>     label temp2       "Temp2/CPU"
>     set   temp2_over  45
>     set   temp2_hyst  25
>=20
>     ignore temp3
>=20
> # Fans
>=20
>     set fan1_min 0
>     set fan2_min 3000
>     ignore fan3
>=20
> # The following is for the Inside Technologies 786LCD which uses either a
> # IT8705F or a SIS950 for monitoring with the SIS630.
> # You will need to load the it87 module as follows to select the correct
> # temperature sensor type.
> # modprobe it87 temp_type=3D0x31
> # The sensors-detect program reports lm78 and a sis5595 and lists the it8=
7 as
> # a misdetect.  Don't do the modprobe for the lm78 or sis5595 as suggeste=
d.
> #
> # delete or comment out above it87 section and uncomment the following.
> #chip "it87-*"
> #    label in0 "VCore 1"
> #    label in1 "VCore 2"
> #    label in2 "+3.3V"
> #    label in3 "+5V"
> #    label in4 "+12V"
> #    label in5 "3.3 Stdby"
> #    label in6 "-12V"
> #    label in7 "Stdby"
> #    label in8 "VBat"
>     # in0 will depend on your processor VID value, set to voltage specifi=
ed in
>     # bios setup screen
> #    set in0_min 1.7 * 0.95
> #    set in0_max 1.7 * 1.05
> #    set in1_min 2.4
> #    set in1_max 2.6
> #    set in2_min 3.3 * 0.95
> #    set in2_max 3.3 * 1.05
> #    set in3_min 5.0 * 0.95
> #    set in3_max 5.0 * 1.05
>     # +- 12V are very poor tolerance on this board. Verified with voltmet=
er
> #    set in4_min 12 * 0.90
> #    set in4_max 12 * 1.10
> #    set in5_min 3.3 * 0.95
> #    set in5_max 3.3 * 1.05
> #    set in6_max -12 * 0.90
> #    set in6_min -12 * 1.10
> #    set in7_min 5 * 0.95
> #    set in7_max 5 * 1.05
>     # vid not monitored by IT8705F
> #    ignore  vid
>=20
> #    compute in3 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
> #    compute in4 ((30/10) +1)*@  , @/((30/10) +1)
> #    compute in6 (1+232/56)*@ - 4.096*232/56, (@ + 4.096*232/56)/(1+232/5=
6)
> #    compute in7 ((6.8/10)+1)*@ ,  @/((6.8/10)+1)
>     # Temperature
> #    label temp1       "CPU Temp"
> #    ignore temp2
> #    ignore temp3
>     # Fans
> #    set fan1_min 3000
> #    ignore fan2
> #    ignore fan3
>=20
> chip "fscpos-*"
>=20
> #
> #    values for the fujitsu siemens poseidon chip
> #
> # Temperature
>=20
>     label temp1       "Temp1/CPU"
>     label temp2       "Temp2/MB"
>     label temp3       "Temp2/AUX"
>=20
> # Fans
>=20
>     label  fan1       "Fan1"
>     ignore  fan2
>     ignore  fan3
>=20
> # Voltage
>=20
>     label volt12      "+12V"
>     label volt5       "+5V"
>     label voltbatt    "+3.3V"
>=20
> chip "fscscy-*"
>=20
> #
> #    values for the fujitsu siemens Scylla chip
> #
> # Temperature
>=20
>     label temp1       "Temp1/CPU0"
>     label temp2       "Temp2/CPU1"
>     label temp3       "Temp3/MB"
>     label temp4       "Temp4/AUX"
>=20
> # Fans
>=20
>     label  fan1       "Fan1/CPU0"
>     label  fan2       "Fan2/CPU0"
>     label  fan3       "Fan3"
>     label  fan4       "Fan4"
>     label  fan5       "Fan5"
>     label  fan6       "Fan6"
>=20
> # Voltage
>=20
>     label volt12      "+12V"
>     label volt5       "+5V"
>     label voltbatt    "+3.3V"
>=20
> (SU-recover1)/export/tools/board_monitor/lm_sensors-2.6.2>exit
> exit
>=20
> Script done on Sat Dec  1 12:12:36 2001

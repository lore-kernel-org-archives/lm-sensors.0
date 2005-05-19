From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:46 +0000
Subject: lm_sensors on a Athlon-MP [amd-768]?
Message-Id: <3E2CB053.3010203@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1041959665.1076.9.camel@public4-leed1-5-cust131.leed.broadband.ntl.com>
In-Reply-To: <1041959665.1076.9.camel@public4-leed1-5-cust131.leed.broadband.ntl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

we have a new driver and much better detection for the w83627hf in CVS.
It doesn't appear that the sensors-detect output below is from CVS.
Please try sensors-detect and the new driver from CVS again
and include output if it doesn't work.
Unfortunately CVS is somewhat broken right now, you will need i2c CVS as
well, and you may wish to wait a week or so until things settle down.

Don't know anything about 768 SMP problems.

Malcolm Gambles wrote:
>   I am trying to get the sensors working  on my mobo.
> Mobo is K7D Master (MS-6501) [2x1.7Ghz AthlonMP]
>=20
> The i2c interface is detected OK but the 'Winbond 83627HF-AW' doesn't=20
> get detected by
> sensors-detect.
> I have tried the CVS version of i2c/lm_sensors with no luck either, same =

> result.
> I am using RH-8.0, I have heard that there is a problem with=20
> multiprocessor boards as the AMD-768  is
> not  a standard  one?
>=20
>=20
> output  from sensors-detect....and proc/pci, if this is any use at all?
> (this sensors-detect is the RH  one, i.e. old,  but the new version=20
> produces the same output)
>=20
> This program will help you to determine which I2C/SMBus modules you need =
to
> load to use lm_sensors most effectively.
> You need to have done a `make install', issued a `depmod -a' and made sure
> `/etc/conf.modules' (or `/etc/modules.conf') contains the appropriate
> module path before you can use some functions of this utility. Read
> doc/modules for more information.
> Also, you need to be `root', or at least have access to the=20
> /dev/i2c[-/]* files for some things. You can use prog/mkdev/mkdev.sh to=20
> create these /dev files
> if you do not have them already.
> If you have patched your kernel and have some drivers built-in you can
> safely answer NO if asked to load some modules. In this case, things may
> seem a bit confusing, but they will still work.
>=20
> IF THIS IS AN IBM THINKPAD, PRESS CTRL-C NOW!
> IBM Thinkpads have a severely broken i2c/SMBus implementation,  just=20
> scanning
> the bus will break your thinkpad forever!
>=20
> We can start with probing for (PCI) I2C or SMBus adapters.
> You do not need any special privileges for this.
> Do you want to probe now? (YES/no):
> Probing for PCI bus adapters...
> Use driver `i2c-amd756' for device 00:07.3: AMD-768 System Management
> Use driver `i2c-matroxfb' for device 01:05.0: MGA G400 AGP
> Probe succesfully concluded.
>=20
> We will now try to load each adapter module in turn.
> Load `i2c-amd756' (say NO if built into your kernel)? (YES/no):
> Module loaded succesfully.
> Load `i2c-matroxfb' (say NO if built into your kernel)? (YES/no):
> Module loaded succesfully.
> Do you now want to be prompted for non-detectable adapters? (yes/NO):
> To continue, we need module `i2c-dev' to be loaded.
> If it is built-in into your kernel, you can safely skip this.
> i2c-dev is not loaded. Do you want to load it now? (YES/no):
> Module loaded succesfully.
>=20
> We are now going to do the adapter probings. Some adapters may hang halfw=
ay
> through; we can't really help that. Also, some chips will be double=20
> detected;
> we choose the one with the highest confidence value in that case.
> If you found that the adapter hung after probing a certain address, you c=
an
> specify that address to remain unprobed. That often
> includes address 0x69 (clock chip).
>=20
> Next adapter: SMBus AMD7X6 adapter at 06e0 (Non-I2C SMBus adapter)
> Do you want to scan it? (YES/no/selectively):
> Client found at address 0x08
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Probing for `Winbond W83L784R/AR'... Failed!
> Client found at address 0x1b
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Probing for `Winbond W83L784R/AR'... Failed!
> Client found at address 0x33
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Probing for `Winbond W83L784R/AR'... Failed!
> Client found at address 0x53
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Probing for `Winbond W83L784R/AR'... Failed!
> Probing for `Serial EEPROM (PC-100 DIMM)'... Success!
>     (confidence 8, driver `eeprom')
> Client found at address 0x69
>=20
> Next adapter: DDC:fb0 #0 on i2c-matroxfb (Bit-shift algorithm)
> Do you want to scan it? (YES/no/selectively):
> Client found at address 0x50
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
> Probing for `Winbond W83L784R/AR'... Failed!
> Probing for `Serial EEPROM (PC-100 DIMM)'... Success!
>     (confidence 1, driver `eeprom')
> Probing for `DDC monitor'... Success!
>     (confidence 8, driver `ddcmon'), other addresses: 0x51 0x52 0x53=20
> 0x54 0x55 0x56 0x57
>=20
> Some chips are also accessible through the ISA bus. ISA probes are
> typically a bit more dangerous, as we have to write to I/O ports to do
> this.  Do you want to scan the ISA bus? (YES/no):
> Probing for `National Semiconductor LM78'
> Character in "C" format wrapped at /usr/sbin/sensors-detect line 963.
>   Trying address 0x0290... Failed!
> Probing for `National Semiconductor LM78-J'
> Character in "C" format wrapped at /usr/sbin/sensors-detect line 963.
>   Trying address 0x0290... Failed!
> Probing for `National Semiconductor LM79'
> Character in "C" format wrapped at /usr/sbin/sensors-detect line 963.
>   Trying address 0x0290... Failed!
> Probing for `Winbond W83781D'
> Character in "C" format wrapped at /usr/sbin/sensors-detect line 963.
>   Trying address 0x0290... Failed!
> Probing for `Winbond W83782D'
> Character in "C" format wrapped at /usr/sbin/sensors-detect line 963.
>   Trying address 0x0290... Failed!
> Probing for `Winbond W83627HF'
> Character in "C" format wrapped at /usr/sbin/sensors-detect line 963.
>   Trying address 0x0290... Failed!
> Probing for `Winbond W83697HF'
> Character in "C" format wrapped at /usr/sbin/sensors-detect line 963.
>   Trying address 0x0290... Failed!
> Probing for `Silicon Integrated Systems SIS5595'
>   Trying general detect... Failed!
> Probing for `VIA Technologies VT82C686 Integrated Sensors'
>   Trying general detect... Failed!
> Probing for `ITE IT8705F / IT8712F / SiS 950'
> Character in "C" format wrapped at /usr/sbin/sensors-detect line 963.
>   Trying address 0x0290... Failed!
> Probing for `IPMI BMC KCS'
>   Trying address 0x0ca0... Failed!
> Probing for `IPMI BMC SMIC'
>   Trying address 0x0ca8... Failed!
>=20
> Now follows a summary of the probes I have just done.
> Just press ENTER to continue:
>=20
> Driver `eeprom' (should be inserted but causes problems):
>   Detects correctly:
>   * Bus `SMBus AMD7X6 adapter at 06e0' (Non-I2C SMBus adapter)
>     Busdriver `i2c-amd756', I2C address 0x53
>     Chip `Serial EEPROM (PC-100 DIMM)' (confidence: 8)
>   Misdetects:
>   * Bus `DDC:fb0 #0 on i2c-matroxfb' (Bit-shift algorithm)
>     Busdriver `i2c-matroxfb', I2C address 0x50
>     Chip `Serial EEPROM (PC-100 DIMM)' (confidence: 1)
>=20
> Driver `ddcmon' (should be inserted):
>   Detects correctly:
>   * Bus `DDC:fb0 #0 on i2c-matroxfb' (Bit-shift algorithm)
>     Busdriver `i2c-matroxfb', I2C address 0x50 (and 0x51 0x52 0x53 0x54=20
> 0x55 0x56 0x57)
>     Chip `DDC monitor' (confidence: 8)
>=20
>=20
> I will now generate the commands needed to load the I2C modules.
> Sometimes, a chip is available both through the ISA bus and an I2C bus.
> ISA bus access is faster, but you need to load an additional driver module
> for it. If you have the choice, do you want to use the ISA bus or the
> I2C/SMBus (ISA/smbus)?
>=20
> WARNING! If you have some things built into your kernel, the
> below list will contain too many modules. Skip the appropriate ones!
> To load everything that is needed, add this to some /etc/rc* file:
>=20
> #----cut here----
> # I2C adapter drivers
> modprobe i2c-amd756
> modprobe i2c-matroxfb
> # I2C chip drivers
> modprobe eeprom
> modprobe ddcmon
> #----cut here----
>=20
> To make the sensors modules behave correctly, add these lines to either
> /etc/modules.conf or /etc/conf.modules:
>=20
> #----cut here----
> # I2C module options
> alias char-major-89 i2c-dev
> options eeprom ignore=3D1,0x50
> #----cut here----
>=20
> from /proc/pci.....
>=20
> PCI devices found:
>   Bus  0, device   0, function  0:
>     Host bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P]=20
> System Controller (rev 17).
>       Master Capable.  Latency2.
>       Prefetchable 32 bit memory at 0xe8000000 [0xefffffff].
>       Prefetchable 32 bit memory at 0xf7000000 [0xf7000fff].
>       I/O at 0xec00 [0xec03].
>   Bus  0, device   1, function  0:
>     PCI bridge: Advanced Micro Devices [AMD] AMD-760 MP [IGD4-2P] AGP=20
> Bridge (rev 0).
>       Master Capable.  Latency2.  Min Gnt=14.
>   Bus  0, device   7, function  0:
>     ISA bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ISA (rev 5).
>   Bus  0, device   7, function  1:
>     IDE interface: Advanced Micro Devices [AMD] AMD-768 [Opus] IDE (rev 4=
).
>       Master Capable.  Latency2.
>       I/O at 0xe000 [0xe00f].
>   Bus  0, device   7, function  3:
>     Bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] ACPI (rev 3).
>       Master Capable.  Latency2.
>   Bus  0, device   7, function  5:
>     Multimedia audio controller: PCI device 1022:7445 (Advanced Micro=20
> Devices [AMD]) (rev 3).
>       IRQ 17.
>       Master Capable.  Latency2.
>       I/O at 0xe400 [0xe4ff].
>       I/O at 0xe800 [0xe83f].
>   Bus  0, device  16, function  0:
>     PCI bridge: Advanced Micro Devices [AMD] AMD-768 [Opus] PCI (rev 5).
>       Master Capable.  Latency2.  Min Gnt=3D6.
>   Bus  1, device   5, function  0:
>     VGA compatible controller: Matrox Graphics, Inc. MGA G400 AGP (rev 13=
0).
>       IRQ 17.
>       Master Capable.  Latency2.  Min Gnt=16.Max Lat2.
>       Prefetchable 32 bit memory at 0xf0000000 [0xf1ffffff].
>       Non-prefetchable 32 bit memory at 0xf2000000 [0xf2003fff].
>       Non-prefetchable 32 bit memory at 0xf3000000 [0xf37fffff].
>   Bus  2, device   0, function  0:
>     USB Controller: Advanced Micro Devices [AMD] AMD-768 [Opus] USB (rev =
7).
>       IRQ 19.
>       Master Capable.  Latency2.  Max Lat=80.
>       Non-prefetchable 32 bit memory at 0xf6001000 [0xf6001fff].
>   Bus  2, device   6, function  0:
>     Ethernet controller: 3Com Corporation 3c905C-TX/TX-M [Tornado] (rev=20
> 120).
>       IRQ 18.
>       Master Capable.  Latency2.  Min Gnt=10.Max Lat=10.
>       I/O at 0xd000 [0xd07f].
>       Non-prefetchable 32 bit memory at 0xf6000000 [0xf600007f].
>=20
> Thanks,
>=20
> Malcolm Amir Hussain-Gambles
>=20
> malcolm.gambles@ntlworld.com <mailto:malcolm.gambles@ntlworld.com>
>=20

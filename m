From: frodol@dds.nl (frodol@dds.nl)
Date: Thu, 19 May 2005 06:23:30 +0000
Subject: Problems with sensors on Vectra vl420/Intel 845 chipset (fwd)
Message-Id: <200202221710.g1MHAQf03514@shire.frodo.local>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Forwarded message:
> From goran.koruga@hermes.si Fri Feb 22 12:55:06 2002
> Date: Fri, 22 Feb 2002 12:40:22 +0100
> From: Goran Koruga <goran.koruga@hermes.si>
> To: frodol@dds.nl
> Subject: Problems with sensors on Vectra vl420/Intel 845 chipset
> Message-ID: <20020222114022.GN31084@isis.hermes.si>
> Mime-Version: 1.0
> Content-Type: text/plain; charset=us-ascii
> Content-Disposition: inline
> User-Agent: Mutt/1.3.25i
> Sender: Goran Koruga <goran.koruga@hermes.si>
> X-Virus-Scanned: by AMaViS snapshot-20010714
> 
> Hi Frodo.
> 
> First of all I'd like to apologize for mailing you directly. I tried
> mailing to lm78@stimpy.netroedge.com and sensors@stimpy.netroedge.com,
> but to no avail (our MTA gave up after two weeks). I also tried posting
> on the support forum on the web page. My message never gets posted, even
> though I tried 3 times.
> 
> In addition to the things mentioned in my report, I have also tried CVS
> version of both i2c and lm_sensors package today. It's the same as with
> 2.6.2.
> 
> Please find my report below.
> 
> Do you have any pointers for me ? Or can you please forward this to
> someone that can help me ?
> 
> Many thanks in advance.
>     Goran
> 
> -------------------------------------------------------------------------
> 
> I have just upgraded my workstation to a HP Vectra VL420. I tried
> lm_sensors package, to see if I could get hardware monitoring going. I
> have followed the standard procedure and everything builds fine. Then I
> run sensors-detect script (log attached), which found some parts, but it
> doesn't find any supported chips.
> 
> Is this a known problem ? How could I identify which chip my motherboard 
> has ? Here's what I have done so far :
> 
> 1) Read the FAQ on your page
> 2) Checked all the info on www.hp.com (needless to say, they don't even
>    mention this or I could not find it)
> 3) Checked www.intel.com (I am a bit puzzled by all the i8xx stuff I am
>    seeing, so I don't even know if checking Intel's page is of any
>    relevance to my problem)
> 4) Checked "new drivers" page, again, I am puzzled by all i8xx options
>    (do they apply to me or not ?) 
> 5) Tried your support "flow-chart/diagnose web page", but it leads me to
>    the "email us" part ;))
> 
> I also tried loading various modules found in chips directory in
> lm_sensors package, neither seems to produce any output with
> "sensors -s" command.
> 
> Linux kernel 2.4.17
> lm_sensors-2.6.2
> i2c-2.6.2
> 
> # sensors-detect
>  This program will help you to determine which I2C/SMBus modules you need to
>  load to use lm_sensors most effectively.
>  You need to have done a `make install', issued a `depmod -a' and made sure
>  `/etc/conf.modules' (or `/etc/modules.conf') contains the appropriate
>  module path before you can use some functions of this utility. Read
>  doc/modules for more information.
>  Also, you need to be `root', or at least have access to the /dev/i2c[-/]* files
>  for some things. You can use prog/mkdev/mkdev.sh to create these /dev files
>  if you do not have them already.
>  If you have patched your kernel and have some drivers built-in you can
>  safely answer NO if asked to load some modules. In this case, things may
>  seem a bit confusing, but they will still work.
> 
>  IF THIS IS AN IBM THINKPAD, PRESS CTRL-C NOW!
>  IBM Thinkpads have a severely broken i2c/SMBus implementation,  just scanning
>  the bus will break your thinkpad forever!
> 
>  We can start with probing for (PCI) I2C or SMBus adapters.
>  You do not need any special privileges for this.
>  Do you want to probe now? (YES/no): 
> Probing for PCI bus adapters...
> Use driver `i2c-i801' for device 00:1f.3: Intel 82801BA ICH2
> Probe succesfully concluded.
> 
>  We will now try to load each adapter module in turn.
> Load `i2c-i801' (say NO if built into your kernel)? (YES/no): 
> Module loaded succesfully.
>  Do you now want to be prompted for non-detectable adapters? (yes/NO): 
>  To continue, we need module `i2c-dev' to be loaded.
>  If it is built-in into your kernel, you can safely skip this.
>  i2c-dev is not loaded. Do you want to load it now? (YES/no): 
>  Module loaded succesfully.
> 
>  We are now going to do the adapter probings. Some adapters may hang halfway
>  through; we can't really help that. Also, some chips will be double detected;
>  we choose the one with the highest confidence value in that case.
>  If you found that the adapter hung after probing a certain address, you can
>  specify that address to remain unprobed. That often
>  includes address 0x69 (clock chip).
> 
> Next adapter: SMBus I801 adapter at 0c00 (Non-I2C SMBus adapter)
> Do you want to scan it? (YES/no/selectively): 
> Client found at address 0x31
> Probing for `National Semiconductor LM78'... Failed!
> Probing for `National Semiconductor LM78-J'... Failed!
> Probing for `National Semiconductor LM79'... Failed!
> Probing for `Winbond W83781D'... Failed!
> Probing for `Winbond W83782D'... Failed!
> Probing for `Winbond W83783S'... Failed!
> Probing for `Winbond W83627HF'... Failed!
> Probing for `Asus AS99127F'... Failed!
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
> Client found at address 0x69
> 
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
> 
>  Now follows a summary of the probes I have just done.
>  Just press ENTER to continue: 
> 
> Driver `eeprom' (should be inserted):
>   Detects correctly:
>   * Bus `SMBus I801 adapter at 0c00' (Non-I2C SMBus adapter)
>     Busdriver `i2c-i801', I2C address 0x50
>     Chip `Serial EEPROM (PC-100 DIMM)' (confidence: 8)
>   * Bus `SMBus I801 adapter at 0c00' (Non-I2C SMBus adapter)
>     Busdriver `i2c-i801', I2C address 0x51
>     Chip `Serial EEPROM (PC-100 DIMM)' (confidence: 8)
>   * Bus `SMBus I801 adapter at 0c00' (Non-I2C SMBus adapter)
>     Busdriver `i2c-i801', I2C address 0x54
>     Chip `Serial EEPROM (PC-100 DIMM)' (confidence: 1)
>   * Bus `SMBus I801 adapter at 0c00' (Non-I2C SMBus adapter)
>     Busdriver `i2c-i801', I2C address 0x55
>     Chip `Serial EEPROM (PC-100 DIMM)' (confidence: 1)
> 
> 
>  I will now generate the commands needed to load the I2C modules.
>  Sometimes, a chip is available both through the ISA bus and an I2C bus.
>  ISA bus access is faster, but you need to load an additional driver module
>  for it. If you have the choice, do you want to use the ISA bus or the
>  I2C/SMBus (ISA/smbus)? 
> 
> WARNING! If you have some things built into your kernel, the 
> below list will contain too many modules. Skip the appropriate ones!
> To load everything that is needed, add this to some /etc/rc* file:
> 
> #----cut here----
> # I2C adapter drivers
> modprobe i2c-i801
> # I2C chip drivers
> modprobe eeprom
> #----cut here----
> 
> To make the sensors modules behave correctly, add these lines to either
> /etc/modules.conf or /etc/conf.modules:
> 
> #----cut here----
> # I2C module options
> alias char-major-89 i2c-dev
> #----cut here----
> 
> # lspci
> 00:00.0 Host bridge: Intel Corp. 82845 845 (Brookdale) Chipset Host Bridge (rev 03)
> 00:01.0 PCI bridge: Intel Corp. 82845 845 (Brookdale) Chipset AGP Bridge (rev 03)
> 00:1e.0 PCI bridge: Intel Corp. 82820 820 (Camino 2) Chipset PCI (rev 12)
> 00:1f.0 ISA bridge: Intel Corp. 82820 820 (Camino 2) Chipset ISA Bridge (ICH2)
> (rev 12)
> 00:1f.1 IDE interface: Intel Corp. 82820 820 (Camino 2) Chipset IDE U100 (rev 12)
> 00:1f.2 USB Controller: Intel Corp. 82820 820 (Camino 2) Chipset USB (Hub A)
> (rev 12)
> 00:1f.3 SMBus: Intel Corp. 82820 820 (Camino 2) Chipset SMBus (rev 12)
> 00:1f.4 USB Controller: Intel Corp. 82820 820 (Camino 2) Chipset USB (Hub B)
> (rev 12)
> 00:1f.5 Multimedia audio controller: Intel Corp. 82820 820 (Camino 2) Chipset
> AC'97 Audio Controller (rev 12)
> 01:00.0 VGA compatible controller: nVidia Corporation NV11 (GeForce2 MX) (rev b2)
> 02:08.0 Ethernet controller: Intel Corp. 82820 (ICH2) Chipset Ethernet
> Controller (rev 03)
> 
> # lspci -n
> 00:00.0 Class 0600: 8086:1a30 (rev 03)
> 00:01.0 Class 0604: 8086:1a31 (rev 03)
> 00:1e.0 Class 0604: 8086:244e (rev 12)
> 00:1f.0 Class 0601: 8086:2440 (rev 12)
> 00:1f.1 Class 0101: 8086:244b (rev 12)
> 00:1f.2 Class 0c03: 8086:2442 (rev 12)
> 00:1f.3 Class 0c05: 8086:2443 (rev 12)
> 00:1f.4 Class 0c03: 8086:2444 (rev 12)
> 00:1f.5 Class 0401: 8086:2445 (rev 12)
> 01:00.0 Class 0300: 10de:0110 (rev b2)
> 02:08.0 Class 0200: 8086:2449 (rev 03)
> 
> # i2cdetect
> Error: No i2c-bus specified!
> Syntax: i2cdetect I2CBUS
>   I2CBUS is an integer
>   Installed I2C busses:
>     i2c-0       smbus           SMBus I801 adapter at 0c00              Non-I2C
> SMBus adapter           
> 
> # i2cdetect 0
>   WARNING! This program can confuse your I2C bus, cause data loss and worse!
>   I will probe file /dev/i2c-0
>   You have five seconds to reconsider and press CTRL-C!
> 
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
> 10: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
> 20: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
> 30: XX 31 XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
> 40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
> 50: 50 51 XX XX 54 55 XX XX XX XX XX XX XX XX XX XX 
> 60: XX XX XX XX XX XX XX XX XX 69 XX XX XX XX XX XX 
> 70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX 
> 
> # isadump 0x295 0x296
>      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
> 10: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
> 20: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
> 30: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
> 40: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
> 50: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
> 60: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
> 70: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
> 80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
> 90: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
> a0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
> b0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
> c0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
> d0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
> e0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
> f0: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff 
> 
> Thanks for your help.
> 
> --
> 
> Writing about music is like dancing about architecture.
>     -- Frank Zappa 
> 


-- 
Frodo Looijaard <frodol@dds.nl>  PGP key and more: http://huizen.dds.nl/~frodol
Defenestration n. (formal or joc.):
  The act of removing Windows from your computer in disgust, usually followed
  by the installation of Linux or some other Unix-like operating system.

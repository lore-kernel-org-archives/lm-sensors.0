From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:50 +0000
Subject: ASUS P4B533 Motherboard
Message-Id: <3E79287B.2010203@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E749F08.5090508@charter.net>
In-Reply-To: <3E749F08.5090508@charter.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

do you have the 2443 device in lspci -n?
See prog/hotplug/README.p4b for more info.

Laurence Vanek wrote:
> Gentlemen:
> 
> I am setting up a new PC that I have just acquired.  It contains an ASUS 
> P4B533 (no suffix) motherboard.
> 
> Having read most of the docs and tired most of the diagnostic test (that 
> I can make work) I am about to
> believe what these tests are telling me.  That would be that lm_sensors 
> doesnt yet support the chip on this
> board.
> 
> I am running Redhat 7.3 with an upgraded kernel, souce installed.
> 
> =========> 
> [root@your-miclwp36yy etc]# uname -r
> 2.4.18-26.7.x
> 
> =========> 
> A few excerpts from dianostic tools:
> 
> from "i2cdetect":
> 
> =========> 
> Error: No i2c-bus specified!
> Syntax: i2cdetect I2CBUS
> I2CBUS is an integer
>  Installed I2C busses:
> 
> =========> 
> from "sensors-detect":
> 
> =========> 
>     This program will help you to determine which I2C/SMBus modules you 
> need to
>  load to use lm_sensors most effectively.
>  You need to have done a `make install', issued a `depmod -a' and made sure
>  `/etc/conf.modules' (or `/etc/modules.conf') contains the appropriate
>  module path before you can use some functions of this utility. Read
>  doc/modules for more information.
>  Also, you need to be `root', or at least have access to the 
> /dev/i2c[-/]* files
>  for some things. You can use prog/mkdev/mkdev.sh to create these /dev 
> files
>  if you do not have them already.
>  If you have patched your kernel and have some drivers built-in you can
>  safely answer NO if asked to load some modules. In this case, things may
>  seem a bit confusing, but they will still work.
> 
>  System vendor: Magnell
>  We can start with probing for (PCI) I2C or SMBus adapters.
>  You do not need any special privileges for this.
>  Do you want to probe now? (YES/no):
> Probing for PCI bus adapters...
> Sorry, no PCI bus adapters found.
> 
>  We will now try to load each adapter module in turn.
>  Do you now want to be prompted for non-detectable adapters? (yes/NO):
>  To continue, we need module `i2c-dev' to be loaded.
>  If it is built-in into your kernel, you can safely skip this.
>  i2c-dev is not loaded. Do you want to load it now? (YES/no):
> Can't exec "modprobe": No such file or directory at 
> /usr/sbin/sensors-detect line 2942, <STDIN> line 3. Loading failed (No 
> such file or directory), expect problems later on.
> 
>  We are now going to do the adapter probings. Some adapters may hang 
> halfway
>  through; we can't really help that. Also, some chips will be double 
> detected;
>  we choose the one with the highest confidence value in that case.
>  If you found that the adapter hung after probing a certain address, you 
> can
>  specify that address to remain unprobed. That often
>  includes address 0x69 (clock chip).
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
> Probing for `VIA Technologies VT82C686 Integrated Sensors'
>   Trying general detect... Failed!
> Probing for `VIA Technologies VT8231 Integrated Sensors'
>   Trying general detect... Failed!
> Probing for `ITE IT8705F / IT8712F / SiS 950'
>   Trying address 0x0290... Failed!
> Probing for `IPMI BMC KCS'
>   Trying address 0x0ca0... Failed!
> Probing for `IPMI BMC SMIC'
>   Trying address 0x0ca8... Failed!
> 
>  Now follows a summary of the probes I have just done.
>  Just press ENTER to continue:
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
> # I2C chip drivers
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
> Do you want to generate /etc/sysconfig/lm_sensors? (YES/no): no
> 
> =========
> 
> from "Modules.conf":
> 
> =========
> alias parport_lowlevel parport_pc
> alias eth0 3c59x
> alias sound-slot-0 cmpci
> post-install sound-slot-0 /bin/aumix-minimal -f /etc/.aumixrc -L 
>  >/dev/null 2>&1 || :
> pre-remove sound-slot-0 /bin/aumix-minimal -f /etc/.aumixrc -S 
>  >/dev/null 2>&1 || :
> alias sound-slot-1 emu10k1
> post-install sound-slot-1 /bin/aumix-minimal -f /etc/.aumixrc -L 
>  >/dev/null 2>&1 || :
> pre-remove sound-slot-1 /bin/aumix-minimal -f /etc/.aumixrc -S 
>  >/dev/null 2>&1 || :
> alias usb-controller usb-uhci
> alias usb-controller1 ehci-hcd
> alias eth1 tulip
> 
> alias char-major-195 nvidia
> 
> # I2C module options
> alias char-major-89 i2c-dev
> 
> =========
> 
> 
> It is worth noting that I am certain this board has a "health 
> monitoring" chip and that it
> supports SMBus 2.0 (had to change jumper to enable).  I believe it is 
> the south bridge controller
> hub (ICH4).
> 
> Also worth noting that I can insert modules manually using modprobe.
> 
> I had no joy using i2c-2.7.0.tar.gz & lm_sensors-2.7.0.tar.gz packages, 
> they compiled with error
> 1 codes.  i2c would not install, probabily due to kernel source tree 
> issue.  Naturally lm_senors would
> not install due to old version of i2c.  Since I am not a kernel hacker I 
> am very reluctant to rebuild my
> kernel (hight probability that I will mess up).  This is all irrelevant 
> if board chip not supported.
> 
> Thanks in advance for any advice you might offer.
> 

From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:28 +0000
Subject: LM84 Temperature Reading is always 0!?!
Message-Id: <3C41B8FF.2B8196EB@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2CBC9098-07A0-11D6-AA76-00039310C316@mac.com>
In-Reply-To: <2CBC9098-07A0-11D6-AA76-00039310C316@mac.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

- you may not have an LM84, it is sometimes misdetected. You didn't
  include the output of sensors-detect without the adm1021 driver
loaded,
  so it's hard to diagnose. Look at your board to verify.
- Don't know why sensors-detect didn't recommend via686a, you
  should try modprobing it. If no luck, send 'lspci -n'.
- Don't know what is at 0x2d, that's probably most of your sensors,
  look at your board and maybe you can figure it out.


megabight@mac.com wrote:
> 
> Hi,
>       I'm new to lm_sensors, and I'm trying to get temperature readings
> from my ABIT KT7A (v1.3) motherboard, but the temperature reading is
> always 0. I am using lm_sensors version 2.6.2 with kernel 2.4.17 without
> devfs and with i2c, i2c device interface, and i2c /proc  interface
> compiled into the kernel. Every time I run sensors, I get a zero
> temperature reading. The output from sensors, and other configuration
> information are attached.
> 
> Thanks in advance for your help,
> 
> -- megabight@mac.com
> 
> ---Hardware/ Configuration Info ---
> 
> Motherboard: ABIT KT7A v1.3
> Processor: AMD Athlon 1600+
> Kernel: 2.4.17 (no devfs, i2c,i2c dev interface,i2c /proc interface
> compiled in)
> Linux Distribution: RedHat 7.2
> Kernel Source Tree: 2.4.17 tarball from kernel.org
> 
> The output of the following commands is attached:
>      # sensors
>      # lsmod
>      # lspci
>      # i2cdetect
>      # i2cdetect 0
>      # sensors-detect
> 
> --- sensors output ---
> 
> [root@localhost root]# sensors
> lm84-i2c-0-18
> Adapter: SMBus Via Pro adapter at 5000
> Algorithm: Non-I2C SMBus adapter
> temp:         +0?C  (min =   +4?C, max =   +0?C)
> remote_temp:
>                +0?C  (min =   +0?C, max =  +60?C)ALARM (N/A)
> 
> eeprom-i2c-0-50
> Adapter: SMBus Via Pro adapter at 5000
> Algorithm: Non-I2C SMBus adapter
> Memory type:            SDRAM DIMM SPD
> SDRAM Size (MB):        256
> 
> eeprom-i2c-0-51
> Adapter: SMBus Via Pro adapter at 5000
> Algorithm: Non-I2C SMBus adapter
> Memory type:            SDRAM DIMM SPD
> SDRAM Size (MB):        256
> 
> --- lsmod output ---
> 
> [root@localhost lm_sensors-2.6.2]# lsmod
> Module                  Size  Used by
> autofs4                 8208   0  (autoclean) (unused)
> tulip                  37360   1
> eeprom                  2912   0  (unused)
> adm1021                 5232   0  (unused)
> i2c-viapro              3632   0
> mousedev                3952   2
> 
> --- lspci output ---
> 
> [root@localhost lm_sensors-2.6.2]# lspci
> 00:00.0 Host bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133]
> (rev 03)
> 00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP]
> 00:07.0 ISA bridge: VIA Technologies, Inc. VT82C686 [Apollo Super South]
> (rev 40)
> 00:07.1 IDE interface: VIA Technologies, Inc. Bus Master IDE (rev 06)
> 00:07.2 USB Controller: VIA Technologies, Inc. UHCI USB (rev 1a)
> 00:07.3 USB Controller: VIA Technologies, Inc. UHCI USB (rev 1a)
> 00:07.4 Bridge: VIA Technologies, Inc. VT82C686 [Apollo Super ACPI] (rev
> 40)
> 00:0d.0 Multimedia audio controller: Creative Labs SB Live! EMU10000
> (rev 07)
> 00:0d.1 Input device controller: Creative Labs SB Live! (rev 07)
> 00:0f.0 Ethernet controller: Digital Equipment Corporation DECchip 21140
> [FasterNet] (rev 22)
> 01:00.0 VGA compatible controller: nVidia Corporation NV15 (Geforce2
> GTS) (rev a3)
> 
> --- i2cdetect output ---
> 
> [root@localhost lm_sensors-2.6.2]# prog/detect/i2cdetect
> Error: No i2c-bus specified!
> Syntax: i2cdetect I2CBUS
>    I2CBUS is an integer
>    Installed I2C busses:
>      i2c-0       smbus           SMBus Via Pro adapter at 5000
> Non-I2C SMBus adapter
> 
> --- "i2cdetect 0" output ---
> 
> [root@localhost lm_sensors-2.6.2]# prog/detect/i2cdetect 0
>    WARNING! This program can confuse your I2C bus, cause data loss and
> worse!
>    I will probe file /dev/i2c-0
>    You have five seconds to reconsider and press CTRL-C!
> 
>       0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f
> 00: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 10: XX XX XX XX XX XX XX XX UU XX XX XX XX XX XX XX
> 20: XX XX XX XX XX XX XX XX XX XX XX XX XX 2d XX XX
> 30: 30 31 XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 40: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 50: UU UU XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 60: XX XX XX XX XX XX XX XX XX 69 XX XX XX XX XX XX
> 70: XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX XX
> 
> -- sensors-detect output ---
> 
> root@localhost lm_sensors-2.6.2]# sensors-detect
>   This program will help you to determine which I2C/SMBus modules you
> need to
>   load to use lm_sensors most effectively.
>   You need to have done a `make install', issued a `depmod -a' and made
> sure
>   `/etc/conf.modules' (or `/etc/modules.conf') contains the appropriate
>   module path before you can use some functions of this utility. Read
>   doc/modules for more information.
>   Also, you need to be `root', or at least have access to the
> /dev/i2c[-/]* files
>   for some things. You can use prog/mkdev/mkdev.sh to create these /dev
> files
>   if you do not have them already.
>   If you have patched your kernel and have some drivers built-in you can
>   safely answer NO if asked to load some modules. In this case, things may
>   seem a bit confusing, but they will still work.
> 
>   IF THIS IS AN IBM THINKPAD, PRESS CTRL-C NOW!
>   IBM Thinkpads have a severely broken i2c/SMBus implementation,  just
> scanning
>   the bus will break your thinkpad forever!
> 
>   We can start with probing for (PCI) I2C or SMBus adapters.
>   You do not need any special privileges for this.
>   Do you want to probe now? (YES/no): YES
> Probing for PCI bus adapters...
> Use driver `i2c-viapro' for device 00:07.4: VIA Technologies VT82C686
> Apollo ACPI
> Use driver `i2c-riva' for device 01:00.0: GeForce GTS
> Probe succesfully concluded.
> 
>   We will now try to load each adapter module in turn.
> Module `i2c-viapro' already loaded.
> Load `i2c-riva' (say NO if built into your kernel)? (YES/no): YES
> modprobe: Can't locate module i2c-riva
> Loading failed ()... skipping.
> ** Note: i2c-riva module is available at
> ** http://drama.obuda.kando.hu/~fero/cgi-bin/rivatv.shtml
>   Do you now want to be prompted for non-detectable adapters? (yes/NO): NO
>   To continue, we need module `i2c-dev' to be loaded.
>   If it is built-in into your kernel, you can safely skip this.
>   i2c-dev is not loaded. Do you want to load it now? (YES/no): NO
>   Well, you will know best. We will just hope you edited
> `/etc/conf.modules'
>   (or `/etc/modules.conf') for automatic loading of this module. If not,
>   you won't be able to open any /dev/i2c[-/]* file (unless youhave it
> built-in
>   into your kernel)
> 
>   We are now going to do the adapter probings. Some adapters may hang
> halfway
>   through; we can't really help that. Also, some chips will be double
> detected;
>   we choose the one with the highest confidence value in that case.
>   If you found that the adapter hung after probing a certain address, you
> can
>   specify that address to remain unprobed. That often
>   includes address 0x69 (clock chip).
> 
> Next adapter: SMBus Via Pro adapter at 5000 (Non-I2C SMBus adapter)
> Do you want to scan it? (YES/no/selectively): YES
> Client at address 0x18 can not be probed - unload all client drivers
> first!
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
> Probing for `National Semiconductor LM81'... Failed!
> Probing for `Analog Devices ADM1025'... Failed!
> Probing for `Analog Devices ADM1024'... Failed!
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
> Client at address 0x50 can not be probed - unload all client drivers
> first!
> Client at address 0x51 can not be probed - unload all client drivers
> first!
> Client found at address 0x69
> 
>   Some chips are also accessible through the ISA bus. ISA probes are
>   typically a bit more dangerous, as we have to write to I/O ports to do
>   this.  Do you want to scan the ISA bus? (YES/no): YES
> Probing for `National Semiconductor LM78'
>    Trying address 0x0290... Failed!
> Probing for `National Semiconductor LM78-J'
>    Trying address 0x0290... Failed!
> Probing for `National Semiconductor LM79'
>    Trying address 0x0290... Failed!
> Probing for `Winbond W83781D'
>    Trying address 0x0290... Failed!
> Probing for `Winbond W83782D'
>    Trying address 0x0290... Failed!
> Probing for `Winbond W83627HF'
>    Trying address 0x0290... Failed!
> Probing for `Winbond W83697HF'
>    Trying address 0x0290... Failed!
> Probing for `Silicon Integrated Systems SIS5595'
>    Trying general detect... Failed!
> Probing for `VIA Technologies VT 82C686 Integrated Sensors'
>    Trying general detect... Failed!
> Probing for `ITE IT8705F / IT8712F / SiS 950'
>    Trying address 0x0290... Failed!
> 
>   Now follows a summary of the probes I have just done.
>   Just press ENTER to continue:
> 
>   I will now generate the commands needed to load the I2C modules.
>   Sometimes, a chip is available both through the ISA bus and an I2C bus.
>   ISA bus access is faster, but you need to load an additional driver
> module
>   for it. If you have the choice, do you want to use the ISA bus or the
>   I2C/SMBus (ISA/smbus)? smbus
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

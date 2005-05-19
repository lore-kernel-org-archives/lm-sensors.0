From: hkg@ipr.res.in (Hitesh Gulati)
Date: Thu, 19 May 2005 06:23:56 +0000
Subject: "Please support me"
Message-Id: <Pine.LNX.4.33.0305221656001.862-400000@control4.ipr.res.in>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear sir

I am not able to detect sensors on my motherboard.

I am attaching the output of sensors-detect in sensors-detect.out file.

The output of lsmod command is in lsmod.out file attached.

The output of lspci -n command is attached in lspci.out file.
Please see it.

The chipset of my motherboard is intel 82440B/ Intel82440ZX/VIA

The sensors version is lm_sensors-2.5.5

The linux kernel version is 2.4.2-2

Please help me.
Waiting for your valuable response.

-- 
Hitesh Kr. Gulati
Engineer - SC
Institute For Plasma Research
Near Indira Bridge
Bhat, Gandhinagar(Gujarat)
Ph.(079)3969001-15(O) Extn 226/315
-------------- next part --------------
Module                  Size  Used by
i2c-isa                 1232   0  (unused)
lm78                    7344   0  (unused)
lm75                    3344   0  (unused)
sensors                 6480   0  [lm78 lm75]
i2c-dev                 3648   0 
i2c-philips-par         2272   0  (unused)
parport                25952   0  [i2c-philips-par]
i2c-elv                 2096   0  (unused)
i2c-algo-bit            7328   1  [i2c-philips-par i2c-elv]
i2c-elektor             2832   0 
i2c-algo-pcf            4400   1  [i2c-elektor]
i2c-viapro              4432   0 
i2c-core               13408   0  [i2c-isa lm78 lm75 sensors i2c-dev i2c-algo-bit i2c-algo-pcf i2c-viapro]
ide-cd                 26848   0  (autoclean)
cdrom                  27232   0  (autoclean) [ide-cd]
cmpci                  23104   0  (autoclean)
soundcore               4464   4  (autoclean) [cmpci]
8139too                16480   1  (autoclean)
reiserfs              203792   2  (autoclean)

-------------- next part --------------
00:00.0 Class 0600: 1106:0691 (rev 44)
00:01.0 Class 0604: 1106:8598
00:07.0 Class 0601: 1106:0596 (rev 23)
00:07.1 Class 0101: 1106:0571 (rev 10)
00:07.2 Class 0c03: 1106:3038 (rev 11)
00:07.3 Class 0600: 1106:3050 (rev 30)
00:0f.0 Class 0200: 10ec:8139 (rev 10)
00:14.0 Class 0401: 13f6:0111 (rev 10)
01:00.0 Class 0300: 1039:6326 (rev 0b)

-------------- next part --------------
The output of sensors-detect is as follows
 This program will help you to determine which I2C/SMBus modules you need
to
 load to use lm_sensors most effectively.
 You need to have done a `make install', issued a `depmod -a' and made
sure
 `/etc/conf.modules' (or `/etc/modules.conf') contains the appropriate
 module path before you can use some functions of this utility. Read
 doc/modules for more information.
 Also, you need to be `root', or at least have access to the /dev/i2c[-]*
files
 for some things. You can use prog/mkdev/mkdev.sh to create these /dev
files
 if you do not have them already.
 If you have patched your kernel and have some drivers built-in you can
 safely answer NO if asked to load some modules. In this case, things may
 seem a bit confusing, but they will still work.

 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no): Y
Probing for PCI bus adapters...
Use driver `i2c-viapro' for device 00:07.3: VIA Technologies VT 82C596
Apollo ACPI
Probe succesfully concluded.
 We are now going to do the adapter probings. Some adapters may hang
halfway
 through; we can't really help that. Also, some chips will be double
detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you
can
 specify that address to remain unprobed. If you have a PIIX4, that often
 includes addresses 0x69 and/or 0x6a.

Next adapter: SMBus vt82c596 adapter at 5000 (Non-I2C SMBus adapter)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x32
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `ITE IT8705F / IT8712F'... Failed!
Client found at address 0x51
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `ITE IT8705F / IT8712F'... Failed!
Probing for `Serial EEPROM (PC-100 DIMM)'... Success!
    (confidence 1, driver `eeprom')
Client found at address 0x52
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!  
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!   
Probing for `ITE IT8705F / IT8712F'... Failed!
Probing for `Serial EEPROM (PC-100 DIMM)'... Success!
Client found at address 0x69

Next adapter: PCF8584 ISA adapter (PCF8584 algorithm)
Do you want to scan it? (YES/no/selectively): Y 

Next adapter: ELV Parallel port adaptor (Bit-shift algorithm)
Do you want to scan it? (YES/no/selectively): Y
Can't open /dev/i2c[-]2

 Some chips are also accessible through the ISA bus. ISA probes are
 typically a bit more dangerous, as we have to write to I/O ports to do
 this.  Do you want to scan the ISA bus? (YES/no): Y  
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
Probing for `VIA Technologies VT 82C686 Integrated Sensors'  
  Trying general detect... Failed!
Probing for `ITE IT8705F / IT8712F'
  Trying address 0x0290... Failed!
 
 
 Now follows a summary of the probes I have just done.
 Just press ENTER to continue:


Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus vt82c596 adapter at 5000' (Non-I2C SMBus adapter)
    Busdriver `i2c-viapro', I2C address 0x51
    Chip `Serial EEPROM (PC-100 DIMM)' (confidence: 1)
  * Bus `SMBus vt82c596 adapter at 5000' (Non-I2C SMBus adapter)
    Busdriver `i2c-viapro', I2C address 0x52
    Chip `Serial EEPROM (PC-100 DIMM)' (confidence: 8)


 I will now generate the commands needed to load the I2C modules.
 Sometimes, a chip is available both through the ISA bus and an I2C bus.
 ISA bus access is faster, but you need to load an additional driver
module
 for it. If you have the choice, do you want to use the ISA bus or the
 I2C/SMBus (ISA/smbus)? smbus

WARNING! If you have some things built into your kernel, the
below list will contain too many modules. Skip the appropriate ones!
To load everything that is needed, add this to some /etc/rc* file:

#----cut here---- 
# I2C adapter drivers
modprobe i2c-viapro
# modprobe unknown adapter PCF8584 ISA adapter using PCF8584 algorithm
# modprobe unknown adapter ELV Parallel port adaptor using Bit-shift
algorithm
# I2C chip drivers
modprobe eeprom
#----cut here----
To make the sensors modules behave correctly, add these lines to either
/etc/modules.conf or /etc/conf.modules:
 
#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----
 

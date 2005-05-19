From: yann.savenye@wanadoo.fr (Yann SAVENYE)
Date: Thu, 19 May 2005 06:23:51 +0000
Subject: Cannot have lm-sensors work with my NV7m ABIT motherboard
Message-Id: <1048578770.2531.7.camel@Ordiyann>
List-Id: <lm-sensors.vger.kernel.org>
References: <1048326224.4015.63.camel@Ordiyann>
In-Reply-To: <1048326224.4015.63.camel@Ordiyann>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Le lun 24/03/2003 ? 09:36, Jean Delvare a ?crit :
> > I followed your idea. Here's the list of all the modules loaded on my
> > computer, after removing everything related to bttv and so on... I
> > think I haven't forgotten anything:
> 
> Actually, my idea was not to remove them, but to never load them. I
> suspect that one of these modules could generate the problem when being
> loaded, which hardly implies it would clean up when being unloaded.
> 
> > dsbr100                 5176   1
> > videodev                7872   2  [dsbr100]
> 
> And I believe you should not load these two ones too.
> 

I removed all the modules I don't need for lm-sensors, actually, all the
modules that may access the i2c bus.

Here's the output of lsmod:

[root@ordiyann yann]# lsmod
Module                  Size  Used by    Not tainted
lp                      8096   0
parport_pc             25096   1
parport                34176   1  [lp parport_pc]
radeon                107428   0
es1371                 29000   2
soundcore               6276   0  [es1371]
ac97_codec             12488   0  [es1371]
gameport                3316   0  [es1371]
nfsd                   74256   0  (autoclean)
af_packet              14952   0  (autoclean)
8139too                17160   1  (autoclean)
mii                     3832   0  (autoclean) [8139too]
supermount             15296   2  (autoclean)
sg                     34636   0  (autoclean)
st                     29488   0  (autoclean) (unused)
sr_mod                 16920   0  (autoclean) (unused)
sd_mod                 13100   0  (autoclean) (unused)
ide-scsi               11280   0  (autoclean)
scsi_mod              103284   5  (autoclean) [sg st sr_mod sd_mod
ide-scsi]
ide-cd                 33856   0  (autoclean)
cdrom                  31648   0  (autoclean) [sr_mod ide-cd]
floppy                 55132   0  (autoclean)
scanner                10904   0
usb-ohci               20584   0  (unused)
usbcore                72992   1  [scanner usb-ohci]
rtc                     8060   0  (autoclean)
ext3                   59916   8
jbd                    38972   8  [ext3]

I don't think I could go any further (may be removing the modules for my
audio card would be the next step?)


> > If you can help... I really don't understand why I always get lm75 and
> > lm80, and all the other chips...
> 
> As said earlier, the bus is going mad, it detects hundreds of things you
> don't have. If we could find out why, then we could investigate. So I
> suggest you prevent the modules from loading (rename them of something)
> and then restart you system (I hope you can) to see what happens then.
> And I really like to know what Mark thinks about it, I may be missing
> something.

The big problem, is that, although I have removed all the modules from
/lib/modules/[name of my kernel]/kernel/[whatsoever] and put them in
another directory so that they can't be found by the system (I had begun
with renaming them, but the system could always find them, so I renamed
the directories in which they were, but it was the same...), I still get
this when doing sensors-detect:

[root@ordiyann yann]# sensors-detect
 This program will help you to determine which I2C/SMBus modules you
need to
 load to use lm_sensors most effectively.
 You need to have done a `make install', issued a `depmod -a' and made
sure
 `/etc/conf.modules' (or `/etc/modules.conf') contains the appropriate
 module path before you can use some functions of this utility. Read
 doc/modules for more information.
 Also, you need to be `root', or at least have access to the
/dev/i2c[-/]* files
 for some things. You can use prog/mkdev/mkdev.sh to create these /dev
files
 if you do not have them already.
 If you have patched your kernel and have some drivers built-in you can
 safely answer NO if asked to load some modules. In this case, things
may
 seem a bit confusing, but they will still work.

 BIOS vendor (ACPI): Nvidia
 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-amd756' for device 00:01.1: nVidia nForce SMBus
Probe succesfully concluded.

 We will now try to load each adapter module in turn.
Load `i2c-amd756' (say NO if built into your kernel)? (YES/no):
Module loaded succesfully.
 Do you now want to be prompted for non-detectable adapters? (yes/NO):
 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
 i2c-dev is not loaded. Do you want to load it now? (YES/no):
 Module loaded succesfully.

 We are now going to do the adapter probings. Some adapters may hang
halfway
 through; we can't really help that. Also, some chips will be double
detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you
can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Next adapter: SMBus nVidia nForce adapter at ec00 (Non-I2C SMBus
adapter)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x00
Client found at address 0x01
Client found at address 0x02
Client found at address 0x03
Client found at address 0x04
Client found at address 0x05
Client found at address 0x06
Client found at address 0x07
Client found at address 0x08
Client found at address 0x09
Client found at address 0x0a
Client found at address 0x0b
Probing for `Smart Battery'... Failed!
Client found at address 0x0c
Client found at address 0x0d
Client found at address 0x0e
Client found at address 0x0f
Client found at address 0x10
Client found at address 0x11
Client found at address 0x12
Client found at address 0x13
Client found at address 0x14
Client found at address 0x15
Client found at address 0x16
Client found at address 0x17
Client found at address 0x18
Probing for `Analog Devices ADM1021'... Failed!
Probing for `Maxim MAX1617'... Success!
    (confidence 3, driver `adm1021')
Probing for `Maxim MAX1617A'... Failed!
Probing for `TI THMC10'... Failed!
Probing for `National Semiconductor LM84'... Success!
    (confidence 6, driver `adm1021')
Probing for `Genesys Logic GL523SM'... Failed!
Probing for `Onsemi MC1066'... Failed!
Client found at address 0x19
Probing for `Analog Devices ADM1021'... Failed!
Probing for `Maxim MAX1617'... Success!
    (confidence 3, driver `adm1021')
Probing for `Maxim MAX1617A'... Failed!
Probing for `TI THMC10'... Failed!
Probing for `National Semiconductor LM84'... Success!
    (confidence 6, driver `adm1021')
Probing for `Genesys Logic GL523SM'... Failed!
Probing for `Onsemi MC1066'... Failed!
Client found at address 0x1a
Probing for `Analog Devices ADM1021'... Failed!
Probing for `Maxim MAX1617'... Success!
    (confidence 3, driver `adm1021')
Probing for `Maxim MAX1617A'... Failed!
Probing for `TI THMC10'... Failed!
Probing for `National Semiconductor LM84'... Success!
    (confidence 6, driver `adm1021')
Probing for `Genesys Logic GL523SM'... Failed!
Probing for `Onsemi MC1066'... Failed!
Client found at address 0x1b
Client found at address 0x1c
Client found at address 0x1d
Client found at address 0x1e
Client found at address 0x1f
Client found at address 0x20
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client found at address 0x21
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client found at address 0x22
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client found at address 0x23
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client found at address 0x24
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client found at address 0x25
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client found at address 0x26
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client found at address 0x27
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client found at address 0x28
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Success!
    (confidence 3, driver `lm80')
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client found at address 0x29
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Success!
    (confidence 3, driver `lm80')
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `Analog Devices ADM1021'... Failed!
Probing for `Maxim MAX1617'... Success!
    (confidence 3, driver `adm1021')
Probing for `Maxim MAX1617A'... Failed!
Probing for `TI THMC10'... Failed!
Probing for `National Semiconductor LM84'... Success!
    (confidence 6, driver `adm1021')
Probing for `Genesys Logic GL523SM'... Failed!
Probing for `Onsemi MC1066'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client found at address 0x2a
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Success!
    (confidence 3, driver `lm80')
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `Analog Devices ADM1021'... Failed!
Probing for `Maxim MAX1617'... Success!
    (confidence 3, driver `adm1021')
Probing for `Maxim MAX1617A'... Failed!
Probing for `TI THMC10'... Failed!
Probing for `National Semiconductor LM84'... Success!
    (confidence 6, driver `adm1021')
Probing for `Genesys Logic GL523SM'... Failed!
Probing for `Onsemi MC1066'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client found at address 0x2b
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Success!
    (confidence 3, driver `lm80')
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `Analog Devices ADM1021'... Failed!
Probing for `Maxim MAX1617'... Success!
    (confidence 3, driver `adm1021')
Probing for `Maxim MAX1617A'... Failed!
Probing for `TI THMC10'... Failed!
Probing for `National Semiconductor LM84'... Success!
    (confidence 6, driver `adm1021')
Probing for `Genesys Logic GL523SM'... Failed!
Probing for `Onsemi MC1066'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client found at address 0x2c
Probing for `Myson MTP008'... Failed!
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Success!
    (confidence 3, driver `lm80')
Probing for `National Semiconductor LM85'... Failed!
Probing for `National Semiconductor LM87'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `Genesys Logic GL518SM Revision 0x00'... Failed!
Probing for `Genesys Logic GL518SM Revision 0x80'... Failed!
Probing for `Genesys Logic GL520SM'... Failed!
Probing for `Analog Devices ADM9240'... Failed!
Probing for `Dallas Semiconductor DS1780'... Failed!
Probing for `National Semiconductor LM81'... Failed!
Probing for `Analog Devices ADM1025'... Failed!
Probing for `Analog Devices ADM1024'... Failed!
Probing for `Analog Devices ADM1022'... Failed!
Probing for `Texas Instruments THMC50'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client found at address 0x2d
Probing for `Myson MTP008'... Failed!
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Success!
    (confidence 3, driver `lm80')
Probing for `National Semiconductor LM85'... Failed!
Probing for `National Semiconductor LM87'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `Genesys Logic GL518SM Revision 0x00'... Failed!
Probing for `Genesys Logic GL518SM Revision 0x80'... Failed!
Probing for `Genesys Logic GL520SM'... Failed!
Probing for `Genesys Logic GL525SM'... Failed!
Probing for `Analog Devices ADM9240'... Failed!
Probing for `Dallas Semiconductor DS1780'... Failed!
Probing for `National Semiconductor LM81'... Failed!
Probing for `Analog Devices ADM1025'... Failed!
Probing for `Analog Devices ADM1024'... Failed!
Probing for `Analog Devices ADM1022'... Failed!
Probing for `Texas Instruments THMC50'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client found at address 0x2e
Probing for `Myson MTP008'... Failed!
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Success!
    (confidence 3, driver `lm80')
Probing for `National Semiconductor LM85'... Failed!
Probing for `National Semiconductor LM87'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `Analog Devices ADM9240'... Failed!
Probing for `Dallas Semiconductor DS1780'... Failed!
Probing for `National Semiconductor LM81'... Failed!
Probing for `Analog Devices ADM1025'... Failed!
Probing for `Analog Devices ADM1024'... Failed!
Probing for `Analog Devices ADM1022'... Failed!
Probing for `Texas Instruments THMC50'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client found at address 0x2f
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Success!
    (confidence 3, driver `lm80')
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83783S'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Asus AS99127F'... Failed!
Probing for `Winbond W83L784R/AR'... Failed!
Probing for `Analog Devices ADM9240'... Failed!
Probing for `Dallas Semiconductor DS1780'... Failed!
Probing for `National Semiconductor LM81'... Failed!
Probing for `Analog Devices ADM1022'... Failed!
Probing for `Texas Instruments THMC50'... Failed!
Probing for `ITE IT8705F / IT8712F / SiS 950'... Failed!
Client found at address 0x30
Client found at address 0x31
Client found at address 0x32
Client found at address 0x33
Client found at address 0x34
Client found at address 0x35
Client found at address 0x36
Client found at address 0x37
Client found at address 0x38
Client found at address 0x39
Client found at address 0x3a
Client found at address 0x3b
Client found at address 0x3c
Client found at address 0x3d
Client found at address 0x3e
Client found at address 0x3f
Client found at address 0x40
Client found at address 0x41
Client found at address 0x42
Client found at address 0x43
Client found at address 0x44
Client found at address 0x45
Client found at address 0x46
Client found at address 0x47
Client found at address 0x48
Probing for `National Semiconductor LM75'... Success!
    (confidence 3, driver `lm75')
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `Philips Semiconductors PCF8591'... Success!
    (confidence 1, driver `pcf8591')
Client found at address 0x49
Probing for `National Semiconductor LM75'... Success!
    (confidence 3, driver `lm75')
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `Philips Semiconductors PCF8591'... Success!
    (confidence 1, driver `pcf8591')
Client found at address 0x4a
Probing for `National Semiconductor LM75'... Success!
    (confidence 3, driver `lm75')
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `Philips Semiconductors PCF8591'... Success!
    (confidence 1, driver `pcf8591')
Client found at address 0x4b
Probing for `National Semiconductor LM75'... Success!
    (confidence 3, driver `lm75')
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `Philips Semiconductors PCF8591'... Success!
    (confidence 1, driver `pcf8591')
Client found at address 0x4c
Probing for `National Semiconductor LM75'... Success!
    (confidence 3, driver `lm75')
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `Analog Devices ADM1021'... Failed!
Probing for `Maxim MAX1617'... Success!
    (confidence 3, driver `adm1021')
Probing for `Maxim MAX1617A'... Failed!
Probing for `TI THMC10'... Failed!
Probing for `National Semiconductor LM84'... Success!
    (confidence 6, driver `adm1021')
Probing for `Genesys Logic GL523SM'... Failed!
Probing for `Onsemi MC1066'... Failed!
Probing for `Philips Semiconductors PCF8591'... Success!
    (confidence 1, driver `pcf8591')
Client found at address 0x4d
Probing for `National Semiconductor LM75'... Success!
    (confidence 3, driver `lm75')
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `Analog Devices ADM1021'... Failed!
Probing for `Maxim MAX1617'... Success!
    (confidence 3, driver `adm1021')
Probing for `Maxim MAX1617A'... Failed!
Probing for `TI THMC10'... Failed!
Probing for `National Semiconductor LM84'... Success!
    (confidence 6, driver `adm1021')
Probing for `Genesys Logic GL523SM'... Failed!
Probing for `Onsemi MC1066'... Failed!
Probing for `Philips Semiconductors PCF8591'... Success!
    (confidence 1, driver `pcf8591')
Client found at address 0x4e
Probing for `National Semiconductor LM75'... Success!
    (confidence 3, driver `lm75')
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `Analog Devices ADM1021'... Failed!
Probing for `Maxim MAX1617'... Success!
    (confidence 3, driver `adm1021')
Probing for `Maxim MAX1617A'... Failed!
Probing for `TI THMC10'... Failed!
Probing for `National Semiconductor LM84'... Success!
    (confidence 6, driver `adm1021')
Probing for `Genesys Logic GL523SM'... Failed!
Probing for `Onsemi MC1066'... Failed!
Probing for `Philips Semiconductors PCF8591'... Success!
    (confidence 1, driver `pcf8591')
Client found at address 0x4f
Probing for `National Semiconductor LM75'... Success!
    (confidence 3, driver `lm75')
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `Philips Semiconductors PCF8591'... Success!
    (confidence 1, driver `pcf8591')
Client found at address 0x50
Probing for `Serial EEPROM'... Success!
    (confidence 8, driver `eeprom')
Probing for `DDC monitor'... Failed!
Client found at address 0x51
Probing for `Serial EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x52
Probing for `Serial EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x53
Probing for `Serial EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x54
Probing for `Serial EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x55
Probing for `Serial EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x56
Probing for `Serial EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x57
Probing for `Serial EEPROM'... Success!
    (confidence 8, driver `eeprom')
Client found at address 0x58
Probing for `LTC1710'... Success!
    (confidence 1, driver `ltc1710')
Client found at address 0x59
Probing for `LTC1710'... Success!
    (confidence 1, driver `ltc1710')
Client found at address 0x5a
Probing for `LTC1710'... Success!
    (confidence 1, driver `ltc1710')
Client found at address 0x5b
Client found at address 0x5c
Client found at address 0x5d
Client found at address 0x5e
Client found at address 0x5f
Client found at address 0x60
Client found at address 0x61
Probing for `SMBus 2.0 ARP-Capable Device'... Success!
    (confidence 1, driver `smbus-arp')
Client found at address 0x62
Client found at address 0x63
Client found at address 0x64
Client found at address 0x65
Client found at address 0x66
Client found at address 0x67
Client found at address 0x68
Client found at address 0x69
Client found at address 0x6a
Client found at address 0x6b
Client found at address 0x6c
Client found at address 0x6d
Client found at address 0x6e
Client found at address 0x6f
Client found at address 0x70
Client found at address 0x71
Client found at address 0x72
Client found at address 0x73
Probing for `FSC poseidon chip'... Failed!
Probing for `FSC Scylla chip'... Failed!
Client found at address 0x74
Client found at address 0x75
Client found at address 0x76
Client found at address 0x77
Client found at address 0x78
Client found at address 0x79
Client found at address 0x7a
Client found at address 0x7b
Client found at address 0x7c
Client found at address 0x7d
Client found at address 0x7e
Client found at address 0x7f

 Some chips are also accessible through the ISA bus. ISA probes are
 typically a bit more dangerous, as we have to write to I/O ports to do
 this.  Do you want to scan the ISA bus? (YES/no): no

 Now follows a summary of the probes I have just done.
 Just press ENTER to continue:

Driver `adm1021' (should be inserted but causes problems):
  Detects correctly:
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x18
    Chip `National Semiconductor LM84' (confidence: 6)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x19
    Chip `National Semiconductor LM84' (confidence: 6)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x1a
    Chip `National Semiconductor LM84' (confidence: 6)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x29
    Chip `National Semiconductor LM84' (confidence: 6)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x2a
    Chip `National Semiconductor LM84' (confidence: 6)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x2b
    Chip `National Semiconductor LM84' (confidence: 6)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x4c
    Chip `National Semiconductor LM84' (confidence: 6)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x4d
    Chip `National Semiconductor LM84' (confidence: 6)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x4e
    Chip `National Semiconductor LM84' (confidence: 6)
  Misdetects:
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x18
    Chip `Maxim MAX1617' (confidence: 3)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x19
    Chip `Maxim MAX1617' (confidence: 3)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x1a
    Chip `Maxim MAX1617' (confidence: 3)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x29
    Chip `Maxim MAX1617' (confidence: 3)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x2a
    Chip `Maxim MAX1617' (confidence: 3)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x2b
    Chip `Maxim MAX1617' (confidence: 3)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x4c
    Chip `Maxim MAX1617' (confidence: 3)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x4d
    Chip `Maxim MAX1617' (confidence: 3)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x4e
    Chip `Maxim MAX1617' (confidence: 3)

Driver `lm80' (should be inserted but causes problems):
  Detects correctly:
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x28
    Chip `National Semiconductor LM80' (confidence: 3)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x2c
    Chip `National Semiconductor LM80' (confidence: 3)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x2d
    Chip `National Semiconductor LM80' (confidence: 3)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x2e
    Chip `National Semiconductor LM80' (confidence: 3)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x2f
    Chip `National Semiconductor LM80' (confidence: 3)
  Misdetects:
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x29
    Chip `National Semiconductor LM80' (confidence: 3)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x2a
    Chip `National Semiconductor LM80' (confidence: 3)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x2b
    Chip `National Semiconductor LM80' (confidence: 3)

Driver `lm75' (should be inserted but causes problems):
  Detects correctly:
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x48
    Chip `National Semiconductor LM75' (confidence: 3)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x49
    Chip `National Semiconductor LM75' (confidence: 3)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x4a
    Chip `National Semiconductor LM75' (confidence: 3)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x4b
    Chip `National Semiconductor LM75' (confidence: 3)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x4f
    Chip `National Semiconductor LM75' (confidence: 3)
  Misdetects:
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x4c
    Chip `National Semiconductor LM75' (confidence: 3)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x4d
    Chip `National Semiconductor LM75' (confidence: 3)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x4e
    Chip `National Semiconductor LM75' (confidence: 3)

Driver `pcf8591' (may not be inserted):
  Misdetects:
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x48
    Chip `Philips Semiconductors PCF8591' (confidence: 1)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x49
    Chip `Philips Semiconductors PCF8591' (confidence: 1)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x4a
    Chip `Philips Semiconductors PCF8591' (confidence: 1)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x4b
    Chip `Philips Semiconductors PCF8591' (confidence: 1)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x4c
    Chip `Philips Semiconductors PCF8591' (confidence: 1)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x4d
    Chip `Philips Semiconductors PCF8591' (confidence: 1)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x4e
    Chip `Philips Semiconductors PCF8591' (confidence: 1)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x4f
    Chip `Philips Semiconductors PCF8591' (confidence: 1)

Driver `eeprom' (should be inserted):
  Detects correctly:
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x50
    Chip `Serial EEPROM' (confidence: 8)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x51
    Chip `Serial EEPROM' (confidence: 8)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x52
    Chip `Serial EEPROM' (confidence: 8)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x53
    Chip `Serial EEPROM' (confidence: 8)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x54
    Chip `Serial EEPROM' (confidence: 8)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x55
    Chip `Serial EEPROM' (confidence: 8)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x56
    Chip `Serial EEPROM' (confidence: 8)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x57
    Chip `Serial EEPROM' (confidence: 8)

Driver `ltc1710' (should be inserted):
  Detects correctly:
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x58
    Chip `LTC1710' (confidence: 1)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x59
    Chip `LTC1710' (confidence: 1)
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x5a
    Chip `LTC1710' (confidence: 1)

Driver `smbus-arp' (should be inserted):
  Detects correctly:
  * Bus `SMBus nVidia nForce adapter at ec00' (Non-I2C SMBus adapter)
    Busdriver `i2c-amd756', I2C address 0x61
    Chip `SMBus 2.0 ARP-Capable Device' (confidence: 1)


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
modprobe i2c-amd756
# I2C chip drivers
modprobe adm1021
modprobe lm80
modprobe lm75
modprobe eeprom
modprobe ltc1710
modprobe smbus-arp
#----cut here----

To make the sensors modules behave correctly, add these lines to either
/etc/modules.conf or /etc/conf.modules:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
options adm1021
ignore=0,0x18,0,0x19,0,0x1a,0,0x29,0,0x2a,0,0x2b,0,0x4c,0,0x4d,0,0x4e
options lm80 ignore=0,0x29,0,0x2a,0,0x2b
options lm75 ignore=0,0x4c,0,0x4d,0,0x4e
#----cut here----

Do you want to generate /etc/sysconfig/lm_sensors? (YES/no):
[root@ordiyann yann]#

So? Do you have any idea, or did I put my finger on something completly
crazy???

Regards

Yann

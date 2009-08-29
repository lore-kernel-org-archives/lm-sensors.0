From: Tech2009 <tech2009@evergrove.com>
Date: Sat, 29 Aug 2009 05:24:13 +0000
Subject: [lm-sensors] "No sensors found!" on Intel Entry Storage System
Message-Id: <1251523453.13079.32.camel@Ubuntu>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="=-fwXVBmaJughE4yqVCZwQ"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org


--=-fwXVBmaJughE4yqVCZwQ
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I am using an x86 ethernet NAS device with a preloaded custom Linux
distribution.

I replaced the OS with a stock debian kernel from another machine.

Linux debian 2.6.26-2-686 #1 SMP Sun Jul 26 21:25:33 UTC 2009 i686
GNU/Linux.

Everything works minus the temperature sensors and LED control, both
worked using the original proprietary software interface.

The manual indicates the following fan controller is used:
SMSC SCH5027D


sensors-detect apparently finds this chip, and modprobe is able to load
the dme1737 driver. (see attachments). Syslog shows nothing exceptional.

"Probing for `SMSC SCH5027D-NW'...Success!
    (confidence 6, driver `dme1737')"

It's not until "sensors" that I see a problem:
"No sensors found! Make sure you loaded all the kernel drivers you need.
Try sensors-detect to find out which these are."

Now my question is, is this user error, or is there an incompatibility
in the sensors program with the dme1737 driver?

I'm not afraid to try and debug the code myself if someone could set me
on the right path.



--=-fwXVBmaJughE4yqVCZwQ
Content-Disposition: attachment; filename="sensors-detect.txt"
Content-Type: text/plain; name="sensors-detect.txt"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

# sensors-detect revision 5249 (2008-05-11 22:56:25 +0200)

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

We can start with probing for (PCI) I2C or SMBus adapters.
Do you want to probe now? (YES/no): 
Probing for PCI bus adapters...
Use driver `i2c-i801' for device 0000:00:1f.3: Intel 82801G ICH7

We will now try to load each adapter module in turn.
Module `i2c-i801' already loaded.
If you have undetectable or unsupported I2C/SMBus adapters, you can have
them scanned by manually loading the modules before running this script.

We are now going to do the I2C/SMBus adapter probings. Some chips may
be double detected; we choose the one with the highest confidence
value in that case.
If you found that the adapter hung after probing a certain address,
you can specify that address to remain unprobed.

Next adapter: SMBus I801 adapter at 0400 (i2c-0)
Do you want to scan it? (YES/no/selectively): 
Client found at address 0x2e
Probing for `Myson MTP008'...                               No
Probing for `National Semiconductor LM78'...                No
Probing for `National Semiconductor LM78-J'...              No
Probing for `National Semiconductor LM79'...                No
Probing for `National Semiconductor LM80'...                No
Probing for `National Semiconductor LM85 or LM96000'...     No
Probing for `Analog Devices ADM1027, ADT7460 or ADT7463'... No
Probing for `SMSC EMC6D100, EMC6D101 or EMC6D102'...        No
Probing for `Analog Devices ADT7462'...                     No
Probing for `Analog Devices ADT7467 or ADT7468'...          No
Probing for `Analog Devices ADT7470'...                     No
Probing for `Analog Devices ADT7473'...                     No
Probing for `Analog Devices ADT7475'...                     No
Probing for `Analog Devices ADT7476'...                     No
Probing for `Andigilog aSC7611'...                          No
Probing for `Andigilog aSC7621'...                          No
Probing for `National Semiconductor LM87'...                No
Probing for `National Semiconductor LM93'...                No
Probing for `Winbond W83781D'...                            No
Probing for `Winbond W83782D'...                            No
Probing for `Winbond W83792D'...                            No
Probing for `Winbond W83793R/G'...                          No
Probing for `Winbond W83791SD'...                           No
Probing for `Winbond W83627HF'...                           No
Probing for `Winbond W83627EHF'...                          No
Probing for `Winbond W83627DHG'...                          No
Probing for `Asus AS99127F (rev.1)'...                      No
Probing for `Asus AS99127F (rev.2)'...                      No
Probing for `Asus ASB100 Bach'...                           No
Probing for `Winbond W83L786NR/NG/R/G'...                   No
Probing for `Winbond W83L785TS-S'...                        No
Probing for `Analog Devices ADM9240'...                     No
Probing for `Dallas Semiconductor DS1780'...                No
Probing for `National Semiconductor LM81'...                No
Probing for `Analog Devices ADM1026'...                     No
Probing for `Analog Devices ADM1025'...                     No
Probing for `Analog Devices ADM1029'...                     No
Probing for `Analog Devices ADM1030'...                     No
Probing for `Analog Devices ADM1031'...                     No
Probing for `Analog Devices ADM1022'...                     No
Probing for `Texas Instruments THMC50'...                   No
Probing for `Analog Devices ADM1028'...                     No
Probing for `ITE IT8712F'...                                No
Probing for `SMSC DME1737'...                               No
Probing for `SMSC SCH5027D-NW'...                           Success!
    (confidence 6, driver `dme1737')
Probing for `Fintek F75373S/SG'...                          No
Probing for `Fintek F75375S/SP'...                          No
Probing for `Fintek F75387SG/RG'...                         No
Probing for `Analog Devices ADM1024'...                     No
Probing for `Winbond W83791D'...                            No
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 
Yes
    (confidence 8, not a hardware monitoring chip)
Probing for `EDID EEPROM'...                                No

Some chips are also accessible through the ISA I/O ports. We have to
write to arbitrary I/O ports to probe them. This is usually safe though.
Yes, you do have ISA I/O ports even if you do not have any ISA slots!
Do you want to scan the ISA I/O ports? (YES/no): Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM78-J' at 0x290...     No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some Super I/O chips may also contain sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no): 
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No
Trying family `ITE'...                                      No
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     Yes
Found `SMSC SCH5027D-NW Super IO'                           
    (hardware monitoring capabilities accessible via SMBus only)

Some south bridges, CPUs or memory controllers may also contain
embedded sensors. Do you want to scan for them? (YES/no): 
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD K10 thermal sensors...                                  No
Intel Core family thermal sensor...                         Success!
    (driver `coretemp')
Intel AMB FB-DIMM thermal sensor...                         No

Now follows a summary of the probes I have just done.
Just press ENTER to continue: 

Driver `dme1737' (should be inserted):
  Detects correctly:
  * Bus `SMBus I801 adapter at 0400'
    Busdriver `i2c-i801', I2C address 0x2e
    Chip `SMSC SCH5027D-NW' (confidence: 6)

Driver `coretemp' (should be inserted):
  Detects correctly:
  * Chip `Intel Core family thermal sensor' (confidence: 9)

I will now generate the commands needed to load the required modules.
Just press ENTER to continue: 

To load everything that is needed, add this to /etc/modules:

#----cut here----
# I2C adapter drivers
i2c-i801
# Chip drivers
dme1737
coretemp
#----cut here----

Do you want to add these lines automatically? (yes/NO)


--=-fwXVBmaJughE4yqVCZwQ
Content-Disposition: attachment; filename="lsmod.txt"
Content-Type: text/plain; name="lsmod.txt"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Module                  Size  Used by
dme1737                29020  0 
hwmon_vid               2720  1 dme1737
i2c_dev                 5256  0 
ipv6                  235364  16 
loop                   12748  0 
evdev                   8000  0 
snd_pcm                62596  0 
snd_timer              17800  1 snd_pcm
snd                    45604  2 snd_pcm,snd_timer
soundcore               6368  1 snd
snd_page_alloc          7816  1 snd_pcm
psmouse                32336  0 
serio_raw               4740  0 
pcspkr                  2432  0 
i2c_i801                7920  0 
i2c_core               19828  3 dme1737,i2c_dev,i2c_i801
rng_core                3940  0 
iTCO_wdt                9508  0 
button                  6096  0 
intel_agp              22556  1 
agpgart                28776  1 intel_agp
ext3                  105512  1 
jbd                    39444  1 ext3
mbcache                 7108  1 ext3
raid10                 18560  0 
raid456               117264  1 
async_xor               3520  1 raid456
async_memcpy            2304  1 raid456
async_tx                6316  3 raid456,async_xor,async_memcpy
xor                    14696  2 raid456,async_xor
raid1                  18016  0 
raid0                   6368  0 
multipath               6112  0 
linear                  4544  0 
md_mod                 67068  6 raid10,raid456,raid1,raid0,multipath,linear
sd_mod                 22200  10 
ahci                   23596  6 
ehci_hcd               28396  0 
sata_sil24             11812  0 
uhci_hcd               18672  0 
usbcore               118224  3 ehci_hcd,uhci_hcd
libata                140416  2 ahci,sata_sil24
scsi_mod              129324  2 sd_mod,libata
dock                    8304  1 libata
e1000e                 84612  0 
thermal                15228  0 
processor              32544  1 thermal
fan                     4164  0 
thermal_sys            10856  3 thermal,processor,fan


--=-fwXVBmaJughE4yqVCZwQ
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--=-fwXVBmaJughE4yqVCZwQ--


From: Daniel Lucio <lucio@eecs.utk.edu>
Date: Wed, 16 Jul 2008 15:12:03 +0000
Subject: [lm-sensors] ERROR: Can't get adapter or algorithm?!?
Message-Id: <0AD1522B-D62F-497E-9003-F9106118358D@eecs.utk.edu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I am using lm-sensors version 2.9.1 in a Dell OptiPlex GX300 running  
Linux kernel 2.6.26. The first time I configured lm-sensors, it  
complained about two missing modules 'adm9240' & 'pc87360'. But at  
least I was able to get access to the CPU temperature. I asked the  
sys admin, to install this modules, and after that, now I get this  
error message:

% sensors
lm81-i2c-0-2c
  ERROR: Can't get adapter or algorithm?!?
2.5V:      +1.65 V  (min =  +1.56 V, max =  +1.80 V)
Vccp1:     +1.66 V  (min =  +1.57 V, max =  +1.80 V)
3.3V:      +2.46 V  (min =  +2.32 V, max =  +2.66 V)
5V:        +3.31 V  (min =  +3.10 V, max =  +3.52 V)
12V:       +5.00 V  (min =  +4.69 V, max =  +5.31 V)
Vccp2:     +1.46 V  (min =  +1.39 V, max =  +1.59 V)
fan1:        0 RPM  (min =   -1 RPM, div = 8)          ALARM
fan2:        0 RPM  (min = 168750 RPM, div = 8)          ALARM
temp:      +45.0 C  (high =    +0 C, hyst =    +1 C)
alarms:

Any ideas how to fix it?

Thank you!

Daniel.


###############################################################

% cat /etc/modules
# /etc/modules: kernel modules to load at boot time.
#
# This file should contain the names of kernel modules that are
# to be loaded at boot time, one per line.  Comments begin with
# a "#", and everything on the line after them are ignored.

usbkbd
usb-uhci
uhci-hcd
keybdev
mousedev
hid
psmouse

i2c-i801
i2c-isa
# I2C chip drivers
# Warning: the required module adm9240 is not currently installed on  
your system.
# For status of 2.6 kernel ports see http://secure.netroedge.com/ 
~lm78/supported.html
# If driver is built-in to the kernel, or unavailable, comment out  
the following line.
adm9240
# Warning: the required module pc87360 is not currently installed on  
your system.
# For status of 2.6 kernel ports see http://secure.netroedge.com/ 
~lm78/supported.html
# If driver is built-in to the kernel, or unavailable, comment out  
the following line.
pc87360

************************************************************************ 
**************
% lsmod
Module                  Size  Used by
i2c_dev                 6348  0
nfs                   266236  3
lockd                  65844  1 nfs
sunrpc                187504  15 nfs,lockd
xt_tcpudp               3208  0
iptable_filter          2732  0
ip_tables              11800  1 iptable_filter
x_tables               15404  2 xt_tcpudp,ip_tables
autofs4                20192  19
ipv6                  252568  12
af_packet              16424  2
ide_cd_mod             33176  0
cdrom                  39684  1 ide_cd_mod
parport_pc             32488  0
parport                34972  1 parport_pc
floppy                 55944  0
rtc                     7872  0
pcspkr                  2472  0
snd_intel8x0           29740  0
snd_ac97_codec         96500  1 snd_intel8x0
ac97_bus                1672  1 snd_ac97_codec
snd_pcm                77484  2 snd_intel8x0,snd_ac97_codec
snd_timer              22516  1 snd_pcm
snd                    53836  4  
snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer
soundcore               7300  1 snd
snd_page_alloc          8596  2 snd_intel8x0,snd_pcm
intel_rng               4620  0
rng_core                4204  1 intel_rng
shpchp                 30560  0
pci_hotplug            28320  1 shpchp
intel_agp              24736  1
agpgart                33124  1 intel_agp
3c59x                  40692  0
mii                     5448  1 3c59x
tg3                   115344  0
md_mod                 80648  0
pc87360                18532  0
adm9240                13464  0
hwmon_vid               2984  2 pc87360,adm9240
i2c_i801                8664  0
i2c_core               22520  3 i2c_dev,adm9240,i2c_i801
psmouse                37316  0
mousedev               12652  0
uhci_hcd               23132  0
usbkbd                  5448  0
usbcore               137132  3 uhci_hcd,usbkbd
ext3                  123096  8
jbd                    46320  1 ext3
mbcache                 7976  1 ext3
ide_disk               13160  11
ide_generic             2508  0 [permanent]
via82cxxx               7980  0 [permanent]
trm290                  3628  0 [permanent]
triflex                 2344  0 [permanent]
slc90e66                3368  0 [permanent]
sis5513                 9356  0 [permanent]
siimage                 8072  0 [permanent]
serverworks             5644  0 [permanent]
sc1200                  4520  0 [permanent]
rz1000                  2184  0 [permanent]
piix                    7116  0 [permanent]
pdc202xx_old            6600  0 [permanent]
pdc202xx_new            5800  0 [permanent]
opti621                 2796  0 [permanent]
ns87415                 3420  0 [permanent]
it821x                  6576  0 [permanent]
it8213                  3528  0 [permanent]
ide_pci_generic         3952  0 [permanent]
hpt366                 13480  0 [permanent]
hpt34x                  2824  0 [permanent]
cy82c693                3308  0 [permanent]
cs5530                  3528  0 [permanent]
cs5520                  3272  0 [permanent]
cmd64x                  5736  0 [permanent]
cmd640                  4104  0 [permanent]
atiixp                  3528  0 [permanent]
amd74xx                 8560  0 [permanent]
alim15x3                6264  0 [permanent]
aec62xx                 4360  0 [permanent]
ide_core               98360  31  
ide_cd_mod,ide_disk,ide_generic,via82cxxx,trm290,triflex,slc90e66,sis551 
3,siimage,serverworks,sc1200,rz1000,piix,pdc202xx_old,pdc202xx_new,opti6 
21,ns87415,it821x,it8213,ide_pci_generic,hpt366,hpt34x,cy82c693,cs5530,c 
s5520,cmd64x,cmd640,atiixp,amd74xx,alim15x3,aec62xx
unix                   24504  213

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%%%

% sensors-detect
This program will help you determine which I2C/SMBus modules you need to
load to use lm_sensors most effectively. You need to have i2c and
lm_sensors installed before running this program.
Also, you need to be `root', or at least have access to the /dev/i2c-*
files, for most things.
If you have patched your kernel and have some drivers built in, you can
safely answer NO if asked to load some modules. In this case, things may
seem a bit confusing, but they will still work.

It is generally safe and recommended to accept the default answers to
all
questions, unless you know what you're doing.

   We can start with probing for (PCI) I2C or SMBus adapters.
   You do not need any special privileges for this.
   Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `rivatv' for device 01:00.0: RIVA UVTNT2
Use driver `i2c-i801' for device 00:1f.3: Intel 82801AA ICH
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Load `rivatv' (say NO if built into your kernel)? (YES/no):
FATAL: Module rivatv not found.
Loading failed... skipping.
** Note: rivatv module is available at http://rivatv.sourceforge.net/
Module `i2c-i801' already loaded.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

   To continue, we need module `i2c-dev' to be loaded.
   If it is built-in into your kernel, you can safely skip this.
   i2c-dev is not loaded. Do you want to load it now? (YES/no):
   Module loaded succesfully.

   We are now going to do the adapter probings. Some adapters may hang
halfway
   through; we can't really help that. Also, some chips will be double
detected;
   we choose the one with the highest confidence value in that case.
   If you found that the adapter hung after probing a certain address,
you can
   specify that address to remain unprobed. That often
   includes address 0x69 (clock chip).

Next adapter: SMBus I801 adapter at dcd0
Do you want to scan it? (YES/no/selectively):
Client at address 0x18 can not be probed - unload all client drivers
first!
Client at address 0x1a can not be probed - unload all client drivers
first!
Client found at address 0x2c
Probing for `Myson MTP008'... Failed!
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Failed!
Probing for `National Semiconductor LM85 or LM96000'... Failed!
Probing for `Analog Devices ADM1027, ADT7460 or ADT7463'... Failed!
Probing for `SMSC EMC6D100, EMC6D101 or EMC6D102'... Failed!
Probing for `National Semiconductor LM87'... Failed!
Probing for `National Semiconductor LM93'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83791D'... Failed!
Probing for `Winbond W83792D'... Failed!
Probing for `Winbond W83791SD'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Winbond W83627EHF'... Failed!
Probing for `Asus AS99127F (rev.1)'... Failed!
Probing for `Asus AS99127F (rev.2)'... Failed!
Probing for `Asus ASB100 Bach'... Failed!
Probing for `Genesys Logic GL518SM Revision 0x00'... Failed!
Probing for `Genesys Logic GL518SM Revision 0x80'... Failed!
Probing for `Genesys Logic GL520SM'... Failed!
Probing for `Analog Devices ADM9240'... Failed!
Probing for `Dallas Semiconductor DS1780'... Failed!
Probing for `National Semiconductor LM81'... Success!
      (confidence 7, driver `adm9240')
Probing for `Analog Devices ADM1026'... Failed!
Probing for `Analog Devices ADM1025'... Failed!
Probing for `Philips NE1619'... Failed!
Probing for `Analog Devices ADM1024'... Failed!
Probing for `Analog Devices ADM1029'... Failed!
Probing for `Analog Devices ADM1030'... Failed!
Probing for `Analog Devices ADM1031'... Failed!
Probing for `Analog Devices ADM1022'... Failed!
Probing for `Texas Instruments THMC50'... Failed!
Probing for `ITE IT8712F'... Failed!
Probing for `ITE IT8705F / SiS 950'... Failed!
Probing for `ALi M5879'... Failed!
Client found at address 0x30
Client found at address 0x31
Client at address 0x50 can not be probed - unload all client drivers
first!
Client at address 0x51 can not be probed - unload all client drivers
first!
Client found at address 0x63

Some chips are also accessible through the ISA bus. ISA probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan the ISA bus? (YES/no):
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
Probing for `Winbond W83627EHF'
    Trying address 0x0290... Failed!
Probing for `Winbond W83697HF'
    Trying address 0x0290... Failed!
Probing for `Silicon Integrated Systems SIS5595'
    Trying general detect... Failed!
Probing for `VIA Technologies VT82C686 Integrated Sensors'
    Trying general detect... Failed!
Probing for `VIA Technologies VT8231 Integrated Sensors'
    Trying general detect... Failed!
Probing for `ITE IT8712F'
    Trying address 0x0290... Failed!
Probing for `ITE IT8705F / SiS 950'
    Trying address 0x0290... Failed!
Probing for `IPMI BMC KCS'
    Trying address 0x0ca0... Failed!
Probing for `IPMI BMC SMIC'
    Trying address 0x0ca8... Failed!

Some Super I/O chips may also contain sensors. Super I/O probes are
typically a bit more dangerous, as we have to write to I/O ports to do
this. This is usually safe though.

Do you want to scan for Super I/O sensors? (YES/no):
Probing for `ITE 8702F Super IO Sensors'
    Failed! (0xe411)
Probing for `ITE 8705F Super IO Sensors'
    Failed! (0xe411)
Probing for `ITE 8712F Super IO Sensors'
    Failed! (0xe411)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
    Failed! (0xe4)
Probing for `Nat. Semi. PC87360 Super IO Fan Sensors'
    Failed! (0xe4)
Probing for `Nat. Semi. PC87363 Super IO Fan Sensors'
    Failed! (0xe4)
Probing for `Nat. Semi. PC87364 Super IO Fan Sensors'
    Success... found at address 0x0c30
Probing for `Nat. Semi. PC87365 Super IO Fan Sensors'
    Failed! (0xe4)
Probing for `Nat. Semi. PC87365 Super IO Voltage Sensors'
    Failed! (0xe4)
Probing for `Nat. Semi. PC87365 Super IO Thermal Sensors'
    Failed! (0xe4)
Probing for `Nat. Semi. PC87366 Super IO Fan Sensors'
    Failed! (0xe4)
Probing for `Nat. Semi. PC87366 Super IO Voltage Sensors'
    Failed! (0xe4)
Probing for `Nat. Semi. PC87366 Super IO Thermal Sensors'
    Failed! (0xe4)
Probing for `Nat. Semi. PC87372 Super IO Fan Sensors'
    Failed! (0xe4)
Probing for `Nat. Semi. PC87373 Super IO Fan Sensors'
    Failed! (0xe4)
Probing for `Nat. Semi. PC87591 Super IO'
    Failed! (0xe4)
Probing for `Nat. Semi. PC87371 Super IO'
    Failed! (0xe4)
Probing for `Nat. Semi. PC97371 Super IO'
    Failed! (0xe4)
Probing for `Nat. Semi. PC8739x Super IO'
    Failed! (0xe4)
Probing for `Nat. Semi. PC8741x Super IO'
    Failed! (0xe4)
Probing for `SMSC 47B27x Super IO Fan Sensors'
    Failed! (0xe4)
Probing for `SMSC 47M10x/13x Super IO Fan Sensors'
    Failed! (0xe4)
Probing for `SMSC 47M14x Super IO Fan Sensors'
    Failed! (0xe4)
Probing for `SMSC 47M15x/192 Super IO Fan Sensors'
    Failed! (0xe4)
Probing for `SMSC 47S42x Super IO Fan Sensors'
    Failed! (0xe4)
Probing for `SMSC 47S45x Super IO Fan Sensors'
    Failed! (0xe4)
Probing for `SMSC 47M172 Super IO'
    Failed! (0xe4)
Probing for `SMSC LPC47B397-NC Super IO'
    Failed! (0xe4)
Probing for `VT1211 Super IO Sensors'
    Failed! (0xe4)
Probing for `Winbond W83627HF Super IO Sensors'
    Failed! (0xe4)
Probing for `Winbond W83627THF Super IO Sensors'
    Failed! (0xe4)
Probing for `Winbond W83637HF Super IO Sensors'
    Failed! (0xe4)
Probing for `Winbond W83697HF Super IO Sensors'
    Failed! (0xe4)
Probing for `Winbond W83697SF/UF Super IO PWM'
    Failed! (0xe4)
Probing for `Winbond W83L517D Super IO'
    Failed! (0xe4)
Probing for `Winbond W83627EHF Super IO Sensors'
    Failed! (0xe411)

Do you want to scan for secondary Super I/O sensors? (YES/no):
Probing for `ITE 8702F Super IO Sensors'
    Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
    Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
    Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
    Failed! (skipping family)
Probing for `Winbond W83627EHF Super IO Sensors'
    Failed! (skipping family)

   Now follows a summary of the probes I have just done.
   Just press ENTER to continue:

Driver `adm9240' (should be inserted):
    Detects correctly:
    * Bus `SMBus I801 adapter at dcd0'
      Busdriver `i2c-i801', I2C address 0x2c
      Chip `National Semiconductor LM81' (confidence: 7)

Driver `pc87360' (should be inserted):
    Detects correctly:
    * ISA bus address 0x0c30 (Busdriver `i2c-isa')
      Chip `Nat. Semi. PC87364 Super IO Fan Sensors' (confidence: 9)


   I will now generate the commands needed to load the I2C modules.
   Sometimes, a chip is available both through the ISA bus and an I2C
bus.
   ISA bus access is faster, but you need to load an additional driver
module
   for it. If you have the choice, do you want to use the ISA bus or the
   I2C/SMBus (ISA/smbus)?

To make the sensors modules behave correctly, add these lines to
/etc/modules:

#----cut here----
# I2C adapter drivers
i2c-i801
i2c-isa
# I2C chip drivers
# Warning: the required module adm9240 is not currently installed on
your system.
# For status of 2.6 kernel ports see http://secure.netroedge.com/ 
~lm78/supported.html
# If driver is built-in to the kernel, or unavailable, comment out the
following line.
adm9240
# Warning: the required module pc87360 is not currently installed on
your system.
# For status of 2.6 kernel ports see http://secure.netroedge.com/ 
~lm78/supported.html
# If driver is built-in to the kernel, or unavailable, comment out the
following line.
pc87360
#----cut here----

Do you want to add these lines to /etc/modules automatically? (yes/NO)



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

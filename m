From: Keith Romberg <romberg@ucar.edu>
Date: Thu, 05 Feb 2009 15:58:15 +0000
Subject: [lm-sensors] Help With a H8QMI-3 Motherboard
Message-Id: <498B0C97.6010900@ucar.edu>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

I have having a little bit of trouble with lm_sensors on a Supermicro 
H8QMI-3 motherboard.  It is a 4 socket board with 4 Opteron 8354 CPUs. 
Basically lm_sensors is reporting 2 CPU temp readings rather than 16 
core temps.  Here is all the info about the system I could think of to 
grab.  In sensors-detect I did notice the message:

"no driver for AMD K10 thermal sensors yet"

Is the AMD K10 sensor for the 8354 CPUs?

Any help you be great.

Keith

---------------------------------------------------------------------

# uname -a
Linux smaug 2.6.26.8-57.fc8 #1 SMP Thu Dec 18 18:59:49 EST 2008 x86_64 
x86_64 x86_64 GNU/Linux

# sensors -v
sensors version 2.10.6 with libsensors version 2.10.6

# lshw -short
===========================
                                 system     H8QM3
/0                              bus        H8QM3
/0/1                            memory     64KiB BIOS
/0/3                            processor  Quad-Core AMD Opteron(tm) 
Processor 8
/0/3/5                          memory     512KiB L1 cache
/0/3/6                          memory     2MiB L2 cache
/0/3/7                          memory     2MiB L3 cache
/0/8                            processor  Quad-Core AMD Opteron(tm) 
Processor 8
/0/8/9                          memory     512KiB L1 cache
/0/8/a                          memory     2MiB L2 cache
/0/8/b                          memory     2MiB L3 cache
/0/c                            processor  Quad-Core AMD Opteron(tm) 
Processor 8
/0/c/d                          memory     512KiB L1 cache
/0/c/e                          memory     2MiB L2 cache
/0/c/f                          memory     2MiB L3 cache
/0/10                           processor  Quad-Core AMD Opteron(tm) 
Processor 8
/0/10/11                        memory     512KiB L1 cache
/0/10/12                        memory     2MiB L2 cache
/0/10/13                        memory     2MiB L3 cache
/0/27                           memory     10GiB System Memory
/0/27/0                         memory     DIMM [empty]
/0/27/1                         memory     DIMM [empty]
/0/27/2                         memory     DIMM [empty]
/0/27/3                         memory     DIMM [empty]
/0/27/4                         memory     512MiB DIMM Synchronous 333 
MHz (3.0
/0/27/5                         memory     512MiB DIMM Synchronous 333 
MHz (3.0
/0/27/6                         memory     1GiB DIMM Synchronous 333 MHz 
(3.0 ns
/0/27/7                         memory     1GiB DIMM Synchronous 333 MHz 
(3.0 ns
/0/27/8                         memory     DIMM [empty]
/0/27/9                         memory     DIMM [empty]
/0/27/a                         memory     DIMM [empty]
/0/27/b                         memory     DIMM [empty]
/0/27/c                         memory     512MiB DIMM Synchronous 333 
MHz (3.0
/0/27/d                         memory     512MiB DIMM Synchronous 333 
MHz (3.0
/0/27/e                         memory     1GiB DIMM Synchronous 333 MHz 
(3.0 ns
/0/27/f                         memory     1GiB DIMM Synchronous 333 MHz 
(3.0 ns
/0/27/10                        memory     DIMM [empty]
/0/27/11                        memory     DIMM [empty]
/0/27/12                        memory     DIMM [empty]
/0/27/13                        memory     DIMM [empty]
/0/27/14                        memory     DIMM [empty]
/0/27/15                        memory     DIMM [empty]
/0/27/16                        memory     1GiB DIMM Synchronous 333 MHz 
(3.0 ns
/0/27/17                        memory     1GiB DIMM Synchronous 333 MHz 
(3.0 ns
/0/27/18                        memory     DIMM [empty]
/0/27/19                        memory     DIMM [empty]
/0/27/1a                        memory     DIMM [empty]
/0/27/1b                        memory     DIMM [empty]
/0/27/1c                        memory     DIMM [empty]
/0/27/1d                        memory     DIMM [empty]
/0/27/1e                        memory     1GiB DIMM Synchronous 333 MHz 
(3.0 ns
/0/27/1f                        memory     1GiB DIMM Synchronous 333 MHz 
(3.0 ns
/0/4                            memory     RAM memory
/0/100                          bridge     MCP55 LPC Bridge
/0/7                            bus        MCP55 SMBus
/0/2                            bus        MCP55 USB Controller
/0/2/1              usb2        bus        OHCI Host Controller
/0/2.1                          bus        MCP55 USB Controller
/0/2.1/1            usb1        bus        EHCI Host Controller
/0/9                scsi7       storage    MCP55 IDE
/0/9/0.0.0          /dev/cdrom  disk       DVD RW AW-Q170A
/0/9/0.0.0/0        /dev/cdrom  disk
/0/9/0.1.0          /dev/sdc    disk       300GB Maxtor 6B300R0
/0/9/0.1.0/1        /dev/sdc1   volume     196MiB EXT3 volume
/0/9/0.1.0/2        /dev/sdc2   volume     279GiB EXT3 volume
/0/5                            storage    MCP55 SATA Controller
/0/5.1                          storage    MCP55 SATA Controller
/0/5.2                          storage    MCP55 SATA Controller
/0/6                            bridge     MCP55 PCI bridge
/0/6/1                          display    ES1000
/0/101                          bridge     MCP55 PCI Express bridge
/0/102                          bridge     MCP55 PCI Express bridge
/0/102/0                        bridge     uPD720400 PCI Express - 
PCI/PCI-X Bri
/0/102/0/3          eth0        network    82546GB Gigabit Ethernet 
Controller
/0/102/0/3.1        eth1        network    82546GB Gigabit Ethernet 
Controller
/0/102/0.1                      bridge     uPD720400 PCI Express - 
PCI/PCI-X Bri
/0/103                          bridge     MCP55 PCI Express bridge
/0/104                          bridge     Family 10h [Opteron, 
Athlon64, Sempro
/0/105                          bridge     Family 10h [Opteron, 
Athlon64, Sempro
/0/106                          bridge     Family 10h [Opteron, 
Athlon64, Sempro
/0/107                          bridge     Family 10h [Opteron, 
Athlon64, Sempro
/0/108                          bridge     Family 10h [Opteron, 
Athlon64, Sempro
/0/109                          bridge     Family 10h [Opteron, 
Athlon64, Sempro
/0/10a                          bridge     Family 10h [Opteron, 
Athlon64, Sempro
/0/10b                          bridge     Family 10h [Opteron, 
Athlon64, Sempro
/0/10c                          bridge     Family 10h [Opteron, 
Athlon64, Sempro
/0/10d                          bridge     Family 10h [Opteron, 
Athlon64, Sempro
/0/10e                          bridge     Family 10h [Opteron, 
Athlon64, Sempro
/0/10f                          bridge     Family 10h [Opteron, 
Athlon64, Sempro
/0/110                          bridge     Family 10h [Opteron, 
Athlon64, Sempro
/0/111                          bridge     Family 10h [Opteron, 
Athlon64, Sempro
/0/112                          bridge     Family 10h [Opteron, 
Athlon64, Sempro
/0/113                          bridge     Family 10h [Opteron, 
Athlon64, Sempro
/0/114                          bridge     Family 10h [Opteron, 
Athlon64, Sempro
/0/115                          bridge     Family 10h [Opteron, 
Athlon64, Sempro
/0/116                          bridge     Family 10h [Opteron, 
Athlon64, Sempro
/0/117                          bridge     Family 10h [Opteron, 
Athlon64, Sempro
/0/0                            memory     RAM memory
/0/a                            memory     RAM memory
/0/b                            bus        MCP55 SMBus
/0/118                          bridge     MCP55 PCI Express bridge
/0/118/0                        bridge     80332 [Dobson] I/O processor 
(A-Segme
/0/118/0/e          scsi0       storage    MegaRAID
/0/118/0/e/0.f.0                processor  12 BAY U2W CU
/0/118/0/e/1.f.0                processor  12 BAY U2W CU
/0/118/0/e/2.0.0    /dev/sda    disk       512GB LD 0 RAID5  489G
/0/118/0/e/2.0.0/1  /dev/sda1   volume     477GiB Linux LVM Physical 
Volume part
/0/118/0/e/2.1.0    /dev/sdb    disk       254GB LD 1 RAID5  242G
/0/118/0/e/2.1.0/1  /dev/sdb1   volume     237GiB Linux LVM Physical 
Volume part
/0/118/0.2                      bridge     80332 [Dobson] I/O processor 
(B-Segme
/0/119                          bridge     MCP55 PCI Express bridge
/0/119/0            eth2        network    RTL8101E PCI Express Fast 
Ethernet co
/0/11a                          bridge     MCP55 PCI Express bridge
/1                  bond0       network    Ethernet interface

# lspci
00:00.0 RAM memory: nVidia Corporation MCP55 Memory Controller (rev a2)
00:01.0 ISA bridge: nVidia Corporation MCP55 LPC Bridge (rev a3)
00:01.1 SMBus: nVidia Corporation MCP55 SMBus (rev a3)
00:02.0 USB Controller: nVidia Corporation MCP55 USB Controller (rev a1)
00:02.1 USB Controller: nVidia Corporation MCP55 USB Controller (rev a2)
00:04.0 IDE interface: nVidia Corporation MCP55 IDE (rev a1)
00:05.0 IDE interface: nVidia Corporation MCP55 SATA Controller (rev a3)
00:05.1 IDE interface: nVidia Corporation MCP55 SATA Controller (rev a3)
00:05.2 IDE interface: nVidia Corporation MCP55 SATA Controller (rev a3)
00:06.0 PCI bridge: nVidia Corporation MCP55 PCI bridge (rev a2)
00:0a.0 PCI bridge: nVidia Corporation MCP55 PCI Express bridge (rev a3)
00:0d.0 PCI bridge: nVidia Corporation MCP55 PCI Express bridge (rev a3)
00:0f.0 PCI bridge: nVidia Corporation MCP55 PCI Express bridge (rev a3)
00:18.0 Host bridge: Advanced Micro Devices [AMD] Family 10h [Opteron, 
Athlon64, Sempron] HyperTransport Configuration
00:18.1 Host bridge: Advanced Micro Devices [AMD] Family 10h [Opteron, 
Athlon64, Sempron] Address Map
00:18.2 Host bridge: Advanced Micro Devices [AMD] Family 10h [Opteron, 
Athlon64, Sempron] DRAM Controller
00:18.3 Host bridge: Advanced Micro Devices [AMD] Family 10h [Opteron, 
Athlon64, Sempron] Miscellaneous Control
00:18.4 Host bridge: Advanced Micro Devices [AMD] Family 10h [Opteron, 
Athlon64, Sempron] Link Control
00:19.0 Host bridge: Advanced Micro Devices [AMD] Family 10h [Opteron, 
Athlon64, Sempron] HyperTransport Configuration
00:19.1 Host bridge: Advanced Micro Devices [AMD] Family 10h [Opteron, 
Athlon64, Sempron] Address Map
00:19.2 Host bridge: Advanced Micro Devices [AMD] Family 10h [Opteron, 
Athlon64, Sempron] DRAM Controller
00:19.3 Host bridge: Advanced Micro Devices [AMD] Family 10h [Opteron, 
Athlon64, Sempron] Miscellaneous Control
00:19.4 Host bridge: Advanced Micro Devices [AMD] Family 10h [Opteron, 
Athlon64, Sempron] Link Control
00:1a.0 Host bridge: Advanced Micro Devices [AMD] Family 10h [Opteron, 
Athlon64, Sempron] HyperTransport Configuration
00:1a.1 Host bridge: Advanced Micro Devices [AMD] Family 10h [Opteron, 
Athlon64, Sempron] Address Map
00:1a.2 Host bridge: Advanced Micro Devices [AMD] Family 10h [Opteron, 
Athlon64, Sempron] DRAM Controller
00:1a.3 Host bridge: Advanced Micro Devices [AMD] Family 10h [Opteron, 
Athlon64, Sempron] Miscellaneous Control
00:1a.4 Host bridge: Advanced Micro Devices [AMD] Family 10h [Opteron, 
Athlon64, Sempron] Link Control
00:1b.0 Host bridge: Advanced Micro Devices [AMD] Family 10h [Opteron, 
Athlon64, Sempron] HyperTransport Configuration
00:1b.1 Host bridge: Advanced Micro Devices [AMD] Family 10h [Opteron, 
Athlon64, Sempron] Address Map
00:1b.2 Host bridge: Advanced Micro Devices [AMD] Family 10h [Opteron, 
Athlon64, Sempron] DRAM Controller
00:1b.3 Host bridge: Advanced Micro Devices [AMD] Family 10h [Opteron, 
Athlon64, Sempron] Miscellaneous Control
00:1b.4 Host bridge: Advanced Micro Devices [AMD] Family 10h [Opteron, 
Athlon64, Sempron] Link Control
01:01.0 VGA compatible controller: ATI Technologies Inc ES1000 (rev 02)
03:00.0 PCI bridge: NEC Corporation uPD720400 PCI Express - PCI/PCI-X 
Bridge (rev 07)
03:00.1 PCI bridge: NEC Corporation uPD720400 PCI Express - PCI/PCI-X 
Bridge (rev 07)
04:03.0 Ethernet controller: Intel Corporation 82546GB Gigabit Ethernet 
Controller (rev 03)
04:03.1 Ethernet controller: Intel Corporation 82546GB Gigabit Ethernet 
Controller (rev 03)
80:00.0 RAM memory: nVidia Corporation MCP55 Memory Controller (rev a2)
80:01.0 RAM memory: nVidia Corporation MCP55 LPC Bridge (rev a3)
80:01.1 SMBus: nVidia Corporation MCP55 SMBus (rev a3)
80:0a.0 PCI bridge: nVidia Corporation MCP55 PCI Express bridge (rev a3)
80:0d.0 PCI bridge: nVidia Corporation MCP55 PCI Express bridge (rev a3)
80:0f.0 PCI bridge: nVidia Corporation MCP55 PCI Express bridge (rev a3)
81:00.0 PCI bridge: Intel Corporation 80332 [Dobson] I/O processor 
(A-Segment Bridge) (rev 07)
81:00.2 PCI bridge: Intel Corporation 80332 [Dobson] I/O processor 
(B-Segment Bridge) (rev 07)
82:0e.0 RAID bus controller: LSI Logic / Symbios Logic MegaRAID (rev 07)
84:00.0 Ethernet controller: Realtek Semiconductor Co., Ltd. RTL8101E 
PCI Express Fast Ethernet controller (rev 01)


# sensors-detect revision 5132 (2008-02-26 14:52:35 +0100)

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

We can start with probing for (PCI) I2C or SMBus adapters.
Do you want to probe now? (YES/no):
Probing for PCI bus adapters...
Use driver `i2c-nforce2' for device 0000:00:01.1: nVidia Corporation 
nForce4 SMBus (MCP55)

We will now try to load each adapter module in turn.
Load `i2c-nforce2' (say NO if built into your kernel)? (YES/no):
Module loaded successfully.
If you have undetectable or unsupported I2C/SMBus adapters, you can have
them scanned by manually loading the modules before running this script.

To continue, we need module `i2c-dev' to be loaded.
Do you want to load `i2c-dev' now? (YES/no):
Module loaded successfully.

We are now going to do the I2C/SMBus adapter probings. Some chips may
be double detected; we choose the one with the highest confidence
value in that case.
If you found that the adapter hung after probing a certain address,
you can specify that address to remain unprobed.

Next adapter: SMBus nForce2 adapter at d800 (i2c-0)
Do you want to scan it? (YES/no/selectively):

Next adapter: SMBus nForce2 adapter at d480 (i2c-1)
Do you want to scan it? (YES/no/selectively):

Next adapter: SMBus nForce2 adapter at 2d00 (i2c-2)
Do you want to scan it? (YES/no/selectively):

Next adapter: SMBus nForce2 adapter at 2e00 (i2c-3)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x1f
Probing for `Maxim MAX6650/MAX6651'...                      No
Client found at address 0x2f
Probing for `National Semiconductor LM78'...                No
Probing for `National Semiconductor LM78-J'...              No
Probing for `National Semiconductor LM79'...                No
Probing for `National Semiconductor LM80'...                No
Probing for `Analog Devices ADT7470'...                     No
Probing for `Winbond W83781D'...                            No
Probing for `Winbond W83782D'...                            No
Probing for `Winbond W83792D'...                            No
Probing for `Winbond W83793R/G'...                          Success!
     (confidence 8, driver `w83793', other addresses: 0x4b 0x4f)
Probing for `Winbond W83791SD'...                           No
Probing for `Winbond W83627HF'...                           No
Probing for `Winbond W83627EHF'...                          No
Probing for `Winbond W83627DHG'...                          No
Probing for `Asus AS99127F (rev.1)'...                      No
Probing for `Asus AS99127F (rev.2)'...                      No
Probing for `Asus ASB100 Bach'...                           No
Probing for `Winbond W83L786NR/NG/R/G'...                   No
Probing for `Analog Devices ADM9240'...                     No
Probing for `Dallas Semiconductor DS1780'...                No
Probing for `National Semiconductor LM81'...                No
Probing for `Analog Devices ADM1029'...                     No
Probing for `ITE IT8712F'...                                No
Probing for `Fintek custom power control IC'...             No
Probing for `Winbond W83791D'...                            No
Client found at address 0x4b
Probing for `National Semiconductor LM75'...                No
Probing for `Dallas Semiconductor DS75'...                  No
Probing for `National Semiconductor LM77'...                No
Probing for `Dallas Semiconductor DS1621'...                No
Probing for `Maxim MAX6650/MAX6651'...                      No
Probing for `National Semiconductor LM92'...                No
Probing for `National Semiconductor LM76'...                No
Probing for `Maxim MAX6633/MAX6634/MAX6635'...              No
Client found at address 0x4f
Probing for `National Semiconductor LM75'...                No
Probing for `Dallas Semiconductor DS75'...                  No
Probing for `Dallas Semiconductor DS1621'...                No
Probing for `Maxim MAX6633/MAX6634/MAX6635'...              No

Some chips are also accessible through the ISA I/O ports. We have to
write to arbitrary I/O ports to probe them. This is usually safe though.
Yes, you do have ISA I/O ports even if you do not have any ISA slots!
Do you want to scan the ISA I/O ports? (YES/no):
Probing for `National Semiconductor LM78' at 0x290...       No
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
Trying family `VIA/Winbond/Fintek'...                       Yes
Found `Winbond W83627HF/F/HG/G Super IO Sensors'            Success!
     (address 0x290, driver `w83627hf')
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No
Trying family `ITE'...                                      No

Some south bridges, CPUs or memory controllers may also contain
embedded sensors. Do you want to scan for them? (YES/no):
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD K10 thermal sensors...                                  Success!
     (driver `to-be-written')
Intel Core family thermal sensor...                         No
Intel AMB FB-DIMM thermal sensor...                         No

Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `w83793' (should be inserted):
   Detects correctly:
   * Bus `SMBus nForce2 adapter at 2e00'
     Busdriver `i2c-nforce2', I2C address 0x2f (and 0x4b 0x4f)
     Chip `Winbond W83793R/G' (confidence: 8)

Driver `w83627hf' (should be inserted):
   Detects correctly:
   * ISA bus, address 0x290
     Chip `Winbond W83627HF/F/HG/G Super IO Sensors' (confidence: 9)

Driver `to-be-written' (should be inserted):
   Detects correctly:
   * Chip `AMD K10 thermal sensors' (confidence: 9)

Do you want to overwrite /etc/sysconfig/lm_sensors? (YES/no): n
To load everything that is needed, add this to one of the system
initialization scripts (e.g. /etc/rc.d/rc.local):

#----cut here----
# I2C adapter drivers
modprobe i2c-nforce2
# Chip drivers
modprobe w83793
modprobe w83627hf
# no driver for AMD K10 thermal sensors yet
/usr/bin/sensors -s
#----cut here----

If you have some drivers built into your kernel, the list above will
contain too many modules. Skip the appropriate ones! You really
should try these commands right now to make sure everything is
working properly. Monitoring programs won't work until the needed
modules are loaded.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

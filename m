From: jason@englanders.cc (Jason Englander)
Date: Sun, 09 Jul 2006 17:46:12 +0000
Subject: [lm-sensors] ITE T8712F-A on a Gigabyte GA-8ICXT MB
Message-Id: <Pine.LNX.4.64.0607081231570.11159@mrhanky.englanders.cc>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I would appreciate any suggestions on getting lm_sensors to work on a 
particular machine, or even a confirmation that it can't be done at the 
moment.  Right now I'm getting "No sensors found!".

I'm usually a Slackware guy, but this machine is Fedora Core 5.  It's a 
Gigabyte GA-8ICXT motherboard.  According to Gigabyte, it has a 
"ITE T8712F-A" Integrated Super I/O Controller.

http://www.giga-byte.com/Products/Networking/Products_Spec.aspx?ClassValue=Networking&ProductID70&ProductName=GA-8ICXT

I started with the FC5 kernel (2.6.17-1.2145) and lm_sensors rpm 
(2.9.2-1), then tried a 2.10.0 rpm from elsewhere, then I tried a vanilla 
2.6.17.4 kernel and lm_sensors 2.10.0 from source.  I currently have 
lm_sensors from subversion (make user, make use_install) installed.

To start with, I've got "alias char-major-89 i2c-dev" in modprobe.conf, I 
have no i2c modules loaded, and I run mkdev.sh (because of udev).  I run 
sensors-detect and hit <enter> for everything, I get this:

<SNIP>
# sensors-detect revision 4065 (2006-07-04 18:05:35 -0400 (Tue, 04 Jul 2006))

This program will help you determine which I2C/SMBus modules you need to
load to use lm_sensors most effectively. You need to have i2c and
lm_sensors installed before running this program.
Also, you need to be `root', or at least have access to the /dev/i2c-*
files, for most things.
If you have patched your kernel and have some drivers built in, you can
safely answer NO if asked to load some modules. In this case, things may
seem a bit confusing, but they will still work.

It is generally safe and recommended to accept the default answers to all
questions, unless you know what you're doing.

  We can start with probing for (PCI) I2C or SMBus adapters.
  You do not need any special privileges for this.
  Do you want to probe now? (YES/no): Probing for PCI bus adapters...
Use driver `i2c-i801' for device 00:1f.3: Intel 82801FB ICH6
Probe succesfully concluded.

We will now try to load each adapter module in turn.
Load `i2c-i801' (say NO if built into your kernel)? (YES/no):
Module loaded succesfully.
If you have undetectable or unsupported adapters, you can have them
scanned by manually loading the modules before running this script.

  To continue, we need module `i2c-dev' to be loaded.
  If it is built-in into your kernel, you can safely skip this.
  i2c-dev is not loaded. Do you want to load it now? (YES/no):
  Module loaded succesfully.

  We are now going to do the adapter probings. Some adapters may hang halfway
  through; we can't really help that. Also, some chips will be double detected;
  we choose the one with the highest confidence value in that case.
  If you found that the adapter hung after probing a certain address, you can
  specify that address to remain unprobed. That often
  includes address 0x69 (clock chip).

Next adapter: SMBus I801 adapter at 3000
Do you want to scan it? (YES/no/selectively):
Client found at address 0x08
Client found at address 0x2e
Probing for `Myson MTP008'... Failed!
Probing for `National Semiconductor LM78'... Failed!
Probing for `National Semiconductor LM78-J'... Failed!
Probing for `National Semiconductor LM79'... Failed!
Probing for `National Semiconductor LM80'... Failed!
Probing for `National Semiconductor LM85 or LM96000'... Failed!
Probing for `Analog Devices ADM1027, ADT7460 or ADT7463'... Failed!
Probing for `SMSC EMC6D100, EMC6D101 or EMC6D102'... Failed!
Probing for `Analog Devices ADT7467 or ADT7468'... Failed!
Probing for `Analog Devices ADT7476'... Failed!
Probing for `National Semiconductor LM87'... Failed!
Probing for `National Semiconductor LM93'... Failed!
Probing for `Winbond W83781D'... Failed!
Probing for `Winbond W83782D'... Failed!
Probing for `Winbond W83792D'... Failed!
Probing for `Winbond W83793R/G'... Failed!
Probing for `Winbond W83791SD'... Failed!
Probing for `Winbond W83627HF'... Failed!
Probing for `Winbond W83627EHF'... Failed!
Probing for `Winbond W83627DHG'... Failed!
Probing for `Asus AS99127F (rev.1)'... Failed!
Probing for `Asus AS99127F (rev.2)'... Failed!
Probing for `Asus ASB100 Bach'... Failed!
Probing for `Winbond W83L785TS-S'... Failed!
Probing for `Analog Devices ADM9240'... Failed!
Probing for `Dallas Semiconductor DS1780'... Failed!
Probing for `National Semiconductor LM81'... Failed!
Probing for `Analog Devices ADM1026'... Failed!
Probing for `Analog Devices ADM1025'... Failed!
Probing for `Analog Devices ADM1024'... Failed!
Probing for `Analog Devices ADM1029'... Failed!
Probing for `Analog Devices ADM1030'... Failed!
Probing for `Analog Devices ADM1031'... Failed!
Probing for `Analog Devices ADM1022'... Failed!
Probing for `Texas Instruments THMC50'... Failed!
Probing for `Analog Devices ADM1028'... Failed!
Probing for `ITE IT8712F'... Failed!
Probing for `Fintek F75373S/SG'... Failed!
Probing for `Fintek F75375S/SP'... Failed!
Probing for `Fintek F75387SG/RG'... Failed!
Probing for `Winbond W83791D'... Success!
     (confidence 7, driver `w83791d'), other addresses: 0x48 0x49
Client found at address 0x44
Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
Client found at address 0x48
Probing for `National Semiconductor LM75'... Failed!
Probing for `National Semiconductor LM77'... Failed!
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `Maxim MAX6650/MAX6651'... Failed!
Probing for `National Semiconductor LM92'... Failed!
Probing for `National Semiconductor LM76'... Failed!
Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
Client found at address 0x49
Probing for `National Semiconductor LM75'... Failed!
Probing for `National Semiconductor LM77'... Failed!
Probing for `Dallas Semiconductor DS1621'... Failed!
Probing for `National Semiconductor LM92'... Failed!
Probing for `National Semiconductor LM76'... Failed!
Probing for `Maxim MAX6633/MAX6634/MAX6635'... Failed!
Client found at address 0x61
Probing for `SMBus 2.0 ARP-Capable Device'... Success!
     (confidence 1, driver `smbus-arp')
Client found at address 0x70
Probing for `Philips Semiconductors PCA9540'... Success!
     (confidence 1, driver `pca9540')

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
Probing for `Winbond W83627DHG'
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

Do you want to scan for Super I/O sensors? (YES/no): Probing for `ITE 8702F Super IO Sensors'
   Failed! (0x8712)
Probing for `ITE 8705F Super IO Sensors'
   Failed! (0x8712)
Probing for `ITE 8712F Super IO Sensors'
   Success... found at address 0x0290
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
   Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
   Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
   Failed! (skipping family)
Probing for `Winbond W83627EHF/EHG Super IO Sensors'
   Failed! (skipping family)

Do you want to scan for secondary Super I/O sensors? (YES/no):
Probing for `ITE 8702F Super IO Sensors'
   Failed! (skipping family)
Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
   Failed! (skipping family)
Probing for `SMSC 47B27x Super IO Fan Sensors'
   Failed! (skipping family)
Probing for `VT1211 Super IO Sensors'
   Failed! (skipping family)
Probing for `Winbond W83627EHF/EHG Super IO Sensors'
   Failed! (skipping family)

  Now follows a summary of the probes I have just done.
  Just press ENTER to continue: 
Driver `w83791d' (should be inserted):
   Detects correctly:
   * Bus `SMBus I801 adapter at 3000'
     Busdriver `i2c-i801', I2C address 0x2e (and 0x48 0x49)
     Chip `Winbond W83791D' (confidence: 7)

Driver `smbus-arp' (should be inserted):
   Detects correctly:
   * Bus `SMBus I801 adapter at 3000'
     Busdriver `i2c-i801', I2C address 0x61
     Chip `SMBus 2.0 ARP-Capable Device' (confidence: 1)

Driver `pca9540' (should be inserted):
   Detects correctly:
   * Bus `SMBus I801 adapter at 3000'
     Busdriver `i2c-i801', I2C address 0x70
     Chip `Philips Semiconductors PCA9540' (confidence: 1)

Driver `it87' (should be inserted):
   Detects correctly:
   * ISA bus address 0x0290 (Busdriver `i2c-isa')
     Chip `ITE 8712F Super IO Sensors' (confidence: 9)


I will now generate the commands needed to load the I2C modules.

To make the sensors modules behave correctly, add these lines to
/etc/modules.conf:

#----cut here----
# I2C module options
alias char-major-89 i2c-dev
#----cut here----

To load everything that is needed, add this to some /etc/rc* file:

#----cut here----
# I2C adapter drivers
modprobe i2c-i801
modprobe i2c-isa
# I2C chip drivers
# Warning: the required module w83791d is not currently installed on your system.
# For status of 2.6 kernel ports see http://www.lm-sensors.org/wiki/SupportedDevices
# If driver is built-in to the kernel, or unavailable, comment out the following line.
modprobe w83791d
# Warning: the required module smbus-arp is not currently installed on your system.
# For status of 2.6 kernel ports see http://www.lm-sensors.org/wiki/SupportedDevices
# If driver is built-in to the kernel, or unavailable, comment out the following line.
modprobe smbus-arp
# Warning: the required module pca9540 is not currently installed on your system.
# For status of 2.6 kernel ports see http://www.lm-sensors.org/wiki/SupportedDevices
# If driver is built-in to the kernel, or unavailable, comment out the following line.
modprobe pca9540
modprobe it87
# sleep 2 # optional
/usr/local/bin/sensors -s # recommended
#----cut here----

WARNING! If you have some things built into your kernel, the list above
will contain too many modules. Skip the appropriate ones! You really should
try these commands right now to make sure everything is working properly.
Monitoring programs won't work until it's done.

Do you want to generate /etc/sysconfig/lm_sensors? (YES/no):
Copy prog/init/lm_sensors.init to /etc/rc.d/init.d/lm_sensors
for initialization at boot time.
</SNIP>

I saw the FAQ entry about smbus-arp.  Not sure about w83791d or pca9540, 
pre 2.6 kernel modules I guess.  When I modprobe i2c-i801, i2c-isa, and 
it87 I get this:

i2c /dev entries driver
it87: Found IT8712F chip at 0x290, revision 7

# sensors -s
No sensors found!

Here's lsmod:
Module                  Size  Used by
it87                   16548  0
hwmon_vid               2304  1 it87
hwmon                   2436  1 it87
i2c_isa                 3456  1 it87
i2c_dev                 6660  0
i2c_i801                7180  0
i2c_core               14848  4 it87,i2c_isa,i2c_dev,i2c_i801
ip_conntrack_netbios_ns     2432  0
ipt_REJECT              3712  1
xt_state                1920  8
ip_conntrack           39264  2 ip_conntrack_netbios_ns,xt_state
nfnetlink               4888  1 ip_conntrack
xt_tcpudp               2944  10
iptable_filter          2432  1
ip_tables              10060  1 iptable_filter
x_tables                9604  4 ipt_REJECT,xt_state,xt_tcpudp,ip_tables
binfmt_misc             8072  1
nls_utf8                1920  1
isofs                  20100  1
nls_base                6144  2 nls_utf8,isofs
psmouse                31240  0

# i2cdetect -l
i2c-0   smbus           SMBus I801 adapter at 3000              Non-I2C 
SMBus adapter

# lspci
00:00.0 Host bridge: Intel Corporation E7220/E7221 Memory Controller Hub (rev 05)
00:01.0 PCI bridge: Intel Corporation E7220/E7221 PCI Express Root Port (rev 05)
00:02.0 VGA compatible controller: Intel Corporation E7221 Integrated Graphics Controller (rev 05)
00:1c.0 PCI bridge: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) PCI Express Port 1 (rev 03)
00:1e.0 PCI bridge: Intel Corporation 82801 PCI Bridge (rev d3)
00:1f.0 ISA bridge: Intel Corporation 82801FB/FR (ICH6/ICH6R) LPC Interface Bridge (rev 03)
00:1f.1 IDE interface: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) IDE Controller (rev 03)
00:1f.3 SMBus: Intel Corporation 82801FB/FBM/FR/FW/FRW (ICH6 Family) SMBus Controller (rev 03)
01:00.0 PCI bridge: Intel Corporation 6702PXH PCI Express-to-PCI Bridge A (rev 09)
02:01.0 RAID bus controller: 3ware Inc 9550SX SATA-RAID
0a:0a.0 Ethernet controller: Intel Corporation 82541GI/PI Gigabit Ethernet Controller (rev 05)
0a:0b.0 Ethernet controller: Intel Corporation 82541GI/PI Gigabit Ethernet Controller (rev 05)

# lspci -n
00:00.0 0600: 8086:2588 (rev 05)
00:01.0 0604: 8086:2589 (rev 05)
00:02.0 0300: 8086:258a (rev 05)
00:1c.0 0604: 8086:2660 (rev 03)
00:1e.0 0604: 8086:244e (rev d3)
00:1f.0 0601: 8086:2640 (rev 03)
00:1f.1 0101: 8086:266f (rev 03)
00:1f.3 0c05: 8086:266a (rev 03)
01:00.0 0604: 8086:032c (rev 09)
02:01.0 0104: 13c1:1003
0a:0a.0 0200: 8086:1076 (rev 05)
0a:0b.0 0200: 8086:1076 (rev 05)

Any suggestions?
(and if I missed a FAQ or whatever, please point me the way)

I can't look at the chip itself at the moment, but I can do that (and 
whatever else is suggested) later.

TIA,
   Jason

-- 
Jason Englander <jason at englanders.cc>
394F 7E02 C105 7268 777A  3F5A 0AC0 C618 0675 80CA



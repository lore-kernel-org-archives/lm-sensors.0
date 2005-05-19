From: donj@asaca.com (Don Jessup)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: System hanging using CSB5 chip with 2.8.1
Message-Id: <20031125211801.35736.qmail@web14522.mail.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



  When doing a sensors-detect the system just ends up hanging.
  

  1. Output from sensors-detect.
  2. output from lsmod
  3. output from lspci, I don't know if it is a 
       pci problem but here is info anyway
  4. output from i2cdetect, which also caused the system to hang
  5. Motherboard type: Super X5DL8-GG
  6. Sensors Version: 2.8.1
  7. Kernel Version: 2.4.22 with 2.8.1 patch 
  8. Numbers of the ServerWork Chip on the Super X5DL8-GG mother board
     SWC-S137440-P01
     0243PU603
  

This is output of sensors-detect after the system hangs.
1. #############################################################
  
This program will help you determine which I2C/SMBus modules you need to
load to use lm_sensors most effectively. You need to have i2c and
lm_sensors installed before running this program.
Also, you need to be `root', or at least have access to the /dev/i2c-*
files, for most things.
If you have patched your kernel and have some drivers built in, you can
safely answer NO if asked to load some modules. In this case, things may
seem a bit confusing, but they will still work.

 BIOS vendor (ACPI): AMI
 System vendor (DMI): Supermicro                                        .
 BIOS version (DMI): 0700xx
 We can start with probing for (PCI) I2C or SMBus adapters.
 You do not need any special privileges for this.
 Do you want to probe now? (YES/no): YES
Probing for PCI bus adapters...
Use driver `i2c-piix4' for device 00:0f.0: ServerWorks CSB5 South Bridge
Probe succesfully concluded.

 We will now try to load each adapter module in turn.
Load `i2c-piix4' (say NO if built into your kernel)? (YES/no): YES
Module loaded succesfully.
 Do you now want to be prompted for non-detectable adapters? (yes/NO): NO
 To continue, we need module `i2c-dev' to be loaded.
 If it is built-in into your kernel, you can safely skip this.
 i2c-dev is not loaded. Do you want to load it now? (YES/no): YES
 Module loaded succesfully.

 We are now going to do the adapter probings. Some adapters may hang halfway
 through; we can't really help that. Also, some chips will be double detected;
 we choose the one with the highest confidence value in that case.
 If you found that the adapter hung after probing a certain address, you can
 specify that address to remain unprobed. That often
 includes address 0x69 (clock chip).

Next adapter: SMBus PIIX4 adapter at 0580 (Non-I2C SMBus adapter)
Do you want to scan it? (YES/no/selectively): selectively
Please enter one or more addresses not to scan. Separate them with comma's.
You can specify a range by using dashes. Addresses may be decimal (like 54)
or hexadecimal (like 0x33).
Addresses: 0x69


2. #############################################################

Module                  Size  Used by    Tainted: PF
i2c-dev                 5184   0  (unused)
i2c-piix4               4488   0  (unused)
dmi_scan                2148   0  [i2c-piix4]
i2c-core               20324   0  [i2c-dev i2c-piix4]
iscsih                110200   0  (unused)
vtarget               239328   0  [iscsih]
sd_mod                 13068   0  (autoclean) (unused)
mptstm                 24688   1  [vtarget]
mptbase                36000   1  [mptstm]
dmdbcdrv               31168   0
ioMetaDevice           92512   0  [vtarget mptstm]
mapdevice              29912   0  (unused)
3w-xxxx                37344   0
autofs                 12372   0  (autoclean) (unused)
tg3                    46344   0  (unused)
e1000                  68192   1
ipt_REJECT              4024   6  (autoclean)
iptable_filter          2316   1  (autoclean)
ip_tables              15072   2  [ipt_REJECT iptable_filter]
microcode               4540   0  (autoclean)
ide-scsi               11280   0
scsi_mod              104212   5  [iscsih vtarget sd_mod 3w-xxxx ide-scsi]
ide-cd                 33632   0
cdrom                  30976   0  [ide-cd]
keybdev                 2688   0  (unused)
mousedev                5300   1
hid                    23172   0  (unused)
input                   5568   0  [keybdev mousedev hid]
usb-ohci               20520   0  (unused)
usbcore                72768   1  [dmdbcdrv hid usb-ohci]
ext3                   64996   6
jbd                    48724   6  [ext3]
raid1                  14604   6


3. ##############################################################

00:00.0 Class 0600: 1166:0014 (rev 31)
00:00.1 Class 0600: 1166:0014
00:00.2 Class 0600: 1166:0014
00:02.0 Class 0300: 1002:4752 (rev 27)
00:04.0 Class 0200: 8086:100e (rev 02)
00:0f.0 Class 0601: 1166:0201 (rev 93)
00:0f.1 Class 0101: 1166:0212 (rev 93)
00:0f.2 Class 0c03: 1166:0220 (rev 05)
00:0f.3 Class 0600: 1166:0225
00:10.0 Class 0600: 1166:0101 (rev 03)
00:10.2 Class 0600: 1166:0101 (rev 03)
00:11.0 Class 0600: 1166:0101 (rev 03)
00:11.2 Class 0600: 1166:0101 (rev 03)
01:02.0 Class 0c04: 1000:0622 (rev 02)
01:02.1 Class 0c04: 1000:0622 (rev 02)
01:03.0 Class 0200: 14e4:16a7 (rev 02)
02:02.0 Class 0104: 13c1:1001 (rev 01)
02:03.0 Class 0104: 13c1:1001 (rev 01)
03:02.0 Class 0104: 13c1:1001 (rev 01)
03:03.0 Class 0104: 13c1:1001 (rev 01)
04:03.0 Class 0100: 9005:801f (rev 03)
04:03.1 Class 0100: 9005:801f (rev 03)


4. ##############################################################

  WARNING! This program can confuse your I2C bus, cause data loss and worse!
  I will probe file /dev/i2c-0
  You have five seconds to reconsider and press CTRL-C!

     0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f


==Don Jessup
Asaca/Shibasoku Corp. of America
400 Corporate Circle, Unit G
Golden, CO  80401
303-278-1111 X232
donj@asaca.com
http://www.asaca.com

From: "Anders Kullenberg" <akullen@swipnet.se>
Date: Sat, 12 Mar 2011 19:25:16 +0000
Subject: [lm-sensors] extrem fan rpms witk atk0110
Message-Id: <000001cbe0eb$37ef09e0$a7cd1da0$@se>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,

I have extremely high fan reading on my ubuntu 10.10 server installation
(AMD64). Any clues to what could be the reason?

Asus m2v motherboard
Lm-sensors 3.1.2 kernel 2.6.35-22

Sensors output:
atk0110-acpi-0
Adapter: ACPI interface
Vcore Voltage:      +1.14 V  (min =3D  +0.85 V, max =3D  +1.60 V)
 +3.3 Voltage:      +3.31 V  (min =3D  +2.97 V, max =3D  +3.63 V)
 +5 Voltage:        +5.00 V  (min =3D  +4.50 V, max =3D  +5.50 V)
 +12 Voltage:      +11.31 V  (min =3D +10.20 V, max =3D +13.80 V)
CPU FAN Speed:     18000 RPM  (min =3D  800 RPM)
CHASSIS FAN Speed: 14835 RPM  (min =3D  800 RPM)
CHASSIS2 FAN Speed:   0 RPM  (min =3D  800 RPM)
CPU Temperature:    +25.0=B0C  (high =3D +60.0=B0C, crit =3D +95.0=B0C)
MB Temperature:     +35.0=B0C  (high =3D +45.0=B0C, crit =3D +95.0=B0C)

k8temp-pci-00c3
Adapter: PCI adapter
Core0 Temp:  +28.0=B0C
Core1 Temp:  +28.0=B0C

Sensors-detect output:
# sensors-detect revision 5818 (2010-01-18 17:22:07 +0100)
# System: System manufacturer System Product Name
# Board: ASUSTeK Computer INC. M2V

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

Some south bridges, CPUs or memory controllers contain embedded sensors.
Do you want to scan for them? This is totally safe. (YES/no): y
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   Success!
    (driver `k8temp')
AMD Family 10h thermal sensors...                           No
AMD Family 11h thermal sensors...                           No
Intel Core family thermal sensor...                         No
Intel Atom thermal sensor...                                No
Intel AMB FB-DIMM thermal sensor...                         No
VIA C7 thermal sensor...                                    No
VIA Nano thermal sensor...                                  No

Some Super I/O chips contain embedded sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no): y
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
Trying family `ITE'...                                      Yes
Found `ITE IT8712F Super IO Sensors'                        Success!
    (address 0xd00, driver `it87')
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
Trying family `ITE'...                                      No

Some systems (mainly servers) implement IPMI, a set of common interfaces
through which system health data may be retrieved, amongst other things.
We first try to get the information from SMBIOS. If we don't find it
there, we have to read from arbitrary I/O ports to probe for such
interfaces. This is normally safe. Do you want to scan for IPMI
interfaces? (YES/no): y
Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Some hardware monitoring chips are accessible through the ISA I/O ports.
We have to write to arbitrary I/O ports to probe them. This is usually
safe though. Yes, you do have ISA I/O ports even if you do not have any
ISA slots! Do you want to scan the ISA I/O ports? (yes/NO):

Lastly, we can probe the I2C/SMBus adapters for connected hardware
monitoring devices. This is the most risky part, and while it works
reasonably well on most systems, it has been reported to cause trouble
on some systems.
Do you want to probe the I2C/SMBus adapters now? (YES/no):
Using driver `i2c-viapro' for device 0000:00:11.0: VIA Technologies VT8237A
South Bridge
Module i2c-dev loaded successfully.

Next adapter: SMBus Via Pro adapter at 0400 (i2c-0)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
    (confidence 8, not a hardware monitoring chip)
Probing for `EDID EEPROM'...                                No
Client found at address 0x51
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
    (confidence 8, not a hardware monitoring chip)
Client found at address 0x52
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
    (confidence 8, not a hardware monitoring chip)

Next adapter: nouveau-0000:02:00.0-0 (i2c-1)
Do you want to scan it? (YES/no/selectively):

Next adapter: nouveau-0000:02:00.0-1 (i2c-2)
Do you want to scan it? (YES/no/selectively):
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No
Probing for `EDID EEPROM'...                                Yes
    (confidence 8, not a hardware monitoring chip)
Client found at address 0x51
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No
Client found at address 0x52
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No
Client found at address 0x53
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No

Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `it87':
  * ISA bus, address 0xd00
    Chip `ITE IT8712F Super IO Sensors' (confidence: 9)

Driver `k8temp' (autoloaded):
  * Chip `AMD K8 thermal sensors' (confidence: 9)

To load everything that is needed, add this to /etc/modules:
#----cut here----
# Chip drivers
it87
#----cut here----
If you have some drivers built into your kernel, the list above will
contain too many modules. Skip the appropriate ones!

Do you want to add these lines automatically to /etc/modules? (yes/NO)y
Successful!

Monitoring programs won't work until the needed modules are
loaded. You may want to run '/etc/init.d/module-init-tools start'
to load them.

Unloading i2c-dev... OK

Syslog:
Mar 12 19:54:48 ubuntu64 kernel: [79586.376615] i2c /dev entries driver
Mar 12 19:55:02 ubuntu64 kernel: [79600.460030] i2c i2c-0: Transaction
error!
Mar 12 19:56:30 ubuntu64 kernel: [79688.138046] it87: Found IT8712F chip at
0xd00, revision 8
Mar 12 19:56:30 ubuntu64 kernel: [79688.138063] it87: in3 is VCC (+5V)
Mar 12 19:56:30 ubuntu64 kernel: [79688.138121] ACPI: resource it87 [io
0x0d05-0x0d06] conflicts with ACPI region ECRE [io  0x0d00-0x0d1f 64bit pref
window disabled]
Mar 12 19:56:30 ubuntu64 kernel: [79688.138127] ACPI: If an ACPI driver is
available for this device, you should use it instead of the native driver
Mar 12 19:57:07 ubuntu64 kernel: [79725.578667] it87: Found IT8712F chip at
0xd00, revision 8
Mar 12 19:57:07 ubuntu64 kernel: [79725.578683] it87: in3 is VCC (+5V)
Mar 12 19:57:07 ubuntu64 kernel: [79725.578739] ACPI: resource it87 [io
0x0d05-0x0d06] conflicts with ACPI region ECRE [io  0x0d00-0x0d1f 64bit pref
window disabled]
Mar 12 19:57:07 ubuntu64 kernel: [79725.578745] ACPI: If an ACPI driver is
available for this device, you should use it instead of the native driver

Lsmod:
akullen@ubuntu64:/var/log$ lsmod
Module                  Size  Used by
hwmon_vid               3154  0
btrfs                 506233  0
zlib_deflate           21866  1 btrfs
crc32c                  3007  1
libcrc32c               1268  1 btrfs
ufs                    74383  0
qnx4                    8101  0
hfsplus                77805  0
hfs                    47012  0
minix                  29316  0
ntfs                   97458  0
vfat                   10954  0
msdos                   7960  0
fat                    55892  2 vfat,msdos
jfs                   182997  0
xfs                   765027  0
exportfs                4226  1 xfs
reiserfs              244566  0
ipt_REJECT              2440  1
xt_comment              1056  7
ipt_LOG                 5394  5
xt_multiport            1949  3
xt_limit                2204  7
xt_tcpudp               2627  11
ipt_addrtype            2175  4
xt_state                1386  7
ip6table_filter         1719  1
ip6_tables             20295  1 ip6table_filter
nf_nat_irc              1601  0
nf_conntrack_irc        4501  1 nf_nat_irc
snd_hda_codec_realtek   299533  1
nf_nat_ftp              1831  0
nf_nat                 20067  2 nf_nat_irc,nf_nat_ftp
nf_conntrack_ipv4      13143  9 nf_nat
nf_defrag_ipv4          1569  1 nf_conntrack_ipv4
nf_conntrack_ftp        7158  1 nf_nat_ftp
snd_hda_intel          26019  0
nf_conntrack           75238  7
xt_state,nf_nat_irc,nf_conntrack_irc,nf_nat_ftp,nf_nat,nf_conntrack_ipv4,nf_
conntrack_ftp
nouveau               568784  1
snd_hda_codec         100823  2 snd_hda_codec_realtek,snd_hda_intel
snd_hwdep               6482  1 snd_hda_codec
iptable_filter          1778  1
ttm                    68180  1 nouveau
drm_kms_helper         32836  1 nouveau
ip_tables              18737  1 iptable_filter
snd_pcm                88118  2 snd_hda_intel,snd_hda_codec
snd_timer              23518  1 snd_pcm
ppdev                   6644  0
x_tables               24391  12
ipt_REJECT,xt_comment,ipt_LOG,xt_multiport,xt_limit,xt_tcpudp,ipt_addrtype,x
t_state,ip6table_filter,ip6_tables,iptable_filter,ip_tables
snd                    63620  6
snd_hda_codec_realtek,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_time
r
soundcore               1240  1 snd
psmouse                62080  0
snd_page_alloc          8588  2 snd_hda_intel,snd_pcm
serio_raw               4942  0
k8temp                  4064  0
edac_core              46822  0
edac_mce_amd            9387  0
i2c_viapro              6817  0
asus_atk0110           12987  0
parport_pc             30086  1
drm                   205201  3 nouveau,ttm,drm_kms_helper
i2c_algo_bit            6208  1 nouveau
shpchp                 34910  0
lp                     10169  0
parport                36936  3 ppdev,parport_pc,lp
usb_storage            50340  1
floppy                 65235  0
atl1                   33691  0
sata_via                9840  2
pata_via                9248  0
mii                     5261  1 atl1

thanks
Anders
=20


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

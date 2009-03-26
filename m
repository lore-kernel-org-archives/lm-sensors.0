From: "D'Inverno Jeremy" <jeremy.dinverno@gmail.com>
Date: Thu, 26 Mar 2009 14:25:32 +0000
Subject: [lm-sensors] LM-sensors and ASUS P6T.
Message-Id: <32b9ed800903260725g4022cc74ke98f6b0dc9611516@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="===============0055718664914453727=="
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--===============0055718664914453727==
Content-Type: multipart/alternative; boundary=0015174bde846f1b4c04660664b0

--0015174bde846f1b4c04660664b0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hy all,

I try to use LM-sensors at my Fedora Core 9 64bit installed on a Asus P6T
motherboard, But i think lm-sensors dont see the integrated sensors:



   - Motherboard: Asus p6t Deluxe



   - Sensors-detect revision 5108 (2008-01-22 13:22:47 +0100)
   - Linux 2.6.25-14.fc9.x86_64


> [root@iceland ~]# sensors-detect
> # sensors-detect revision 5108 (2008-01-22 13:22:47 +0100)
> We can start with probing for (PCI) I2C or SMBus adapters.
> Do you want to probe now? (YES/no):
> Probing for PCI bus adapters...
> Found unknown SMBus adapter 8086:3a30 at 0000:00:1f.3.
> Sorry, no known PCI bus adapters found.
> We will now try to load each adapter module in turn.
> If you have undetectable or unsupported adapters, you can have them
> scanned by manually loading the modules before running this script.
> We are now going to do the I2C/SMBus adapter probings. Some chips may
> be double detected; we choose the one with the highest confidence
> value in that case.
> If you found that the adapter hung after probing a certain address,
> you can specify that address to remain unprobed.
> Next adapter: SMBus I801 adapter at 0400 (i2c-0)
> Do you want to scan it? (YES/no/selectively):
> Client found at address 0x44
> Probing for `Maxim MAX6633/MAX6634/MAX6635'...
> No
> Client found at address 0x4f
> Probing for `National Semiconductor LM75'...
> No
> Probing for `Dallas Semiconductor DS75'...                  No
> Probing for `Dallas Semiconductor DS1621'...                No
> Probing for `Maxim MAX6633/MAX6634/MAX6635'...
> No
> Client found at address 0x50
> Probing for `Analog Devices ADM1033'...                     No
> Probing for `Analog Devices ADM1034'...                     No
> Probing for `SPD EEPROM'...                                 No
> Probing for `EDID EEPROM'...                                No
> Client found at address 0x51
> Probing for `Analog Devices ADM1033'...                     No
> Probing for `Analog Devices ADM1034'...                     No
> Probing for `SPD EEPROM'...                                 No
> Probing for `EDID EEPROM'...                                No
> Client found at address 0x52
> Probing for `Analog Devices ADM1033'...                     No
> Probing for `Analog Devices ADM1034'...                     No
> Probing for `SPD EEPROM'...                                 No
> Probing for `EDID EEPROM'...                                No
> Client found at address 0x53
> Probing for `Analog Devices ADM1033'...                     No
> Probing for `Analog Devices ADM1034'...                     No
> Probing for `SPD EEPROM'...                                 No
> Probing for `EDID EEPROM'...                                No
> Some chips are also accessible through the ISA I/O ports. We have to
> write to arbitrary I/O ports to probe them. This is usually safe though.
> Yes, you do have ISA I/O ports even if you do not have any ISA slots!
> Do you want to scan the ISA I/O ports? (YES/no): Probing for `National
> Semiconductor LM78' at 0x290...       No
> Probing for `National Semiconductor LM78-J' at 0x290...     No
> Probing for `National Semiconductor LM79' at 0x290...       No
> Probing for `Winbond W83781D' at 0x290...                   No
> Probing for `Winbond W83782D' at 0x290...                   No
> Probing for `Silicon Integrated Systems SIS5595'...         No
> Probing for `VIA VT82C686 Integrated Sensors'...            No
> Probing for `VIA VT8231 Integrated Sensors'...              No
> Probing for `IPMI BMC KCS' at 0xca0...                      No
> Probing for `IPMI BMC SMIC' at 0xca8...                     No
> Some Super I/O chips may also contain sensors. We have to write to
> standard I/O ports to probe them. This is usually safe.
> Do you want to scan for Super I/O sensors? (YES/no): Probing for Super-I/O
> at 0x2e/0x2f
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     No
> Trying family `VIA/Winbond/Fintek'...                       Yes
> Found unknown chip with ID 0xa513
>     (logical device B has address 0x290, could be sensors)
> Probing for Super-I/O at 0x4e/0x4f
> Trying family `National Semiconductor'...                   No
> Trying family `SMSC'...                                     No
> Trying family `VIA/Winbond/Fintek'...                       No
> Trying family `ITE'...                                      No
> Some CPUs or memory controllers may also contain embedded sensors.
> Do you want to scan for them? (YES/no): AMD K8 thermal
> sensors...                                   No
> AMD K10 thermal sensors...                                  No
> Intel Core family thermal sensor...                         No
> Intel AMB FB-DIMM thermal sensor...                         No
> *Sorry, no sensors were detected.*
> Either your sensors are not supported, or they are connected to an
> I2C or SMBus adapter that is not supported. See doc/FAQ,
> doc/lm_sensors-FAQ.html or http://www.lm-sensors.org/wiki/FAQ
> (FAQ #4.24.3) for further information.
> If you find out what chips are on your board, check
> http://www.lm-sensors.org/wiki/Devices for driver status.
>

[root@iceland ~]# lsmod
Module                  Size  Used by
i2c_dev                14608  0
bridge                 59304  0
bnep                   21632  2
rfcomm                 44448  4
l2cap                  29312  16 bnep,rfcomm
bluetooth              59044  5 bnep,rfcomm,l2cap
nfs                   257240  1
lockd                  71376  2 nfs
nfs_acl                11392  1 nfs
fuse                   51008  1
sunrpc                185000  11 nfs,lockd,nfs_acl
dm_mirror              32004  0
dm_multipath           24976  0
dm_mod                 62104  2 dm_mirror,dm_multipath
ipv6                  276360  48
sr_mod                 23732  0
cdrom                  40616  1 sr_mod
ahci                   35976  0
i2c_i801               17692  0
snd_hda_intel         447540  1
firewire_ohci          29316  0
firewire_core          44224  1 firewire_ohci
snd_seq_dummy          11524  0
snd_seq_oss            39232  0
snd_seq_midi_event     15104  1 snd_seq_oss
snd_seq                61840  5 snd_seq_dummy,snd_seq_oss,snd_seq_midi_event
snd_seq_device         15508  3 snd_seq_dummy,snd_seq_oss,snd_seq
snd_pcm_oss            52096  0
snd_mixer_oss          23296  1 snd_pcm_oss
snd_pcm                86024  2 snd_hda_intel,snd_pcm_oss
wmi                    15040  0
button                 15776  0
pata_marvell           13696  0
snd_timer              29584  2 snd_seq,snd_pcm
snd_page_alloc         16912  2 snd_hda_intel,snd_pcm
snd_hwdep              16520  1 snd_hda_intel
i2c_core               28448  2 i2c_dev,i2c_i801
pcspkr                 11136  0
sky2                   52740  0
snd                    66808  12
snd_hda_intel,snd_seq_dummy,snd_seq_oss,snd_seq,snd_seq_device,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer,snd_hwdep
soundcore              14864  1 snd
crc_itu_t              10368  1 firewire_core
sg                     40528  0
ata_generic            14596  0
pata_acpi              13824  0
ata_piix               29188  4
libata                149024  5
ahci,pata_marvell,ata_generic,pata_acpi,ata_piix
sd_mod                 33200  5
scsi_mod              150232  4 sr_mod,sg,libata,sd_mod
ext3                  129680  3
jbd                    52904  1 ext3
mbcache                15876  1 ext3
uhci_hcd               29984  0
ohci_hcd               28804  0
ehci_hcd               40460  0


[root@iceland ~]# lspci -nn 00:00.0 Host bridge [0600]: Intel Corporation
QuickPath Architecture I/O Hub to ESI Port [8086:3405] (rev 12)
00:01.0 PCI bridge [0604]: Intel Corporation QuickPath Architecture I/O Hub
PCI Express Root Port 1 [8086:3408] (rev 12)
00:03.0 PCI bridge [0604]: Intel Corporation QuickPath Architecture I/O Hub
PCI Express Root Port 3 [8086:340a] (rev 12)
00:07.0 PCI bridge [0604]: Intel Corporation QuickPath Architecture I/O Hub
PCI Express Root Port 7 [8086:340e] (rev 12)
00:10.0 PIC [0800]: Intel Corporation QuickPath Interconnect Physical and
Link Layer Registers Port 0 [8086:3425] (rev 12)
00:10.1 PIC [0800]: Intel Corporation QuickPath Interconnect Routing and
Protocol Layer Registers Port 0 [8086:3426] (rev 12)
00:13.0 PIC [0800]: Intel Corporation QuickPath Architecture I/O Hub
I/OxAPIC Interrupt Controller [8086:342d] (rev 12)
00:14.0 PIC [0800]: Intel Corporation QuickPath Architecture I/O Hub System
Management Registers [8086:342e] (rev 12)
00:14.1 PIC [0800]: Intel Corporation QuickPath Architecture I/O Hub GPIO
and Scratch Pad Registers [8086:3422] (rev 12)
00:14.2 PIC [0800]: Intel Corporation QuickPath Architecture I/O Hub Control
Status and RAS Registers [8086:3423] (rev 12)
00:14.3 PIC [0800]: Intel Corporation QuickPath Architecture I/O Hub
Throttle Registers [8086:3438] (rev 12)
00:1a.0 USB Controller [0c03]: Intel Corporation ICH10 USB UHCI Controller
#4 [8086:3a37]
00:1a.1 USB Controller [0c03]: Intel Corporation ICH10 USB UHCI Controller
#5 [8086:3a38]
00:1a.2 USB Controller [0c03]: Intel Corporation ICH10 USB UHCI Controller
#6 [8086:3a39]
00:1a.7 USB Controller [0c03]: Intel Corporation ICH10 USB2 EHCI Controller
#2 [8086:3a3c]
00:1b.0 Audio device [0403]: Intel Corporation ICH10 HD Audio Controller
[8086:3a3e]
00:1c.0 PCI bridge [0604]: Intel Corporation ICH10 PCI Express Port 1
[8086:3a40]
00:1c.2 PCI bridge [0604]: Intel Corporation ICH10 PCI Express Port 3
[8086:3a44]
00:1c.4 PCI bridge [0604]: Intel Corporation ICH10 PCI Express Port 5
[8086:3a48]
00:1c.5 PCI bridge [0604]: Intel Corporation ICH10 PCI Express Port 6
[8086:3a4a]
00:1d.0 USB Controller [0c03]: Intel Corporation ICH10 USB UHCI Controller
#1 [8086:3a34]
00:1d.1 USB Controller [0c03]: Intel Corporation ICH10 USB UHCI Controller
#2 [8086:3a35]
00:1d.2 USB Controller [0c03]: Intel Corporation ICH10 USB UHCI Controller
#3 [8086:3a36]
00:1d.7 USB Controller [0c03]: Intel Corporation ICH10 USB2 EHCI Controller
#1 [8086:3a3a]
00:1e.0 PCI bridge [0604]: Intel Corporation 82801 PCI Bridge [8086:244e]
(rev 90)
00:1f.0 ISA bridge [0601]: Intel Corporation ICH10 LPC Interface Controller
[8086:3a16]
00:1f.2 IDE interface [0101]: Intel Corporation ICH10 4 port SATA IDE
Controller [8086:3a20]
00:1f.3 SMBus [0c05]: Intel Corporation ICH10 SMBus Controller [8086:3a30]
00:1f.5 IDE interface [0101]: Intel Corporation ICH10 2 port SATA IDE
Controller [8086:3a26]
02:00.0 VGA compatible controller [0300]: nVidia Corporation GeForce 8400 GS
[10de:0422] (rev a1)
04:00.0 Ethernet controller [0200]: Marvell Technology Group Ltd. 88E8056
PCI-E Gigabit Ethernet Controller [11ab:4364] (rev 12)
05:00.0 IDE interface [0101]: Marvell Technology Group Ltd. 88SE6121 SATA II
Controller [11ab:6121] (rev b2)
06:00.0 Ethernet controller [0200]: Marvell Technology Group Ltd. 88E8056
PCI-E Gigabit Ethernet Controller [11ab:4364] (rev 12)
08:02.0 FireWire (IEEE 1394) [0c00]: VIA Technologies, Inc. IEEE 1394 Host
Controller [1106:3044] (rev c0)

--0015174bde846f1b4c04660664b0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

PGRpdj5IeSBhbGwsPC9kaXY+CjxkaXY+wqA8L2Rpdj4KPGRpdj5JIHRyeSB0byB1c2UgTE0tc2Vu
c29ycyBhdCBteSBGZWRvcmEgQ29yZSA5IDY0Yml0IGluc3RhbGxlZCBvbiBhIEFzdXMgUDZUIG1v
dGhlcmJvYXJkLCBCdXQgaSB0aGlua8KgbG0tc2Vuc29ycyBkb250IHNlZSB0aGUgaW50ZWdyYXRl
ZCBzZW5zb3JzOjwvZGl2Pgo8ZGl2PsKgPC9kaXY+CjxkaXY+wqA8L2Rpdj4KPHVsPgo8bGk+TW90
aGVyYm9hcmQ6IEFzdXMgcDZ0IERlbHV4ZTwvbGk+PC91bD4KPGRpdj7CoDwvZGl2Pgo8dWw+Cjxs
aT5TZW5zb3JzLWRldGVjdCByZXZpc2lvbiA1MTA4ICgyMDA4LTAxLTIyIDEzOjIyOjQ3ICswMTAw
KTwvbGk+CjxsaT5MaW51eCAyLjYuMjUtMTQuZmM5Lng4Nl82NDwvbGk+PC91bD4KPGRpdj4KPGJs
b2NrcXVvdGUgZGlyPSJsdHIiIHN0eWxlPSJNQVJHSU4tUklHSFQ6IDBweCI+CjxibG9ja3F1b3Rl
IGNsYXNzPSJnbWFpbF9xdW90ZSIgc3R5bGU9IlBBRERJTkctTEVGVDogMWV4OyBNQVJHSU46IDBw
eCAwcHggMHB4IDAuOGV4OyBCT1JERVItTEVGVDogI2NjYyAxcHggc29saWQiPgo8ZGl2PsKgPC9k
aXY+CjxkaXY+W3Jvb3RAaWNlbGFuZCB+XSMgc2Vuc29ycy1kZXRlY3Q8L2Rpdj4KPGRpdj4jIHNl
bnNvcnMtZGV0ZWN0IHJldmlzaW9uIDUxMDggKDIwMDgtMDEtMjIgMTM6MjI6NDcgKzAxMDApPC9k
aXY+CjxkaXY+V2UgY2FuIHN0YXJ0IHdpdGggcHJvYmluZyBmb3IgKFBDSSkgSTJDIG9yIFNNQnVz
IGFkYXB0ZXJzLjwvZGl2Pgo8ZGl2PkRvIHlvdSB3YW50IHRvIHByb2JlIG5vdz8gKFlFUy9ubyk6
PC9kaXY+CjxkaXY+UHJvYmluZyBmb3IgUENJIGJ1cyBhZGFwdGVycy4uLjwvZGl2Pgo8ZGl2PkZv
dW5kIHVua25vd24gU01CdXMgYWRhcHRlciA4MDg2OjNhMzAgYXQgMDAwMDowMDoxZi4zLjwvZGl2
Pgo8ZGl2PlNvcnJ5LCBubyBrbm93biBQQ0kgYnVzIGFkYXB0ZXJzIGZvdW5kLjwvZGl2Pgo8ZGl2
PldlIHdpbGwgbm93IHRyeSB0byBsb2FkIGVhY2ggYWRhcHRlciBtb2R1bGUgaW4gdHVybi48L2Rp
dj4KPGRpdj5JZiB5b3UgaGF2ZSB1bmRldGVjdGFibGUgb3IgdW5zdXBwb3J0ZWQgYWRhcHRlcnMs
IHlvdSBjYW4gaGF2ZSB0aGVtPC9kaXY+CjxkaXY+c2Nhbm5lZCBieSBtYW51YWxseSBsb2FkaW5n
IHRoZSBtb2R1bGVzIGJlZm9yZSBydW5uaW5nIHRoaXMgc2NyaXB0LjwvZGl2Pgo8ZGl2PldlIGFy
ZSBub3cgZ29pbmcgdG8gZG8gdGhlIEkyQy9TTUJ1cyBhZGFwdGVyIHByb2JpbmdzLiBTb21lIGNo
aXBzIG1heTwvZGl2Pgo8ZGl2PmJlIGRvdWJsZSBkZXRlY3RlZDsgd2UgY2hvb3NlIHRoZSBvbmUg
d2l0aCB0aGUgaGlnaGVzdCBjb25maWRlbmNlPC9kaXY+CjxkaXY+dmFsdWUgaW4gdGhhdCBjYXNl
LjwvZGl2Pgo8ZGl2PklmIHlvdSBmb3VuZCB0aGF0IHRoZSBhZGFwdGVyIGh1bmcgYWZ0ZXIgcHJv
YmluZyBhIGNlcnRhaW4gYWRkcmVzcyw8L2Rpdj4KPGRpdj55b3UgY2FuIHNwZWNpZnkgdGhhdCBh
ZGRyZXNzIHRvIHJlbWFpbiB1bnByb2JlZC48L2Rpdj4KPGRpdj5OZXh0IGFkYXB0ZXI6IFNNQnVz
IEk4MDEgYWRhcHRlciBhdCAwNDAwIChpMmMtMCk8L2Rpdj4KPGRpdj5EbyB5b3Ugd2FudCB0byBz
Y2FuIGl0PyAoWUVTL25vL3NlbGVjdGl2ZWx5KTo8L2Rpdj4KPGRpdj5DbGllbnQgZm91bmQgYXQg
YWRkcmVzcyAweDQ0PC9kaXY+CjxkaXY+UHJvYmluZyBmb3IgYE1heGltIE1BWDY2MzMvTUFYNjYz
NC9NQVg2NjM1JiMzOTsuLi48L2Rpdj4KPGRpdj5ObzwvZGl2Pgo8ZGl2PkNsaWVudCBmb3VuZCBh
dCBhZGRyZXNzIDB4NGY8L2Rpdj4KPGRpdj5Qcm9iaW5nIGZvciBgTmF0aW9uYWwgU2VtaWNvbmR1
Y3RvciBMTTc1JiMzOTsuLi48L2Rpdj4KPGRpdj5ObzwvZGl2Pgo8ZGl2PlByb2JpbmcgZm9yIGBE
YWxsYXMgU2VtaWNvbmR1Y3RvciBEUzc1JiMzOTsuLi7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIE5vPC9kaXY+CjxkaXY+UHJvYmluZyBmb3IgYERhbGxhcyBTZW1pY29uZHVjdG9y
IERTMTYyMSYjMzk7Li4uwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE5vPC9kaXY+Cjxk
aXY+UHJvYmluZyBmb3IgYE1heGltIE1BWDY2MzMvTUFYNjYzNC9NQVg2NjM1JiMzOTsuLi48L2Rp
dj4KPGRpdj5ObzwvZGl2Pgo8ZGl2PkNsaWVudCBmb3VuZCBhdCBhZGRyZXNzIDB4NTA8L2Rpdj4K
PGRpdj5Qcm9iaW5nIGZvciBgQW5hbG9nIERldmljZXMgQURNMTAzMyYjMzk7Li4uwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBObzwvZGl2Pgo8ZGl2PlByb2JpbmcgZm9y
IGBBbmFsb2cgRGV2aWNlcyBBRE0xMDM0JiMzOTsuLi7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIE5vPC9kaXY+CjxkaXY+UHJvYmluZyBmb3IgYFNQRCBFRVBST00mIzM5
Oy4uLsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
wqDCoMKgwqDCoCBObzwvZGl2Pgo8ZGl2PlByb2JpbmcgZm9yIGBFRElEIEVFUFJPTSYjMzk7Li4u
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgTm88L2Rpdj4KPGRpdj5DbGllbnQgZm91bmQgYXQgYWRkcmVzcyAweDUxPC9kaXY+Cjxk
aXY+UHJvYmluZyBmb3IgYEFuYWxvZyBEZXZpY2VzIEFETTEwMzMmIzM5Oy4uLsKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgTm88L2Rpdj4KPGRpdj5Qcm9iaW5nIGZvciBg
QW5hbG9nIERldmljZXMgQURNMTAzNCYjMzk7Li4uwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoCBObzwvZGl2Pgo8ZGl2PlByb2JpbmcgZm9yIGBTUEQgRUVQUk9NJiMzOTsu
Li7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIE5vPC9kaXY+CjxkaXY+UHJvYmluZyBmb3IgYEVESUQgRUVQUk9NJiMzOTsuLi7C
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBObzwvZGl2Pgo8ZGl2PkNsaWVudCBmb3VuZCBhdCBhZGRyZXNzIDB4NTI8L2Rpdj4KPGRp
dj5Qcm9iaW5nIGZvciBgQW5hbG9nIERldmljZXMgQURNMTAzMyYjMzk7Li4uwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBObzwvZGl2Pgo8ZGl2PlByb2JpbmcgZm9yIGBB
bmFsb2cgRGV2aWNlcyBBRE0xMDM0JiMzOTsuLi7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgIE5vPC9kaXY+CjxkaXY+UHJvYmluZyBmb3IgYFNQRCBFRVBST00mIzM5Oy4u
LsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgTm88L2Rpdj4KPGRpdj5Qcm9iaW5nIGZvciBgRURJRCBFRVBST00mIzM5Oy4uLsKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIE5vPC9kaXY+CjxkaXY+Q2xpZW50IGZvdW5kIGF0IGFkZHJlc3MgMHg1MzwvZGl2Pgo8ZGl2
PlByb2JpbmcgZm9yIGBBbmFsb2cgRGV2aWNlcyBBRE0xMDMzJiMzOTsuLi7CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE5vPC9kaXY+CjxkaXY+UHJvYmluZyBmb3IgYEFu
YWxvZyBEZXZpY2VzIEFETTEwMzQmIzM5Oy4uLsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgTm88L2Rpdj4KPGRpdj5Qcm9iaW5nIGZvciBgU1BEIEVFUFJPTSYjMzk7Li4u
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgTm88L2Rpdj4KPGRpdj5Qcm9iaW5nIGZvciBgRURJRCBFRVBST00mIzM5Oy4uLsKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIE5vPC9kaXY+CjxkaXY+U29tZSBjaGlwcyBhcmUgYWxzbyBhY2Nlc3NpYmxlIHRocm91Z2gg
dGhlIElTQSBJL08gcG9ydHMuIFdlIGhhdmUgdG88L2Rpdj4KPGRpdj53cml0ZSB0byBhcmJpdHJh
cnkgSS9PIHBvcnRzIHRvIHByb2JlIHRoZW0uIFRoaXMgaXMgdXN1YWxseSBzYWZlIHRob3VnaC48
L2Rpdj4KPGRpdj5ZZXMsIHlvdSBkbyBoYXZlIElTQSBJL08gcG9ydHMgZXZlbiBpZiB5b3UgZG8g
bm90IGhhdmUgYW55IElTQSBzbG90cyE8L2Rpdj4KPGRpdj5EbyB5b3Ugd2FudCB0byBzY2FuIHRo
ZSBJU0EgSS9PIHBvcnRzPyAoWUVTL25vKTogUHJvYmluZyBmb3IgYE5hdGlvbmFsIFNlbWljb25k
dWN0b3IgTE03OCYjMzk7IGF0IDB4MjkwLi4uwqDCoMKgwqDCoMKgIE5vPC9kaXY+CjxkaXY+UHJv
YmluZyBmb3IgYE5hdGlvbmFsIFNlbWljb25kdWN0b3IgTE03OC1KJiMzOTsgYXQgMHgyOTAuLi7C
oMKgwqDCoCBObzwvZGl2Pgo8ZGl2PlByb2JpbmcgZm9yIGBOYXRpb25hbCBTZW1pY29uZHVjdG9y
IExNNzkmIzM5OyBhdCAweDI5MC4uLsKgwqDCoMKgwqDCoCBObzwvZGl2Pgo8ZGl2PlByb2Jpbmcg
Zm9yIGBXaW5ib25kIFc4Mzc4MUQmIzM5OyBhdCAweDI5MC4uLsKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCBObzwvZGl2Pgo8ZGl2PlByb2JpbmcgZm9yIGBXaW5ib25kIFc4Mzc4
MkQmIzM5OyBhdCAweDI5MC4uLsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBO
bzwvZGl2Pgo8ZGl2PlByb2JpbmcgZm9yIGBTaWxpY29uIEludGVncmF0ZWQgU3lzdGVtcyBTSVM1
NTk1JiMzOTsuLi7CoMKgwqDCoMKgwqDCoMKgIE5vPC9kaXY+CjxkaXY+UHJvYmluZyBmb3IgYFZJ
QSBWVDgyQzY4NiBJbnRlZ3JhdGVkIFNlbnNvcnMmIzM5Oy4uLsKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgTm88L2Rpdj4KPGRpdj5Qcm9iaW5nIGZvciBgVklBIFZUODIzMSBJbnRlZ3JhdGVkIFNlbnNv
cnMmIzM5Oy4uLsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE5vPC9kaXY+CjxkaXY+UHJvYmlu
ZyBmb3IgYElQTUkgQk1DIEtDUyYjMzk7IGF0IDB4Y2EwLi4uwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIE5vPC9kaXY+CjxkaXY+UHJvYmluZyBmb3IgYElQTUkgQk1D
IFNNSUMmIzM5OyBhdCAweGNhOC4uLsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgTm88L2Rpdj4KPGRpdj5Tb21lIFN1cGVyIEkvTyBjaGlwcyBtYXkgYWxzbyBjb250YWlu
IHNlbnNvcnMuIFdlIGhhdmUgdG8gd3JpdGUgdG88L2Rpdj4KPGRpdj5zdGFuZGFyZCBJL08gcG9y
dHMgdG8gcHJvYmUgdGhlbS4gVGhpcyBpcyB1c3VhbGx5IHNhZmUuPC9kaXY+CjxkaXY+RG8geW91
IHdhbnQgdG8gc2NhbiBmb3IgU3VwZXIgSS9PIHNlbnNvcnM/IChZRVMvbm8pOiBQcm9iaW5nIGZv
ciBTdXBlci1JL08gYXQgMHgyZS8weDJmPC9kaXY+CjxkaXY+VHJ5aW5nIGZhbWlseSBgTmF0aW9u
YWwgU2VtaWNvbmR1Y3RvciYjMzk7Li4uwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIE5vPC9kaXY+CjxkaXY+VHJ5aW5nIGZhbWlseSBgU01TQyYjMzk7Li4uwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIE5vPC9kaXY+CjxkaXY+VHJ5aW5nIGZhbWlseSBgVklBL1dpbmJvbmQvRmludGVrJiMzOTsu
Li7CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBZZXM8L2Rpdj4K
PGRpdj5Gb3VuZCB1bmtub3duIGNoaXAgd2l0aCBJRCAweGE1MTM8L2Rpdj4KPGRpdj7CoMKgwqAg
KGxvZ2ljYWwgZGV2aWNlIEIgaGFzIGFkZHJlc3MgMHgyOTAsIGNvdWxkIGJlIHNlbnNvcnMpPC9k
aXY+CjxkaXY+UHJvYmluZyBmb3IgU3VwZXItSS9PIGF0IDB4NGUvMHg0ZjwvZGl2Pgo8ZGl2PlRy
eWluZyBmYW1pbHkgYE5hdGlvbmFsIFNlbWljb25kdWN0b3ImIzM5Oy4uLsKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBObzwvZGl2Pgo8ZGl2PlRyeWluZyBmYW1pbHkgYFNNU0Mm
IzM5Oy4uLsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBObzwvZGl2Pgo8ZGl2PlRyeWluZyBmYW1pbHkgYFZJQS9X
aW5ib25kL0ZpbnRlayYjMzk7Li4uwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgTm88L2Rpdj4KPGRpdj5UcnlpbmcgZmFtaWx5IGBJVEUmIzM5Oy4uLsKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIE5vPC9kaXY+CjxkaXY+U29tZSBDUFVzIG9yIG1lbW9yeSBjb250cm9sbGVycyBt
YXkgYWxzbyBjb250YWluIGVtYmVkZGVkIHNlbnNvcnMuPC9kaXY+CjxkaXY+RG8geW91IHdhbnQg
dG8gc2NhbiBmb3IgdGhlbT8gKFlFUy9ubyk6IEFNRCBLOCB0aGVybWFsIHNlbnNvcnMuLi7CoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBObzwvZGl2Pgo8ZGl2PkFNRCBLMTAgdGhlcm1hbCBzZW5zb3JzLi4uwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IE5vPC9kaXY+CjxkaXY+SW50ZWwgQ29yZSBmYW1pbHkgdGhlcm1hbCBzZW5zb3IuLi7CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgTm88L2Rpdj4KPGRpdj5J
bnRlbCBBTUIgRkItRElNTSB0aGVybWFsIHNlbnNvci4uLsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBObzwvZGl2Pgo8ZGl2PjxzdHJvbmc+U29ycnksIG5v
IHNlbnNvcnMgd2VyZSBkZXRlY3RlZC48L3N0cm9uZz48L2Rpdj4KPGRpdj5FaXRoZXIgeW91ciBz
ZW5zb3JzIGFyZSBub3Qgc3VwcG9ydGVkLCBvciB0aGV5IGFyZSBjb25uZWN0ZWQgdG8gYW48L2Rp
dj4KPGRpdj5JMkMgb3IgU01CdXMgYWRhcHRlciB0aGF0IGlzIG5vdCBzdXBwb3J0ZWQuIFNlZSBk
b2MvRkFRLDwvZGl2Pgo8ZGl2PmRvYy9sbV9zZW5zb3JzLUZBUS5odG1sIG9yIDxhIGhyZWY9Imh0
dHA6Ly93d3cubG0tc2Vuc29ycy5vcmcvd2lraS9GQVEiPmh0dHA6Ly93d3cubG0tc2Vuc29ycy5v
cmcvd2lraS9GQVE8L2E+PC9kaXY+CjxkaXY+KEZBUSAjNC4yNC4zKSBmb3IgZnVydGhlciBpbmZv
cm1hdGlvbi48L2Rpdj4KPGRpdj5JZiB5b3UgZmluZCBvdXQgd2hhdCBjaGlwcyBhcmUgb24geW91
ciBib2FyZCwgY2hlY2s8L2Rpdj4KPGRpdj48YSBocmVmPSJodHRwOi8vd3d3LmxtLXNlbnNvcnMu
b3JnL3dpa2kvRGV2aWNlcyI+aHR0cDovL3d3dy5sbS1zZW5zb3JzLm9yZy93aWtpL0RldmljZXM8
L2E+IGZvciBkcml2ZXIgc3RhdHVzLjwvZGl2PjwvYmxvY2txdW90ZT48L2Jsb2NrcXVvdGU+Cjxk
aXY+wqA8L2Rpdj48L2Rpdj4KPGRpdj5bcm9vdEBpY2VsYW5kIH5dIyBsc21vZDwvZGl2Pgo8ZGl2
Pk1vZHVsZcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgU2l6ZcKgIFVzZWQgYnk8
L2Rpdj4KPGRpdj5pMmNfZGV2wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDE0NjA4wqAg
MDwvZGl2Pgo8ZGl2PmJyaWRnZcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDU5MzA0
wqAgMDwvZGl2Pgo8ZGl2PmJuZXDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
MjE2MzLCoCAyPC9kaXY+CjxkaXY+cmZjb21twqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgNDQ0NDjCoCA0PC9kaXY+CjxkaXY+bDJjYXDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIDI5MzEywqAgMTYgYm5lcCxyZmNvbW08L2Rpdj4KPGRpdj5ibHVldG9vdGjCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCA1OTA0NMKgIDUgYm5lcCxyZmNvbW0sbDJjYXA8L2Rpdj4KPGRp
dj5uZnPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMjU3MjQwwqAgMTwvZGl2
Pgo8ZGl2PmxvY2tkwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA3MTM3NsKgIDIg
bmZzPC9kaXY+CjxkaXY+bmZzX2FjbMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAxMTM5
MsKgIDEgbmZzPC9kaXY+CjxkaXY+ZnVzZcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoCA1MTAwOMKgIDE8L2Rpdj4KPGRpdj5zdW5ycGPCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgMTg1MDAwwqAgMTEgbmZzLGxvY2tkLG5mc19hY2w8L2Rpdj4KPGRpdj5kbV9taXJyb3LC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAzMjAwNMKgIDA8L2Rpdj4KPGRpdj5kbV9tdWx0aXBh
dGjCoMKgwqDCoMKgwqDCoMKgwqDCoCAyNDk3NsKgIDA8L2Rpdj4KPGRpdj5kbV9tb2TCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA2MjEwNMKgIDIgZG1fbWlycm9yLGRtX211bHRpcGF0
aDwvZGl2Pgo8ZGl2PmlwdjbCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDI3NjM2
MMKgIDQ4PC9kaXY+CjxkaXY+c3JfbW9kwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
MjM3MzLCoCAwPC9kaXY+CjxkaXY+Y2Ryb23CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIDQwNjE2wqAgMSBzcl9tb2Q8L2Rpdj4KPGRpdj5haGNpwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIDM1OTc2wqAgMDwvZGl2Pgo8ZGl2PmkyY19pODAxwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAxNzY5MsKgIDA8L2Rpdj4KPGRpdj5zbmRfaGRhX2ludGVswqDCoMKg
wqDCoMKgwqDCoCA0NDc1NDDCoCAxPC9kaXY+CjxkaXY+ZmlyZXdpcmVfb2hjacKgwqDCoMKgwqDC
oMKgwqDCoCAyOTMxNsKgIDA8L2Rpdj4KPGRpdj5maXJld2lyZV9jb3JlwqDCoMKgwqDCoMKgwqDC
oMKgIDQ0MjI0wqAgMSBmaXJld2lyZV9vaGNpPC9kaXY+CjxkaXY+c25kX3NlcV9kdW1tecKgwqDC
oMKgwqDCoMKgwqDCoCAxMTUyNMKgIDA8L2Rpdj4KPGRpdj5zbmRfc2VxX29zc8KgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgMzkyMzLCoCAwPC9kaXY+CjxkaXY+c25kX3NlcV9taWRpX2V2ZW50wqDCoMKg
wqAgMTUxMDTCoCAxIHNuZF9zZXFfb3NzPC9kaXY+CjxkaXY+c25kX3NlccKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCA2MTg0MMKgIDUgc25kX3NlcV9kdW1teSxzbmRfc2VxX29zcyxzbmRf
c2VxX21pZGlfZXZlbnQ8L2Rpdj4KPGRpdj5zbmRfc2VxX2RldmljZcKgwqDCoMKgwqDCoMKgwqAg
MTU1MDjCoCAzIHNuZF9zZXFfZHVtbXksc25kX3NlcV9vc3Msc25kX3NlcTwvZGl2Pgo8ZGl2PnNu
ZF9wY21fb3NzwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA1MjA5NsKgIDA8L2Rpdj4KPGRpdj5zbmRf
bWl4ZXJfb3NzwqDCoMKgwqDCoMKgwqDCoMKgIDIzMjk2wqAgMSBzbmRfcGNtX29zczwvZGl2Pgo8
ZGl2PnNuZF9wY23CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgODYwMjTCoCAyIHNuZF9o
ZGFfaW50ZWwsc25kX3BjbV9vc3M8L2Rpdj4KPGRpdj53bWnCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAxNTA0MMKgIDA8L2Rpdj4KPGRpdj5idXR0b27CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCAxNTc3NsKgIDA8L2Rpdj4KPGRpdj5wYXRhX21hcnZlbGzCoMKg
wqDCoMKgwqDCoMKgwqDCoCAxMzY5NsKgIDA8L2Rpdj4KPGRpdj5zbmRfdGltZXLCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAyOTU4NMKgIDIgc25kX3NlcSxzbmRfcGNtPC9kaXY+CjxkaXY+c25k
X3BhZ2VfYWxsb2PCoMKgwqDCoMKgwqDCoMKgIDE2OTEywqAgMiBzbmRfaGRhX2ludGVsLHNuZF9w
Y208L2Rpdj4KPGRpdj5zbmRfaHdkZXDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAxNjUyMMKg
IDEgc25kX2hkYV9pbnRlbDwvZGl2Pgo8ZGl2PmkyY19jb3JlwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCAyODQ0OMKgIDIgaTJjX2RldixpMmNfaTgwMTwvZGl2Pgo8ZGl2PnBjc3BrcsKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDExMTM2wqAgMDwvZGl2Pgo8ZGl2PnNreTLCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgNTI3NDDCoCAwPC9kaXY+CjxkaXY+c25k
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgNjY4MDjCoCAxMiBzbmRfaGRh
X2ludGVsLHNuZF9zZXFfZHVtbXksc25kX3NlcV9vc3Msc25kX3NlcSxzbmRfc2VxX2RldmljZSxz
bmRfcGNtX29zcyxzbmRfbWl4ZXJfb3NzLHNuZF9wY20sc25kX3RpbWVyLHNuZF9od2RlcDwvZGl2
Pgo8ZGl2PnNvdW5kY29yZcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDE0ODY0wqAgMSBzbmQ8
L2Rpdj4KPGRpdj5jcmNfaXR1X3TCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAxMDM2OMKgIDEg
ZmlyZXdpcmVfY29yZTwvZGl2Pgo8ZGl2PnNnwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCA0MDUyOMKgIDA8L2Rpdj4KPGRpdj5hdGFfZ2VuZXJpY8KgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgMTQ1OTbCoCAwPC9kaXY+CjxkaXY+cGF0YV9hY3BpwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgMTM4MjTCoCAwPC9kaXY+CjxkaXY+YXRhX3BpaXjCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIDI5MTg4wqAgNDwvZGl2Pgo8ZGl2PmxpYmF0YcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCAxNDkwMjTCoCA1IGFoY2kscGF0YV9tYXJ2ZWxsLGF0YV9nZW5lcmljLHBhdGFf
YWNwaSxhdGFfcGlpeDwvZGl2Pgo8ZGl2PnNkX21vZMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIDMzMjAwwqAgNTwvZGl2Pgo8ZGl2PnNjc2lfbW9kwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgMTUwMjMywqAgNCBzcl9tb2Qsc2csbGliYXRhLHNkX21vZDwvZGl2Pgo8ZGl2PmV4dDPC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDEyOTY4MMKgIDM8L2Rpdj4KPGRpdj5q
YmTCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA1MjkwNMKgIDEgZXh0Mzwv
ZGl2Pgo8ZGl2Pm1iY2FjaGXCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMTU4NzbCoCAx
IGV4dDM8L2Rpdj4KPGRpdj51aGNpX2hjZMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgMjk5
ODTCoCAwPC9kaXY+CjxkaXY+b2hjaV9oY2TCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIDI4
ODA0wqAgMDwvZGl2Pgo8ZGl2PmVoY2lfaGNkwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCA0
MDQ2MMKgIDA8L2Rpdj4KPGRpdj7CoDwvZGl2Pgo8ZGl2PsKgPC9kaXY+CjxkaXY+W3Jvb3RAaWNl
bGFuZCB+XSMgbHNwY2kgLW5uIAo8ZGl2PjAwOjAwLjAgSG9zdCBicmlkZ2UgWzA2MDBdOiBJbnRl
bCBDb3Jwb3JhdGlvbiBRdWlja1BhdGggQXJjaGl0ZWN0dXJlIEkvTyBIdWIgdG8gRVNJIFBvcnQg
WzgwODY6MzQwNV0gKHJldiAxMik8L2Rpdj4KPGRpdj4wMDowMS4wIFBDSSBicmlkZ2UgWzA2MDRd
OiBJbnRlbCBDb3Jwb3JhdGlvbiBRdWlja1BhdGggQXJjaGl0ZWN0dXJlIEkvTyBIdWIgUENJIEV4
cHJlc3MgUm9vdCBQb3J0IDEgWzgwODY6MzQwOF0gKHJldiAxMik8L2Rpdj4KPGRpdj4wMDowMy4w
IFBDSSBicmlkZ2UgWzA2MDRdOiBJbnRlbCBDb3Jwb3JhdGlvbiBRdWlja1BhdGggQXJjaGl0ZWN0
dXJlIEkvTyBIdWIgUENJIEV4cHJlc3MgUm9vdCBQb3J0IDMgWzgwODY6MzQwYV0gKHJldiAxMik8
L2Rpdj4KPGRpdj4wMDowNy4wIFBDSSBicmlkZ2UgWzA2MDRdOiBJbnRlbCBDb3Jwb3JhdGlvbiBR
dWlja1BhdGggQXJjaGl0ZWN0dXJlIEkvTyBIdWIgUENJIEV4cHJlc3MgUm9vdCBQb3J0IDcgWzgw
ODY6MzQwZV0gKHJldiAxMik8L2Rpdj4KPGRpdj4wMDoxMC4wIFBJQyBbMDgwMF06IEludGVsIENv
cnBvcmF0aW9uIFF1aWNrUGF0aCBJbnRlcmNvbm5lY3QgUGh5c2ljYWwgYW5kIExpbmsgTGF5ZXIg
UmVnaXN0ZXJzIFBvcnQgMCBbODA4NjozNDI1XSAocmV2IDEyKTwvZGl2Pgo8ZGl2PjAwOjEwLjEg
UElDIFswODAwXTogSW50ZWwgQ29ycG9yYXRpb24gUXVpY2tQYXRoIEludGVyY29ubmVjdCBSb3V0
aW5nIGFuZCBQcm90b2NvbCBMYXllciBSZWdpc3RlcnMgUG9ydCAwIFs4MDg2OjM0MjZdIChyZXYg
MTIpPC9kaXY+CjxkaXY+MDA6MTMuMCBQSUMgWzA4MDBdOiBJbnRlbCBDb3Jwb3JhdGlvbiBRdWlj
a1BhdGggQXJjaGl0ZWN0dXJlIEkvTyBIdWIgSS9PeEFQSUMgSW50ZXJydXB0IENvbnRyb2xsZXIg
WzgwODY6MzQyZF0gKHJldiAxMik8L2Rpdj4KPGRpdj4wMDoxNC4wIFBJQyBbMDgwMF06IEludGVs
IENvcnBvcmF0aW9uIFF1aWNrUGF0aCBBcmNoaXRlY3R1cmUgSS9PIEh1YiBTeXN0ZW0gTWFuYWdl
bWVudCBSZWdpc3RlcnMgWzgwODY6MzQyZV0gKHJldiAxMik8L2Rpdj4KPGRpdj4wMDoxNC4xIFBJ
QyBbMDgwMF06IEludGVsIENvcnBvcmF0aW9uIFF1aWNrUGF0aCBBcmNoaXRlY3R1cmUgSS9PIEh1
YiBHUElPIGFuZCBTY3JhdGNoIFBhZCBSZWdpc3RlcnMgWzgwODY6MzQyMl0gKHJldiAxMik8L2Rp
dj4KPGRpdj4wMDoxNC4yIFBJQyBbMDgwMF06IEludGVsIENvcnBvcmF0aW9uIFF1aWNrUGF0aCBB
cmNoaXRlY3R1cmUgSS9PIEh1YiBDb250cm9sIFN0YXR1cyBhbmQgUkFTIFJlZ2lzdGVycyBbODA4
NjozNDIzXSAocmV2IDEyKTwvZGl2Pgo8ZGl2PjAwOjE0LjMgUElDIFswODAwXTogSW50ZWwgQ29y
cG9yYXRpb24gUXVpY2tQYXRoIEFyY2hpdGVjdHVyZSBJL08gSHViIFRocm90dGxlIFJlZ2lzdGVy
cyBbODA4NjozNDM4XSAocmV2IDEyKTwvZGl2Pgo8ZGl2PjAwOjFhLjAgVVNCIENvbnRyb2xsZXIg
WzBjMDNdOiBJbnRlbCBDb3Jwb3JhdGlvbiBJQ0gxMCBVU0IgVUhDSSBDb250cm9sbGVyICM0IFs4
MDg2OjNhMzddPC9kaXY+CjxkaXY+MDA6MWEuMSBVU0IgQ29udHJvbGxlciBbMGMwM106IEludGVs
IENvcnBvcmF0aW9uIElDSDEwIFVTQiBVSENJIENvbnRyb2xsZXIgIzUgWzgwODY6M2EzOF08L2Rp
dj4KPGRpdj4wMDoxYS4yIFVTQiBDb250cm9sbGVyIFswYzAzXTogSW50ZWwgQ29ycG9yYXRpb24g
SUNIMTAgVVNCIFVIQ0kgQ29udHJvbGxlciAjNiBbODA4NjozYTM5XTwvZGl2Pgo8ZGl2PjAwOjFh
LjcgVVNCIENvbnRyb2xsZXIgWzBjMDNdOiBJbnRlbCBDb3Jwb3JhdGlvbiBJQ0gxMCBVU0IyIEVI
Q0kgQ29udHJvbGxlciAjMiBbODA4NjozYTNjXTwvZGl2Pgo8ZGl2PjAwOjFiLjAgQXVkaW8gZGV2
aWNlIFswNDAzXTogSW50ZWwgQ29ycG9yYXRpb24gSUNIMTAgSEQgQXVkaW8gQ29udHJvbGxlciBb
ODA4NjozYTNlXTwvZGl2Pgo8ZGl2PjAwOjFjLjAgUENJIGJyaWRnZSBbMDYwNF06IEludGVsIENv
cnBvcmF0aW9uIElDSDEwIFBDSSBFeHByZXNzIFBvcnQgMSBbODA4NjozYTQwXTwvZGl2Pgo8ZGl2
PjAwOjFjLjIgUENJIGJyaWRnZSBbMDYwNF06IEludGVsIENvcnBvcmF0aW9uIElDSDEwIFBDSSBF
eHByZXNzIFBvcnQgMyBbODA4NjozYTQ0XTwvZGl2Pgo8ZGl2PjAwOjFjLjQgUENJIGJyaWRnZSBb
MDYwNF06IEludGVsIENvcnBvcmF0aW9uIElDSDEwIFBDSSBFeHByZXNzIFBvcnQgNSBbODA4Njoz
YTQ4XTwvZGl2Pgo8ZGl2PjAwOjFjLjUgUENJIGJyaWRnZSBbMDYwNF06IEludGVsIENvcnBvcmF0
aW9uIElDSDEwIFBDSSBFeHByZXNzIFBvcnQgNiBbODA4NjozYTRhXTwvZGl2Pgo8ZGl2PjAwOjFk
LjAgVVNCIENvbnRyb2xsZXIgWzBjMDNdOiBJbnRlbCBDb3Jwb3JhdGlvbiBJQ0gxMCBVU0IgVUhD
SSBDb250cm9sbGVyICMxIFs4MDg2OjNhMzRdPC9kaXY+CjxkaXY+MDA6MWQuMSBVU0IgQ29udHJv
bGxlciBbMGMwM106IEludGVsIENvcnBvcmF0aW9uIElDSDEwIFVTQiBVSENJIENvbnRyb2xsZXIg
IzIgWzgwODY6M2EzNV08L2Rpdj4KPGRpdj4wMDoxZC4yIFVTQiBDb250cm9sbGVyIFswYzAzXTog
SW50ZWwgQ29ycG9yYXRpb24gSUNIMTAgVVNCIFVIQ0kgQ29udHJvbGxlciAjMyBbODA4NjozYTM2
XTwvZGl2Pgo8ZGl2PjAwOjFkLjcgVVNCIENvbnRyb2xsZXIgWzBjMDNdOiBJbnRlbCBDb3Jwb3Jh
dGlvbiBJQ0gxMCBVU0IyIEVIQ0kgQ29udHJvbGxlciAjMSBbODA4NjozYTNhXTwvZGl2Pgo8ZGl2
PjAwOjFlLjAgUENJIGJyaWRnZSBbMDYwNF06IEludGVsIENvcnBvcmF0aW9uIDgyODAxIFBDSSBC
cmlkZ2UgWzgwODY6MjQ0ZV0gKHJldiA5MCk8L2Rpdj4KPGRpdj4wMDoxZi4wIElTQSBicmlkZ2Ug
WzA2MDFdOiBJbnRlbCBDb3Jwb3JhdGlvbiBJQ0gxMCBMUEMgSW50ZXJmYWNlIENvbnRyb2xsZXIg
WzgwODY6M2ExNl08L2Rpdj4KPGRpdj4wMDoxZi4yIElERSBpbnRlcmZhY2UgWzAxMDFdOiBJbnRl
bCBDb3Jwb3JhdGlvbiBJQ0gxMCA0IHBvcnQgU0FUQSBJREUgQ29udHJvbGxlciBbODA4NjozYTIw
XTwvZGl2Pgo8ZGl2PjAwOjFmLjMgU01CdXMgWzBjMDVdOiBJbnRlbCBDb3Jwb3JhdGlvbiBJQ0gx
MCBTTUJ1cyBDb250cm9sbGVyIFs4MDg2OjNhMzBdPC9kaXY+CjxkaXY+MDA6MWYuNSBJREUgaW50
ZXJmYWNlIFswMTAxXTogSW50ZWwgQ29ycG9yYXRpb24gSUNIMTAgMiBwb3J0IFNBVEEgSURFIENv
bnRyb2xsZXIgWzgwODY6M2EyNl08L2Rpdj4KPGRpdj4wMjowMC4wIFZHQSBjb21wYXRpYmxlIGNv
bnRyb2xsZXIgWzAzMDBdOiBuVmlkaWEgQ29ycG9yYXRpb24gR2VGb3JjZSA4NDAwIEdTIFsxMGRl
OjA0MjJdIChyZXYgYTEpPC9kaXY+CjxkaXY+MDQ6MDAuMCBFdGhlcm5ldCBjb250cm9sbGVyIFsw
MjAwXTogTWFydmVsbCBUZWNobm9sb2d5IEdyb3VwIEx0ZC4gODhFODA1NiBQQ0ktRSBHaWdhYml0
IEV0aGVybmV0IENvbnRyb2xsZXIgWzExYWI6NDM2NF0gKHJldiAxMik8L2Rpdj4KPGRpdj4wNTow
MC4wIElERSBpbnRlcmZhY2UgWzAxMDFdOiBNYXJ2ZWxsIFRlY2hub2xvZ3kgR3JvdXAgTHRkLiA4
OFNFNjEyMSBTQVRBIElJIENvbnRyb2xsZXIgWzExYWI6NjEyMV0gKHJldiBiMik8L2Rpdj4KPGRp
dj4wNjowMC4wIEV0aGVybmV0IGNvbnRyb2xsZXIgWzAyMDBdOiBNYXJ2ZWxsIFRlY2hub2xvZ3kg
R3JvdXAgTHRkLiA4OEU4MDU2IFBDSS1FIEdpZ2FiaXQgRXRoZXJuZXQgQ29udHJvbGxlciBbMTFh
Yjo0MzY0XSAocmV2IDEyKTwvZGl2Pgo8ZGl2PjA4OjAyLjAgRmlyZVdpcmUgKElFRUUgMTM5NCkg
WzBjMDBdOiBWSUEgVGVjaG5vbG9naWVzLCBJbmMuIElFRUUgMTM5NCBIb3N0IENvbnRyb2xsZXIg
WzExMDY6MzA0NF0gKHJldiBjMCk8L2Rpdj48L2Rpdj4KPGRpdj7CoDwvZGl2Pgo=
--0015174bde846f1b4c04660664b0--


--===============0055718664914453727==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--===============0055718664914453727==--

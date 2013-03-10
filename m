From: vasya <volk.vasiliy@gmail.com>
Date: Sun, 10 Mar 2013 20:24:34 +0000
Subject: [lm-sensors] Asus Zenbook UX31A
Message-Id: <CACFVp02JRnmnQ0T6-sXd2-HNMqO2JifxwUDfso7qbxKRH2UZ8w@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="047d7b6247be6e695004d797d920"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

--047d7b6247be6e695004d797d920
Content-Type: multipart/alternative; boundary=047d7b6247be6e693f04d797d91e

--047d7b6247be6e693f04d797d91e
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hello.
I've read that there I can request for support...

I've asus zenbook ux31a and there is no fan control on it. Here is what you
need (as I understand) to basic overview:

Motherboard vendor and model:
Base Board Information
Manufacturer: ASUSTeK COMPUTER INC.
Product Name: UX31A
 Version: 1.0
Serial Number: BSN12345678901234567
Asset Tag: ATN12345678901234567
 Features:
Board is a hosting board
Board is replaceable
 Location In Chassis: MIDDLE
Chassis Handle: 0x0003
Type: Motherboard
 Contained Object Handles: 0

Lm_sensors and kernel versions:
lm_sensors: 3.3.3-r2 kernel: gentoo 3.8.2-hardened

The output of sensors:
asus-isa-0000
Adapter: ISA adapter
temp1:        +51.0=C2=B0C

coretemp-isa-0000
Adapter: ISA adapter
Physical id 0:  +53.0=C2=B0C  (high =3D +87.0=C2=B0C, crit =3D +105.0=C2=B0=
C)
Core 0:         +52.0=C2=B0C  (high =3D +87.0=C2=B0C, crit =3D +105.0=C2=B0=
C)
Core 1:         +49.0=C2=B0C  (high =3D +87.0=C2=B0C, crit =3D +105.0=C2=B0=
C)

The dmesg or syslog output if applicable (attachment)

The output of (as root) sensors-detect:
# sensors-detect revision 6085 (2012-10-30 18:18:45 +0100)
# System: ASUSTeK COMPUTER INC. UX31A [1.0] (laptop)

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

Some south bridges, CPUs or memory controllers contain embedded sensors.
Do you want to scan for them? This is totally safe. (YES/no): yes
Module cpuid loaded successfully.
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD Family 10h thermal sensors...                           No
AMD Family 11h thermal sensors...                           No
AMD Family 12h and 14h thermal sensors...                   No
AMD Family 15h thermal sensors...                           No
AMD Family 15h power sensors...                             No
Intel digital thermal sensor...                             Success!
    (driver `coretemp')
Intel AMB FB-DIMM thermal sensor...                         No
VIA C7 thermal sensor...                                    No
VIA Nano thermal sensor...                                  No

Some Super I/O chips contain embedded sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor/ITE'...               No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
Trying family `ITE'...                                      No
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor/ITE'...               No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
Trying family `ITE'...                                      No

Some hardware monitoring chips are accessible through the ISA I/O ports.
We have to write to arbitrary I/O ports to probe them. This is usually
safe though. Yes, you do have ISA I/O ports even if you do not have any
ISA slots! Do you want to scan the ISA I/O ports? (YES/no):
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No

Lastly, we can probe the I2C/SMBus adapters for connected hardware
monitoring devices. This is the most risky part, and while it works
reasonably well on most systems, it has been reported to cause trouble
on some systems.
Do you want to probe the I2C/SMBus adapters now? (YES/no):
Using driver `i2c-i801' for device 0000:00:1f.3: Intel Panther Point (PCH)
Module i2c-dev loaded successfully.

Next adapter: i915 gmbus ssc (i2c-0)
Do you want to scan it? (yes/NO/selectively):

Next adapter: i915 gmbus vga (i2c-1)
Do you want to scan it? (yes/NO/selectively):

Next adapter: i915 gmbus panel (i2c-2)
Do you want to scan it? (yes/NO/selectively):

Next adapter: i915 gmbus dpc (i2c-3)
Do you want to scan it? (yes/NO/selectively):

Next adapter: i915 gmbus dpb (i2c-4)
Do you want to scan it? (yes/NO/selectively):

Next adapter: i915 gmbus dpd (i2c-5)
Do you want to scan it? (yes/NO/selectively):

Next adapter: DPDDC-A (i2c-6)
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

Next adapter: DPDDC-C (i2c-7)
Do you want to scan it? (YES/no/selectively):

Now follows a summary of the probes I have just done.
Just press ENTER to continue:

Driver `coretemp':
  * Chip `Intel digital thermal sensor' (confidence: 9)


Do you want to overwrite /etc/conf.d/lm_sensors? Enter s to specify other
file name?
  (yes/NO/s):
If you have some drivers built into your kernel, the list above will
contain too many modules. Skip the appropriate ones! You really
should try these commands right now to make sure everything is
working properly. Monitoring programs won't work until the needed
modules are loaded.

Unloading i2c-dev... OK
Unloading cpuid... OK

The output of lsmod
Module                  Size  Used by
coretemp                5474  0
nls_utf8                1216  0
nls_cp866               5305  0
iwldvm                151524  0
mac80211              324242  1 iwldvm
iwlwifi                70391  1 iwldvm
cfg80211              165942  3 iwlwifi,mac80211,iwldvm
btrfs                 610059  0
ufs                    56550  0
hfsplus                70870  0
hfs                    39513  0
ntfs                  166976  0
vfat                    8367  0
msdos                   6182  0
fat                    44627  2 vfat,msdos
xfs                   469834  0
crc32c                  1648  1
libcrc32c                930  2 xfs,btrfs
i915                  465450  6
intel_agp              10244  1 i915
intel_gtt              11286  2 i915,intel_agp
drm_kms_helper         24463  1 i915
drm                   211739  7 i915,drm_kms_helper
i2c_algo_bit            4691  1 i915
snd_seq                57412  1
snd_seq_device          4564  1 snd_seq
ipv6                  256306  48
8021q                  15980  0
ipheth                  5993  0
arc4                    1895  2
uvcvideo               64308  0
videobuf2_vmalloc       2576  1 uvcvideo
videobuf2_memops        1551  1 videobuf2_vmalloc
videobuf2_core         22402  1 uvcvideo
videodev               97731  2 uvcvideo,videobuf2_core
rts5139               252882  0
snd_hda_codec_hdmi     24600  1
snd_hda_codec_realtek    53958  1
i2c_i801                8438  0
snd_hda_intel          24946  3
i2c_core               17188  6
drm,i915,i2c_i801,drm_kms_helper,i2c_algo_bit,videodev
snd_hda_codec          77602  3
snd_hda_codec_realtek,snd_hda_codec_hdmi,snd_hda_intel
snd_hwdep               6213  1 snd_hda_codec
snd_pcm                70870  3
snd_hda_codec_hdmi,snd_hda_codec,snd_hda_intel
snd_page_alloc          6682  2 snd_pcm,snd_hda_intel
snd_timer              19398  2 snd_pcm,snd_seq
lpc_ich                11145  0
snd                    59860  16
snd_hda_codec_realtek,snd_hwdep,snd_timer,snd_hda_codec_hdmi,snd_pcm,snd_se=
q,snd_hda_codec,snd_hda_intel,snd_seq_device
mfd_core                2865  1 lpc_ich
kvm_intel             114108  0
asus_nb_wmi             5120  0
asus_wmi               14173  1 asus_nb_wmi
kvm                   249301  1 kvm_intel
sparse_keymap           2768  1 asus_wmi
rfkill                 14543  2 cfg80211,asus_wmi
pci_hotplug             9168  1 asus_wmi
microcode               8668  0
joydev                 13247  0
thermal                 9329  0
wmi                     7295  1 asus_wmi
battery                11884  0
button                  4613  1 i915
ac                      3457  0
video                  12007  2 i915,asus_wmi
acpi_cpufreq            6534  0
mperf                   1051  1 acpi_cpufreq
processor              31719  1 acpi_cpufreq
dm_bio_prison           3535  0
dm_bufio               12188  0
aesni_intel            44273  1
ablk_helper             1604  1 aesni_intel
cryptd                  7448  2 aesni_intel,ablk_helper
lrw                     3325  1 aesni_intel
xts                     2959  1 aesni_intel
gf128mul                5410  2 lrw,xts
aes_x86_64              7515  1 aesni_intel
cbc                     2650  0
iscsi_tcp               7888  0
libiscsi_tcp           10934  1 iscsi_tcp
libiscsi               31040  2 libiscsi_tcp,iscsi_tcp
scsi_transport_iscsi    35659  2 iscsi_tcp,libiscsi
tg3                   128783  0
libphy                 17984  1 tg3
hwmon                   1177  3 tg3,coretemp,asus_wmi
ptp                     8892  1 tg3
pps_core                7256  1 ptp
e1000                  89798  0
fuse                   61642  2
exportfs                3210  1 xfs
nfs                   112521  0
fscache                34980  1 nfs
lockd                  55669  1 nfs
sunrpc                156068  2 nfs,lockd
jfs                   145990  0
reiserfs              213572  0
zlib_deflate           17995  1 btrfs
ext4                  281940  2
jbd2                   50808  1 ext4
crc16                   1247  1 ext4
ext3                  112125  0
jbd                    42078  1 ext3
ext2                   55992  0
mbcache                 4758  3 ext2,ext3,ext4
linear                  3455  0
raid0                   6787  0
dm_raid                12292  0
raid10                 36173  1 dm_raid
raid1                  24964  1 dm_raid
raid456                50212  1 dm_raid
md_mod                 92709  6 raid456,dm_raid,raid0,raid1,linear,raid10
async_pq                2974  1 raid456
async_xor               2121  2 async_pq,raid456
xor                     7916  1 async_xor
async_memcpy            1182  1 raid456
async_raid6_recov       1209  1 raid456
raid6_pq               90278  2 async_pq,async_raid6_recov
async_tx                1694  5
async_pq,raid456,async_xor,async_memcpy,async_raid6_recov
dm_snapshot            24699  0
dm_crypt               13864  0
dm_mirror              11456  0
dm_region_hash          6615  1 dm_mirror
dm_log                  7711  2 dm_region_hash,dm_mirror
dm_mod                 63184  12
dm_raid,dm_log,dm_mirror,dm_bufio,dm_crypt,dm_snapshot
xhci_hcd               74023  0
ohci_hcd               20238  0
uhci_hcd               19125  0
scsi_transport_fc      40723  0
aacraid                78072  0
sx8                    11189  0
cciss                  52641  0
atp870u                23209  0
dmx3191d                9121  0
sym53c8xx              63315  0
gdth                   78348  0
initio                 15300  0
BusLogic               19540  0
aic7xxx               101482  0
aic79xx               123570  0
scsi_transport_spi     18588  4 sym53c8xx,aic79xx,aic7xxx,dmx3191d
sg                     25076  0
ata_piix               22155  0
pata_pcmcia             9733  0
pcmcia                 30451  1 pata_pcmcia
pcmcia_core            10893  1 pcmcia
pata_oldpiix            2984  0
pata_mpiix              2810  0

Sorry I have no part numbers of chips. I'm looking for in internet but have
no luck at this time.

Thank you!

--047d7b6247be6e693f04d797d91e
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+SGVsbG8uPGRpdiBzdHlsZT5JJiMzOTt2ZSByZWFkIHRoYXQgdGhlcmUg
SSBjYW4gcmVxdWVzdCBmb3Igc3VwcG9ydC4uLjwvZGl2PjxkaXYgc3R5bGU+PGJyPjwvZGl2Pjxk
aXYgc3R5bGU+SSYjMzk7dmUgYXN1cyB6ZW5ib29rIHV4MzFhIGFuZCB0aGVyZSBpcyBubyBmYW4g
Y29udHJvbCBvbiBpdC4gSGVyZSBpcyB3aGF0IHlvdSBuZWVkIChhcyBJIHVuZGVyc3RhbmQpIHRv
IGJhc2ljIG92ZXJ2aWV3OjwvZGl2Pg0KDQo8ZGl2IHN0eWxlPjxicj48L2Rpdj48ZGl2IHN0eWxl
Pk1vdGhlcmJvYXJkIHZlbmRvciBhbmQgbW9kZWw6wqA8L2Rpdj48ZGl2IHN0eWxlPkJhc2UgQm9h
cmQgSW5mb3JtYXRpb248YnI+PC9kaXY+PGRpdj48c3BhbiBjbGFzcz0iIiBzdHlsZT0id2hpdGUt
c3BhY2U6cHJlIj4JPC9zcGFuPk1hbnVmYWN0dXJlcjogQVNVU1RlSyBDT01QVVRFUiBJTkMuPC9k
aXY+PGRpdj48c3BhbiBjbGFzcz0iIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPlBy
b2R1Y3QgTmFtZTogVVgzMUE8L2Rpdj4NCg0KPGRpdj48c3BhbiBjbGFzcz0iIiBzdHlsZT0id2hp
dGUtc3BhY2U6cHJlIj4JPC9zcGFuPlZlcnNpb246IDEuMCDCoCDCoCDCoMKgPC9kaXY+PGRpdj48
c3BhbiBjbGFzcz0iIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPlNlcmlhbCBOdW1i
ZXI6IEJTTjEyMzQ1Njc4OTAxMjM0NTY3PC9kaXY+PGRpdj48c3BhbiBjbGFzcz0iIiBzdHlsZT0i
d2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPkFzc2V0IFRhZzogQVROMTIzNDU2Nzg5MDEyMzQ1Njc8
L2Rpdj4NCg0KPGRpdj48c3BhbiBjbGFzcz0iIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9z
cGFuPkZlYXR1cmVzOjwvZGl2PjxkaXY+PHNwYW4gY2xhc3M9IiIgc3R5bGU9IndoaXRlLXNwYWNl
OnByZSI+CQk8L3NwYW4+Qm9hcmQgaXMgYSBob3N0aW5nIGJvYXJkPC9kaXY+PGRpdj48c3BhbiBj
bGFzcz0iIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JCTwvc3Bhbj5Cb2FyZCBpcyByZXBsYWNl
YWJsZTwvZGl2Pg0KDQo8ZGl2PjxzcGFuIGNsYXNzPSIiIHN0eWxlPSJ3aGl0ZS1zcGFjZTpwcmUi
Pgk8L3NwYW4+TG9jYXRpb24gSW4gQ2hhc3NpczogTUlERExFIMKgIMKgIMKgIMKgIMKgIMKgIMKg
PC9kaXY+PGRpdj48c3BhbiBjbGFzcz0iIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFu
PkNoYXNzaXMgSGFuZGxlOiAweDAwMDM8L2Rpdj48ZGl2PjxzcGFuIGNsYXNzPSIiIHN0eWxlPSJ3
aGl0ZS1zcGFjZTpwcmUiPgk8L3NwYW4+VHlwZTogTW90aGVyYm9hcmQ8L2Rpdj4NCg0KPGRpdj48
c3BhbiBjbGFzcz0iIiBzdHlsZT0id2hpdGUtc3BhY2U6cHJlIj4JPC9zcGFuPkNvbnRhaW5lZCBP
YmplY3QgSGFuZGxlczogMDwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+TG1fc2Vuc29ycyBhbmQg
a2VybmVsIHZlcnNpb25zOjxicj48L2Rpdj48ZGl2IHN0eWxlPmxtX3NlbnNvcnM6wqAzLjMuMy1y
MiBrZXJuZWw6IGdlbnRvbyAzLjguMi1oYXJkZW5lZDwvZGl2PjxkaXYgc3R5bGU+DQoNCjxicj48
L2Rpdj48ZGl2IHN0eWxlPlRoZSBvdXRwdXQgb2Ygc2Vuc29yczo8YnI+PC9kaXY+PGRpdiBzdHls
ZT48ZGl2PmFzdXMtaXNhLTAwMDA8L2Rpdj48ZGl2PkFkYXB0ZXI6IElTQSBhZGFwdGVyPC9kaXY+
PGRpdj50ZW1wMTogwqAgwqAgwqAgwqArNTEuMMKwQyDCoDwvZGl2PjxkaXY+PGJyPjwvZGl2Pjxk
aXY+Y29yZXRlbXAtaXNhLTAwMDA8L2Rpdj48ZGl2PkFkYXB0ZXI6IElTQSBhZGFwdGVyPC9kaXY+
DQoNCjxkaXY+UGh5c2ljYWwgaWQgMDogwqArNTMuMMKwQyDCoChoaWdoID0gKzg3LjDCsEMsIGNy
aXQgPSArMTA1LjDCsEMpPC9kaXY+PGRpdj5Db3JlIDA6IMKgIMKgIMKgIMKgICs1Mi4wwrBDIMKg
KGhpZ2ggPSArODcuMMKwQywgY3JpdCA9ICsxMDUuMMKwQyk8L2Rpdj48ZGl2PkNvcmUgMTogwqAg
wqAgwqAgwqAgKzQ5LjDCsEMgwqAoaGlnaCA9ICs4Ny4wwrBDLCBjcml0ID0gKzEwNS4wwrBDKTwv
ZGl2PjxkaXY+PGJyPjwvZGl2Pg0KDQo8ZGl2PlRoZSBkbWVzZyBvciBzeXNsb2cgb3V0cHV0IGlm
IGFwcGxpY2FibGUgKGF0dGFjaG1lbnQpPGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+VGhl
IG91dHB1dCBvZiAoYXMgcm9vdCkgc2Vuc29ycy1kZXRlY3Q6PGJyPjwvZGl2PjxkaXY+PGRpdj4j
IHNlbnNvcnMtZGV0ZWN0IHJldmlzaW9uIDYwODUgKDIwMTItMTAtMzAgMTg6MTg6NDUgKzAxMDAp
PC9kaXY+PGRpdj4jIFN5c3RlbTogQVNVU1RlSyBDT01QVVRFUiBJTkMuIFVYMzFBIFsxLjBdIChs
YXB0b3ApPC9kaXY+DQoNCjxkaXY+PGJyPjwvZGl2PjxkaXY+VGhpcyBwcm9ncmFtIHdpbGwgaGVs
cCB5b3UgZGV0ZXJtaW5lIHdoaWNoIGtlcm5lbCBtb2R1bGVzIHlvdSBuZWVkPC9kaXY+PGRpdj50
byBsb2FkIHRvIHVzZSBsbV9zZW5zb3JzIG1vc3QgZWZmZWN0aXZlbHkuIEl0IGlzIGdlbmVyYWxs
eSBzYWZlPC9kaXY+PGRpdj5hbmQgcmVjb21tZW5kZWQgdG8gYWNjZXB0IHRoZSBkZWZhdWx0IGFu
c3dlcnMgdG8gYWxsIHF1ZXN0aW9ucyw8L2Rpdj4NCg0KPGRpdj51bmxlc3MgeW91IGtub3cgd2hh
dCB5b3UmIzM5O3JlIGRvaW5nLjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+U29tZSBzb3V0aCBi
cmlkZ2VzLCBDUFVzIG9yIG1lbW9yeSBjb250cm9sbGVycyBjb250YWluIGVtYmVkZGVkIHNlbnNv
cnMuPC9kaXY+PGRpdj5EbyB5b3Ugd2FudCB0byBzY2FuIGZvciB0aGVtPyBUaGlzIGlzIHRvdGFs
bHkgc2FmZS4gKFlFUy9ubyk6IHllczwvZGl2Pg0KDQo8ZGl2Pk1vZHVsZSBjcHVpZCBsb2FkZWQg
c3VjY2Vzc2Z1bGx5LjwvZGl2PjxkaXY+U2lsaWNvbiBJbnRlZ3JhdGVkIFN5c3RlbXMgU0lTNTU5
NS4uLiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBObzwvZGl2PjxkaXY+VklBIFZU
ODJDNjg2IEludGVncmF0ZWQgU2Vuc29ycy4uLiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoE5vPC9kaXY+PGRpdj5WSUEgVlQ4MjMxIEludGVncmF0ZWQgU2Vuc29ycy4uLiDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoE5vPC9kaXY+DQoNCjxkaXY+
QU1EIEs4IHRoZXJtYWwgc2Vuc29ycy4uLiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCBObzwvZGl2PjxkaXY+QU1EIEZhbWlseSAxMGggdGhlcm1hbCBz
ZW5zb3JzLi4uIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE5vPC9kaXY+
PGRpdj5BTUQgRmFtaWx5IDExaCB0aGVybWFsIHNlbnNvcnMuLi4gwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgTm88L2Rpdj48ZGl2Pg0KDQpBTUQgRmFtaWx5IDEyaCBhbmQg
MTRoIHRoZXJtYWwgc2Vuc29ycy4uLiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBObzwvZGl2
PjxkaXY+QU1EIEZhbWlseSAxNWggdGhlcm1hbCBzZW5zb3JzLi4uIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIE5vPC9kaXY+PGRpdj5BTUQgRmFtaWx5IDE1aCBwb3dlciBz
ZW5zb3JzLi4uIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE5vPC9k
aXY+PGRpdj5JbnRlbCBkaWdpdGFsIHRoZXJtYWwgc2Vuc29yLi4uIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIFN1Y2Nlc3MhPC9kaXY+DQoNCjxkaXY+wqAgwqAgKGRy
aXZlciBgY29yZXRlbXAmIzM5Oyk8L2Rpdj48ZGl2PkludGVsIEFNQiBGQi1ESU1NIHRoZXJtYWwg
c2Vuc29yLi4uIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE5vPC9kaXY+PGRp
dj5WSUEgQzcgdGhlcm1hbCBzZW5zb3IuLi4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBObzwvZGl2PjxkaXY+VklBIE5hbm8gdGhlcm1hbCBzZW5z
b3IuLi4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBO
bzwvZGl2Pg0KDQo8ZGl2Pjxicj48L2Rpdj48ZGl2PlNvbWUgU3VwZXIgSS9PIGNoaXBzIGNvbnRh
aW4gZW1iZWRkZWQgc2Vuc29ycy4gV2UgaGF2ZSB0byB3cml0ZSB0bzwvZGl2PjxkaXY+c3RhbmRh
cmQgSS9PIHBvcnRzIHRvIHByb2JlIHRoZW0uIFRoaXMgaXMgdXN1YWxseSBzYWZlLjwvZGl2Pjxk
aXY+RG8geW91IHdhbnQgdG8gc2NhbiBmb3IgU3VwZXIgSS9PIHNlbnNvcnM/IChZRVMvbm8pOsKg
PC9kaXY+DQoNCjxkaXY+UHJvYmluZyBmb3IgU3VwZXItSS9PIGF0IDB4MmUvMHgyZjwvZGl2Pjxk
aXY+VHJ5aW5nIGZhbWlseSBgTmF0aW9uYWwgU2VtaWNvbmR1Y3Rvci9JVEUmIzM5Oy4uLiDCoCDC
oCDCoCDCoCDCoCDCoCDCoCBObzwvZGl2PjxkaXY+VHJ5aW5nIGZhbWlseSBgU01TQyYjMzk7Li4u
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE5v
PC9kaXY+PGRpdj5UcnlpbmcgZmFtaWx5IGBWSUEvV2luYm9uZC9OdXZvdG9uL0ZpbnRlayYjMzk7
Li4uIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE5vPC9kaXY+DQoNCjxkaXY+VHJ5aW5nIGZhbWlseSBg
SVRFJiMzOTsuLi4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBObzwvZGl2PjxkaXY+UHJvYmluZyBmb3IgU3VwZXItSS9PIGF0IDB4NGUvMHg0
ZjwvZGl2PjxkaXY+VHJ5aW5nIGZhbWlseSBgTmF0aW9uYWwgU2VtaWNvbmR1Y3Rvci9JVEUmIzM5
Oy4uLiDCoCDCoCDCoCDCoCDCoCDCoCDCoCBObzwvZGl2PjxkaXY+VHJ5aW5nIGZhbWlseSBgU01T
QyYjMzk7Li4uIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIE5vPC9kaXY+DQoNCjxkaXY+VHJ5aW5nIGZhbWlseSBgVklBL1dpbmJvbmQvTnV2b3Rv
bi9GaW50ZWsmIzM5Oy4uLiDCoCDCoCDCoCDCoCDCoCDCoCDCoCBObzwvZGl2PjxkaXY+VHJ5aW5n
IGZhbWlseSBgSVRFJiMzOTsuLi4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBObzwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+U29tZSBoYXJk
d2FyZSBtb25pdG9yaW5nIGNoaXBzIGFyZSBhY2Nlc3NpYmxlIHRocm91Z2ggdGhlIElTQSBJL08g
cG9ydHMuPC9kaXY+DQoNCjxkaXY+V2UgaGF2ZSB0byB3cml0ZSB0byBhcmJpdHJhcnkgSS9PIHBv
cnRzIHRvIHByb2JlIHRoZW0uIFRoaXMgaXMgdXN1YWxseTwvZGl2PjxkaXY+c2FmZSB0aG91Z2gu
IFllcywgeW91IGRvIGhhdmUgSVNBIEkvTyBwb3J0cyBldmVuIGlmIHlvdSBkbyBub3QgaGF2ZSBh
bnk8L2Rpdj48ZGl2PklTQSBzbG90cyEgRG8geW91IHdhbnQgdG8gc2NhbiB0aGUgSVNBIEkvTyBw
b3J0cz8gKFlFUy9ubyk6wqA8L2Rpdj4NCg0KPGRpdj5Qcm9iaW5nIGZvciBgTmF0aW9uYWwgU2Vt
aWNvbmR1Y3RvciBMTTc4JiMzOTsgYXQgMHgyOTAuLi4gwqAgwqAgwqAgTm88L2Rpdj48ZGl2PlBy
b2JpbmcgZm9yIGBOYXRpb25hbCBTZW1pY29uZHVjdG9yIExNNzkmIzM5OyBhdCAweDI5MC4uLiDC
oCDCoCDCoCBObzwvZGl2PjxkaXY+UHJvYmluZyBmb3IgYFdpbmJvbmQgVzgzNzgxRCYjMzk7IGF0
IDB4MjkwLi4uIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE5vPC9kaXY+DQoNCjxkaXY+UHJv
YmluZyBmb3IgYFdpbmJvbmQgVzgzNzgyRCYjMzk7IGF0IDB4MjkwLi4uIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIE5vPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5MYXN0bHksIHdlIGNhbiBw
cm9iZSB0aGUgSTJDL1NNQnVzIGFkYXB0ZXJzIGZvciBjb25uZWN0ZWQgaGFyZHdhcmU8L2Rpdj48
ZGl2Pm1vbml0b3JpbmcgZGV2aWNlcy4gVGhpcyBpcyB0aGUgbW9zdCByaXNreSBwYXJ0LCBhbmQg
d2hpbGUgaXQgd29ya3M8L2Rpdj4NCg0KPGRpdj5yZWFzb25hYmx5IHdlbGwgb24gbW9zdCBzeXN0
ZW1zLCBpdCBoYXMgYmVlbiByZXBvcnRlZCB0byBjYXVzZSB0cm91YmxlPC9kaXY+PGRpdj5vbiBz
b21lIHN5c3RlbXMuPC9kaXY+PGRpdj5EbyB5b3Ugd2FudCB0byBwcm9iZSB0aGUgSTJDL1NNQnVz
IGFkYXB0ZXJzIG5vdz8gKFlFUy9ubyk6wqA8L2Rpdj48ZGl2PlVzaW5nIGRyaXZlciBgaTJjLWk4
MDEmIzM5OyBmb3IgZGV2aWNlIDAwMDA6MDA6MWYuMzogSW50ZWwgUGFudGhlciBQb2ludCAoUENI
KTwvZGl2Pg0KDQo8ZGl2Pk1vZHVsZSBpMmMtZGV2IGxvYWRlZCBzdWNjZXNzZnVsbHkuPC9kaXY+
PGRpdj48YnI+PC9kaXY+PGRpdj5OZXh0IGFkYXB0ZXI6IGk5MTUgZ21idXMgc3NjIChpMmMtMCk8
L2Rpdj48ZGl2PkRvIHlvdSB3YW50IHRvIHNjYW4gaXQ/ICh5ZXMvTk8vc2VsZWN0aXZlbHkpOsKg
PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5OZXh0IGFkYXB0ZXI6IGk5MTUgZ21idXMgdmdhIChp
MmMtMSk8L2Rpdj4NCg0KPGRpdj5EbyB5b3Ugd2FudCB0byBzY2FuIGl0PyAoeWVzL05PL3NlbGVj
dGl2ZWx5KTrCoDwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+TmV4dCBhZGFwdGVyOiBpOTE1IGdt
YnVzIHBhbmVsIChpMmMtMik8L2Rpdj48ZGl2PkRvIHlvdSB3YW50IHRvIHNjYW4gaXQ/ICh5ZXMv
Tk8vc2VsZWN0aXZlbHkpOsKgPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5OZXh0IGFkYXB0ZXI6
IGk5MTUgZ21idXMgZHBjIChpMmMtMyk8L2Rpdj4NCg0KPGRpdj5EbyB5b3Ugd2FudCB0byBzY2Fu
IGl0PyAoeWVzL05PL3NlbGVjdGl2ZWx5KTrCoDwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+TmV4
dCBhZGFwdGVyOiBpOTE1IGdtYnVzIGRwYiAoaTJjLTQpPC9kaXY+PGRpdj5EbyB5b3Ugd2FudCB0
byBzY2FuIGl0PyAoeWVzL05PL3NlbGVjdGl2ZWx5KTrCoDwvZGl2PjxkaXY+PGJyPjwvZGl2Pjxk
aXY+TmV4dCBhZGFwdGVyOiBpOTE1IGdtYnVzIGRwZCAoaTJjLTUpPC9kaXY+DQoNCjxkaXY+RG8g
eW91IHdhbnQgdG8gc2NhbiBpdD8gKHllcy9OTy9zZWxlY3RpdmVseSk6wqA8L2Rpdj48ZGl2Pjxi
cj48L2Rpdj48ZGl2Pk5leHQgYWRhcHRlcjogRFBEREMtQSAoaTJjLTYpPC9kaXY+PGRpdj5EbyB5
b3Ugd2FudCB0byBzY2FuIGl0PyAoWUVTL25vL3NlbGVjdGl2ZWx5KTrCoDwvZGl2PjxkaXY+Q2xp
ZW50IGZvdW5kIGF0IGFkZHJlc3MgMHg1MDwvZGl2PjxkaXY+UHJvYmluZyBmb3IgYEFuYWxvZyBE
ZXZpY2VzIEFETTEwMzMmIzM5Oy4uLiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBObzwv
ZGl2Pg0KDQo8ZGl2PlByb2JpbmcgZm9yIGBBbmFsb2cgRGV2aWNlcyBBRE0xMDM0JiMzOTsuLi4g
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTm88L2Rpdj48ZGl2PlByb2JpbmcgZm9yIGBT
UEQgRUVQUk9NJiMzOTsuLi4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgTm88L2Rpdj48ZGl2PlByb2JpbmcgZm9yIGBFRElEIEVFUFJPTSYjMzk7Li4uIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgWWVzPC9kaXY+DQoN
CjxkaXY+wqAgwqAgKGNvbmZpZGVuY2UgOCwgbm90IGEgaGFyZHdhcmUgbW9uaXRvcmluZyBjaGlw
KTwvZGl2PjxkaXY+Q2xpZW50IGZvdW5kIGF0IGFkZHJlc3MgMHg1MTwvZGl2PjxkaXY+UHJvYmlu
ZyBmb3IgYEFuYWxvZyBEZXZpY2VzIEFETTEwMzMmIzM5Oy4uLiDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCBObzwvZGl2PjxkaXY+UHJvYmluZyBmb3IgYEFuYWxvZyBEZXZpY2VzIEFETTEw
MzQmIzM5Oy4uLiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBObzwvZGl2Pg0KDQo8ZGl2
PlByb2JpbmcgZm9yIGBTUEQgRUVQUk9NJiMzOTsuLi4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgTm88L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2Pk5leHQg
YWRhcHRlcjogRFBEREMtQyAoaTJjLTcpPC9kaXY+PGRpdj5EbyB5b3Ugd2FudCB0byBzY2FuIGl0
PyAoWUVTL25vL3NlbGVjdGl2ZWx5KTrCoDwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+Tm93IGZv
bGxvd3MgYSBzdW1tYXJ5IG9mIHRoZSBwcm9iZXMgSSBoYXZlIGp1c3QgZG9uZS48L2Rpdj4NCg0K
PGRpdj5KdXN0IHByZXNzIEVOVEVSIHRvIGNvbnRpbnVlOsKgPC9kaXY+PGRpdj48YnI+PC9kaXY+
PGRpdj5Ecml2ZXIgYGNvcmV0ZW1wJiMzOTs6PC9kaXY+PGRpdj7CoCAqIENoaXAgYEludGVsIGRp
Z2l0YWwgdGhlcm1hbCBzZW5zb3ImIzM5OyAoY29uZmlkZW5jZTogOSk8L2Rpdj48ZGl2Pjxicj48
L2Rpdj48ZGl2Pjxicj48L2Rpdj48ZGl2PkRvIHlvdSB3YW50IHRvIG92ZXJ3cml0ZSAvZXRjL2Nv
bmYuZC9sbV9zZW5zb3JzPyBFbnRlciBzIHRvIHNwZWNpZnkgb3RoZXIgZmlsZSBuYW1lPzwvZGl2
Pg0KDQo8ZGl2PsKgICh5ZXMvTk8vcyk6wqA8L2Rpdj48ZGl2PklmIHlvdSBoYXZlIHNvbWUgZHJp
dmVycyBidWlsdCBpbnRvIHlvdXIga2VybmVsLCB0aGUgbGlzdCBhYm92ZSB3aWxsPC9kaXY+PGRp
dj5jb250YWluIHRvbyBtYW55IG1vZHVsZXMuIFNraXAgdGhlIGFwcHJvcHJpYXRlIG9uZXMhIFlv
dSByZWFsbHk8L2Rpdj48ZGl2PnNob3VsZCB0cnkgdGhlc2UgY29tbWFuZHMgcmlnaHQgbm93IHRv
IG1ha2Ugc3VyZSBldmVyeXRoaW5nIGlzPC9kaXY+DQoNCjxkaXY+d29ya2luZyBwcm9wZXJseS4g
TW9uaXRvcmluZyBwcm9ncmFtcyB3b24mIzM5O3Qgd29yayB1bnRpbCB0aGUgbmVlZGVkPC9kaXY+
PGRpdj5tb2R1bGVzIGFyZSBsb2FkZWQuPC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5VbmxvYWRp
bmcgaTJjLWRldi4uLiBPSzwvZGl2PjxkaXY+VW5sb2FkaW5nIGNwdWlkLi4uIE9LPC9kaXY+PGRp
dj48YnI+PC9kaXY+PC9kaXY+PGRpdj48ZGl2Pg0KDQpUaGUgb3V0cHV0IG9mIGxzbW9kPC9kaXY+
PC9kaXY+PGRpdj48ZGl2Pk1vZHVsZSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoFNpemUgwqBV
c2VkIGJ5PC9kaXY+PGRpdj5jb3JldGVtcCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDU0NzQgwqAw
wqA8L2Rpdj48ZGl2Pm5sc191dGY4IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgMTIxNiDCoDDCoDwv
ZGl2PjxkaXY+bmxzX2NwODY2IMKgIMKgIMKgIMKgIMKgIMKgIMKgIDUzMDUgwqAwwqA8L2Rpdj48
ZGl2Pml3bGR2bSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDE1MTUyNCDCoDDCoDwvZGl2Pg0KDQo8
ZGl2Pm1hYzgwMjExIMKgIMKgIMKgIMKgIMKgIMKgIMKgMzI0MjQyIMKgMSBpd2xkdm08L2Rpdj48
ZGl2Pml3bHdpZmkgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA3MDM5MSDCoDEgaXdsZHZtPC9kaXY+
PGRpdj5jZmc4MDIxMSDCoCDCoCDCoCDCoCDCoCDCoCDCoDE2NTk0MiDCoDMgaXdsd2lmaSxtYWM4
MDIxMSxpd2xkdm08L2Rpdj48ZGl2PmJ0cmZzIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDYxMDA1
OSDCoDDCoDwvZGl2PjxkaXY+dWZzIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgNTY1NTAg
wqAwwqA8L2Rpdj4NCg0KPGRpdj5oZnNwbHVzIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgNzA4NzAg
wqAwwqA8L2Rpdj48ZGl2PmhmcyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDM5NTEzIMKg
MMKgPC9kaXY+PGRpdj5udGZzIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgMTY2OTc2IMKgMMKg
PC9kaXY+PGRpdj52ZmF0IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgODM2NyDCoDDCoDwv
ZGl2PjxkaXY+bXNkb3MgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgNjE4MiDCoDDCoDwvZGl2
PjxkaXY+DQpmYXQgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA0NDYyNyDCoDIgdmZhdCxt
c2RvczwvZGl2Pg0KPGRpdj54ZnMgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgNDY5ODM0IMKg
MMKgPC9kaXY+PGRpdj5jcmMzMmMgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAxNjQ4IMKgMcKg
PC9kaXY+PGRpdj5saWJjcmMzMmMgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA5MzAgwqAyIHhmcyxi
dHJmczwvZGl2PjxkaXY+aTkxNSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDQ2NTQ1MCDCoDbC
oDwvZGl2PjxkaXY+aW50ZWxfYWdwIMKgIMKgIMKgIMKgIMKgIMKgIMKgMTAyNDQgwqAxIGk5MTU8
L2Rpdj4NCg0KPGRpdj5pbnRlbF9ndHQgwqAgwqAgwqAgwqAgwqAgwqAgwqAxMTI4NiDCoDIgaTkx
NSxpbnRlbF9hZ3A8L2Rpdj48ZGl2PmRybV9rbXNfaGVscGVyIMKgIMKgIMKgIMKgIDI0NDYzIMKg
MSBpOTE1PC9kaXY+PGRpdj5kcm0gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgMjExNzM5IMKg
NyBpOTE1LGRybV9rbXNfaGVscGVyPC9kaXY+PGRpdj5pMmNfYWxnb19iaXQgwqAgwqAgwqAgwqAg
wqAgwqA0NjkxIMKgMSBpOTE1PC9kaXY+PGRpdj5zbmRfc2VxIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgNTc0MTIgwqAxwqA8L2Rpdj4NCg0KPGRpdj5zbmRfc2VxX2RldmljZSDCoCDCoCDCoCDCoCDC
oDQ1NjQgwqAxIHNuZF9zZXE8L2Rpdj48ZGl2PmlwdjYgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAyNTYzMDYgwqA0OMKgPC9kaXY+PGRpdj44MDIxcSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oDE1OTgwIMKgMMKgPC9kaXY+PGRpdj5pcGhldGggwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA1
OTkzIMKgMMKgPC9kaXY+PGRpdj5hcmM0IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgMTg5
NSDCoDLCoDwvZGl2Pg0KDQo8ZGl2PnV2Y3ZpZGVvIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDY0MzA4
IMKgMMKgPC9kaXY+PGRpdj52aWRlb2J1ZjJfdm1hbGxvYyDCoCDCoCDCoCAyNTc2IMKgMSB1dmN2
aWRlbzwvZGl2PjxkaXY+dmlkZW9idWYyX21lbW9wcyDCoCDCoCDCoCDCoDE1NTEgwqAxIHZpZGVv
YnVmMl92bWFsbG9jPC9kaXY+PGRpdj52aWRlb2J1ZjJfY29yZSDCoCDCoCDCoCDCoCAyMjQwMiDC
oDEgdXZjdmlkZW88L2Rpdj48ZGl2PnZpZGVvZGV2IMKgIMKgIMKgIMKgIMKgIMKgIMKgIDk3NzMx
IMKgMiB1dmN2aWRlbyx2aWRlb2J1ZjJfY29yZTwvZGl2Pg0KDQo8ZGl2PnJ0czUxMzkgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgMjUyODgyIMKgMMKgPC9kaXY+PGRpdj5zbmRfaGRhX2NvZGVjX2hkbWkg
wqAgwqAgMjQ2MDAgwqAxwqA8L2Rpdj48ZGl2PnNuZF9oZGFfY29kZWNfcmVhbHRlayDCoCDCoDUz
OTU4IMKgMcKgPC9kaXY+PGRpdj5pMmNfaTgwMSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDg0Mzgg
wqAwwqA8L2Rpdj48ZGl2PnNuZF9oZGFfaW50ZWwgwqAgwqAgwqAgwqAgwqAyNDk0NiDCoDPCoDwv
ZGl2PjxkaXY+DQoNCmkyY19jb3JlIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDE3MTg4IMKgNiBkcm0s
aTkxNSxpMmNfaTgwMSxkcm1fa21zX2hlbHBlcixpMmNfYWxnb19iaXQsdmlkZW9kZXY8L2Rpdj48
ZGl2PnNuZF9oZGFfY29kZWMgwqAgwqAgwqAgwqAgwqA3NzYwMiDCoDMgc25kX2hkYV9jb2RlY19y
ZWFsdGVrLHNuZF9oZGFfY29kZWNfaGRtaSxzbmRfaGRhX2ludGVsPC9kaXY+PGRpdj5zbmRfaHdk
ZXAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgNjIxMyDCoDEgc25kX2hkYV9jb2RlYzwvZGl2Pg0KDQo8
ZGl2PnNuZF9wY20gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA3MDg3MCDCoDMgc25kX2hkYV9jb2Rl
Y19oZG1pLHNuZF9oZGFfY29kZWMsc25kX2hkYV9pbnRlbDwvZGl2PjxkaXY+c25kX3BhZ2VfYWxs
b2MgwqAgwqAgwqAgwqAgwqA2NjgyIMKgMiBzbmRfcGNtLHNuZF9oZGFfaW50ZWw8L2Rpdj48ZGl2
PnNuZF90aW1lciDCoCDCoCDCoCDCoCDCoCDCoCDCoDE5Mzk4IMKgMiBzbmRfcGNtLHNuZF9zZXE8
L2Rpdj48ZGl2PmxwY19pY2ggwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAxMTE0NSDCoDDCoDwvZGl2
Pg0KDQo8ZGl2PnNuZCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDU5ODYwIMKgMTYgc25k
X2hkYV9jb2RlY19yZWFsdGVrLHNuZF9od2RlcCxzbmRfdGltZXIsc25kX2hkYV9jb2RlY19oZG1p
LHNuZF9wY20sc25kX3NlcSxzbmRfaGRhX2NvZGVjLHNuZF9oZGFfaW50ZWwsc25kX3NlcV9kZXZp
Y2U8L2Rpdj48ZGl2Pm1mZF9jb3JlIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgMjg2NSDCoDEgbHBj
X2ljaDwvZGl2PjxkaXY+a3ZtX2ludGVsIMKgIMKgIMKgIMKgIMKgIMKgIDExNDEwOCDCoDDCoDwv
ZGl2Pg0KDQo8ZGl2PmFzdXNfbmJfd21pIMKgIMKgIMKgIMKgIMKgIMKgIDUxMjAgwqAwwqA8L2Rp
dj48ZGl2PmFzdXNfd21pIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDE0MTczIMKgMSBhc3VzX25iX3dt
aTwvZGl2PjxkaXY+a3ZtIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDI0OTMwMSDCoDEga3Zt
X2ludGVsPC9kaXY+PGRpdj5zcGFyc2Vfa2V5bWFwIMKgIMKgIMKgIMKgIMKgIDI3NjggwqAxIGFz
dXNfd21pPC9kaXY+PGRpdj5yZmtpbGwgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgMTQ1NDMgwqAy
IGNmZzgwMjExLGFzdXNfd21pPC9kaXY+DQoNCjxkaXY+cGNpX2hvdHBsdWcgwqAgwqAgwqAgwqAg
wqAgwqAgOTE2OCDCoDEgYXN1c193bWk8L2Rpdj48ZGl2Pm1pY3JvY29kZSDCoCDCoCDCoCDCoCDC
oCDCoCDCoCA4NjY4IMKgMMKgPC9kaXY+PGRpdj5qb3lkZXYgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgMTMyNDcgwqAwwqA8L2Rpdj48ZGl2PnRoZXJtYWwgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
OTMyOSDCoDDCoDwvZGl2PjxkaXY+d21pIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDcy
OTUgwqAxIGFzdXNfd21pPC9kaXY+DQoNCjxkaXY+YmF0dGVyeSDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoDExODg0IMKgMMKgPC9kaXY+PGRpdj5idXR0b24gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqA0NjEzIMKgMSBpOTE1PC9kaXY+PGRpdj5hYyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoDM0NTcgwqAwwqA8L2Rpdj48ZGl2PnZpZGVvIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
MTIwMDcgwqAyIGk5MTUsYXN1c193bWk8L2Rpdj48ZGl2PmFjcGlfY3B1ZnJlcSDCoCDCoCDCoCDC
oCDCoCDCoDY1MzQgwqAwwqA8L2Rpdj4NCg0KPGRpdj5tcGVyZiDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCAxMDUxIMKgMSBhY3BpX2NwdWZyZXE8L2Rpdj48ZGl2PnByb2Nlc3NvciDCoCDCoCDC
oCDCoCDCoCDCoCDCoDMxNzE5IMKgMSBhY3BpX2NwdWZyZXE8L2Rpdj48ZGl2PmRtX2Jpb19wcmlz
b24gwqAgwqAgwqAgwqAgwqAgMzUzNSDCoDDCoDwvZGl2PjxkaXY+ZG1fYnVmaW8gwqAgwqAgwqAg
wqAgwqAgwqAgwqAgMTIxODggwqAwwqA8L2Rpdj48ZGl2PmFlc25pX2ludGVsIMKgIMKgIMKgIMKg
IMKgIMKgNDQyNzMgwqAxwqA8L2Rpdj4NCg0KPGRpdj5hYmxrX2hlbHBlciDCoCDCoCDCoCDCoCDC
oCDCoCAxNjA0IMKgMSBhZXNuaV9pbnRlbDwvZGl2PjxkaXY+Y3J5cHRkIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgNzQ0OCDCoDIgYWVzbmlfaW50ZWwsYWJsa19oZWxwZXI8L2Rpdj48ZGl2Pmxy
dyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAzMzI1IMKgMSBhZXNuaV9pbnRlbDwvZGl2
PjxkaXY+eHRzIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDI5NTkgwqAxIGFlc25pX2lu
dGVsPC9kaXY+DQoNCjxkaXY+Z2YxMjhtdWwgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA1NDEwIMKg
MiBscncseHRzPC9kaXY+PGRpdj5hZXNfeDg2XzY0IMKgIMKgIMKgIMKgIMKgIMKgIMKgNzUxNSDC
oDEgYWVzbmlfaW50ZWw8L2Rpdj48ZGl2PmNiYyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCAyNjUwIMKgMMKgPC9kaXY+PGRpdj5pc2NzaV90Y3AgwqAgwqAgwqAgwqAgwqAgwqAgwqAgNzg4
OCDCoDDCoDwvZGl2PjxkaXY+bGliaXNjc2lfdGNwIMKgIMKgIMKgIMKgIMKgIDEwOTM0IMKgMSBp
c2NzaV90Y3A8L2Rpdj4NCg0KPGRpdj5saWJpc2NzaSDCoCDCoCDCoCDCoCDCoCDCoCDCoCAzMTA0
MCDCoDIgbGliaXNjc2lfdGNwLGlzY3NpX3RjcDwvZGl2PjxkaXY+c2NzaV90cmFuc3BvcnRfaXNj
c2kgwqAgwqAzNTY1OSDCoDIgaXNjc2lfdGNwLGxpYmlzY3NpPC9kaXY+PGRpdj50ZzMgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgMTI4NzgzIMKgMMKgPC9kaXY+PGRpdj5saWJwaHkgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgMTc5ODQgwqAxIHRnMzwvZGl2PjxkaXY+DQoNCmh3bW9uIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIDExNzcgwqAzIHRnMyxjb3JldGVtcCxhc3VzX3dtaTwvZGl2
PjxkaXY+cHRwIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDg4OTIgwqAxIHRnMzwvZGl2
PjxkaXY+cHBzX2NvcmUgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA3MjU2IMKgMSBwdHA8L2Rpdj48
ZGl2PmUxMDAwIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgODk3OTggwqAwwqA8L2Rpdj48ZGl2
PmZ1c2UgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgNjE2NDIgwqAywqA8L2Rpdj4NCg0KPGRp
dj5leHBvcnRmcyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDMyMTAgwqAxIHhmczwvZGl2PjxkaXY+
bmZzIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDExMjUyMSDCoDDCoDwvZGl2PjxkaXY+ZnNj
YWNoZSDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDM0OTgwIMKgMSBuZnM8L2Rpdj48ZGl2PmxvY2tk
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgNTU2NjkgwqAxIG5mczwvZGl2PjxkaXY+c3VucnBj
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgMTU2MDY4IMKgMiBuZnMsbG9ja2Q8L2Rpdj4NCg0KPGRp
dj5qZnMgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgMTQ1OTkwIMKgMMKgPC9kaXY+PGRpdj5y
ZWlzZXJmcyDCoCDCoCDCoCDCoCDCoCDCoCDCoDIxMzU3MiDCoDDCoDwvZGl2PjxkaXY+emxpYl9k
ZWZsYXRlIMKgIMKgIMKgIMKgIMKgIDE3OTk1IMKgMSBidHJmczwvZGl2PjxkaXY+ZXh0NCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoDI4MTk0MCDCoDLCoDwvZGl2PjxkaXY+amJkMiDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCA1MDgwOCDCoDEgZXh0NDwvZGl2Pg0KDQo8ZGl2PmNyYzE2IMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDEyNDcgwqAxIGV4dDQ8L2Rpdj48ZGl2PmV4dDMgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAxMTIxMjUgwqAwwqA8L2Rpdj48ZGl2PmpiZCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoDQyMDc4IMKgMSBleHQzPC9kaXY+PGRpdj5leHQyIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIDU1OTkyIMKgMMKgPC9kaXY+PGRpdj5tYmNhY2hlIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIDQ3NTggwqAzIGV4dDIsZXh0MyxleHQ0PC9kaXY+DQoNCjxkaXY+
bGluZWFyIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgMzQ1NSDCoDDCoDwvZGl2PjxkaXY+cmFp
ZDAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgNjc4NyDCoDDCoDwvZGl2PjxkaXY+ZG1fcmFp
ZCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDEyMjkyIMKgMMKgPC9kaXY+PGRpdj5yYWlkMTAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgMzYxNzMgwqAxIGRtX3JhaWQ8L2Rpdj48ZGl2PnJhaWQxIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgMjQ5NjQgwqAxIGRtX3JhaWQ8L2Rpdj4NCg0KPGRpdj5y
YWlkNDU2IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgNTAyMTIgwqAxIGRtX3JhaWQ8L2Rpdj48ZGl2
Pm1kX21vZCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCA5MjcwOSDCoDYgcmFpZDQ1NixkbV9yYWlk
LHJhaWQwLHJhaWQxLGxpbmVhcixyYWlkMTA8L2Rpdj48ZGl2PmFzeW5jX3BxIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgMjk3NCDCoDEgcmFpZDQ1NjwvZGl2PjxkaXY+YXN5bmNfeG9yIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIDIxMjEgwqAyIGFzeW5jX3BxLHJhaWQ0NTY8L2Rpdj4NCg0KPGRpdj54b3Ig
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgNzkxNiDCoDEgYXN5bmNfeG9yPC9kaXY+PGRp
dj5hc3luY19tZW1jcHkgwqAgwqAgwqAgwqAgwqAgwqAxMTgyIMKgMSByYWlkNDU2PC9kaXY+PGRp
dj5hc3luY19yYWlkNl9yZWNvdiDCoCDCoCDCoCAxMjA5IMKgMSByYWlkNDU2PC9kaXY+PGRpdj5y
YWlkNl9wcSDCoCDCoCDCoCDCoCDCoCDCoCDCoCA5MDI3OCDCoDIgYXN5bmNfcHEsYXN5bmNfcmFp
ZDZfcmVjb3Y8L2Rpdj4NCg0KPGRpdj5hc3luY190eCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDE2
OTQgwqA1IGFzeW5jX3BxLHJhaWQ0NTYsYXN5bmNfeG9yLGFzeW5jX21lbWNweSxhc3luY19yYWlk
Nl9yZWNvdjwvZGl2PjxkaXY+ZG1fc25hcHNob3QgwqAgwqAgwqAgwqAgwqAgwqAyNDY5OSDCoDDC
oDwvZGl2PjxkaXY+ZG1fY3J5cHQgwqAgwqAgwqAgwqAgwqAgwqAgwqAgMTM4NjQgwqAwwqA8L2Rp
dj48ZGl2PmRtX21pcnJvciDCoCDCoCDCoCDCoCDCoCDCoCDCoDExNDU2IMKgMMKgPC9kaXY+DQoN
CjxkaXY+ZG1fcmVnaW9uX2hhc2ggwqAgwqAgwqAgwqAgwqA2NjE1IMKgMSBkbV9taXJyb3I8L2Rp
dj48ZGl2PmRtX2xvZyDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDc3MTEgwqAyIGRtX3JlZ2lv
bl9oYXNoLGRtX21pcnJvcjwvZGl2PjxkaXY+ZG1fbW9kIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IDYzMTg0IMKgMTIgZG1fcmFpZCxkbV9sb2csZG1fbWlycm9yLGRtX2J1ZmlvLGRtX2NyeXB0LGRt
X3NuYXBzaG90PC9kaXY+PGRpdj4NCg0KeGhjaV9oY2QgwqAgwqAgwqAgwqAgwqAgwqAgwqAgNzQw
MjMgwqAwwqA8L2Rpdj48ZGl2Pm9oY2lfaGNkIMKgIMKgIMKgIMKgIMKgIMKgIMKgIDIwMjM4IMKg
MMKgPC9kaXY+PGRpdj51aGNpX2hjZCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAxOTEyNSDCoDDCoDwv
ZGl2PjxkaXY+c2NzaV90cmFuc3BvcnRfZmMgwqAgwqAgwqA0MDcyMyDCoDDCoDwvZGl2PjxkaXY+
YWFjcmFpZCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoDc4MDcyIMKgMMKgPC9kaXY+PGRpdj5zeDgg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAxMTE4OSDCoDDCoDwvZGl2Pg0KDQo8ZGl2PmNj
aXNzIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgNTI2NDEgwqAwwqA8L2Rpdj48ZGl2PmF0cDg3
MHUgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAyMzIwOSDCoDDCoDwvZGl2PjxkaXY+ZG14MzE5MWQg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqA5MTIxIMKgMMKgPC9kaXY+PGRpdj5zeW01M2M4eHggwqAg
wqAgwqAgwqAgwqAgwqAgwqA2MzMxNSDCoDDCoDwvZGl2PjxkaXY+Z2R0aCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCA3ODM0OCDCoDDCoDwvZGl2PjxkaXY+DQppbml0aW8gwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgMTUzMDAgwqAwwqA8L2Rpdj4NCjxkaXY+QnVzTG9naWMgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgMTk1NDAgwqAwwqA8L2Rpdj48ZGl2PmFpYzd4eHggwqAgwqAgwqAgwqAgwqAgwqAg
wqAgMTAxNDgyIMKgMMKgPC9kaXY+PGRpdj5haWM3OXh4IMKgIMKgIMKgIMKgIMKgIMKgIMKgIDEy
MzU3MCDCoDDCoDwvZGl2PjxkaXY+c2NzaV90cmFuc3BvcnRfc3BpIMKgIMKgIDE4NTg4IMKgNCBz
eW01M2M4eHgsYWljNzl4eCxhaWM3eHh4LGRteDMxOTFkPC9kaXY+PGRpdj5zZyDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCAyNTA3NiDCoDDCoDwvZGl2Pg0KDQo8ZGl2PmF0YV9waWl4IMKg
IMKgIMKgIMKgIMKgIMKgIMKgIDIyMTU1IMKgMMKgPC9kaXY+PGRpdj5wYXRhX3BjbWNpYSDCoCDC
oCDCoCDCoCDCoCDCoCA5NzMzIMKgMMKgPC9kaXY+PGRpdj5wY21jaWEgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgMzA0NTEgwqAxIHBhdGFfcGNtY2lhPC9kaXY+PGRpdj5wY21jaWFfY29yZSDCoCDC
oCDCoCDCoCDCoCDCoDEwODkzIMKgMSBwY21jaWE8L2Rpdj48ZGl2PnBhdGFfb2xkcGlpeCDCoCDC
oCDCoCDCoCDCoCDCoDI5ODQgwqAwwqA8L2Rpdj4NCg0KPGRpdj5wYXRhX21waWl4IMKgIMKgIMKg
IMKgIMKgIMKgIMKgMjgxMCDCoDDCoDwvZGl2PjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXYgc3R5
bGU+U29ycnkgSSBoYXZlIG5vIHBhcnQgbnVtYmVycyBvZiBjaGlwcy4gSSYjMzk7bSBsb29raW5n
IGZvciBpbiBpbnRlcm5ldCBidXQgaGF2ZSBubyBsdWNrIGF0IHRoaXMgdGltZS48L2Rpdj48ZGl2
IHN0eWxlPjxicj48L2Rpdj48ZGl2IHN0eWxlPlRoYW5rIHlvdSE8L2Rpdj4NCg0KPGRpdj48YnI+
PC9kaXY+PC9kaXY+PC9kaXY+DQo=
--047d7b6247be6e693f04d797d91e--

--047d7b6247be6e695004d797d920
Content-Type: application/octet-stream; name=dmesg
Content-Disposition: attachment; filename=dmesg
Content-Transfer-Encoding: base64
X-Attachment-Id: f_he4mve6n0

WzUxMDkxLjgxOTY4Ml0gQ1BVMTogUGFja2FnZSBwb3dlciBsaW1pdCBub3RpZmljYXRpb24gKHRv
dGFsIGV2ZW50cyA9IDg3MDk2KQpbNTEwOTEuODE5Njg1XSBDUFUyOiBQYWNrYWdlIHBvd2VyIGxp
bWl0IG5vdGlmaWNhdGlvbiAodG90YWwgZXZlbnRzID0gODcwOTYpCls1MTA5MS44MTk2ODldIENQ
VTM6IFBhY2thZ2UgcG93ZXIgbGltaXQgbm90aWZpY2F0aW9uICh0b3RhbCBldmVudHMgPSA4NzA5
NSkKWzUxMDkxLjgyNzcwOV0gQ1BVMDogUGFja2FnZSBwb3dlciBsaW1pdCBub3JtYWwKWzUxMDkx
LjgyNzcxMV0gQ1BVMjogUGFja2FnZSBwb3dlciBsaW1pdCBub3JtYWwKWzUxMDkxLjgyNzcyN10g
Q1BVMzogUGFja2FnZSBwb3dlciBsaW1pdCBub3JtYWwKWzUxMDkxLjgyNzcyOV0gQ1BVMTogUGFj
a2FnZSBwb3dlciBsaW1pdCBub3JtYWwKWzUxMjc3Ljg4MTEyM10gaXdsd2lmaSAwMDAwOjAyOjAw
LjA6IGZhaWwgdG8gZmx1c2ggYWxsIHR4IGZpZm8gcXVldWVzCls1MTM5OS4zOTc3NDNdIENQVTA6
IFBhY2thZ2UgcG93ZXIgbGltaXQgbm90aWZpY2F0aW9uICh0b3RhbCBldmVudHMgPSA4NzIzMikK
WzUxMzk5LjM5Nzc0N10gQ1BVMTogUGFja2FnZSBwb3dlciBsaW1pdCBub3RpZmljYXRpb24gKHRv
dGFsIGV2ZW50cyA9IDg3MjM0KQpbNTEzOTkuMzk3NzQ5XSBDUFUyOiBQYWNrYWdlIHBvd2VyIGxp
bWl0IG5vdGlmaWNhdGlvbiAodG90YWwgZXZlbnRzID0gODcyMzQpCls1MTM5OS4zOTc3NTFdIENQ
VTM6IFBhY2thZ2UgcG93ZXIgbGltaXQgbm90aWZpY2F0aW9uICh0b3RhbCBldmVudHMgPSA4NzIz
MykKWzUxMzk5LjQxMDc3MF0gQ1BVMDogUGFja2FnZSBwb3dlciBsaW1pdCBub3JtYWwKWzUxMzk5
LjQxMDc3M10gQ1BVMjogUGFja2FnZSBwb3dlciBsaW1pdCBub3JtYWwKWzUxMzk5LjQxMDc3Nl0g
Q1BVMTogUGFja2FnZSBwb3dlciBsaW1pdCBub3JtYWwKWzUxMzk5LjQxMDc3OV0gQ1BVMzogUGFj
a2FnZSBwb3dlciBsaW1pdCBub3JtYWwKWzUxNzA1LjczMjQ1Nl0gQ1BVMDogUGFja2FnZSBwb3dl
ciBsaW1pdCBub3RpZmljYXRpb24gKHRvdGFsIGV2ZW50cyA9IDkwMzA1KQpbNTE3MDUuNzMyNDYw
XSBDUFUzOiBQYWNrYWdlIHBvd2VyIGxpbWl0IG5vdGlmaWNhdGlvbiAodG90YWwgZXZlbnRzID0g
OTAzMDYpCls1MTcwNS43MzI0NjJdIENQVTE6IFBhY2thZ2UgcG93ZXIgbGltaXQgbm90aWZpY2F0
aW9uICh0b3RhbCBldmVudHMgPSA5MDMwNykKWzUxNzA1LjczMjQ2NF0gQ1BVMjogUGFja2FnZSBw
b3dlciBsaW1pdCBub3RpZmljYXRpb24gKHRvdGFsIGV2ZW50cyA9IDkwMzA3KQpbNTE3MDUuNzM3
ODgxXSBDUFUzOiBQYWNrYWdlIHBvd2VyIGxpbWl0IG5vcm1hbApbNTE3MDUuNzM3ODg1XSBDUFUx
OiBQYWNrYWdlIHBvd2VyIGxpbWl0IG5vcm1hbApbNTE3MDUuNzM3ODk4XSBDUFUyOiBQYWNrYWdl
IHBvd2VyIGxpbWl0IG5vcm1hbApbNTE3MDUuNzM3OTAyXSBDUFUwOiBQYWNrYWdlIHBvd2VyIGxp
bWl0IG5vcm1hbApbNTIwMDUuMzY4Mjc4XSBDUFUxOiBQYWNrYWdlIHBvd2VyIGxpbWl0IG5vcm1h
bApbNTIwMDUuMzY4MjgwXSBDUFUwOiBQYWNrYWdlIHBvd2VyIGxpbWl0IG5vcm1hbApbNTIwMDUu
MzY4MjgyXSBDUFUyOiBQYWNrYWdlIHBvd2VyIGxpbWl0IG5vcm1hbApbNTIwMDUuMzY4MjgzXSBD
UFUzOiBQYWNrYWdlIHBvd2VyIGxpbWl0IG5vcm1hbApbNTIyNzYuMjk3MzE0XSBpd2x3aWZpIDAw
MDA6MDI6MDAuMDogZmFpbCB0byBmbHVzaCBhbGwgdHggZmlmbyBxdWV1ZXMKWzUyMzA4LjEzMzg4
MV0gQ1BVMjogUGFja2FnZSBwb3dlciBsaW1pdCBub3RpZmljYXRpb24gKHRvdGFsIGV2ZW50cyA9
IDk2MTM2KQpbNTIzMDguMTMzODg1XSBDUFUxOiBQYWNrYWdlIHBvd2VyIGxpbWl0IG5vdGlmaWNh
dGlvbiAodG90YWwgZXZlbnRzID0gOTYxMzUpCls1MjMwOC4xMzM4ODddIENQVTA6IFBhY2thZ2Ug
cG93ZXIgbGltaXQgbm90aWZpY2F0aW9uICh0b3RhbCBldmVudHMgPSA5NjEzNCkKWzUyMzA4LjEz
Mzg4OV0gQ1BVMzogUGFja2FnZSBwb3dlciBsaW1pdCBub3RpZmljYXRpb24gKHRvdGFsIGV2ZW50
cyA9IDk2MTM0KQpbNTIzMDguMTQyOTA1XSBDUFUxOiBQYWNrYWdlIHBvd2VyIGxpbWl0IG5vcm1h
bApbNTIzMDguMTQyOTA4XSBDUFUyOiBQYWNrYWdlIHBvd2VyIGxpbWl0IG5vcm1hbApbNTIzMDgu
MTQyOTEwXSBDUFUwOiBQYWNrYWdlIHBvd2VyIGxpbWl0IG5vcm1hbApbNTIzMDguMTQyOTExXSBD
UFUzOiBQYWNrYWdlIHBvd2VyIGxpbWl0IG5vcm1hbApbNTI1NzIuOTI4MDY0XSBpd2x3aWZpIDAw
MDA6MDI6MDAuMDogZmFpbCB0byBmbHVzaCBhbGwgdHggZmlmbyBxdWV1ZXMKWzUyNjE0Ljg2MTAy
MV0gQ1BVMjogUGFja2FnZSBwb3dlciBsaW1pdCBub3RpZmljYXRpb24gKHRvdGFsIGV2ZW50cyA9
IDk2MjE0KQpbNTI2MTQuODYxMDI0XSBDUFUzOiBQYWNrYWdlIHBvd2VyIGxpbWl0IG5vdGlmaWNh
dGlvbiAodG90YWwgZXZlbnRzID0gOTYyMTIpCls1MjYxNC44NjEwMjZdIENQVTE6IFBhY2thZ2Ug
cG93ZXIgbGltaXQgbm90aWZpY2F0aW9uICh0b3RhbCBldmVudHMgPSA5NjIxMykKWzUyNjE0Ljg2
MTAyOF0gQ1BVMDogUGFja2FnZSBwb3dlciBsaW1pdCBub3RpZmljYXRpb24gKHRvdGFsIGV2ZW50
cyA9IDk2MjEyKQpbNTI2MTQuODYyNjI0XSBDUFUxOiBQYWNrYWdlIHBvd2VyIGxpbWl0IG5vcm1h
bApbNTI2MTQuODYyNjI2XSBDUFUyOiBQYWNrYWdlIHBvd2VyIGxpbWl0IG5vcm1hbApbNTI2MTQu
ODYyNjI4XSBDUFUwOiBQYWNrYWdlIHBvd2VyIGxpbWl0IG5vcm1hbApbNTI2MTQuODYyNjMwXSBD
UFUzOiBQYWNrYWdlIHBvd2VyIGxpbWl0IG5vcm1hbApbNTI5MTkuMTAzNDU0XSBDUFUzOiBQYWNr
YWdlIHBvd2VyIGxpbWl0IG5vdGlmaWNhdGlvbiAodG90YWwgZXZlbnRzID0gOTY5OTQpCls1Mjkx
OS4xMDM0NTddIENQVTE6IFBhY2thZ2UgcG93ZXIgbGltaXQgbm90aWZpY2F0aW9uICh0b3RhbCBl
dmVudHMgPSA5Njk5NSkKWzUyOTE5LjEwMzQ2MF0gQ1BVMjogUGFja2FnZSBwb3dlciBsaW1pdCBu
b3RpZmljYXRpb24gKHRvdGFsIGV2ZW50cyA9IDk2OTk2KQpbNTI5MTkuMTAzNDYyXSBDUFUwOiBQ
YWNrYWdlIHBvd2VyIGxpbWl0IG5vdGlmaWNhdGlvbiAodG90YWwgZXZlbnRzID0gOTY5OTQpCls1
MjkxOS4xMTEyNjddIENQVTM6IFBhY2thZ2UgcG93ZXIgbGltaXQgbm9ybWFsCls1MjkxOS4xMTEy
NjldIENQVTA6IFBhY2thZ2UgcG93ZXIgbGltaXQgbm9ybWFsCls1MjkxOS4xMTEyNzFdIENQVTE6
IFBhY2thZ2UgcG93ZXIgbGltaXQgbm9ybWFsCls1MjkxOS4xMTEyNzNdIENQVTI6IFBhY2thZ2Ug
cG93ZXIgbGltaXQgbm9ybWFsCls1MzI0Mi43Mzg3NzNdIENQVTI6IFBhY2thZ2UgcG93ZXIgbGlt
aXQgbm90aWZpY2F0aW9uICh0b3RhbCBldmVudHMgPSAxMDAyNDQpCls1MzI0Mi43Mzg3NzddIENQ
VTE6IFBhY2thZ2UgcG93ZXIgbGltaXQgbm90aWZpY2F0aW9uICh0b3RhbCBldmVudHMgPSAxMDAy
NDIpCls1MzI0Mi43Mzg3NzldIENQVTA6IFBhY2thZ2UgcG93ZXIgbGltaXQgbm90aWZpY2F0aW9u
ICh0b3RhbCBldmVudHMgPSAxMDAyNDEpCls1MzI0Mi43Mzg3ODJdIENQVTM6IFBhY2thZ2UgcG93
ZXIgbGltaXQgbm90aWZpY2F0aW9uICh0b3RhbCBldmVudHMgPSAxMDAyNDIpCls1MzI0Mi43NTE3
NDVdIENQVTM6IFBhY2thZ2UgcG93ZXIgbGltaXQgbm9ybWFsCls1MzI0Mi43NTE3NDhdIENQVTE6
IFBhY2thZ2UgcG93ZXIgbGltaXQgbm9ybWFsCls1MzI0Mi43NTE3NTddIENQVTA6IFBhY2thZ2Ug
cG93ZXIgbGltaXQgbm9ybWFsCls1MzI0Mi43NTE3NTldIENQVTI6IFBhY2thZ2UgcG93ZXIgbGlt
aXQgbm9ybWFsCls1MzQ0MC43Mzg0NTJdIGl3bHdpZmkgMDAwMDowMjowMC4wOiBmYWlsIHRvIGZs
dXNoIGFsbCB0eCBmaWZvIHF1ZXVlcwpbNTM1OTQuMzU1MDY1XSBDUFUwOiBQYWNrYWdlIHBvd2Vy
IGxpbWl0IG5vdGlmaWNhdGlvbiAodG90YWwgZXZlbnRzID0gMTAyMzY1KQpbNTM1OTQuMzU1MDY5
XSBDUFUyOiBQYWNrYWdlIHBvd2VyIGxpbWl0IG5vdGlmaWNhdGlvbiAodG90YWwgZXZlbnRzID0g
MTAyMzY5KQpbNTM1OTQuMzU1MDczXSBDUFUzOiBQYWNrYWdlIHBvd2VyIGxpbWl0IG5vdGlmaWNh
dGlvbiAodG90YWwgZXZlbnRzID0gMTAyMzY3KQpbNTM1OTQuMzU1MDc2XSBDUFUxOiBQYWNrYWdl
IHBvd2VyIGxpbWl0IG5vdGlmaWNhdGlvbiAodG90YWwgZXZlbnRzID0gMTAyMzY3KQpbNTM1OTQu
MzU1NzM1XSBDUFUwOiBQYWNrYWdlIHBvd2VyIGxpbWl0IG5vcm1hbApbNTM1OTQuMzU1NzQwXSBD
UFUyOiBQYWNrYWdlIHBvd2VyIGxpbWl0IG5vcm1hbApbNTM1OTQuMzU1NzQ1XSBDUFUxOiBQYWNr
YWdlIHBvd2VyIGxpbWl0IG5vcm1hbApbNTM1OTQuMzU1NzQ5XSBDUFUzOiBQYWNrYWdlIHBvd2Vy
IGxpbWl0IG5vcm1hbApbNTQzMzguODgyOTUxXSBpd2x3aWZpIDAwMDA6MDI6MDAuMDogZmFpbCB0
byBmbHVzaCBhbGwgdHggZmlmbyBxdWV1ZXMKWzU0NDA5LjEyODM4NV0gQ1BVMTogUGFja2FnZSBw
b3dlciBsaW1pdCBub3RpZmljYXRpb24gKHRvdGFsIGV2ZW50cyA9IDEwMjkzMikKWzU0NDA5LjEy
ODM4OF0gQ1BVMzogUGFja2FnZSBwb3dlciBsaW1pdCBub3RpZmljYXRpb24gKHRvdGFsIGV2ZW50
cyA9IDEwMjkzMikKWzU0NDA5LjEyODM5N10gQ1BVMDogUGFja2FnZSBwb3dlciBsaW1pdCBub3Rp
ZmljYXRpb24gKHRvdGFsIGV2ZW50cyA9IDEwMjkzMCkKWzU0NDA5LjEyODM5OV0gQ1BVMjogUGFj
a2FnZSBwb3dlciBsaW1pdCBub3RpZmljYXRpb24gKHRvdGFsIGV2ZW50cyA9IDEwMjkzNCkKWzU0
NDA5LjE0MTM5N10gQ1BVMjogUGFja2FnZSBwb3dlciBsaW1pdCBub3JtYWwKWzU0NDA5LjE0MTQw
MF0gQ1BVMzogUGFja2FnZSBwb3dlciBsaW1pdCBub3JtYWwKWzU0NDA5LjE0MTQwM10gQ1BVMDog
UGFja2FnZSBwb3dlciBsaW1pdCBub3JtYWwKWzU0NDA5LjE0MTQwNV0gQ1BVMTogUGFja2FnZSBw
b3dlciBsaW1pdCBub3JtYWwKWzU0NzE0LjIyNTc3NF0gQ1BVMjogUGFja2FnZSBwb3dlciBsaW1p
dCBub3RpZmljYXRpb24gKHRvdGFsIGV2ZW50cyA9IDEwMzQxMCkKWzU0NzE0LjIyNTc3Nl0gQ1BV
MDogUGFja2FnZSBwb3dlciBsaW1pdCBub3RpZmljYXRpb24gKHRvdGFsIGV2ZW50cyA9IDEwMzQw
NikKWzU0NzE0LjIyNTc3OV0gQ1BVMzogUGFja2FnZSBwb3dlciBsaW1pdCBub3RpZmljYXRpb24g
KHRvdGFsIGV2ZW50cyA9IDEwMzQwOCkKWzU0NzE0LjIyNTc4Ml0gQ1BVMTogUGFja2FnZSBwb3dl
ciBsaW1pdCBub3RpZmljYXRpb24gKHRvdGFsIGV2ZW50cyA9IDEwMzQwOCkKWzU0NzE0LjIzNzc1
NF0gQ1BVMDogUGFja2FnZSBwb3dlciBsaW1pdCBub3JtYWwKWzU0NzE0LjIzNzc1Nl0gQ1BVMTog
UGFja2FnZSBwb3dlciBsaW1pdCBub3JtYWwKWzU0NzE0LjIzNzc1N10gQ1BVMjogUGFja2FnZSBw
b3dlciBsaW1pdCBub3JtYWwKWzU0NzE0LjIzNzc1OV0gQ1BVMzogUGFja2FnZSBwb3dlciBsaW1p
dCBub3JtYWwKWzU1MDE0LjA4NTUwN10gQ1BVMDogUGFja2FnZSBwb3dlciBsaW1pdCBub3RpZmlj
YXRpb24gKHRvdGFsIGV2ZW50cyA9IDEwNTQyNykKWzU1MDE0LjA4NTUwOV0gQ1BVMjogUGFja2Fn
ZSBwb3dlciBsaW1pdCBub3RpZmljYXRpb24gKHRvdGFsIGV2ZW50cyA9IDEwNTQzMSkKWzU1MDE0
LjA4NTUxMl0gQ1BVMTogUGFja2FnZSBwb3dlciBsaW1pdCBub3RpZmljYXRpb24gKHRvdGFsIGV2
ZW50cyA9IDEwNTQyOSkKWzU1MDE0LjA4NTUxNF0gQ1BVMzogUGFja2FnZSBwb3dlciBsaW1pdCBu
b3RpZmljYXRpb24gKHRvdGFsIGV2ZW50cyA9IDEwNTQyOSkKWzU1MDE0LjA4NTcwNF0gQ1BVMTog
UGFja2FnZSBwb3dlciBsaW1pdCBub3JtYWwKWzU1MDE0LjA4NTcwNV0gQ1BVMzogUGFja2FnZSBw
b3dlciBsaW1pdCBub3JtYWwKWzU1MDE0LjA4NTcwN10gQ1BVMDogUGFja2FnZSBwb3dlciBsaW1p
dCBub3JtYWwKWzU1MDE0LjA4NTcwOF0gQ1BVMjogUGFja2FnZSBwb3dlciBsaW1pdCBub3JtYWwK
WzU1MDkxLjQwNzQzMF0gYXRhMS4wMDogY29uZmlndXJlZCBmb3IgVURNQS8xMzMKWzU1MDkxLjQw
NzQ0MV0gYXRhMTogRUggY29tcGxldGUKWzU1MDkxLjQwNzkzOF0gc2QgMDowOjA6MDogW3NkYV0g
V3JpdGUgY2FjaGU6IGVuYWJsZWQsIHJlYWQgY2FjaGU6IGVuYWJsZWQsIGRvZXNuJ3Qgc3VwcG9y
dCBEUE8gb3IgRlVBCls1NTA5Ny42MTY3MjZdIEVYVDQtZnMgKGRtLTEpOiByZS1tb3VudGVkLiBP
cHRzOiBkaXNjYXJkLGNvbW1pdD0wCls1NTA5Ny42NDcyNDldIEVYVDQtZnMgKGRtLTApOiByZS1t
b3VudGVkLiBPcHRzOiBkaXNjYXJkLGNvbW1pdD0wCls1NTA5Ny42NzMzMjJdIEVYVDQtZnMgKGRt
LTEpOiByZS1tb3VudGVkLiBPcHRzOiBkaXNjYXJkLGNvbW1pdD0wCls1NTA5Ny43MjU4MjRdIEVY
VDQtZnMgKGRtLTApOiByZS1tb3VudGVkLiBPcHRzOiBkaXNjYXJkLGNvbW1pdD0wCls1NTA5Ny45
NTI0MjRdIGVoY2ktcGNpIDAwMDA6MDA6MWQuMDogc2V0dGluZyBsYXRlbmN5IHRpbWVyIHRvIDY0
Cls1NTM1My4yMDg5MjJdIGl3bHdpZmkgMDAwMDowMjowMC4wOiBmYWlsIHRvIGZsdXNoIGFsbCB0
eCBmaWZvIHF1ZXVlcwpbNTU0NzkuOTYyNDY1XSBDUFUwOiBQYWNrYWdlIHBvd2VyIGxpbWl0IG5v
dGlmaWNhdGlvbiAodG90YWwgZXZlbnRzID0gMTA2NTY0KQpbNTU0NzkuOTYyNDY5XSBDUFUzOiBQ
YWNrYWdlIHBvd2VyIGxpbWl0IG5vdGlmaWNhdGlvbiAodG90YWwgZXZlbnRzID0gMTA2NTY2KQpb
NTU0NzkuOTYyNDcxXSBDUFUxOiBQYWNrYWdlIHBvd2VyIGxpbWl0IG5vdGlmaWNhdGlvbiAodG90
YWwgZXZlbnRzID0gMTA2NTY2KQpbNTU0NzkuOTYyNDczXSBDUFUyOiBQYWNrYWdlIHBvd2VyIGxp
bWl0IG5vdGlmaWNhdGlvbiAodG90YWwgZXZlbnRzID0gMTA2NTY4KQpbNTU0NzkuOTYzNTE4XSBD
UFUwOiBQYWNrYWdlIHBvd2VyIGxpbWl0IG5vcm1hbApbNTU0NzkuOTYzNTIwXSBDUFUyOiBQYWNr
YWdlIHBvd2VyIGxpbWl0IG5vcm1hbApbNTU0NzkuOTYzNTIyXSBDUFUzOiBQYWNrYWdlIHBvd2Vy
IGxpbWl0IG5vcm1hbApbNTU0NzkuOTYzNTIzXSBDUFUxOiBQYWNrYWdlIHBvd2VyIGxpbWl0IG5v
cm1hbApbNTU3MjIuMTk4OTcwXSBpd2x3aWZpIDAwMDA6MDI6MDAuMDogZmFpbCB0byBmbHVzaCBh
bGwgdHggZmlmbyBxdWV1ZXMKWzU2MTcxLjY1MTk3NF0gaXdsd2lmaSAwMDAwOjAyOjAwLjA6IGZh
aWwgdG8gZmx1c2ggYWxsIHR4IGZpZm8gcXVldWVzCls1NjIwMS42MTQxNDRdIGl3bHdpZmkgMDAw
MDowMjowMC4wOiBmYWlsIHRvIGZsdXNoIGFsbCB0eCBmaWZvIHF1ZXVlcwpbNTYyMDkuNjAzMjk5
XSBpd2x3aWZpIDAwMDA6MDI6MDAuMDogZmFpbCB0byBmbHVzaCBhbGwgdHggZmlmbyBxdWV1ZXMK
WzU2Mjk0LjQ5MzYwN10gaXdsd2lmaSAwMDAwOjAyOjAwLjA6IGZhaWwgdG8gZmx1c2ggYWxsIHR4
IGZpZm8gcXVldWVzCls1NjI5Ny40OTM5ODldIGl3bHdpZmkgMDAwMDowMjowMC4wOiBmYWlsIHRv
IGZsdXNoIGFsbCB0eCBmaWZvIHF1ZXVlcwpbNTYzMDAuNDkyMjA2XSBpd2x3aWZpIDAwMDA6MDI6
MDAuMDogZmFpbCB0byBmbHVzaCBhbGwgdHggZmlmbyBxdWV1ZXMKWzU2MzAzLjQ4MjU4MF0gaXds
d2lmaSAwMDAwOjAyOjAwLjA6IGZhaWwgdG8gZmx1c2ggYWxsIHR4IGZpZm8gcXVldWVzCls1NjQz
Mi4yMzA4NDhdIGl3bHdpZmkgMDAwMDowMjowMC4wOiBmYWlsIHRvIGZsdXNoIGFsbCB0eCBmaWZv
IHF1ZXVlcwpbNTY1MDQuMjQyMTcxXSBpd2x3aWZpIDAwMDA6MDI6MDAuMDogZmFpbCB0byBmbHVz
aCBhbGwgdHggZmlmbyBxdWV1ZXMKWzU2NTA5LjIzNjAwNl0gaXdsd2lmaSAwMDAwOjAyOjAwLjA6
IGZhaWwgdG8gZmx1c2ggYWxsIHR4IGZpZm8gcXVldWVzCls1NjUxNC4yMjY4MDhdIGl3bHdpZmkg
MDAwMDowMjowMC4wOiBmYWlsIHRvIGZsdXNoIGFsbCB0eCBmaWZvIHF1ZXVlcwpbNTY1OTMuMTI0
NjMxXSBpd2x3aWZpIDAwMDA6MDI6MDAuMDogZmFpbCB0byBmbHVzaCBhbGwgdHggZmlmbyBxdWV1
ZXMKWzU2NTk2LjEyNDg5M10gaXdsd2lmaSAwMDAwOjAyOjAwLjA6IGZhaWwgdG8gZmx1c2ggYWxs
IHR4IGZpZm8gcXVldWVzCls1NjU5OS4xMTcyMzZdIGl3bHdpZmkgMDAwMDowMjowMC4wOiBmYWls
IHRvIGZsdXNoIGFsbCB0eCBmaWZvIHF1ZXVlcwpbNTY2MDIuMTA5NTcyXSBpd2x3aWZpIDAwMDA6
MDI6MDAuMDogZmFpbCB0byBmbHVzaCBhbGwgdHggZmlmbyBxdWV1ZXMKWzU2NjA1LjExNDgyMl0g
aXdsd2lmaSAwMDAwOjAyOjAwLjA6IGZhaWwgdG8gZmx1c2ggYWxsIHR4IGZpZm8gcXVldWVzCls1
NjY3MS4xNDk0NjJdIGl3bHdpZmkgMDAwMDowMjowMC4wOiBmYWlsIHRvIGZsdXNoIGFsbCB0eCBm
aWZvIHF1ZXVlcwpbNTY2ODkuMDA2NTExXSBpd2x3aWZpIDAwMDA6MDI6MDAuMDogZmFpbCB0byBm
bHVzaCBhbGwgdHggZmlmbyBxdWV1ZXMKWzU2NjkyLjAwOTc1Nl0gaXdsd2lmaSAwMDAwOjAyOjAw
LjA6IGZhaWwgdG8gZmx1c2ggYWxsIHR4IGZpZm8gcXVldWVzCls1Njc2Ny45MTgyOTldIGl3bHdp
ZmkgMDAwMDowMjowMC4wOiBmYWlsIHRvIGZsdXNoIGFsbCB0eCBmaWZvIHF1ZXVlcwpbNTY3NzAu
OTEyNjIzXSBpd2x3aWZpIDAwMDA6MDI6MDAuMDogZmFpbCB0byBmbHVzaCBhbGwgdHggZmlmbyBx
dWV1ZXMKWzU2NzczLjkwNjkyNF0gaXdsd2lmaSAwMDAwOjAyOjAwLjA6IGZhaWwgdG8gZmx1c2gg
YWxsIHR4IGZpZm8gcXVldWVzCls1Njc3Ni45MDUyNDBdIGl3bHdpZmkgMDAwMDowMjowMC4wOiBm
YWlsIHRvIGZsdXNoIGFsbCB0eCBmaWZvIHF1ZXVlcwpbNTY3ODEuODk3MDkwXSBpd2x3aWZpIDAw
MDA6MDI6MDAuMDogZmFpbCB0byBmbHVzaCBhbGwgdHggZmlmbyBxdWV1ZXMKWzU2ODY5Ljc5Mjc3
MF0gaXdsd2lmaSAwMDAwOjAyOjAwLjA6IGZhaWwgdG8gZmx1c2ggYWxsIHR4IGZpZm8gcXVldWVz
Cls1NjkwMC43NDY2NzFdIGl3bHdpZmkgMDAwMDowMjowMC4wOiBmYWlsIHRvIGZsdXNoIGFsbCB0
eCBmaWZvIHF1ZXVlcwpbNTY5MDMuNzQ3MDI0XSBpd2x3aWZpIDAwMDA6MDI6MDAuMDogZmFpbCB0
byBmbHVzaCBhbGwgdHggZmlmbyBxdWV1ZXMKWzU2OTM0LjcwMzc5MF0gaXdsd2lmaSAwMDAwOjAy
OjAwLjA6IGZhaWwgdG8gZmx1c2ggYWxsIHR4IGZpZm8gcXVldWVzCls1NzA0OC41NjM1NTldIGl3
bHdpZmkgMDAwMDowMjowMC4wOiBmYWlsIHRvIGZsdXNoIGFsbCB0eCBmaWZvIHF1ZXVlcwpbNTcx
MTQuNDkwMzc1XSBpd2x3aWZpIDAwMDA6MDI6MDAuMDogZmFpbCB0byBmbHVzaCBhbGwgdHggZmlm
byBxdWV1ZXMKWzU3MTIzLjQ3MjMxNl0gaXdsd2lmaSAwMDAwOjAyOjAwLjA6IGZhaWwgdG8gZmx1
c2ggYWxsIHR4IGZpZm8gcXVldWVzCls1NzEyNy40NzE0MzFdIGl3bHdpZmkgMDAwMDowMjowMC4w
OiBmYWlsIHRvIGZsdXNoIGFsbCB0eCBmaWZvIHF1ZXVlcwpbNTcxMzIuNDYxMjQ0XSBpd2x3aWZp
IDAwMDA6MDI6MDAuMDogZmFpbCB0byBmbHVzaCBhbGwgdHggZmlmbyBxdWV1ZXMKWzU3MjA0LjM3
MjY3Nl0gaXdsd2lmaSAwMDAwOjAyOjAwLjA6IGZhaWwgdG8gZmx1c2ggYWxsIHR4IGZpZm8gcXVl
dWVzCls1NzIyNi4zNDQ1NThdIGl3bHdpZmkgMDAwMDowMjowMC4wOiBmYWlsIHRvIGZsdXNoIGFs
bCB0eCBmaWZvIHF1ZXVlcwpbNTczOTAuNDY0MzgxXSBpd2x3aWZpIDAwMDA6MDI6MDAuMDogZmFp
bCB0byBmbHVzaCBhbGwgdHggZmlmbyBxdWV1ZXMKWzU3NDM0LjA4NDY5Nl0gaXdsd2lmaSAwMDAw
OjAyOjAwLjA6IGZhaWwgdG8gZmx1c2ggYWxsIHR4IGZpZm8gcXVldWVzCls1NzYzMS40Mjk0ODRd
IGl3bHdpZmkgMDAwMDowMjowMC4wOiBmYWlsIHRvIGZsdXNoIGFsbCB0eCBmaWZvIHF1ZXVlcwpb
NTc3NTMuOTY3ODU5XSBpd2x3aWZpIDAwMDA6MDI6MDAuMDogZmFpbCB0byBmbHVzaCBhbGwgdHgg
ZmlmbyBxdWV1ZXMKWzU3ODcwLjI0NjMyMV0gaXdsd2lmaSAwMDAwOjAyOjAwLjA6IGZhaWwgdG8g
Zmx1c2ggYWxsIHR4IGZpZm8gcXVldWVzCls1Nzk0MS40NTM2MjhdIGl3bHdpZmkgMDAwMDowMjow
MC4wOiBmYWlsIHRvIGZsdXNoIGFsbCB0eCBmaWZvIHF1ZXVlcwpbNTgwNzMuODc5MzYxXSBhdGEx
LjAwOiBjb25maWd1cmVkIGZvciBVRE1BLzEzMwpbNTgwNzMuODc5MzczXSBhdGExOiBFSCBjb21w
bGV0ZQpbNTgwNzMuODgwMjk3XSBzZCAwOjA6MDowOiBbc2RhXSBXcml0ZSBjYWNoZTogZGlzYWJs
ZWQsIHJlYWQgY2FjaGU6IGVuYWJsZWQsIGRvZXNuJ3Qgc3VwcG9ydCBEUE8gb3IgRlVBCls1ODA3
NC4wNjczMDNdIEVYVDQtZnMgKGRtLTEpOiByZS1tb3VudGVkLiBPcHRzOiBkaXNjYXJkLGNvbW1p
dD02MDAKWzU4MDc0LjEyMzkyOF0gRVhUNC1mcyAoZG0tMCk6IHJlLW1vdW50ZWQuIE9wdHM6IGRp
c2NhcmQsY29tbWl0PTYwMApbNTgwNzQuOTYwOTk4XSBFWFQ0LWZzIChkbS0xKTogcmUtbW91bnRl
ZC4gT3B0czogZGlzY2FyZCxjb21taXQ9NjAwCls1ODA3NS4wMzE4NTRdIEVYVDQtZnMgKGRtLTAp
OiByZS1tb3VudGVkLiBPcHRzOiBkaXNjYXJkLGNvbW1pdD02MDAKWzU4MTA5Ljg3OTE1N10gaXds
d2lmaSAwMDAwOjAyOjAwLjA6IGZhaWwgdG8gZmx1c2ggYWxsIHR4IGZpZm8gcXVldWVzCls1ODEx
OC4yMjc4MDldIGl3bHdpZmkgMDAwMDowMjowMC4wOiBmYWlsIHRvIGZsdXNoIGFsbCB0eCBmaWZv
IHF1ZXVlcwpbNTgxNTguMTg2NTgxXSBpd2x3aWZpIDAwMDA6MDI6MDAuMDogZmFpbCB0byBmbHVz
aCBhbGwgdHggZmlmbyBxdWV1ZXMKWzU4MTk4LjQ4NjYxM10gQ1BVMDogUGFja2FnZSBwb3dlciBs
aW1pdCBub3RpZmljYXRpb24gKHRvdGFsIGV2ZW50cyA9IDEwNjYxNykKWzU4MTk4LjQ4NjYxNl0g
Q1BVMzogUGFja2FnZSBwb3dlciBsaW1pdCBub3RpZmljYXRpb24gKHRvdGFsIGV2ZW50cyA9IDEw
NjYxOSkKWzU4MTk4LjQ4NjYxOF0gQ1BVMjogUGFja2FnZSBwb3dlciBsaW1pdCBub3RpZmljYXRp
b24gKHRvdGFsIGV2ZW50cyA9IDEwNjYyMSkKWzU4MTk4LjQ4NjYyMF0gQ1BVMTogUGFja2FnZSBw
b3dlciBsaW1pdCBub3RpZmljYXRpb24gKHRvdGFsIGV2ZW50cyA9IDEwNjYxOSkKWzU4MTk4LjQ5
MDQ5NF0gQ1BVMDogUGFja2FnZSBwb3dlciBsaW1pdCBub3JtYWwKWzU4MTk4LjQ5MDQ5Nl0gQ1BV
MjogUGFja2FnZSBwb3dlciBsaW1pdCBub3JtYWwKWzU4MTk4LjQ5MDQ5OF0gQ1BVMzogUGFja2Fn
ZSBwb3dlciBsaW1pdCBub3JtYWwKWzU4MTk4LjQ5MDQ5OV0gQ1BVMTogUGFja2FnZSBwb3dlciBs
aW1pdCBub3JtYWwKWzU4NTMwLjY5OTA4OF0gQ1BVMzogUGFja2FnZSBwb3dlciBsaW1pdCBub3Rp
ZmljYXRpb24gKHRvdGFsIGV2ZW50cyA9IDEwNjYyMSkKWzU4NTMwLjY5OTA5MF0gQ1BVMTogUGFj
a2FnZSBwb3dlciBsaW1pdCBub3RpZmljYXRpb24gKHRvdGFsIGV2ZW50cyA9IDEwNjYyMSkKWzU4
NTMwLjY5OTA5Ml0gQ1BVMDogUGFja2FnZSBwb3dlciBsaW1pdCBub3RpZmljYXRpb24gKHRvdGFs
IGV2ZW50cyA9IDEwNjYxOSkKWzU4NTMwLjY5OTA5NF0gQ1BVMjogUGFja2FnZSBwb3dlciBsaW1p
dCBub3RpZmljYXRpb24gKHRvdGFsIGV2ZW50cyA9IDEwNjYyMykKWzU4NTMwLjcwMjMzMl0gQ1BV
MjogUGFja2FnZSBwb3dlciBsaW1pdCBub3JtYWwKWzU4NTMwLjcwMjMzNF0gQ1BVMDogUGFja2Fn
ZSBwb3dlciBsaW1pdCBub3JtYWwKWzU4NTMwLjcwMjMzNl0gQ1BVMzogUGFja2FnZSBwb3dlciBs
aW1pdCBub3JtYWwKWzU4NTMwLjcwMjMzN10gQ1BVMTogUGFja2FnZSBwb3dlciBsaW1pdCBub3Jt
YWwKWzU4NTg5LjI1NDExNl0gaXdsd2lmaSAwMDAwOjAyOjAwLjA6IGZhaWwgdG8gZmx1c2ggYWxs
IHR4IGZpZm8gcXVldWVzCls1ODY1My41NzAxOTZdIGl3bHdpZmkgMDAwMDowMjowMC4wOiBmYWls
IHRvIGZsdXNoIGFsbCB0eCBmaWZvIHF1ZXVlcwpbNTkwMTIuMTM0MzIwXSBpd2x3aWZpIDAwMDA6
MDI6MDAuMDogZmFpbCB0byBmbHVzaCBhbGwgdHggZmlmbyBxdWV1ZXMKWzU5MTI5LjM3MTUwOF0g
c2QgODowOjA6MDogW3NkYl0gMTU1MjM4NDAgNTEyLWJ5dGUgbG9naWNhbCBibG9ja3M6ICg3Ljk0
IEdCLzcuNDAgR2lCKQpbNTkxMjkuMzcxNjA1XSBzZCA4OjA6MDowOiBbc2RiXSBDYWNoZSBkYXRh
IHVuYXZhaWxhYmxlCls1OTEyOS4zNzE2MDldIHNkIDg6MDowOjA6IFtzZGJdIEFzc3VtaW5nIGRy
aXZlIGNhY2hlOiB3cml0ZSB0aHJvdWdoCls1OTEyOS4zNzMzMjhdIHNkIDg6MDowOjA6IFtzZGJd
IENhY2hlIGRhdGEgdW5hdmFpbGFibGUKWzU5MTI5LjM3MzMzNF0gc2QgODowOjA6MDogW3NkYl0g
QXNzdW1pbmcgZHJpdmUgY2FjaGU6IHdyaXRlIHRocm91Z2gKWzU5MTI5LjM4Mjc4N10gIHNkYjog
c2RiMQpbNTkxMjkuNzU3ODUwXSBGQVQtZnMgKHNkYjEpOiB1dGY4IGlzIG5vdCBhIHJlY29tbWVu
ZGVkIElPIGNoYXJzZXQgZm9yIEZBVCBmaWxlc3lzdGVtcywgZmlsZXN5c3RlbSB3aWxsIGJlIGNh
c2Ugc2Vuc2l0aXZlIQpbNTkyMjUuOTI5MTI5XSBDUFUwOiBQYWNrYWdlIHBvd2VyIGxpbWl0IG5v
dGlmaWNhdGlvbiAodG90YWwgZXZlbnRzID0gMTA2NjIxKQpbNTkyMjUuOTI5MTMyXSBDUFUxOiBQ
YWNrYWdlIHBvd2VyIGxpbWl0IG5vdGlmaWNhdGlvbiAodG90YWwgZXZlbnRzID0gMTA2NjIzKQpb
NTkyMjUuOTI5MTM0XSBDUFUzOiBQYWNrYWdlIHBvd2VyIGxpbWl0IG5vdGlmaWNhdGlvbiAodG90
YWwgZXZlbnRzID0gMTA2NjIzKQpbNTkyMjUuOTI5MTM2XSBDUFUyOiBQYWNrYWdlIHBvd2VyIGxp
bWl0IG5vdGlmaWNhdGlvbiAodG90YWwgZXZlbnRzID0gMTA2NjI1KQpbNTkyMjUuOTM0MzMyXSBD
UFUwOiBQYWNrYWdlIHBvd2VyIGxpbWl0IG5vcm1hbApbNTkyMjUuOTM0MzM0XSBDUFUyOiBQYWNr
YWdlIHBvd2VyIGxpbWl0IG5vcm1hbApbNTkyMjUuOTM0MzM2XSBDUFUxOiBQYWNrYWdlIHBvd2Vy
IGxpbWl0IG5vcm1hbApbNTkyMjUuOTM0MzM4XSBDUFUzOiBQYWNrYWdlIHBvd2VyIGxpbWl0IG5v
cm1hbApbNTkyNDEuMDMxNTM5XSBzZGI6IGRldGVjdGVkIGNhcGFjaXR5IGNoYW5nZSBmcm9tIDc5
NDgyMDYwODAgdG8gMApbNjAxNTEuNjM3OTM4XSBpd2x3aWZpIDAwMDA6MDI6MDAuMDogZmFpbCB0
byBmbHVzaCBhbGwgdHggZmlmbyBxdWV1ZXMKWzYwMjM4Ljc0MzY0MF0gYXRhMS4wMDogY29uZmln
dXJlZCBmb3IgVURNQS8xMzMKWzYwMjM4Ljc0MzY1NV0gYXRhMTogRUggY29tcGxldGUKWzYwMjM4
Ljc0NDE3MV0gc2QgMDowOjA6MDogW3NkYV0gV3JpdGUgY2FjaGU6IGVuYWJsZWQsIHJlYWQgY2Fj
aGU6IGVuYWJsZWQsIGRvZXNuJ3Qgc3VwcG9ydCBEUE8gb3IgRlVBCls2MDIzOS44NTk4MzNdIEVY
VDQtZnMgKGRtLTEpOiByZS1tb3VudGVkLiBPcHRzOiBkaXNjYXJkLGNvbW1pdD0wCls2MDIzOS44
ODc0NDRdIEVYVDQtZnMgKGRtLTApOiByZS1tb3VudGVkLiBPcHRzOiBkaXNjYXJkLGNvbW1pdD0w
Cls2MDI0MC43NDUxMTFdIEVYVDQtZnMgKGRtLTEpOiByZS1tb3VudGVkLiBPcHRzOiBkaXNjYXJk
LGNvbW1pdD0wCls2MDI0MC44NjA1OTJdIEVYVDQtZnMgKGRtLTApOiByZS1tb3VudGVkLiBPcHRz
OiBkaXNjYXJkLGNvbW1pdD0wCls2MDI0MS4xOTE5MzVdIGVoY2ktcGNpIDAwMDA6MDA6MWQuMDog
c2V0dGluZyBsYXRlbmN5IHRpbWVyIHRvIDY0Cls2MDI1OS42MDMyNTBdIGl3bHdpZmkgMDAwMDow
MjowMC4wOiBmYWlsIHRvIGZsdXNoIGFsbCB0eCBmaWZvIHF1ZXVlcwpbNjAyNjkuOTc3NDMzXSBp
d2x3aWZpIDAwMDA6MDI6MDAuMDogZmFpbCB0byBmbHVzaCBhbGwgdHggZmlmbyBxdWV1ZXMKWzYw
MzUxLjQ4NzAwOF0gZ3JzZWM6IGRlbmllZCBSV1ggbW1hcCBvZiA8YW5vbnltb3VzIG1hcHBpbmc+
IGJ5IC91c3IvbGliNjQvZmlyZWZveC9maXJlZm94W2ZpcmVmb3g6OTQ1N10gdWlkL2V1aWQ6MTAw
MC8xMDAwIGdpZC9lZ2lkOjEwMDEvMTAwMSwgcGFyZW50IC91c3IvYmluL2dub21lLXNoZWxsW2du
b21lLXNoZWxsOjEyNTg5XSB1aWQvZXVpZDoxMDAwLzEwMDAgZ2lkL2VnaWQ6MTAwMS8xMDAxCls2
MDM4Ny4yODU0MDJdIGl3bHdpZmkgMDAwMDowMjowMC4wOiBmYWlsIHRvIGZsdXNoIGFsbCB0eCBm
aWZvIHF1ZXVlcwpbNjA2MjYuODMyMjY0XSBpd2x3aWZpIDAwMDA6MDI6MDAuMDogZmFpbCB0byBm
bHVzaCBhbGwgdHggZmlmbyBxdWV1ZXMKWzYxMjAzLjQ1MzQxM10gaXdsd2lmaSAwMDAwOjAyOjAw
LjA6IGZhaWwgdG8gZmx1c2ggYWxsIHR4IGZpZm8gcXVldWVzCls2MTI3Ny40NzU1NjZdIENQVTE6
IFBhY2thZ2UgcG93ZXIgbGltaXQgbm90aWZpY2F0aW9uICh0b3RhbCBldmVudHMgPSAxMDY3MjIp
Cls2MTI3Ny40NzU1NjldIENQVTI6IFBhY2thZ2UgcG93ZXIgbGltaXQgbm90aWZpY2F0aW9uICh0
b3RhbCBldmVudHMgPSAxMDY3MjQpCls2MTI3Ny40NzU1NzFdIENQVTA6IFBhY2thZ2UgcG93ZXIg
bGltaXQgbm90aWZpY2F0aW9uICh0b3RhbCBldmVudHMgPSAxMDY3MjApCls2MTI3Ny40NzU1NzNd
IENQVTM6IFBhY2thZ2UgcG93ZXIgbGltaXQgbm90aWZpY2F0aW9uICh0b3RhbCBldmVudHMgPSAx
MDY3MjIpCls2MTI3Ny40ODY1NjldIENQVTI6IFBhY2thZ2UgcG93ZXIgbGltaXQgbm9ybWFsCls2
MTI3Ny40ODY1NzJdIENQVTE6IFBhY2thZ2UgcG93ZXIgbGltaXQgbm9ybWFsCls2MTI3Ny40ODY1
NzRdIENQVTA6IFBhY2thZ2UgcG93ZXIgbGltaXQgbm9ybWFsCls2MTI3Ny40ODY1NzddIENQVTM6
IFBhY2thZ2UgcG93ZXIgbGltaXQgbm9ybWFsCls2MTQyMS45NzY3OThdIHNkIDg6MDowOjA6IFtz
ZGJdIDE1NTIzODQwIDUxMi1ieXRlIGxvZ2ljYWwgYmxvY2tzOiAoNy45NCBHQi83LjQwIEdpQikK
WzYxNDIxLjk3Njg0M10gc2QgODowOjA6MDogW3NkYl0gQ2FjaGUgZGF0YSB1bmF2YWlsYWJsZQpb
NjE0MjEuOTc2ODQ2XSBzZCA4OjA6MDowOiBbc2RiXSBBc3N1bWluZyBkcml2ZSBjYWNoZTogd3Jp
dGUgdGhyb3VnaApbNjE0MjEuOTc4ODE4XSBzZCA4OjA6MDowOiBbc2RiXSBDYWNoZSBkYXRhIHVu
YXZhaWxhYmxlCls2MTQyMS45Nzg4MjBdIHNkIDg6MDowOjA6IFtzZGJdIEFzc3VtaW5nIGRyaXZl
IGNhY2hlOiB3cml0ZSB0aHJvdWdoCls2MTQyMS45ODgxNjJdICBzZGI6IHNkYjEKWzYxNDIyLjQx
MjQ5N10gRkFULWZzIChzZGIxKTogdXRmOCBpcyBub3QgYSByZWNvbW1lbmRlZCBJTyBjaGFyc2V0
IGZvciBGQVQgZmlsZXN5c3RlbXMsIGZpbGVzeXN0ZW0gd2lsbCBiZSBjYXNlIHNlbnNpdGl2ZSEK
WzYxNTA3LjE1NTY4NF0gaXdsd2lmaSAwMDAwOjAyOjAwLjA6IGZhaWwgdG8gZmx1c2ggYWxsIHR4
IGZpZm8gcXVldWVzCls2MTcwNy45ODczMDBdIGl3bHdpZmkgMDAwMDowMjowMC4wOiBmYWlsIHRv
IGZsdXNoIGFsbCB0eCBmaWZvIHF1ZXVlcwpbNjIwNDUuNTAzMzg3XSBpd2x3aWZpIDAwMDA6MDI6
MDAuMDogZmFpbCB0byBmbHVzaCBhbGwgdHggZmlmbyBxdWV1ZXMKWzYyMDg5LjIzMTYwOV0gQ1BV
MTogUGFja2FnZSBwb3dlciBsaW1pdCBub3RpZmljYXRpb24gKHRvdGFsIGV2ZW50cyA9IDEwNjcy
MykKWzYyMDg5LjIzMTYxMl0gQ1BVMzogUGFja2FnZSBwb3dlciBsaW1pdCBub3RpZmljYXRpb24g
KHRvdGFsIGV2ZW50cyA9IDEwNjcyMykKWzYyMDg5LjIzMTYxNl0gQ1BVMjogUGFja2FnZSBwb3dl
ciBsaW1pdCBub3RpZmljYXRpb24gKHRvdGFsIGV2ZW50cyA9IDEwNjcyNSkKWzYyMDg5LjIzMTYx
OF0gQ1BVMDogUGFja2FnZSBwb3dlciBsaW1pdCBub3RpZmljYXRpb24gKHRvdGFsIGV2ZW50cyA9
IDEwNjcyMSkKWzYyMDg5LjIzMTgwMV0gQ1BVMDogUGFja2FnZSBwb3dlciBsaW1pdCBub3JtYWwK
WzYyMDg5LjIzMTgwMl0gQ1BVMjogUGFja2FnZSBwb3dlciBsaW1pdCBub3JtYWwKWzYyMDg5LjIz
MTgwNF0gQ1BVMTogUGFja2FnZSBwb3dlciBsaW1pdCBub3JtYWwKWzYyMDg5LjIzMTgwNF0gQ1BV
MzogUGFja2FnZSBwb3dlciBsaW1pdCBub3JtYWwKWzYyMjIwLjI4MjY1OF0gaXdsd2lmaSAwMDAw
OjAyOjAwLjA6IGZhaWwgdG8gZmx1c2ggYWxsIHR4IGZpZm8gcXVldWVzCls2MjIyMy4yODQxMDNd
IGl3bHdpZmkgMDAwMDowMjowMC4wOiBmYWlsIHRvIGZsdXNoIGFsbCB0eCBmaWZvIHF1ZXVlcwpb
NjIzOTguMDY3MTYwXSBpd2x3aWZpIDAwMDA6MDI6MDAuMDogZmFpbCB0byBmbHVzaCBhbGwgdHgg
ZmlmbyBxdWV1ZXMKWzYyNDA2LjA1NjQwMl0gaXdsd2lmaSAwMDAwOjAyOjAwLjA6IGZhaWwgdG8g
Zmx1c2ggYWxsIHR4IGZpZm8gcXVldWVzCls2MjQwOS4wNTk3NTZdIGl3bHdpZmkgMDAwMDowMjow
MC4wOiBmYWlsIHRvIGZsdXNoIGFsbCB0eCBmaWZvIHF1ZXVlcwpbNjI0MTIuMDUwMDkxXSBpd2x3
aWZpIDAwMDA6MDI6MDAuMDogZmFpbCB0byBmbHVzaCBhbGwgdHggZmlmbyBxdWV1ZXMKWzYyNDE3
LjA1MjAwM10gaXdsd2lmaSAwMDAwOjAyOjAwLjA6IGZhaWwgdG8gZmx1c2ggYWxsIHR4IGZpZm8g
cXVldWVzCls2Mjc0Ni40NTE4OTldIHNkYjogZGV0ZWN0ZWQgY2FwYWNpdHkgY2hhbmdlIGZyb20g
Nzk0ODIwNjA4MCB0byAwCls2Mjc1NS42Mzk2MTZdIGl3bHdpZmkgMDAwMDowMjowMC4wOiBmYWls
IHRvIGZsdXNoIGFsbCB0eCBmaWZvIHF1ZXVlcwpbNjI4MzQuODY2MDUwXSBzZCA4OjA6MDowOiBb
c2RiXSAxNTUyMzg0MCA1MTItYnl0ZSBsb2dpY2FsIGJsb2NrczogKDcuOTQgR0IvNy40MCBHaUIp
Cls2MjgzNC44NjYyNTZdIHNkIDg6MDowOjA6IFtzZGJdIENhY2hlIGRhdGEgdW5hdmFpbGFibGUK
WzYyODM0Ljg2NjI1OF0gc2QgODowOjA6MDogW3NkYl0gQXNzdW1pbmcgZHJpdmUgY2FjaGU6IHdy
aXRlIHRocm91Z2gKWzYyODM0Ljg2ODc0MV0gc2QgODowOjA6MDogW3NkYl0gQ2FjaGUgZGF0YSB1
bmF2YWlsYWJsZQpbNjI4MzQuODY4NzQ5XSBzZCA4OjA6MDowOiBbc2RiXSBBc3N1bWluZyBkcml2
ZSBjYWNoZTogd3JpdGUgdGhyb3VnaApbNjI4MzQuODc3ODY5XSAgc2RiOiBzZGIxCls2MjgzNS4x
ODg1MTJdIEZBVC1mcyAoc2RiMSk6IHV0ZjggaXMgbm90IGEgcmVjb21tZW5kZWQgSU8gY2hhcnNl
dCBmb3IgRkFUIGZpbGVzeXN0ZW1zLCBmaWxlc3lzdGVtIHdpbGwgYmUgY2FzZSBzZW5zaXRpdmUh
Cls2Mjg0OS4yMDM0MzNdIHNkYjogZGV0ZWN0ZWQgY2FwYWNpdHkgY2hhbmdlIGZyb20gNzk0ODIw
NjA4MCB0byAwCls2MzQ3MS43NjE5MTddIGl3bHdpZmkgMDAwMDowMjowMC4wOiBmYWlsIHRvIGZs
dXNoIGFsbCB0eCBmaWZvIHF1ZXVlcwpbNjM1MDMuMjU1NTI5XSBpd2x3aWZpIDAwMDA6MDI6MDAu
MDogZmFpbCB0byBmbHVzaCBhbGwgdHggZmlmbyBxdWV1ZXMKWzYzNjIzLjk0MDMyM10gaXdsd2lm
aSAwMDAwOjAyOjAwLjA6IGZhaWwgdG8gZmx1c2ggYWxsIHR4IGZpZm8gcXVldWVzCls2MzY1MS41
Mzk4MTBdIGl3bHdpZmkgMDAwMDowMjowMC4wOiBmYWlsIHRvIGZsdXNoIGFsbCB0eCBmaWZvIHF1
ZXVlcwpbNjM3NDMuMDk5MzY1XSBpd2x3aWZpIDAwMDA6MDI6MDAuMDogZmFpbCB0byBmbHVzaCBh
bGwgdHggZmlmbyBxdWV1ZXMKWzYzODI2LjMzMTAwNl0gaXdsd2lmaSAwMDAwOjAyOjAwLjA6IGZh
aWwgdG8gZmx1c2ggYWxsIHR4IGZpZm8gcXVldWVzCls2MzkyNi4yMDk1NjNdIGl3bHdpZmkgMDAw
MDowMjowMC4wOiBmYWlsIHRvIGZsdXNoIGFsbCB0eCBmaWZvIHF1ZXVlcwpbNjM5MjkuMjA1ODUw
XSBpd2x3aWZpIDAwMDA6MDI6MDAuMDogZmFpbCB0byBmbHVzaCBhbGwgdHggZmlmbyBxdWV1ZXMK
WzYzOTM2LjE5OTM1NF0gaXdsd2lmaSAwMDAwOjAyOjAwLjA6IGZhaWwgdG8gZmx1c2ggYWxsIHR4
IGZpZm8gcXVldWVzCls2NDAwNC4xMTQ2MzddIGl3bHdpZmkgMDAwMDowMjowMC4wOiBmYWlsIHRv
IGZsdXNoIGFsbCB0eCBmaWZvIHF1ZXVlcwpbNjQwMDcuMTEzMDgxXSBpd2x3aWZpIDAwMDA6MDI6
MDAuMDogZmFpbCB0byBmbHVzaCBhbGwgdHggZmlmbyBxdWV1ZXMKWzY0MDEwLjEwNzQzMl0gaXds
d2lmaSAwMDAwOjAyOjAwLjA6IGZhaWwgdG8gZmx1c2ggYWxsIHR4IGZpZm8gcXVldWVzCls2NDA1
MC4wNTQ3MzldIGl3bHdpZmkgMDAwMDowMjowMC4wOiBmYWlsIHRvIGZsdXNoIGFsbCB0eCBmaWZv
IHF1ZXVlcwpbNjQwNTYuMDQ3NDc3XSBpd2x3aWZpIDAwMDA6MDI6MDAuMDogZmFpbCB0byBmbHVz
aCBhbGwgdHggZmlmbyBxdWV1ZXMKWzY0MDYzLjAzODk2N10gaXdsd2lmaSAwMDAwOjAyOjAwLjA6
IGZhaWwgdG8gZmx1c2ggYWxsIHR4IGZpZm8gcXVldWVzCls2NDEwOS45ODc4NTBdIGl3bHdpZmkg
MDAwMDowMjowMC4wOiBmYWlsIHRvIGZsdXNoIGFsbCB0eCBmaWZvIHF1ZXVlcwpbNjQxMTkuOTcz
NTg5XSBpd2x3aWZpIDAwMDA6MDI6MDAuMDogZmFpbCB0byBmbHVzaCBhbGwgdHggZmlmbyBxdWV1
ZXMKWzY0MTI3Ljk1ODkwNV0gaXdsd2lmaSAwMDAwOjAyOjAwLjA6IGZhaWwgdG8gZmx1c2ggYWxs
IHR4IGZpZm8gcXVldWVzCls2NDE4MS44OTQyMjBdIGl3bHdpZmkgMDAwMDowMjowMC4wOiBmYWls
IHRvIGZsdXNoIGFsbCB0eCBmaWZvIHF1ZXVlcwpbNjQxODQuODk1NjQ5XSBpd2x3aWZpIDAwMDA6
MDI6MDAuMDogZmFpbCB0byBmbHVzaCBhbGwgdHggZmlmbyBxdWV1ZXMKWzY0MTg4Ljg5Mjc0N10g
aXdsd2lmaSAwMDAwOjAyOjAwLjA6IGZhaWwgdG8gZmx1c2ggYWxsIHR4IGZpZm8gcXVldWVzCls2
NDIzMC44MzQ2ODRdIGl3bHdpZmkgMDAwMDowMjowMC4wOiBmYWlsIHRvIGZsdXNoIGFsbCB0eCBm
aWZvIHF1ZXVlcwpbNjQyMzMuODMwOTg2XSBpd2x3aWZpIDAwMDA6MDI6MDAuMDogZmFpbCB0byBm
bHVzaCBhbGwgdHggZmlmbyBxdWV1ZXMKWzY0MzAwLjc1MzU5OF0gaXdsd2lmaSAwMDAwOjAyOjAw
LjA6IGZhaWwgdG8gZmx1c2ggYWxsIHR4IGZpZm8gcXVldWVzCls2NDMyNi43MjU4ODldIGl3bHdp
ZmkgMDAwMDowMjowMC4wOiBmYWlsIHRvIGZsdXNoIGFsbCB0eCBmaWZvIHF1ZXVlcwpbNjQzMjku
NzE0Mjk3XSBpd2x3aWZpIDAwMDA6MDI6MDAuMDogZmFpbCB0byBmbHVzaCBhbGwgdHggZmlmbyBx
dWV1ZXMKWzY0MzUxLjY4NzU1OF0gaXdsd2lmaSAwMDAwOjAyOjAwLjA6IGZhaWwgdG8gZmx1c2gg
YWxsIHR4IGZpZm8gcXVldWVzCls2NDM5MS42NDY4MzhdIGl3bHdpZmkgMDAwMDowMjowMC4wOiBm
YWlsIHRvIGZsdXNoIGFsbCB0eCBmaWZvIHF1ZXVlcwpbNjQzOTQuNjM1MjUyXSBpd2x3aWZpIDAw
MDA6MDI6MDAuMDogZmFpbCB0byBmbHVzaCBhbGwgdHggZmlmbyBxdWV1ZXMKWzY0Mzk4LjYzMDM2
MF0gaXdsd2lmaSAwMDAwOjAyOjAwLjA6IGZhaWwgdG8gZmx1c2ggYWxsIHR4IGZpZm8gcXVldWVz
Cls2NDQyMi42MDUyMTNdIGl3bHdpZmkgMDAwMDowMjowMC4wOiBmYWlsIHRvIGZsdXNoIGFsbCB0
eCBmaWZvIHF1ZXVlcwpbNjQ0ODMuNTI2OTUyXSBpd2x3aWZpIDAwMDA6MDI6MDAuMDogZmFpbCB0
byBmbHVzaCBhbGwgdHggZmlmbyBxdWV1ZXMKWzY0NTA3LjQ5NzgzN10gaXdsd2lmaSAwMDAwOjAy
OjAwLjA6IGZhaWwgdG8gZmx1c2ggYWxsIHR4IGZpZm8gcXVldWVzCls2NDUyNS40NzU5MzBdIGl3
bHdpZmkgMDAwMDowMjowMC4wOiBmYWlsIHRvIGZsdXNoIGFsbCB0eCBmaWZvIHF1ZXVlcwpbNjQ1
NDMuNDU3OTkwXSBpd2x3aWZpIDAwMDA6MDI6MDAuMDogZmFpbCB0byBmbHVzaCBhbGwgdHggZmlm
byBxdWV1ZXMKWzY0NTU5LjQzNDUxMl0gaXdsd2lmaSAwMDAwOjAyOjAwLjA6IGZhaWwgdG8gZmx1
c2ggYWxsIHR4IGZpZm8gcXVldWVzCls2NDYwMi4zODEyNTFdIGl3bHdpZmkgMDAwMDowMjowMC4w
OiBmYWlsIHRvIGZsdXNoIGFsbCB0eCBmaWZvIHF1ZXVlcwpbNjQ2MjQuMzU1NDc1XSBpd2x3aWZp
IDAwMDA6MDI6MDAuMDogZmFpbCB0byBmbHVzaCBhbGwgdHggZmlmbyBxdWV1ZXMKWzY1MzAxLjE4
MDQxMF0gaXdsd2lmaSAwMDAwOjAyOjAwLjA6IGZhaWwgdG8gZmx1c2ggYWxsIHR4IGZpZm8gcXVl
dWVzCls2OTU2OS40MDQ5MDhdIGdyc2VjOiBkZW5pZWQgcmVzb3VyY2Ugb3ZlcnN0ZXAgYnkgcmVx
dWVzdGluZyAzMCBmb3IgUkxJTUlUX05JQ0UgYWdhaW5zdCBsaW1pdCAwIGZvciAvdXNyL2xpYjY0
L2Nocm9taXVtLWJyb3dzZXIvY2hyb21lW0Nocm9tZV9DaGlsZElPVDoxOTQyMV0gdWlkL2V1aWQ6
MTAwMC8xMDAwIGdpZC9lZ2lkOjEwMDEvMTAwMSwgcGFyZW50IC91c3IvbGliNjQvY2hyb21pdW0t
YnJvd3Nlci9jaHJvbWVbY2hyb21lOjMxMzQ4XSB1aWQvZXVpZDoxMDAwLzEwMDAgZ2lkL2VnaWQ6
MTAwMS8xMDAxCls2OTU2OS41NDg0MzddIGdyc2VjOiBkZW5pZWQgcmVzb3VyY2Ugb3ZlcnN0ZXAg
YnkgcmVxdWVzdGluZyAzMCBmb3IgUkxJTUlUX05JQ0UgYWdhaW5zdCBsaW1pdCAwIGZvciAvdXNy
L2xpYjY0L2Nocm9taXVtLWJyb3dzZXIvY2hyb21lW0Nocm9tZV9DaGlsZElPVDoxOTQyMV0gdWlk
L2V1aWQ6MTAwMC8xMDAwIGdpZC9lZ2lkOjEwMDEvMTAwMSwgcGFyZW50IC91c3IvbGliNjQvY2hy
b21pdW0tYnJvd3Nlci9jaHJvbWVbY2hyb21lOjMxMzQ4XSB1aWQvZXVpZDoxMDAwLzEwMDAgZ2lk
L2VnaWQ6MTAwMS8xMDAxCls2OTU3MC43MDQzMTJdIGdyc2VjOiBkZW5pZWQgcmVzb3VyY2Ugb3Zl
cnN0ZXAgYnkgcmVxdWVzdGluZyAzMCBmb3IgUkxJTUlUX05JQ0UgYWdhaW5zdCBsaW1pdCAwIGZv
ciAvdXNyL2xpYjY0L2Nocm9taXVtLWJyb3dzZXIvY2hyb21lW0Nocm9tZV9DaGlsZElPVDoxOTQy
MV0gdWlkL2V1aWQ6MTAwMC8xMDAwIGdpZC9lZ2lkOjEwMDEvMTAwMSwgcGFyZW50IC91c3IvbGli
NjQvY2hyb21pdW0tYnJvd3Nlci9jaHJvbWVbY2hyb21lOjMxMzQ4XSB1aWQvZXVpZDoxMDAwLzEw
MDAgZ2lkL2VnaWQ6MTAwMS8xMDAxCls2OTU5OC42MDYwNjhdIGdyc2VjOiBkZW5pZWQgcmVzb3Vy
Y2Ugb3ZlcnN0ZXAgYnkgcmVxdWVzdGluZyAzMCBmb3IgUkxJTUlUX05JQ0UgYWdhaW5zdCBsaW1p
dCAwIGZvciAvdXNyL2xpYjY0L2Nocm9taXVtLWJyb3dzZXIvY2hyb21lW0Nocm9tZV9DaGlsZElP
VDoxOTQyMV0gdWlkL2V1aWQ6MTAwMC8xMDAwIGdpZC9lZ2lkOjEwMDEvMTAwMSwgcGFyZW50IC91
c3IvbGliNjQvY2hyb21pdW0tYnJvd3Nlci9jaHJvbWVbY2hyb21lOjMxMzQ4XSB1aWQvZXVpZDox
MDAwLzEwMDAgZ2lkL2VnaWQ6MTAwMS8xMDAxCls2OTU5OC42MDYyMDZdIGdyc2VjOiBkZW5pZWQg
cmVzb3VyY2Ugb3ZlcnN0ZXAgYnkgcmVxdWVzdGluZyAzMCBmb3IgUkxJTUlUX05JQ0UgYWdhaW5z
dCBsaW1pdCAwIGZvciAvdXNyL2xpYjY0L2Nocm9taXVtLWJyb3dzZXIvY2hyb21lW0Nocm9tZV9D
aGlsZElPVDoxOTQyMV0gdWlkL2V1aWQ6MTAwMC8xMDAwIGdpZC9lZ2lkOjEwMDEvMTAwMSwgcGFy
ZW50IC91c3IvbGliNjQvY2hyb21pdW0tYnJvd3Nlci9jaHJvbWVbY2hyb21lOjMxMzQ4XSB1aWQv
ZXVpZDoxMDAwLzEwMDAgZ2lkL2VnaWQ6MTAwMS8xMDAxCls2OTcxMC42MzI0NzVdIGdyc2VjOiBk
ZW5pZWQgcmVzb3VyY2Ugb3ZlcnN0ZXAgYnkgcmVxdWVzdGluZyAzMCBmb3IgUkxJTUlUX05JQ0Ug
YWdhaW5zdCBsaW1pdCAwIGZvciAvdXNyL2xpYjY0L2Nocm9taXVtLWJyb3dzZXIvY2hyb21lW0No
cm9tZV9DaGlsZElPVDoxOTQyMV0gdWlkL2V1aWQ6MTAwMC8xMDAwIGdpZC9lZ2lkOjEwMDEvMTAw
MSwgcGFyZW50IC91c3IvbGliNjQvY2hyb21pdW0tYnJvd3Nlci9jaHJvbWVbY2hyb21lOjMxMzQ4
XSB1aWQvZXVpZDoxMDAwLzEwMDAgZ2lkL2VnaWQ6MTAwMS8xMDAxCls2OTcxMC42MzkzMTldIGdy
c2VjOiBkZW5pZWQgcmVzb3VyY2Ugb3ZlcnN0ZXAgYnkgcmVxdWVzdGluZyAzMCBmb3IgUkxJTUlU
X05JQ0UgYWdhaW5zdCBsaW1pdCAwIGZvciAvdXNyL2xpYjY0L2Nocm9taXVtLWJyb3dzZXIvY2hy
b21lW0Nocm9tZV9DaGlsZElPVDoxOTQyMV0gdWlkL2V1aWQ6MTAwMC8xMDAwIGdpZC9lZ2lkOjEw
MDEvMTAwMSwgcGFyZW50IC91c3IvbGliNjQvY2hyb21pdW0tYnJvd3Nlci9jaHJvbWVbY2hyb21l
OjMxMzQ4XSB1aWQvZXVpZDoxMDAwLzEwMDAgZ2lkL2VnaWQ6MTAwMS8xMDAxCls2OTc5NS40NzI1
NTJdIGdyc2VjOiBkZW5pZWQgcmVzb3VyY2Ugb3ZlcnN0ZXAgYnkgcmVxdWVzdGluZyAzMCBmb3Ig
UkxJTUlUX05JQ0UgYWdhaW5zdCBsaW1pdCAwIGZvciAvdXNyL2xpYjY0L2Nocm9taXVtLWJyb3dz
ZXIvY2hyb21lW0Nocm9tZV9DaGlsZElPVDoxOTQyMV0gdWlkL2V1aWQ6MTAwMC8xMDAwIGdpZC9l
Z2lkOjEwMDEvMTAwMSwgcGFyZW50IC91c3IvbGliNjQvY2hyb21pdW0tYnJvd3Nlci9jaHJvbWVb
Y2hyb21lOjMxMzQ4XSB1aWQvZXVpZDoxMDAwLzEwMDAgZ2lkL2VnaWQ6MTAwMS8xMDAxCls2OTgy
MC4yNDI1MTBdIENQVTI6IFBhY2thZ2UgcG93ZXIgbGltaXQgbm90aWZpY2F0aW9uICh0b3RhbCBl
dmVudHMgPSAxMDY3MjcpCls2OTgyMC4yNDI1MTNdIENQVTM6IFBhY2thZ2UgcG93ZXIgbGltaXQg
bm90aWZpY2F0aW9uICh0b3RhbCBldmVudHMgPSAxMDY3MjUpCls2OTgyMC4yNDI1MTZdIENQVTE6
IFBhY2thZ2UgcG93ZXIgbGltaXQgbm90aWZpY2F0aW9uICh0b3RhbCBldmVudHMgPSAxMDY3MjUp
Cls2OTgyMC4yNDI1MThdIENQVTA6IFBhY2thZ2UgcG93ZXIgbGltaXQgbm90aWZpY2F0aW9uICh0
b3RhbCBldmVudHMgPSAxMDY3MjMpCls2OTgyMC4yNDQyODJdIENQVTE6IFBhY2thZ2UgcG93ZXIg
bGltaXQgbm9ybWFsCls2OTgyMC4yNDQyODNdIENQVTM6IFBhY2thZ2UgcG93ZXIgbGltaXQgbm9y
bWFsCls2OTgyMC4yNDQzMDRdIENQVTI6IFBhY2thZ2UgcG93ZXIgbGltaXQgbm9ybWFsCls2OTgy
MC4yNDQzMDVdIENQVTA6IFBhY2thZ2UgcG93ZXIgbGltaXQgbm9ybWFsCls3MDA0Mi44Mzc4MTFd
IGdyc2VjOiBkZW5pZWQgcmVzb3VyY2Ugb3ZlcnN0ZXAgYnkgcmVxdWVzdGluZyAzMCBmb3IgUkxJ
TUlUX05JQ0UgYWdhaW5zdCBsaW1pdCAwIGZvciAvdXNyL2xpYjY0L2Nocm9taXVtLWJyb3dzZXIv
Y2hyb21lW0Nocm9tZV9DaGlsZElPVDoxOTU1NF0gdWlkL2V1aWQ6MTAwMC8xMDAwIGdpZC9lZ2lk
OjEwMDEvMTAwMSwgcGFyZW50IC91c3IvbGliNjQvY2hyb21pdW0tYnJvd3Nlci9jaHJvbWVbY2hy
b21lOjMxMzQ4XSB1aWQvZXVpZDoxMDAwLzEwMDAgZ2lkL2VnaWQ6MTAwMS8xMDAxCls3MDA0Mi44
NjMxMzZdIGdyc2VjOiBkZW5pZWQgcmVzb3VyY2Ugb3ZlcnN0ZXAgYnkgcmVxdWVzdGluZyAzMCBm
b3IgUkxJTUlUX05JQ0UgYWdhaW5zdCBsaW1pdCAwIGZvciAvdXNyL2xpYjY0L2Nocm9taXVtLWJy
b3dzZXIvY2hyb21lW0Nocm9tZV9DaGlsZElPVDoxOTU1NF0gdWlkL2V1aWQ6MTAwMC8xMDAwIGdp
ZC9lZ2lkOjEwMDEvMTAwMSwgcGFyZW50IC91c3IvbGliNjQvY2hyb21pdW0tYnJvd3Nlci9jaHJv
bWVbY2hyb21lOjMxMzQ4XSB1aWQvZXVpZDoxMDAwLzEwMDAgZ2lkL2VnaWQ6MTAwMS8xMDAxCls3
MDA0NC42NjE0NDZdIGdyc2VjOiBkZW5pZWQgcmVzb3VyY2Ugb3ZlcnN0ZXAgYnkgcmVxdWVzdGlu
ZyAzMCBmb3IgUkxJTUlUX05JQ0UgYWdhaW5zdCBsaW1pdCAwIGZvciAvdXNyL2xpYjY0L2Nocm9t
aXVtLWJyb3dzZXIvY2hyb21lW0Nocm9tZV9DaGlsZElPVDoxOTU1NF0gdWlkL2V1aWQ6MTAwMC8x
MDAwIGdpZC9lZ2lkOjEwMDEvMTAwMSwgcGFyZW50IC91c3IvbGliNjQvY2hyb21pdW0tYnJvd3Nl
ci9jaHJvbWVbY2hyb21lOjMxMzQ4XSB1aWQvZXVpZDoxMDAwLzEwMDAgZ2lkL2VnaWQ6MTAwMS8x
MDAxCls3MDA1My42NTQ1NjJdIGdyc2VjOiBkZW5pZWQgcmVzb3VyY2Ugb3ZlcnN0ZXAgYnkgcmVx
dWVzdGluZyAzMCBmb3IgUkxJTUlUX05JQ0UgYWdhaW5zdCBsaW1pdCAwIGZvciAvdXNyL2xpYjY0
L2Nocm9taXVtLWJyb3dzZXIvY2hyb21lW0Nocm9tZV9DaGlsZElPVDoxOTU1NF0gdWlkL2V1aWQ6
MTAwMC8xMDAwIGdpZC9lZ2lkOjEwMDEvMTAwMSwgcGFyZW50IC91c3IvbGliNjQvY2hyb21pdW0t
YnJvd3Nlci9jaHJvbWVbY2hyb21lOjMxMzQ4XSB1aWQvZXVpZDoxMDAwLzEwMDAgZ2lkL2VnaWQ6
MTAwMS8xMDAxCls3MDA1My42NTQ2MTBdIGdyc2VjOiBkZW5pZWQgcmVzb3VyY2Ugb3ZlcnN0ZXAg
YnkgcmVxdWVzdGluZyAzMCBmb3IgUkxJTUlUX05JQ0UgYWdhaW5zdCBsaW1pdCAwIGZvciAvdXNy
L2xpYjY0L2Nocm9taXVtLWJyb3dzZXIvY2hyb21lW0Nocm9tZV9DaGlsZElPVDoxOTU1NF0gdWlk
L2V1aWQ6MTAwMC8xMDAwIGdpZC9lZ2lkOjEwMDEvMTAwMSwgcGFyZW50IC91c3IvbGliNjQvY2hy
b21pdW0tYnJvd3Nlci9jaHJvbWVbY2hyb21lOjMxMzQ4XSB1aWQvZXVpZDoxMDAwLzEwMDAgZ2lk
L2VnaWQ6MTAwMS8xMDAxCls3MDIwOC41MTgwMTVdIGdyc2VjOiBkZW5pZWQgcmVzb3VyY2Ugb3Zl
cnN0ZXAgYnkgcmVxdWVzdGluZyAzMCBmb3IgUkxJTUlUX05JQ0UgYWdhaW5zdCBsaW1pdCAwIGZv
ciAvdXNyL2xpYjY0L2Nocm9taXVtLWJyb3dzZXIvY2hyb21lW0Nocm9tZV9DaGlsZElPVDoxOTYw
OV0gdWlkL2V1aWQ6MTAwMC8xMDAwIGdpZC9lZ2lkOjEwMDEvMTAwMSwgcGFyZW50IC91c3IvbGli
NjQvY2hyb21pdW0tYnJvd3Nlci9jaHJvbWVbY2hyb21lOjMxMzQ4XSB1aWQvZXVpZDoxMDAwLzEw
MDAgZ2lkL2VnaWQ6MTAwMS8xMDAxCls3MDIwOC41MTgwOTJdIGdyc2VjOiBkZW5pZWQgcmVzb3Vy
Y2Ugb3ZlcnN0ZXAgYnkgcmVxdWVzdGluZyAzMCBmb3IgUkxJTUlUX05JQ0UgYWdhaW5zdCBsaW1p
dCAwIGZvciAvdXNyL2xpYjY0L2Nocm9taXVtLWJyb3dzZXIvY2hyb21lW0Nocm9tZV9DaGlsZElP
VDoxOTYwOV0gdWlkL2V1aWQ6MTAwMC8xMDAwIGdpZC9lZ2lkOjEwMDEvMTAwMSwgcGFyZW50IC91
c3IvbGliNjQvY2hyb21pdW0tYnJvd3Nlci9jaHJvbWVbY2hyb21lOjMxMzQ4XSB1aWQvZXVpZDox
MDAwLzEwMDAgZ2lkL2VnaWQ6MTAwMS8xMDAxCls3MTI2NC4wNjA1NjFdIGdyc2VjOiBkZW5pZWQg
cmVzb3VyY2Ugb3ZlcnN0ZXAgYnkgcmVxdWVzdGluZyAzMCBmb3IgUkxJTUlUX05JQ0UgYWdhaW5z
dCBsaW1pdCAwIGZvciAvdXNyL2xpYjY0L2Nocm9taXVtLWJyb3dzZXIvY2hyb21lW0Nocm9tZV9D
aGlsZElPVDoyMDA2Ml0gdWlkL2V1aWQ6MTAwMC8xMDAwIGdpZC9lZ2lkOjEwMDEvMTAwMSwgcGFy
ZW50IC91c3IvbGliNjQvY2hyb21pdW0tYnJvd3Nlci9jaHJvbWVbY2hyb21lOjMxMzQ4XSB1aWQv
ZXVpZDoxMDAwLzEwMDAgZ2lkL2VnaWQ6MTAwMS8xMDAxCls3MTI2NC4wNzU5MzNdIGdyc2VjOiBk
ZW5pZWQgcmVzb3VyY2Ugb3ZlcnN0ZXAgYnkgcmVxdWVzdGluZyAzMCBmb3IgUkxJTUlUX05JQ0Ug
YWdhaW5zdCBsaW1pdCAwIGZvciAvdXNyL2xpYjY0L2Nocm9taXVtLWJyb3dzZXIvY2hyb21lW0No
cm9tZV9DaGlsZElPVDoyMDA2Ml0gdWlkL2V1aWQ6MTAwMC8xMDAwIGdpZC9lZ2lkOjEwMDEvMTAw
MSwgcGFyZW50IC91c3IvbGliNjQvY2hyb21pdW0tYnJvd3Nlci9jaHJvbWVbY2hyb21lOjMxMzQ4
XSB1aWQvZXVpZDoxMDAwLzEwMDAgZ2lkL2VnaWQ6MTAwMS8xMDAxCls3MTQ1OS4yMzYyNzldIGdy
c2VjOiBkZW5pZWQgcmVzb3VyY2Ugb3ZlcnN0ZXAgYnkgcmVxdWVzdGluZyAzMCBmb3IgUkxJTUlU
X05JQ0UgYWdhaW5zdCBsaW1pdCAwIGZvciAvdXNyL2xpYjY0L2Nocm9taXVtLWJyb3dzZXIvY2hy
b21lW0Nocm9tZV9DaGlsZElPVDoyMDA2Ml0gdWlkL2V1aWQ6MTAwMC8xMDAwIGdpZC9lZ2lkOjEw
MDEvMTAwMSwgcGFyZW50IC91c3IvbGliNjQvY2hyb21pdW0tYnJvd3Nlci9jaHJvbWVbY2hyb21l
OjMxMzQ4XSB1aWQvZXVpZDoxMDAwLzEwMDAgZ2lkL2VnaWQ6MTAwMS8xMDAxCls3MTUxMi4wMjg5
MjNdIGdyc2VjOiBkZW5pZWQgcmVzb3VyY2Ugb3ZlcnN0ZXAgYnkgcmVxdWVzdGluZyAzMCBmb3Ig
UkxJTUlUX05JQ0UgYWdhaW5zdCBsaW1pdCAwIGZvciAvdXNyL2xpYjY0L2Nocm9taXVtLWJyb3dz
ZXIvY2hyb21lW0Nocm9tZV9DaGlsZElPVDoyMDExM10gdWlkL2V1aWQ6MTAwMC8xMDAwIGdpZC9l
Z2lkOjEwMDEvMTAwMSwgcGFyZW50IC91c3IvbGliNjQvY2hyb21pdW0tYnJvd3Nlci9jaHJvbWVb
Y2hyb21lOjMxMzQ4XSB1aWQvZXVpZDoxMDAwLzEwMDAgZ2lkL2VnaWQ6MTAwMS8xMDAxCls3MTUx
Mi4zMDg1OThdIGdyc2VjOiBkZW5pZWQgcmVzb3VyY2Ugb3ZlcnN0ZXAgYnkgcmVxdWVzdGluZyAz
MCBmb3IgUkxJTUlUX05JQ0UgYWdhaW5zdCBsaW1pdCAwIGZvciAvdXNyL2xpYjY0L2Nocm9taXVt
LWJyb3dzZXIvY2hyb21lW0Nocm9tZV9DaGlsZElPVDoyMDExM10gdWlkL2V1aWQ6MTAwMC8xMDAw
IGdpZC9lZ2lkOjEwMDEvMTAwMSwgcGFyZW50IC91c3IvbGliNjQvY2hyb21pdW0tYnJvd3Nlci9j
aHJvbWVbY2hyb21lOjMxMzQ4XSB1aWQvZXVpZDoxMDAwLzEwMDAgZ2lkL2VnaWQ6MTAwMS8xMDAx
Cls3MTgxNi41OTM3ODldIGdyc2VjOiBkZW5pZWQgcmVzb3VyY2Ugb3ZlcnN0ZXAgYnkgcmVxdWVz
dGluZyAzMCBmb3IgUkxJTUlUX05JQ0UgYWdhaW5zdCBsaW1pdCAwIGZvciAvdXNyL2xpYjY0L2No
cm9taXVtLWJyb3dzZXIvY2hyb21lW0Nocm9tZV9DaGlsZElPVDoyMDA2Ml0gdWlkL2V1aWQ6MTAw
MC8xMDAwIGdpZC9lZ2lkOjEwMDEvMTAwMSwgcGFyZW50IC91c3IvbGliNjQvY2hyb21pdW0tYnJv
d3Nlci9jaHJvbWVbY2hyb21lOjMxMzQ4XSB1aWQvZXVpZDoxMDAwLzEwMDAgZ2lkL2VnaWQ6MTAw
MS8xMDAxCls3MTgyMS4wNDQ1NDddIGdyc2VjOiBkZW5pZWQgcmVzb3VyY2Ugb3ZlcnN0ZXAgYnkg
cmVxdWVzdGluZyAzMCBmb3IgUkxJTUlUX05JQ0UgYWdhaW5zdCBsaW1pdCAwIGZvciAvdXNyL2xp
YjY0L2Nocm9taXVtLWJyb3dzZXIvY2hyb21lW0Nocm9tZV9DaGlsZElPVDoyMDA2Ml0gdWlkL2V1
aWQ6MTAwMC8xMDAwIGdpZC9lZ2lkOjEwMDEvMTAwMSwgcGFyZW50IC91c3IvbGliNjQvY2hyb21p
dW0tYnJvd3Nlci9jaHJvbWVbY2hyb21lOjMxMzQ4XSB1aWQvZXVpZDoxMDAwLzEwMDAgZ2lkL2Vn
aWQ6MTAwMS8xMDAxCls3MTgyMS4wNTA2NDhdIGdyc2VjOiBkZW5pZWQgcmVzb3VyY2Ugb3ZlcnN0
ZXAgYnkgcmVxdWVzdGluZyAzMCBmb3IgUkxJTUlUX05JQ0UgYWdhaW5zdCBsaW1pdCAwIGZvciAv
dXNyL2xpYjY0L2Nocm9taXVtLWJyb3dzZXIvY2hyb21lW0Nocm9tZV9DaGlsZElPVDoyMDA2Ml0g
dWlkL2V1aWQ6MTAwMC8xMDAwIGdpZC9lZ2lkOjEwMDEvMTAwMSwgcGFyZW50IC91c3IvbGliNjQv
Y2hyb21pdW0tYnJvd3Nlci9jaHJvbWVbY2hyb21lOjMxMzQ4XSB1aWQvZXVpZDoxMDAwLzEwMDAg
Z2lkL2VnaWQ6MTAwMS8xMDAxCls3NDQ1NS40NDE0MDRdIENQVTI6IFBhY2thZ2UgcG93ZXIgbGlt
aXQgbm90aWZpY2F0aW9uICh0b3RhbCBldmVudHMgPSAxMDY3MzApCls3NDQ1NS40NDE0MDhdIENQ
VTM6IFBhY2thZ2UgcG93ZXIgbGltaXQgbm90aWZpY2F0aW9uICh0b3RhbCBldmVudHMgPSAxMDY3
MjgpCls3NDQ1NS40NDE0MTBdIENQVTA6IFBhY2thZ2UgcG93ZXIgbGltaXQgbm90aWZpY2F0aW9u
ICh0b3RhbCBldmVudHMgPSAxMDY3MjYpCls3NDQ1NS40NDE0MTJdIENQVTE6IFBhY2thZ2UgcG93
ZXIgbGltaXQgbm90aWZpY2F0aW9uICh0b3RhbCBldmVudHMgPSAxMDY3MjgpCls3NDQ1NS40NTIz
NzFdIENQVTI6IFBhY2thZ2UgcG93ZXIgbGltaXQgbm9ybWFsCls3NDQ1NS40NTIzNzJdIENQVTA6
IFBhY2thZ2UgcG93ZXIgbGltaXQgbm9ybWFsCls3NDQ1NS40NTIzNzVdIENQVTE6IFBhY2thZ2Ug
cG93ZXIgbGltaXQgbm9ybWFsCls3NDQ1NS40NTIzNzZdIENQVTM6IFBhY2thZ2UgcG93ZXIgbGlt
aXQgbm9ybWFsCls3NTQyOC42NzQ2ODBdIGkyYyAvZGV2IGVudHJpZXMgZHJpdmVyCg==
--047d7b6247be6e695004d797d920
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--047d7b6247be6e695004d797d920--

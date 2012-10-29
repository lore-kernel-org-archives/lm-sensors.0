From: Alejandro Jakubi <jakubi@df.uba.ar>
Date: Mon, 29 Oct 2012 05:00:33 +0000
Subject: [lm-sensors] high value for CPUTIN
Message-Id: <alpine.DEB.2.02.1210290159070.3309@cosmos>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="8323329-991563949-1351486834=:3309"
List-Id: <lm-sensors.vger.kernel.org>
To: lm-sensors@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-991563949-1351486834=:3309
Content-Type: TEXT/PLAIN; format=flowed; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

I observe a very high value for CPUTIN, namely 96.5C, far above the high=20
limit of 80C, that seems inconsistent with all the other values of=20
temperature provided by lm-sensors, in the range of the 30s C. And also=20
seems inconsistent with the BIOS values: CPU 37C, MB 33C. Besides, I gues=
s=20
that the CPU would no longer work at that temperature...

Find appended below the information requested in the FAQ, as far as I hav=
e
understood it as relevant for this case. Just tell me whether additional
information is needed.

So, I wonder whether this is a bug, a weakness of the sensor (diode?) and
possible solutions or workarounds.


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
lm-sensors version: 1:3.3.1-2ubuntu1

Linux Mint Release 13 (maya) 32-bit
Kernel Linux 3.2.0-23-generic
GNOME 3.4.2

Intel Core i7-3820 CPU @ 3.60GHz

Mother Asus P9X79

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
sensor:

coretemp-isa-0000
Adapter: ISA adapter
Physical id 0:  +35.0=B0C  (high =3D +82.0=B0C, crit =3D +100.0=B0C)
Core 0:         +34.0=B0C  (high =3D +82.0=B0C, crit =3D +100.0=B0C)
Core 1:         +32.0=B0C  (high =3D +82.0=B0C, crit =3D +100.0=B0C)
Core 2:         +34.0=B0C  (high =3D +82.0=B0C, crit =3D +100.0=B0C)
Core 3:         +33.0=B0C  (high =3D +82.0=B0C, crit =3D +100.0=B0C)

nct6776-isa-0290
Adapter: ISA adapter
Vcore:         +0.94 V  (min =3D  +0.00 V, max =3D  +1.74 V)
in1:           +1.02 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
AVCC:          +3.31 V  (min =3D  +2.98 V, max =3D  +3.63 V)
+3.3V:         +3.30 V  (min =3D  +2.98 V, max =3D  +3.63 V)
in4:           +1.00 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
in5:           +2.04 V  (min =3D  +0.00 V, max =3D  +0.00 V)  ALARM
3VSB:          +3.42 V  (min =3D  +2.98 V, max =3D  +3.63 V)
Vbat:          +3.36 V  (min =3D  +2.70 V, max =3D  +3.30 V)  ALARM
fan1:            0 RPM  (min =3D    0 RPM)  ALARM
fan2:         4411 RPM  (min =3D    0 RPM)  ALARM
fan3:            0 RPM  (min =3D    0 RPM)  ALARM
fan4:            0 RPM  (min =3D    0 RPM)  ALARM
fan5:            0 RPM  (min =3D    0 RPM)  ALARM
SYSTIN:        +33.0=B0C  (high =3D  +0.0=B0C, hyst =3D  +0.0=B0C)  ALARM=
  sensor =3D thermistor
CPUTIN:        +96.5=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  ALARM=
  sensor =3D diode
AUXTIN:        +33.0=B0C  (high =3D +80.0=B0C, hyst =3D +75.0=B0C)  senso=
r =3D thermistor
PECI Agent 0:  +33.5=B0C
cpu0_vid:     +1.708 V
intrusion0:   OK
intrusion1:   ALARM

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
sensors-detect:

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

Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor/ITE'...               No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               Yes
Found `Nuvoton NCT6776F Super IO Sensors'                   Success!
     (address 0x290, driver `w83627ehf')
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor/ITE'...               No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
Trying family `ITE'...                                      No

Probing for `IPMI BMC KCS' at 0xca0...                      No
Probing for `IPMI BMC SMIC' at 0xca8...                     No

Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No

Found unknown SMBus adapter 8086:1d22 at 0000:00:1f.3.
Sorry, no supported PCI bus adapters found.
Module i2c-dev loaded successfully.

Next adapter: NVIDIA i2c adapter 0 at 1:00.0 (i2c-0)
Do you want to scan it? (YES/no/selectively): y

Next adapter: NVIDIA i2c adapter 1 at 1:00.0 (i2c-1)
Do you want to scan it? (YES/no/selectively): yes
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 No
Probing for `EDID EEPROM'...                                Yes
     (confidence 8, not a hardware monitoring chip)
Client found at address 0x58
Probing for `Analog Devices ADT7462'...                     No
Probing for `Andigilog aSC7512'...                          No

Next adapter: NVIDIA i2c adapter 9 at 1:00.0 (i2c-2)
Do you want to scan it? (YES/no/selectively): y

Driver `w83627ehf':
   * ISA bus, address 0x290
     Chip `Nuvoton NCT6776F Super IO Sensors' (confidence: 9)

Driver `coretemp':
   * Chip `Intel digital thermal sensor' (confidence: 9)

To load everything that is needed, add this to /etc/modules:
#----cut here----
# Chip drivers
coretemp
w83627ehf
#----cut here----

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
lsmod:

Module                  Size  Used by
nls_utf8               12493  1
isofs                  39553  1
parport_pc             32114  0
ppdev                  12849  0
bnep                   17830  2
rfcomm                 38139  0
bluetooth             158438  10 bnep,rfcomm
binfmt_misc            17292  1
dm_crypt               22528  0
nls_iso8859_1          12617  2
nls_cp437              12751  2
vfat                   17308  2
fat                    55605  1 vfat
snd_hda_codec_hdmi     31775  4
ip6t_LOG               16846  4
xt_hl                  12465  6
ip6t_rt                12473  3
nf_conntrack_ipv6      13581  7
nf_defrag_ipv6         13139  1 nf_conntrack_ipv6
ipt_REJECT             12512  1
ipt_LOG                12783  5
xt_limit               12541  12
xt_tcpudp              12531  18
xt_addrtype            12596  4
xt_state               12514  14
eeepc_wmi              12949  0
asus_wmi               19624  1 eeepc_wmi
sparse_keymap          13658  1 asus_wmi
mxm_wmi                12859  0
snd_hda_codec_realtek   174055  1
nvidia              10962290  30
serio_raw              13027  0
dm_multipath           22710  0
ip6table_filter        12711  1
ip6_tables             22528  3 ip6t_LOG,ip6t_rt,ip6table_filter
nf_conntrack_netbios_ns    12585  0
nf_conntrack_broadcast    12541  1 nf_conntrack_netbios_ns
nf_nat_ftp             12595  0
nf_nat                 24959  1 nf_nat_ftp
nf_conntrack_ipv4      19084  9 nf_nat
nf_defrag_ipv4         12649  1 nf_conntrack_ipv4
nf_conntrack_ftp       13183  1 nf_nat_ftp
nf_conntrack           73847  8 nf_conntrack_ipv6,xt_state,nf_conntrack_n=
etbios_ns,nf_conntrack_broadcast,nf_nat_ftp,nf_nat,nf_conntrack_ipv4,nf_c=
onntrack_ftp
iptable_filter         12706  1
ip_tables              18106  1 iptable_filter
x_tables               21974  13 ip6t_LOG,xt_hl,ip6t_rt,ipt_REJECT,ipt_LO=
G,xt_limit,xt_tcpudp,xt_addrtype,xt_state,ip6table_filter,ip6_tables,ipta=
ble_filter,ip_tables
snd_hda_intel          32765  5
snd_hda_codec         109562  3 snd_hda_codec_hdmi,snd_hda_codec_realtek,=
snd_hda_intel
snd_hwdep              13276  1 snd_hda_codec
snd_pcm                80845  3 snd_hda_codec_hdmi,snd_hda_intel,snd_hda_=
codec
snd_seq_midi           13132  0
snd_rawmidi            25424  1 snd_seq_midi
snd_seq_midi_event     14475  1 snd_seq_midi
snd_seq                51567  2 snd_seq_midi,snd_seq_midi_event
snd_timer              28931  2 snd_pcm,snd_seq
snd_seq_device         14172  3 snd_seq_midi,snd_rawmidi,snd_seq
mei                    36570  0
snd                    62064  20 snd_hda_codec_hdmi,snd_hda_codec_realtek=
,snd_hda_intel,snd_hda_codec,snd_hwdep,snd_pcm,snd_rawmidi,snd_seq,snd_ti=
mer,snd_seq_device
soundcore              14635  1 snd
snd_page_alloc         14115  2 snd_hda_intel,snd_pcm
wmi                    18744  2 asus_wmi,mxm_wmi
mac_hid                13077  0
w83627ehf              29485  0
hwmon_vid              12723  1 w83627ehf
coretemp               13269  0
lp                     17455  0
parport                40930  3 parport_pc,ppdev,lp
dm_raid45              76451  0
xor                    25987  1 dm_raid45
dm_mirror              21822  0
dm_region_hash         16065  1 dm_mirror
dm_log                 18193  3 dm_raid45,dm_mirror,dm_region_hash
btrfs                 638208  0
zlib_deflate           26622  1 btrfs
libcrc32c              12543  1 btrfs
usbhid                 41906  0
hid                    77367  1 usbhid
uas                    17699  0
usb_storage            39646  3
firewire_ohci          40180  0
firewire_core          56906  1 firewire_ohci
crc_itu_t              12627  1 firewire_core
e1000e                140005  0
zram                   18193  1

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
--8323329-991563949-1351486834=:3309
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--8323329-991563949-1351486834=:3309--

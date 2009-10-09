From: nyyr1@tiscali.cz
Date: Fri, 09 Oct 2009 20:35:54 +0000
Subject: [lm-sensors] "No sensors found!" although it87 module loaded
Message-Id: <49C97D630013E049@nzoth.tiscali.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hello,

        does anyone have an idea?
It is GA-EP45-DS3R mainboard...

N.

2.6.18-164.el5 #1 SMP Thu Sep 3 03:28:30 EDT 2009 x86_64 x86_64 x86_64
GNU/Linux

lm_sensors-2.10.7-4.el5

[root@n1 /]# lsmod
Module                  Size  Used by
i2c_dev                43977  0=20
ppdev                  42441  0=20
snd_rtctimer           37025  0=20
autofs4                63049  2=20
it87                   57061  0=20
hwmon_vid              35905  1 it87
i2c_isa                39105  1 it87
hidp                   83521  2=20
rfcomm                104809  0=20
l2cap                  89281  10 hidp,rfcomm
bluetooth             118853  5 hidp,rfcomm,l2cap
lockd                 101297  0=20
sunrpc                198537  2 lockd
ip6t_REJECT            38849  1=20
ip6table_filter        36033  1=20
ip6_tables             50049  1 ip6table_filter
ip_conntrack_netbios_ns    36033  0=20
ipt_REJECT             38977  1=20
xt_state               35265  2=20
ip_conntrack           91621  2 ip_conntrack_netbios_ns,xt_state
nfnetlink              40457  1 ip_conntrack
xt_tcpudp              36289  10=20
iptable_filter         36161  1=20
ip_tables              55201  1 iptable_filter
x_tables               50505  6
ip6t_REJECT,ip6_tables,ipt_REJECT,xt_state,xt_tcpudp,ip_tables
cpufreq_ondemand       42449  2=20
acpi_cpufreq           47937  0=20
freq_table             40889  2 cpufreq_ondemand,acpi_cpufreq
dm_multipath           56153  0=20
scsi_dh                41665  1 dm_multipath
video                  53197  0=20
hwmon                  36553  1 it87
backlight              39873  1 video
sbs                    49921  0=20
i2c_ec                 38593  1 sbs
button                 40545  0=20
battery                43849  0=20
asus_acpi              50917  0=20
acpi_memhotplug        40261  0=20
ac                     38729  0=20
ipv6                  432161  27 ip6t_REJECT
xfrm_nalgo             43333  1 ipv6
lp                     47121  0=20
snd_hda_intel         584593  1=20
snd_seq_dummy          37061  0=20
nvidia              10302184  26=20
snd_seq_oss            65473  0=20
snd_seq_midi_event     41025  1 snd_seq_oss
snd_seq                87777  5
snd_seq_dummy,snd_seq_oss,snd_seq_midi_event
snd_seq_device         41557  3 snd_seq_dummy,snd_seq_oss,snd_seq
snd_pcm_oss            77377  0=20
snd_mixer_oss          49985  1 snd_pcm_oss
snd_pcm               116681  2 snd_hda_intel,snd_pcm_oss
snd_timer              57161  3 snd_rtctimer,snd_seq,snd_pcm
parport_pc             62313  1=20
snd_page_alloc         44113  2 snd_hda_intel,snd_pcm
shpchp                 70892  0=20
parport                73165  3 ppdev,lp,parport_pc
ide_cd                 73825  0=20
snd_hwdep              43593  1 snd_hda_intel
snd                   100073  11
snd_hda_intel,snd_seq_oss,snd_seq,snd_seq_device,snd_pcm_oss,snd_mixer_oss,=
snd_pcm,snd_timer,snd_hwdep
floppy                 95465  0=20
r8169                  70853  0=20
i2c_i801               41813  0=20
cdrom                  68713  1 ide_cd
mii                    38849  1 r8169
i2c_core               56129  6
i2c_dev,it87,i2c_isa,i2c_ec,nvidia,i2c_i801
sg                     70377  0=20
soundcore              41825  1 snd
serio_raw              40517  0=20
pcspkr                 36289  0=20
dm_raid45              99657  0=20
dm_message             36289  1 dm_raid45
dm_region_hash         46145  1 dm_raid45
dm_mem_cache           38977  1 dm_raid45
ahci                   69449  2=20
libata                209489  1 ahci
sd_mod                 56513  2=20
scsi_mod              196697  4 scsi_dh,sg,libata,sd_mod
sha256                 41665  0=20
cbc                    37441  0=20
crypto_blkcipher       48321  1 cbc
crypto_algapi          54721  2 cbc,crypto_blkcipher
crypto_api             42945  3
xfrm_nalgo,crypto_blkcipher,crypto_algapi
aes_generic            59265  0=20
aes_x86_64             58473  2=20
dm_crypt               46665  1=20
dm_snapshot            51977  0=20
dm_zero                35265  0=20
dm_mirror              54609  1=20
dm_log                 44993  4 dm_raid45,dm_region_hash,dm_mirror
dm_mod                101521  24
dm_multipath,dm_raid45,dm_crypt,dm_snapshot,dm_zero,dm_mirror,dm_log
ext3                  168401  4=20
jbd                    94385  1 ext3
uhci_hcd               57433  0=20
ohci_hcd               55925  0=20
ehci_hcd               66253  0=20
[root@n1 /]# sensors-detect
# sensors-detect revision 5291 (2008-06-23 23:40:46 -0700)

This program will help you determine which kernel modules you need
to load to use lm_sensors most effectively. It is generally safe
and recommended to accept the default answers to all questions,
unless you know what you're doing.

We can start with probing for (PCI) I2C or SMBus adapters.
Do you want to probe now? (YES/no):=20
Probing for PCI bus adapters...
Use driver `i2c-i801' for device 0000:00:1f.3: Intel ICH10

We will now try to load each adapter module in turn.
Module `i2c-i801' already loaded.
If you have undetectable or unsupported I2C/SMBus adapters, you can have
them scanned by manually loading the modules before running this script.

We are now going to do the I2C/SMBus adapter probings. Some chips may
be double detected; we choose the one with the highest confidence
value in that case.
If you found that the adapter hung after probing a certain address,
you can specify that address to remain unprobed.

Next adapter: SMBus I801 adapter at 0500 (i2c-0)
Do you want to scan it? (YES/no/selectively):=20
Client found at address 0x4e
Probing for `National Semiconductor LM75'...                No
Probing for `Dallas Semiconductor DS75'...                  No
Probing for `Dallas Semiconductor DS1621/DS1631'...         No
Probing for `Analog Devices ADM1021'...                     No
Probing for `Analog Devices ADM1021A/ADM1023'...            No
Probing for `Maxim MAX1617'...                              No
Probing for `Maxim MAX1617A'...                             No
Probing for `TI THMC10'...                                  No
Probing for `National Semiconductor LM84'...                No
Probing for `Genesys Logic GL523SM'...                      No
Probing for `Onsemi MC1066'...                              No
Probing for `Maxim MAX1619'...                              No
Probing for `National Semiconductor LM82/LM83'...           No
Probing for `Maxim MAX6659'...                              No
Probing for `Maxim MAX6680/MAX6681'...                      No
Probing for `National Semiconductor LM64'...                No
Probing for `Maxim MAX6633/MAX6634/MAX6635'...              No
Probing for `ITE IT8201R/IT8203R/IT8206R/IT8266R'...        Yes
    (confidence 6, not a hardware monitoring chip)
Probing for `Fintek F75111R/RG/N (GPIO)'...                 No
Probing for `Fintek F75121R/F75122R/RG (VID+GPIO)'...       No
Client found at address 0x50
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
    (confidence 8, not a hardware monitoring chip)
Probing for `EDID EEPROM'...                                No
Client found at address 0x52
Probing for `Analog Devices ADM1033'...                     No
Probing for `Analog Devices ADM1034'...                     No
Probing for `SPD EEPROM'...                                 Yes
    (confidence 8, not a hardware monitoring chip)
Probing for `EDID EEPROM'...                                No

Next adapter: NVIDIA i2c adapter 0 at 1:00.0 (i2c-1)
Do you want to scan it? (YES/no/selectively):=20
Adapter cannot be probed, skipping.

Next adapter: NVIDIA i2c adapter 1 at 1:00.0 (i2c-2)
Do you want to scan it? (YES/no/selectively):=20
Adapter cannot be probed, skipping.

Next adapter: NVIDIA i2c adapter 2 at 1:00.0 (i2c-3)
Do you want to scan it? (YES/no/selectively):=20
Adapter cannot be probed, skipping.

Some chips are also accessible through the ISA I/O ports. We have to
write to arbitrary I/O ports to probe them. This is usually safe though.
Yes, you do have ISA I/O ports even if you do not have any ISA slots!
Do you want to scan the ISA I/O ports? (YES/no):=20
Probing for `National Semiconductor LM78' at 0x290...       No
Probing for `National Semiconductor LM78-J' at 0x290...     No
Probing for `National Semiconductor LM79' at 0x290...       No
Probing for `Winbond W83781D' at 0x290...                   No
Probing for `Winbond W83782D' at 0x290...                   No

Some Super I/O chips may also contain sensors. We have to write to
standard I/O ports to probe them. This is usually safe.
Do you want to scan for Super I/O sensors? (YES/no):=20
Probing for Super-I/O at 0x2e/0x2f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     No
Trying family `VIA/Winbond/Fintek'...                       No
Trying family `ITE'...                                      Yes
Found `ITE IT8718F Super IO Sensors'                        Success!
    (address 0x290, driver `it87')
Probing for Super-I/O at 0x4e/0x4f
Trying family `National Semiconductor'...                   No
Trying family `SMSC'...                                     Yes
Found unknown chip with ID 0x0b00

Some south bridges, CPUs or memory controllers may also contain
embedded sensors. Do you want to scan for them? (YES/no):=20
Silicon Integrated Systems SIS5595...                       No
VIA VT82C686 Integrated Sensors...                          No
VIA VT8231 Integrated Sensors...                            No
AMD K8 thermal sensors...                                   No
AMD K10 thermal sensors...                                  No
Intel AMB FB-DIMM thermal sensor...                         No

Now follows a summary of the probes I have just done.
Just press ENTER to continue:=20

Driver `it87' (should be inserted):
  Detects correctly:
  * ISA bus, address 0x290
    Chip `ITE IT8718F Super IO Sensors' (confidence: 9)

Do you want to overwrite /etc/sysconfig/lm_sensors? (YES/no):=20
Starting lm_sensors: No sensors found!
Make sure you loaded all the kernel drivers you need.
Try sensors-detect to find out which these are.
                                                           [FAILED]
[root@n1 /]#=20


______________________________________
http://www.sportstream.cz/ - aktu=E1ln=ED sportovn=ED videa




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

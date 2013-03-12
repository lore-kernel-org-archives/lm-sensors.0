From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 12 Mar 2013 05:06:25 +0000
Subject: Re: [lm-sensors] Asus Zenbook UX31A
Message-Id: <20130312050625.GA20995@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CACFVp02JRnmnQ0T6-sXd2-HNMqO2JifxwUDfso7qbxKRH2UZ8w@mail.gmail.com>
In-Reply-To: <CACFVp02JRnmnQ0T6-sXd2-HNMqO2JifxwUDfso7qbxKRH2UZ8w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Mon, Mar 11, 2013 at 12:24:34AM +0400, vasya wrote:
> Hello.
> I've read that there I can request for support...
>=20
> I've asus zenbook ux31a and there is no fan control on it. Here is what y=
ou
> need (as I understand) to basic overview:
>=20
Looks like the fan would need to be controlled using ACPI.

Here is a link with some information:

http://forum.notebookreview.com/asus/705656-fan-control-asus-prime-ux31-ux3=
1a-ux32a-ux32vd.html

and a proposed patch for drivers/platform/x86/asus-laptop.c:

http://www.mail-archive.com/acpi4asus-user@lists.sourceforge.net/msg00065.h=
tml

So all you need is someone with an UX31A and the time and desire
to create a working patch and submit it ....

Guenter

> Motherboard vendor and model:
> Base Board Information
> Manufacturer: ASUSTeK COMPUTER INC.
> Product Name: UX31A
>  Version: 1.0
> Serial Number: BSN12345678901234567
> Asset Tag: ATN12345678901234567
>  Features:
> Board is a hosting board
> Board is replaceable
>  Location In Chassis: MIDDLE
> Chassis Handle: 0x0003
> Type: Motherboard
>  Contained Object Handles: 0
>=20
> Lm_sensors and kernel versions:
> lm_sensors: 3.3.3-r2 kernel: gentoo 3.8.2-hardened
>=20
> The output of sensors:
> asus-isa-0000
> Adapter: ISA adapter
> temp1:        +51.0=B0C
>=20
> coretemp-isa-0000
> Adapter: ISA adapter
> Physical id 0:  +53.0=B0C  (high =3D +87.0=B0C, crit =3D +105.0=B0C)
> Core 0:         +52.0=B0C  (high =3D +87.0=B0C, crit =3D +105.0=B0C)
> Core 1:         +49.0=B0C  (high =3D +87.0=B0C, crit =3D +105.0=B0C)
>=20
> The dmesg or syslog output if applicable (attachment)
>=20
> The output of (as root) sensors-detect:
> # sensors-detect revision 6085 (2012-10-30 18:18:45 +0100)
> # System: ASUSTeK COMPUTER INC. UX31A [1.0] (laptop)
>=20
> This program will help you determine which kernel modules you need
> to load to use lm_sensors most effectively. It is generally safe
> and recommended to accept the default answers to all questions,
> unless you know what you're doing.
>=20
> Some south bridges, CPUs or memory controllers contain embedded sensors.
> Do you want to scan for them? This is totally safe. (YES/no): yes
> Module cpuid loaded successfully.
> Silicon Integrated Systems SIS5595...                       No
> VIA VT82C686 Integrated Sensors...                          No
> VIA VT8231 Integrated Sensors...                            No
> AMD K8 thermal sensors...                                   No
> AMD Family 10h thermal sensors...                           No
> AMD Family 11h thermal sensors...                           No
> AMD Family 12h and 14h thermal sensors...                   No
> AMD Family 15h thermal sensors...                           No
> AMD Family 15h power sensors...                             No
> Intel digital thermal sensor...                             Success!
>     (driver `coretemp')
> Intel AMB FB-DIMM thermal sensor...                         No
> VIA C7 thermal sensor...                                    No
> VIA Nano thermal sensor...                                  No
>=20
> Some Super I/O chips contain embedded sensors. We have to write to
> standard I/O ports to probe them. This is usually safe.
> Do you want to scan for Super I/O sensors? (YES/no):
> Probing for Super-I/O at 0x2e/0x2f
> Trying family `National Semiconductor/ITE'...               No
> Trying family `SMSC'...                                     No
> Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
> Trying family `ITE'...                                      No
> Probing for Super-I/O at 0x4e/0x4f
> Trying family `National Semiconductor/ITE'...               No
> Trying family `SMSC'...                                     No
> Trying family `VIA/Winbond/Nuvoton/Fintek'...               No
> Trying family `ITE'...                                      No
>=20
> Some hardware monitoring chips are accessible through the ISA I/O ports.
> We have to write to arbitrary I/O ports to probe them. This is usually
> safe though. Yes, you do have ISA I/O ports even if you do not have any
> ISA slots! Do you want to scan the ISA I/O ports? (YES/no):
> Probing for `National Semiconductor LM78' at 0x290...       No
> Probing for `National Semiconductor LM79' at 0x290...       No
> Probing for `Winbond W83781D' at 0x290...                   No
> Probing for `Winbond W83782D' at 0x290...                   No
>=20
> Lastly, we can probe the I2C/SMBus adapters for connected hardware
> monitoring devices. This is the most risky part, and while it works
> reasonably well on most systems, it has been reported to cause trouble
> on some systems.
> Do you want to probe the I2C/SMBus adapters now? (YES/no):
> Using driver `i2c-i801' for device 0000:00:1f.3: Intel Panther Point (PCH)
> Module i2c-dev loaded successfully.
>=20
> Next adapter: i915 gmbus ssc (i2c-0)
> Do you want to scan it? (yes/NO/selectively):
>=20
> Next adapter: i915 gmbus vga (i2c-1)
> Do you want to scan it? (yes/NO/selectively):
>=20
> Next adapter: i915 gmbus panel (i2c-2)
> Do you want to scan it? (yes/NO/selectively):
>=20
> Next adapter: i915 gmbus dpc (i2c-3)
> Do you want to scan it? (yes/NO/selectively):
>=20
> Next adapter: i915 gmbus dpb (i2c-4)
> Do you want to scan it? (yes/NO/selectively):
>=20
> Next adapter: i915 gmbus dpd (i2c-5)
> Do you want to scan it? (yes/NO/selectively):
>=20
> Next adapter: DPDDC-A (i2c-6)
> Do you want to scan it? (YES/no/selectively):
> Client found at address 0x50
> Probing for `Analog Devices ADM1033'...                     No
> Probing for `Analog Devices ADM1034'...                     No
> Probing for `SPD EEPROM'...                                 No
> Probing for `EDID EEPROM'...                                Yes
>     (confidence 8, not a hardware monitoring chip)
> Client found at address 0x51
> Probing for `Analog Devices ADM1033'...                     No
> Probing for `Analog Devices ADM1034'...                     No
> Probing for `SPD EEPROM'...                                 No
>=20
> Next adapter: DPDDC-C (i2c-7)
> Do you want to scan it? (YES/no/selectively):
>=20
> Now follows a summary of the probes I have just done.
> Just press ENTER to continue:
>=20
> Driver `coretemp':
>   * Chip `Intel digital thermal sensor' (confidence: 9)
>=20
>=20
> Do you want to overwrite /etc/conf.d/lm_sensors? Enter s to specify other
> file name?
>   (yes/NO/s):
> If you have some drivers built into your kernel, the list above will
> contain too many modules. Skip the appropriate ones! You really
> should try these commands right now to make sure everything is
> working properly. Monitoring programs won't work until the needed
> modules are loaded.
>=20
> Unloading i2c-dev... OK
> Unloading cpuid... OK
>=20
> The output of lsmod
> Module                  Size  Used by
> coretemp                5474  0
> nls_utf8                1216  0
> nls_cp866               5305  0
> iwldvm                151524  0
> mac80211              324242  1 iwldvm
> iwlwifi                70391  1 iwldvm
> cfg80211              165942  3 iwlwifi,mac80211,iwldvm
> btrfs                 610059  0
> ufs                    56550  0
> hfsplus                70870  0
> hfs                    39513  0
> ntfs                  166976  0
> vfat                    8367  0
> msdos                   6182  0
> fat                    44627  2 vfat,msdos
> xfs                   469834  0
> crc32c                  1648  1
> libcrc32c                930  2 xfs,btrfs
> i915                  465450  6
> intel_agp              10244  1 i915
> intel_gtt              11286  2 i915,intel_agp
> drm_kms_helper         24463  1 i915
> drm                   211739  7 i915,drm_kms_helper
> i2c_algo_bit            4691  1 i915
> snd_seq                57412  1
> snd_seq_device          4564  1 snd_seq
> ipv6                  256306  48
> 8021q                  15980  0
> ipheth                  5993  0
> arc4                    1895  2
> uvcvideo               64308  0
> videobuf2_vmalloc       2576  1 uvcvideo
> videobuf2_memops        1551  1 videobuf2_vmalloc
> videobuf2_core         22402  1 uvcvideo
> videodev               97731  2 uvcvideo,videobuf2_core
> rts5139               252882  0
> snd_hda_codec_hdmi     24600  1
> snd_hda_codec_realtek    53958  1
> i2c_i801                8438  0
> snd_hda_intel          24946  3
> i2c_core               17188  6
> drm,i915,i2c_i801,drm_kms_helper,i2c_algo_bit,videodev
> snd_hda_codec          77602  3
> snd_hda_codec_realtek,snd_hda_codec_hdmi,snd_hda_intel
> snd_hwdep               6213  1 snd_hda_codec
> snd_pcm                70870  3
> snd_hda_codec_hdmi,snd_hda_codec,snd_hda_intel
> snd_page_alloc          6682  2 snd_pcm,snd_hda_intel
> snd_timer              19398  2 snd_pcm,snd_seq
> lpc_ich                11145  0
> snd                    59860  16
> snd_hda_codec_realtek,snd_hwdep,snd_timer,snd_hda_codec_hdmi,snd_pcm,snd_=
seq,snd_hda_codec,snd_hda_intel,snd_seq_device
> mfd_core                2865  1 lpc_ich
> kvm_intel             114108  0
> asus_nb_wmi             5120  0
> asus_wmi               14173  1 asus_nb_wmi
> kvm                   249301  1 kvm_intel
> sparse_keymap           2768  1 asus_wmi
> rfkill                 14543  2 cfg80211,asus_wmi
> pci_hotplug             9168  1 asus_wmi
> microcode               8668  0
> joydev                 13247  0
> thermal                 9329  0
> wmi                     7295  1 asus_wmi
> battery                11884  0
> button                  4613  1 i915
> ac                      3457  0
> video                  12007  2 i915,asus_wmi
> acpi_cpufreq            6534  0
> mperf                   1051  1 acpi_cpufreq
> processor              31719  1 acpi_cpufreq
> dm_bio_prison           3535  0
> dm_bufio               12188  0
> aesni_intel            44273  1
> ablk_helper             1604  1 aesni_intel
> cryptd                  7448  2 aesni_intel,ablk_helper
> lrw                     3325  1 aesni_intel
> xts                     2959  1 aesni_intel
> gf128mul                5410  2 lrw,xts
> aes_x86_64              7515  1 aesni_intel
> cbc                     2650  0
> iscsi_tcp               7888  0
> libiscsi_tcp           10934  1 iscsi_tcp
> libiscsi               31040  2 libiscsi_tcp,iscsi_tcp
> scsi_transport_iscsi    35659  2 iscsi_tcp,libiscsi
> tg3                   128783  0
> libphy                 17984  1 tg3
> hwmon                   1177  3 tg3,coretemp,asus_wmi
> ptp                     8892  1 tg3
> pps_core                7256  1 ptp
> e1000                  89798  0
> fuse                   61642  2
> exportfs                3210  1 xfs
> nfs                   112521  0
> fscache                34980  1 nfs
> lockd                  55669  1 nfs
> sunrpc                156068  2 nfs,lockd
> jfs                   145990  0
> reiserfs              213572  0
> zlib_deflate           17995  1 btrfs
> ext4                  281940  2
> jbd2                   50808  1 ext4
> crc16                   1247  1 ext4
> ext3                  112125  0
> jbd                    42078  1 ext3
> ext2                   55992  0
> mbcache                 4758  3 ext2,ext3,ext4
> linear                  3455  0
> raid0                   6787  0
> dm_raid                12292  0
> raid10                 36173  1 dm_raid
> raid1                  24964  1 dm_raid
> raid456                50212  1 dm_raid
> md_mod                 92709  6 raid456,dm_raid,raid0,raid1,linear,raid10
> async_pq                2974  1 raid456
> async_xor               2121  2 async_pq,raid456
> xor                     7916  1 async_xor
> async_memcpy            1182  1 raid456
> async_raid6_recov       1209  1 raid456
> raid6_pq               90278  2 async_pq,async_raid6_recov
> async_tx                1694  5
> async_pq,raid456,async_xor,async_memcpy,async_raid6_recov
> dm_snapshot            24699  0
> dm_crypt               13864  0
> dm_mirror              11456  0
> dm_region_hash          6615  1 dm_mirror
> dm_log                  7711  2 dm_region_hash,dm_mirror
> dm_mod                 63184  12
> dm_raid,dm_log,dm_mirror,dm_bufio,dm_crypt,dm_snapshot
> xhci_hcd               74023  0
> ohci_hcd               20238  0
> uhci_hcd               19125  0
> scsi_transport_fc      40723  0
> aacraid                78072  0
> sx8                    11189  0
> cciss                  52641  0
> atp870u                23209  0
> dmx3191d                9121  0
> sym53c8xx              63315  0
> gdth                   78348  0
> initio                 15300  0
> BusLogic               19540  0
> aic7xxx               101482  0
> aic79xx               123570  0
> scsi_transport_spi     18588  4 sym53c8xx,aic79xx,aic7xxx,dmx3191d
> sg                     25076  0
> ata_piix               22155  0
> pata_pcmcia             9733  0
> pcmcia                 30451  1 pata_pcmcia
> pcmcia_core            10893  1 pcmcia
> pata_oldpiix            2984  0
> pata_mpiix              2810  0
>=20
> Sorry I have no part numbers of chips. I'm looking for in internet but ha=
ve
> no luck at this time.
>=20
> Thank you!


> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

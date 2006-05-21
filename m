From: mahashakti89@wanadoo.fr (mahashakti89)
Date: Sun, 21 May 2006 17:04:57 +0000
Subject: [lm-sensors] ASUS P4P 800 and sensors.conf
Message-Id: <44709DB9.7000006@wanadoo.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi !

I am using an ASUS P4P800 motherboard, and I cannot manage it to get
lm-sensors to work properly ; I mean some output values are obviously
quite wrong  :

> w83627thf-isa-0290 Adapter: ISA adapter in0:       +1.57 V  (min =  +1.46 V, max =  +1.60 V)
> in1:       +3.14 V  (min =  +2.85 V, max =  +3.47 V)              e/claude/sensor
> in2:       +3.23 V  (min =  +3.14 V, max =  +3.47 V)
> in3:       +2.96 V  (min =  +2.85 V, max =  +3.15 V)
> in4:       +4.08 V  (min =  +0.34 V, max =  +0.80 V)       ALARM
> in7:       +2.99 V  (min =  +2.83 V, max =  +3.12 V)
> in8:       +0.29 V  (min =  +2.40 V, max =  +3.60 V)       ALARM
> fan1:     1795 RPM  (min = 11250 RPM, div = 8)              ALARM
> fan2:     2235 RPM  (min = 5113 RPM, div = 4)              ALARM
> fan3:        0 RPM  (min =  620 RPM, div = 128)              ALARM
> temp1:       +50?C  (high =   +60?C, hyst =   +17?C)   sensor = thermistor
> temp2:     +41.0?C  (high =   +80?C, hyst =   +75?C)   sensor = thermistor
> temp3:     -48.0?C  (high =   +80?C, hyst =   +75?C)   sensor = thermistor
> vid:      +1.525 V  (VRM Version 9.0)
> alarms:
> beep_enable:
>           Sound alarm enabled

I am ashamed to say that I didn't find the solution to get lm-sensors
work ,  so I could need some good help to get a working sensors.conf for
this motherboard and also the explication of the thing in order to
understand how to solve this problem next time.

1.Output of sensors-detect

> To make the sensors modules behave correctly, add these lines to
> /etc/modules:
> 
> #----cut here----
> # I2C adapter drivers
> # modprobe unknown adapter NVIDIA I2C Device
> # modprobe unknown adapter NVIDIA I2C Device
> # modprobe unknown adapter NVIDIA I2C Device
> i2c-i801
> i2c-isa
> # I2C chip drivers
> eeprom
> # Warning: the required module smbus-arp is not currently installed on your system.
> # For status of 2.6 kernel ports see http://secure.netroedge.com/~lm78/supported.html
> # If driver is built-in to the kernel, or unavailable, comment out the following line.
> smbus-arp
> w83627hf
> #----cut here----


2.lsmod

> Module                  Size  Used by
> nls_cp437               5760  1
> vfat                    9088  1
> ppp_async               8192  1
> crc_ccitt               2048  1 ppp_async
> nls_iso8859_15          4608  1
> cpufreq_ondemand        5392  1
> thermal                10760  0
> fan                     3460  0
> button                  5136  0
> processor              20172  1 thermal
> ipt_TOS                 2176  12
> ipt_REJECT              3968  4
> ipt_LOG                 5248  8
> xt_tcpudp               3072  25
> xt_state                1920  9
> xt_pkttype              1792  4
> iptable_raw             1792  0
> xt_CLASSIFY             2048  0
> ipt_owner               1920  0
> ipt_recent              8716  0
> ipt_iprange             1792  0
> ipt_policy              2816  0
> ipt_multiport           2304  4
> xt_conntrack            2304  0
> iptable_mangle          2304  1
> ip_nat_irc              2176  0
> ip_nat_tftp             1664  0
> ip_nat_ftp              2816  0
> iptable_nat             6276  0
> ip_nat                 13204  4 ip_nat_irc,ip_nat_tftp,ip_nat_ftp,iptable_nat
> ip_conntrack_irc        5144  1 ip_nat_irc
> ip_conntrack_tftp       3348  1 ip_nat_tftp
> ip_conntrack_ftp        5660  1 ip_nat_ftp
> ip_conntrack           38340  10 xt_state,xt_conntrack,ip_nat_irc,ip_nat_tftp,ip_nat_ftp,iptable_nat,ip_nat,ip_conntrack_irc,ip_conntrack_tftp,ip_conntrack_ftp
> iptable_filter          2432  1
> ip_tables               9820  4 iptable_raw,iptable_mangle,iptable_nat,iptable_filter
> x_tables                9092  15 ipt_TOS,ipt_REJECT,ipt_LOG,xt_tcpudp,xt_state,xt_pkttype,xt_CLASSIFY,ipt_owner,ipt_recent,ipt_iprange,ipt_policy,ipt_multiport,xt_conntrack,iptable_nat,ip_tables
> nvidia               4539572  12
> cpufreq_userspace       3240  0
> cpufreq_powersave       1792  0
> smbfs                  51064  0
> 8250_pci               18176  0
> bsd_comp                5120  0
> loop                   11272  0
> sg                     23836  0
> dm_zero                 1920  0
> dm_snapshot            12448  0
> dm_crypt                8712  0
> dm_mod                 39828  3 dm_zero,dm_snapshot,dm_crypt
> sha512                  9600  0
> sha256                 11392  0
> crc32c                  1920  0
> blowfish                8960  0
> libcrc32c               2688  1 crc32c
> fuse                   29324  0
> rivafb                 44176  0
> nvidiafb               48156  0
> i2c_algo_bit            7560  2 rivafb,nvidiafb
> ohci_hcd               15748  0
> snd_seq_oss            25828  0
> snd_seq_midi_event      5760  1 snd_seq_oss
> snd_seq                42188  4 snd_seq_oss,snd_seq_midi_event
> snd_seq_device          6540  2 snd_seq_oss,snd_seq
> xfrm_user              13572  0
> af_key                 24592  0
> udf                    67104  0
> romfs                   6276  0
> msdos                   7424  0
> fat                    39452  2 vfat,msdos
> binfmt_misc             8072  0
> binfmt_aout             6156  0
> vga16fb                10504  0
> vgastate                7296  2 rivafb,vga16fb
> usb_storage            29188  1
> usbhid                 24452  0
> usblp                  10368  0
> ppp_deflate             4608  1
> zlib_deflate           18208  1 ppp_deflate
> ppp_generic            19476  7 ppp_async,bsd_comp,ppp_deflate
> slhc                    5632  1 ppp_generic
> ide_floppy             13184  0
> eeprom                  5520  0
> i2c_dev                 6688  0
> w83627hf               21264  0
> i2c_isa                 3584  1 w83627hf
> lm75                    6416  0
> hwmon_vid               2304  1 w83627hf
> drm                    54420  0
> agpgart                23392  2 nvidia,drm
> nvram                   6536  0
> video                  13316  0
> hw_random               4760  0
> snd_intel8x0           25628  0
> snd_ac97_codec         79648  1 snd_intel8x0
> snd_ac97_bus            2048  1 snd_ac97_codec
> snd_pcm_oss            39200  0
> snd_mixer_oss          13696  1 snd_pcm_oss
> snd_pcm                65284  3 snd_intel8x0,snd_ac97_codec,snd_pcm_oss
> snd_timer              17412  2 snd_seq,snd_pcm
> sd_mod                 11264  3
> snd                    39520  9 snd_seq_oss,snd_seq,snd_seq_device,snd_intel8x0,snd_ac97_codec,snd_pcm_oss,snd_mixer_oss,snd_pcm,snd_timer
> 8250_pnp                8448  0
> hsfpcibasic2           59664  2
> hsfserial              20420  4 hsfpcibasic2
> uhci_hcd               24720  0
> ehci_hcd               24712  0
> ohci1394               26416  0
> hsfengine            1312660  2 hsfpcibasic2,hsfserial
> hsfosspec              84328  4 hsfpcibasic2,hsfserial,hsfengine
> 8250                   18272  2 8250_pci,8250_pnp
> i2c_i801                7180  0
> ata_piix                7300  1
> libata                 44560  1 ata_piix
> ieee1394              273464  1 ohci1394
> soundcore               6752  1 snd
> usbcore                95776  8 ohci_hcd,usb_storage,usbhid,usblp,uhci_hcd,ehci_hcd,hsfosspec
> serial_core            15104  2 hsfserial,8250
> scsi_mod               72044  4 sg,usb_storage,sd_mod,libata
> sk98lin               130400  0
> pcspkr                  2692  0
> i2c_core               15360  10 nvidia,rivafb,nvidiafb,i2c_algo_bit,eeprom,i2c_dev,w83627hf,i2c_isa,lm75,i2c_i801
> snd_page_alloc          7688  2 snd_intel8x0,snd_pcm
> parport_pc             28272  0
> parport                30408  1 parport_pc
> rtc                     9652  1
> ide_cd                 31136  1
> hsfsoar                85384  1 hsfpcibasic2

3.Motherboard is an ASUS P4P800, Kernel is 2.6.16, lm-sensors version is
Version : 1:2.10.0-5


Hope it's not too long.

Thanks for your help

mahashakti89
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEcJ24PPuyRSaD7LoRAhLjAKCX4TXpb9BCdUSA8Owwrn5o+Qo0swCgg8GD
MRhYZi4yFTcfsexEiUsIzII=lHAm
-----END PGP SIGNATURE-----



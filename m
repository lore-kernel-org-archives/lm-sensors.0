From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 08 Apr 2015 18:27:05 +0000
Subject: Re: [lm-sensors] Kernel Panic when running sensors on new CentOS kernel (3.10.0-229.1.2)
Message-Id: <20150408182705.GA27367@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <55256D66.1000400@winfirst.com>
In-Reply-To: <55256D66.1000400@winfirst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Wed, Apr 08, 2015 at 11:03:18AM -0700, Mark Hansen wrote:
> lm-sensors team,
>=20
> First, thank you very much for all your work providing us with such a use=
ful and necessary
> tool.
>=20
> I've just upgraded my CentOS system from 7.0.1406 to 7.1.1503 (kernel: 3.=
10.0-229.1.2).
>=20
> The upgrade seemed to go without any problems, but since then the machine=
 has been rebooting
> at what looked like regular intervals. If I boot on the previous kernel (=
3.10.0-123.20.1),
> the problem doesn't occur.
>=20
> I've narrowed the problem down to what looks like a kernel panic whenever=
 the 'sensors' command
> is run (from the lm_sensors-3.3.4-11 package). Note that sensors has been=
 running fine with
> this configuration for several months. Only after upgrading the O/S to 7.=
1 did it start having
> this problem. I haven't made any other configuration changes to the senso=
rs package.
>=20
> Each time this happens, there is a lot of information written to the scre=
en that is gone before
> I can get a good look at it. I took a picture of the screen right when I =
ran the sensors command
> and found that the information is also written to the vcore-dmesg.txt fil=
e that is left in the
> /var/crash/<IP-date-time> directory (along with a vcore file). The last p=
art of the text file
> is shown below.
>=20
> Based on the information (shown below) it seems the sensors command is ha=
ving a problem when
> trying to read the sensor chip on the Radeon display card.
>=20
> The motherboard in the machine is an ASUS M5A97 R2.0
> The display adapter is an "XFX Radeon AMD ONE 1GB 5450 DDR3 HDMI PCIe"
>=20
> When I run sensors while running on the previous kernel, it does include =
the following
> section:
>=20
> radeon-pci-0100
> Adapter: PCI adapter
> temp1:        +49.5=B0C
>=20
> so it seems it is trying to read the sensors chip from the display adapte=
r card.
>=20
> Is there something I need to do to get sensors running with the new kerne=
l?
> What other information can I get for you?
>=20
> Thanks,
>=20
> Excerpt from the vcore-dmesg.txt file after the kernel panics:
>=20
>     [  284.171817] BUG: unable to handle kernel NULL pointer dereference =
at 00000000000001d8
>     [  284.171896] IP: [<ffffffffa01a1fd2>] radeon_hwmon_show_temp+0x32/0=
x70 [radeon]
>     [  284.172009] PGD 0
>     [  284.172034] Oops: 0000 [#1] SMP
>     [  284.172072] Modules linked in: xt_nat xt_conntrack nf_log_ipv4
> nf_log_common xt_LOG iptable_filter nf_nat_ftp iptable_nat nf_nat_ipv4
> nf_nat nf_conntrack_irc nf_conntrack_ftp nf_conntrack_ipv4 nf_defrag_ipv4
> nf_conntrack ip_tables it87 hwmon_vid eeepc_wmi asus_wmi sparse_keymap
> rfkill kvm_amd kvm crct10dif_pclmul crc32_pclmul crc32c_intel
> ghash_clmulni_intel aesni_intel lrw gf128mul glue_helper ablk_helper video
> pcspkr snd_hda_codec_realtek snd_hda_codec_generic snd_hda_codec_hdmi
> snd_hda_intel snd_hda_controller snd_hda_codec snd_hwdep snd_seq
> snd_seq_device snd_pcm snd_timer snd sp5100_tco cryptd soundcore serio_raw
> mxm_wmi tpm_infineon k10temp fam15h_power edac_mce_amd edac_core i2c_piix4
> shpchp wmi acpi_cpufreq xfs libcrc32c sd_mod sr_mod crc_t10dif cdrom
> crct10dif_common radeon i2c_algo_bit
>     [  284.172939]  drm_kms_helper ttm ahci libahci drm libata r8169 i2c_=
core mii dm_mirror dm_region_hash dm_log dm_mod
>     [  284.173068] CPU: 3 PID: 2579 Comm: sensors Not tainted 3.10.0-229.=
1.2.el7.x86_64 #1
>     [  284.173133] Hardware name: To be filled by O.E.M. To be filled by =
O.E.M./M5A97 R2.0, BIOS 2301 01/06/2014
>     [  284.173213] task: ffff88022f6038e0 ti: ffff8800b78f8000 task.ti: f=
fff8800b78f8000
>     [  284.173276] RIP: 0010:[<ffffffffa01a1fd2>]  [<ffffffffa01a1fd2>] r=
adeon_hwmon_show_temp+0x32/0x70 [radeon]
>     [  284.173398] RSP: 0018:ffff8800b78fbe88  EFLAGS: 00010246
>     [  284.173444] RAX: ffff88022f5b4000 RBX: ffff88022ffd1000 RCX: 00000=
00000000000
>     [  284.173504] RDX: 0000000000000000 RSI: ffffffffa0277460 RDI: ffff8=
8022ee6c400
>     [  284.173590] RBP: ffff8800b78fbe90 R08: ffffffff8183c4e0 R09: ffffe=
a0008bff480
>     [  284.173649] R10: 0000000000003525 R11: 0000000000000246 R12: ffff8=
800b78fbf48
>     [  284.173709] R13: 0000000000001000 R14: ffff88022d3fa360 R15: ffff8=
8022ee90070
>     [  284.173769] FS:  00007f25769fe740(0000) GS:ffff88023ecc0000(0000) =
knlGS:0000000000000000
>     [  284.173840] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>     [  284.173888] CR2: 00000000000001d8 CR3: 00000000b78ac000 CR4: 00000=
000000407e0
>     [  284.173948] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 00000=
00000000000
>     [  284.174008] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 00000=
00000000400
>     [  284.174067] Stack:
>     [  284.174087]  ffffffffa0277460 ffff8800b78fbeb0 ffffffff813cec30 ff=
ff8800b78fbeb0
>     [  284.174165]  ffff88022d3fa380 ffff8800b78fbf00 ffffffff8123d38a ff=
ff88022ee6c410
>     [  284.174242]  ffffffff8168eaf0 00007f25769fc000 ffff880231424500 00=
007f25769fc000
>     [  284.174319] Call Trace:
>     [  284.174354]  [<ffffffff813cec30>] dev_attr_show+0x20/0x60
>     [  284.174405]  [<ffffffff8123d38a>] sysfs_read_file+0x9a/0x1a0
>     [  284.174460]  [<ffffffff811c6acc>] vfs_read+0x9c/0x170
>     [  284.174507]  [<ffffffff811c75f8>] SyS_read+0x58/0xb0
>     [  284.174555]  [<ffffffff81614a29>] system_call_fastpath+0x16/0x1b
>     [  284.174607] Code: 89 e5 53 48 89 d3 e8 7e 0d 23 e1 f6 80 6b 01 00 =
00
> 02 48 8b 50 08 74 0a 8b 92 60 05 00 00 85 d2 75 37 48 8b 90 e0 16 00 00 31
> c9 <48> 8b b2 d8 01 00 00 48 85 f6 74 07 48 89 c7 ff d6 89 c1 48 c7
>     [  284.175044] RIP  [<ffffffffa01a1fd2>] radeon_hwmon_show_temp+0x32/=
0x70 [radeon]
>     [  284.175147]  RSP <ffff8800b78fbe88>
>     [  284.175178] CR2: 00000000000001d8
>=20
I would guess that some patch from a later kernel version was back-ported,
but is missing a critical part. Do you know if the source code for that ker=
nel
is available somewhere ?

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 08 Feb 2012 00:27:40 +0000
Subject: Re: [lm-sensors] lm-sensors and Kernel driver w83627ehf
Message-Id: <20120208002740.GA18795@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Tue, Feb 07, 2012 at 02:08:37AM -0500, Patrick Marty wrote:
> Dear Guenter,
>=20
> Here are some detailed informations.
> Hope it helps :)
>=20
>=20
Forwarding this to the lm-sensors list so people know what is going on.
This is seen with the latest version of the w83627ehf driver in my -next br=
anch,
and the driver in the master branch of my repository on github.

So far I have no clue what is causing the problem.

Guenter

> >> when I run sensors-detect, I got this ( abbreviated ) output :
> >>
> >> Driver `to-be-written':
> >> =A0 * ISA bus, address 0x290
> >> =A0 =A0 Chip `Nuvoton NCT6776F Super IO Sensors' (confidence: 9)
> >>
> > Probably this is an old version of sensors-detect.
>=20
>=20
> sensor-detect : revision 5946
> sensors version : 3.3.0
> lm-sensors package version : 3.3.0-4
>=20
>=20
> > Do you see an error
> > message with dmesg ?
>=20
> yes here is the error message given by dmesg after running modprobe w8362=
7ehf:
>=20
> [  237.889559] BUG: unable to handle kernel paging request at ffffffffa0c=
7c2e4
> [  237.889566] IP: [<ffffffff81032919>] __ticket_spin_lock+0x9/0x20
> [  237.889574] PGD 1c05067 PUD 1c09063 PMD 3f0bd7067 PTE 3eaa56161
> [  237.889580] Oops: 0003 [#1] SMP
> [  237.889584] CPU 4
> [  237.889585] Modules linked in: w83627ehf(-) hwmon_vid parport_pc
> dm_crypt ppdev bnep rfcomm snd_hda_codec_hdmi joydev wacom nvidia(P)
> snd_hda_codec_realtek mxm_wmi eeepc_wmi asus_wmi sparse_keymap
> binfmt_misc btusb bluetooth snd_seq_midi snd_hda_intel snd_hda_codec
> psmouse snd_hwdep serio_raw snd_pcm snd_rawmidi snd_seq_midi_event
> snd_seq snd_timer snd_seq_device snd mei(C) wmi soundcore
> snd_page_alloc coretemp lp parport vesafb usbhid hid firewire_ohci
> firewire_core crc_itu_t ahci libahci xhci_hcd e1000e video
> [  237.889624]
> [  237.889627] Pid: 2383, comm: modprobe Tainted: P     	C
> 3.0.0-15-generic #26-Ubuntu System manufacturer System Product
> Name/P8Z68-V PRO GEN3
> [  237.889633] RIP: 0010:[<ffffffff81032919>]  [<ffffffff81032919>]
> __ticket_spin_lock+0x9/0x20
> [  237.889638] RSP: 0018:ffff8803ea889e68  EFLAGS: 00010086
> [  237.889641] RAX: 0000000000010000 RBX: 0000000000000286 RCX: 00000000c=
0000100
> [  237.889644] RDX: 0000000000000000 RSI: 0000000000000286 RDI: ffffffffa=
0c7c2e4
> [  237.889646] RBP: ffff8803ea889e68 R08: ffff8803ea888000 R09: 000000000=
0000000
> [  237.889649] R10: 0000000000000400 R11: 0000000000000001 R12: ffffffffa=
0c7c2e4
> [  237.889651] R13: 0000000000000000 R14: ffffffff8109ffde R15: 000000000=
000000f
> [  237.889655] FS:  00007f39a4f00720(0000) GS:ffff88041f500000(0000)
> knlGS:0000000000000000
> [  237.889658] CS:  0010 DS: 0000 ES: 0000 CR0: 000000008005003b
> [  237.889660] CR2: ffffffffa0c7c2e4 CR3: 00000003eaf2e000 CR4: 000000000=
00406e0
> [  237.889663] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 000000000=
0000000
> [  237.889666] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 000000000=
0000400
> [  237.889669] Process modprobe (pid: 2383, threadinfo
> ffff8803ea888000, task ffff880402b71720)
> [  237.889671] Stack:
> [  237.889673]  ffff8803ea889e78 ffffffff810329b9 ffff8803ea889e98
> ffffffff815f208e
> [  237.889678]  ffffffffa0c7bcd4 ffffffffa0c7c2e4 ffff8803ea889ef8
> ffffffff81057179
> [  237.889682]  ffff880402b71720 ffffffff81057340 dead000000100100
> dead000000200200
> [  237.889687] Call Trace:
> [  237.889691]  [<ffffffff810329b9>] default_spin_lock_flags+0x9/0x10
> [  237.889696]  [<ffffffff815f208e>] _raw_spin_lock_irqsave+0x2e/0x40
> [  237.889703]  [<ffffffffa0c7bcd4>] ? store_tolerance+0x184/0x184 [w8362=
7ehf]
> [  237.889708]  [<ffffffffa0c7c2e4>] ? w83627ehf_probe+0x59e/0x22ba [w836=
27ehf]
> [  237.889713]  [<ffffffff81057179>] try_to_wake_up+0x39/0x200
> [  237.889716]  [<ffffffff81057340>] ? try_to_wake_up+0x200/0x200
> [  237.889721]  [<ffffffff8109ffde>] ? sys_init_module+0x1be/0x230
> [  237.889724]  [<ffffffff81057375>] wake_up_process+0x15/0x20
> [  237.889727]  [<ffffffff8109d37f>] module_put+0xaf/0xc0
> [  237.889731]  [<ffffffff8109ffde>] sys_init_module+0x1be/0x230
> [  237.889735]  [<ffffffff815fa1c2>] system_call_fastpath+0x16/0x1b
> [  237.889738] Code: 00 00 48 c7 c1 21 27 03 81 48 c7 c2 1e 27 03 81
> e9 dd fe ff ff 90 90 90 90 90 90 90 90 90 90 90 90 90 55 b8 00 00 01
> 00 48 89 e5 <f0> 0f c1 07 0f b7 d0 c1 e8 10 39 c2 74 07 f3 90 0f b7 17
> eb f5
> [  237.889773] RIP  [<ffffffff81032919>] __ticket_spin_lock+0x9/0x20
> [  237.889777]  RSP <ffff8803ea889e68>
> [  237.889779] CR2: ffffffffa0c7c2e4
> [  237.889782] ---[ end trace 99e0d80bf6a60138 ]---
>=20
>=20
> > Also, do you see that the driver is loaded when
> > running "lsmod" ?
>=20
> no the driver is not loaded
>=20
> the first time I load the driver with modprob, I got the error message ab=
ove
> if I try to load the driver again, modprob runs endlessly ( the
> process is marked as sleeping by top command )
>=20
> My kernel version is kernel 3.0.0-15-generic ( ubuntu 11.10 ).
>=20
>=20
>=20
> I have run ubuntu 11.10 from a usb key ( kernel version
> 3.0.0-12-generic, lm-sensors package 3.3.0-4 ).
> The driver w83627 shipped with it loads without error ( but I still
> have to load it manually, sensors-detect don't do it for me ).
> Here is the dmesg output after loading the module with modprobe :
>=20
> [  740.741755] coretemp coretemp.0: TjMax is 98 C.
> [  957.438553] w83627ehf: Found NCT6776F chip at 0x290
>=20
> and the driver is loaded when running lsmod :
>=20
> ubuntu@ubuntu:~$ lsmod | grep w83
> w83627ehf          	38413  0
> hwmon_vid          	12746  1 w83627ehf
>=20
>=20
> Do you need more details ?
>=20
> I am going to re-install my system tomorrow or the day after.
> If you need more information, ask me.
>=20
>=20
> Thanks
>=20
> Best regards, Patrick

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

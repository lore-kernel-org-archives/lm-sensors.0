From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 08 Feb 2012 14:16:41 +0000
Subject: Re: [lm-sensors] lm-sensors and Kernel driver w83627ehf
Message-Id: <20120208141641.GB21061@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120208002740.GA18795@ericsson.com>
In-Reply-To: <20120208002740.GA18795@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Wed, Feb 08, 2012 at 06:39:46AM -0500, Patrick Marty wrote:
> Guenter,
>=20
> I have tested all driver versions with the 3 linux kernels installed
> on my system :
>    * 3.0.0-15-generic
>    * 3.0.0-12-generic
>    * 2.6.38-13-generic
>=20
> I have re-compiled and re-installed each driver version for each kernel v=
ersion.
>=20
> All versions work with kernel 2.6.38-13 ( but you probably already
> know that ) and ... all versions fail with kernels 3.0.0.* ( I mean I
> got an error message when loading the driver with modprobe )
>=20
> I have also tested all driver versions with linux running from an usb
> key with kernel 3.0.0-12-generic.
>=20
> And all versions worked ! No error after loading the driver :)
>=20
> The main differences I could think of with the linux installed on my
> hard drive with the linux from usb key were :
>    * not the same gcc version :
>       * 4.6.1 on usb key
>       * 4.4.6 on hard drive
>    * not the same graphic card driver
>       * nouveau driver on usb key
>       * nvidia driver on hard drive
>=20
> So I have also tried all driver versions compiled with gcc 4.6.1 with
> linux kernel 3.0.0-15-generic ( I unload the driver with modprobe -r
> ... before reloading it and I checked with dmesg & lsmod that the
> driver was loaded :) ).
> And all versions worked :)
>=20
> So It seems that compiling with gcc 4.4.6 is the source of the problem.
> And compiling the driver with gcc 4.6 solved it.
> Do you have any idea why ?
>=20
Puzzled. I am copying Jean and the list ... Jean, any idea ? Compiler bug ?

> I can send you the .o & .ko files compiled with gcc 4.6 if you need them.
>=20
Would be great if you could do that, with -DDEBUG as suggested by Jean
in his other e-mail, to let us find the offending source.

Please keep Jean and the list copied on your replies. We'll need as much su=
pport
as we can get on this one.

Thanks,
Guenter

> Yours
> Patrick
>=20
>=20
> 2012/2/7 Guenter Roeck <guenter.roeck@ericsson.com>:
> > Patrick,
> >
> > I must be doing something wrong when disassembling the object file. The
> > offending code seems to be in a part of the driver which should not be
> > executed for NCT6776F. Right now I have no idea what is going on, even
> > after looking at the code for several hours. Which means the only thing
> > we can do is to bisect the problem, ie install the various driver
> > versions until we find the one that works. Please let me know when you
> > get tired of this ...
> >
> > Thanks,
> > Guenter
> >
> > On Tue, 2012-02-07 at 14:00 -0500, Patrick Marty wrote:
> >> Hi Guenter,
> >>
> >> The files are in attachment
> >>
> >> Yours
> >> Patrick
> >>
> >> 2012/2/7 Guenter Roeck <guenter.roeck@ericsson.com>:
> >> > Hi Patrick,
> >> >
> >> > On Tue, Feb 07, 2012 at 02:08:37AM -0500, Patrick Marty wrote:
> >> >> Dear Guenter,
> >> >>
> >> >> Here are some detailed informations.
> >> >> Hope it helps :)
> >> >>
> >> >>
> >> >> >> when I run sensors-detect, I got this ( abbreviated ) output :
> >> >> >>
> >> >> >> Driver `to-be-written':
> >> >> >> =A0 * ISA bus, address 0x290
> >> >> >> =A0 =A0 Chip `Nuvoton NCT6776F Super IO Sensors' (confidence: 9)
> >> >> >>
> >> >> > Probably this is an old version of sensors-detect.
> >> >>
> >> >>
> >> >> sensor-detect : revision 5946
> >> >> sensors version : 3.3.0
> >> >> lm-sensors package version : 3.3.0-4
> >> >>
> >> >>
> >> >> > Do you see an error
> >> >> > message with dmesg ?
> >> >>
> >> >> yes here is the error message given by dmesg after running modprobe=
 w83627ehf:
> >> >>
> >> >> [ =A0237.889559] BUG: unable to handle kernel paging request at fff=
fffffa0c7c2e4
> >> >> [ =A0237.889566] IP: [<ffffffff81032919>] __ticket_spin_lock+0x9/0x=
20
> >> >> [ =A0237.889574] PGD 1c05067 PUD 1c09063 PMD 3f0bd7067 PTE 3eaa56161
> >> >> [ =A0237.889580] Oops: 0003 [#1] SMP
> >> >> [ =A0237.889584] CPU 4
> >> >> [ =A0237.889585] Modules linked in: w83627ehf(-) hwmon_vid parport_=
pc
> >> >> dm_crypt ppdev bnep rfcomm snd_hda_codec_hdmi joydev wacom nvidia(P)
> >> >> snd_hda_codec_realtek mxm_wmi eeepc_wmi asus_wmi sparse_keymap
> >> >> binfmt_misc btusb bluetooth snd_seq_midi snd_hda_intel snd_hda_codec
> >> >> psmouse snd_hwdep serio_raw snd_pcm snd_rawmidi snd_seq_midi_event
> >> >> snd_seq snd_timer snd_seq_device snd mei(C) wmi soundcore
> >> >> snd_page_alloc coretemp lp parport vesafb usbhid hid firewire_ohci
> >> >> firewire_core crc_itu_t ahci libahci xhci_hcd e1000e video
> >> >> [ =A0237.889624]
> >> >> [ =A0237.889627] Pid: 2383, comm: modprobe Tainted: P =A0 =A0 =A0 =
=A0 =A0 C
> >> >> 3.0.0-15-generic #26-Ubuntu System manufacturer System Product
> >> >> Name/P8Z68-V PRO GEN3
> >> >> [ =A0237.889633] RIP: 0010:[<ffffffff81032919>] =A0[<ffffffff810329=
19>]
> >> >> __ticket_spin_lock+0x9/0x20
> >> >> [ =A0237.889638] RSP: 0018:ffff8803ea889e68 =A0EFLAGS: 00010086
> >> >> [ =A0237.889641] RAX: 0000000000010000 RBX: 0000000000000286 RCX: 0=
0000000c0000100
> >> >> [ =A0237.889644] RDX: 0000000000000000 RSI: 0000000000000286 RDI: f=
fffffffa0c7c2e4
> >> >> [ =A0237.889646] RBP: ffff8803ea889e68 R08: ffff8803ea888000 R09: 0=
000000000000000
> >> >> [ =A0237.889649] R10: 0000000000000400 R11: 0000000000000001 R12: f=
fffffffa0c7c2e4
> >> >> [ =A0237.889651] R13: 0000000000000000 R14: ffffffff8109ffde R15: 0=
00000000000000f
> >> >> [ =A0237.889655] FS: =A000007f39a4f00720(0000) GS:ffff88041f500000(=
0000)
> >> >> knlGS:0000000000000000
> >> >> [ =A0237.889658] CS: =A00010 DS: 0000 ES: 0000 CR0: 000000008005003b
> >> >> [ =A0237.889660] CR2: ffffffffa0c7c2e4 CR3: 00000003eaf2e000 CR4: 0=
0000000000406e0
> >> >> [ =A0237.889663] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0=
000000000000000
> >> >> [ =A0237.889666] DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0=
000000000000400
> >> >> [ =A0237.889669] Process modprobe (pid: 2383, threadinfo
> >> >> ffff8803ea888000, task ffff880402b71720)
> >> >> [ =A0237.889671] Stack:
> >> >> [ =A0237.889673] =A0ffff8803ea889e78 ffffffff810329b9 ffff8803ea889=
e98
> >> >> ffffffff815f208e
> >> >> [ =A0237.889678] =A0ffffffffa0c7bcd4 ffffffffa0c7c2e4 ffff8803ea889=
ef8
> >> >> ffffffff81057179
> >> >> [ =A0237.889682] =A0ffff880402b71720 ffffffff81057340 dead000000100=
100
> >> >> dead000000200200
> >> >> [ =A0237.889687] Call Trace:
> >> >> [ =A0237.889691] =A0[<ffffffff810329b9>] default_spin_lock_flags+0x=
9/0x10
> >> >> [ =A0237.889696] =A0[<ffffffff815f208e>] _raw_spin_lock_irqsave+0x2=
e/0x40
> >> >> [ =A0237.889703] =A0[<ffffffffa0c7bcd4>] ? store_tolerance+0x184/0x=
184 [w83627ehf]
> >> >> [ =A0237.889708] =A0[<ffffffffa0c7c2e4>] ? w83627ehf_probe+0x59e/0x=
22ba [w83627ehf]
> >> >> [ =A0237.889713] =A0[<ffffffff81057179>] try_to_wake_up+0x39/0x200
> >> >> [ =A0237.889716] =A0[<ffffffff81057340>] ? try_to_wake_up+0x200/0x2=
00
> >> >> [ =A0237.889721] =A0[<ffffffff8109ffde>] ? sys_init_module+0x1be/0x=
230
> >> >> [ =A0237.889724] =A0[<ffffffff81057375>] wake_up_process+0x15/0x20
> >> >> [ =A0237.889727] =A0[<ffffffff8109d37f>] module_put+0xaf/0xc0
> >> >> [ =A0237.889731] =A0[<ffffffff8109ffde>] sys_init_module+0x1be/0x230
> >> >> [ =A0237.889735] =A0[<ffffffff815fa1c2>] system_call_fastpath+0x16/=
0x1b
> >> >> [ =A0237.889738] Code: 00 00 48 c7 c1 21 27 03 81 48 c7 c2 1e 27 03=
 81
> >> >> e9 dd fe ff ff 90 90 90 90 90 90 90 90 90 90 90 90 90 55 b8 00 00 01
> >> >> 00 48 89 e5 <f0> 0f c1 07 0f b7 d0 c1 e8 10 39 c2 74 07 f3 90 0f b7=
 17
> >> >> eb f5
> >> >> [ =A0237.889773] RIP =A0[<ffffffff81032919>] __ticket_spin_lock+0x9=
/0x20
> >> >> [ =A0237.889777] =A0RSP <ffff8803ea889e68>
> >> >> [ =A0237.889779] CR2: ffffffffa0c7c2e4
> >> >> [ =A0237.889782] ---[ end trace 99e0d80bf6a60138 ]---
> >> >>
> >> >
> >> > Yes and no ... that code path doesn't make any sense :(.
> >> >
> >> > Can you send me w83627ehf.o and w83627ehf.ko as attachments ?
> >> >
> >> > Thanks,
> >> > Guenter
> >
> >

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

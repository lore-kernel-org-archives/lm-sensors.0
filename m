From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:24:03 +0000
Subject: Trouble with i2c and bttv
Message-Id: <3F05E2BC.9050607@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307042024.55272.tim.boneko@web.de>
In-Reply-To: <200307042024.55272.tim.boneko@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

i2c-2.8.0 isn't compatible with existing i2c drivers in the kernel due
to struct changes.

Tim Boneko wrote:
> Hello!
> I'm running linux for years now, but this is my very first bug report,=20
> and i hope it's helpful. If not, sorry for the bother...
>=20
> On June 29, i pulled the latest i2c and lm_sensors drivers via CVS and=20
> got them working on my PC (MB: Asus A7N8X with nforce2 chipset,=20
> Kernel: 2.4.21-vanilla, a Hauppauge TV card (see log excerpt below).=20
> I did _not_ patch the kernel but replaced the kernel i2c modules with=20
> the downloaded+compiled ones.)
> Worked fine so far, maybe except for the 4.08 volt reading appearing=20
> from time to time on various voltage measures, even "VCore1".
> After such a successful installation i needed some relaxing and wanted=20
> to watch TV. "modprobe bttv" made my kernel go "Oops".
> This module depends on i2c-algo-bit and i2c-core which were replaced=20
> by the i2c-drivers, so i guess there's a problem here.=20
> Below is the output of "lsmod" (before loading bttv.o) and an excerpt=20
> from my /var/log/kern.log after that.
>=20
> Greetings,
>=20
> 	tim
>=20
> lsmod:
> Module                  Size  Used by    Not tainted
> snd-mixer-oss          13528   0  (autoclean)
> w83781d                22320   0  (unused)
> eeprom                  3440   0  (unused)
> i2c-proc                6260   0  [w83781d eeprom]
> i2c-nforce2             3176   0  (unused)
> i2c-core               13924   0  [w83781d eeprom i2c-proc=20
> i2c-nforce2]
> serial                 46660   0  (autoclean)
> snd-intel8x0           18052   2
> snd-ac97-codec         40200   0  [snd-intel8x0]
> snd-pcm                62016   2  [snd-intel8x0]
> snd-timer              14820   0  [snd-pcm]
> snd-page-alloc          5244   0  [snd-intel8x0 snd-pcm]
> snd-mpu401-uart         3440   0  [snd-intel8x0]
> snd-rawmidi            14016   0  [snd-mpu401-uart]
> snd-seq-device          4304   0  [snd-rawmidi]
> snd                    30532   0  [snd-mixer-oss snd-intel8x0=20
> snd-ac97-codec snd-pcm snd-timer snd-mpu401-uart snd-rawmidi=20
> snd-seq-device]
> soundcore               3844   1  [snd]
> nls_cp437               4380   1  (autoclean)
> vfat                   10636   1  (autoclean)
> fat                    32472   0  (autoclean) [vfat]
> apm                    10248   1
> nls_iso8859-15          3388   1
> nls_cp850               3612   0  (unused)
> printer                 7392   0
> usb-storage            25104   0  (unused)
> usb-ohci               19016   0  (unused)
> usbcore                62528   0  [printer usb-storage usb-ohci]
> unix                   15752  99  (autoclean)
>=20
> /var/log/kern.log:
>=20
> Jul  4 14:25:04 timbo kernel: bttv: driver version 0.7.104 loaded
> Jul  4 14:25:04 timbo kernel: bttv: using 4 buffers with 2080k (8320k=20
> total) for capture
> Jul  4 14:25:04 timbo kernel: bttv: Host bridge is PCI device=20
> 10de:01e0 (nVidia Corporation)
> Jul  4 14:25:04 timbo kernel: bttv: Bt8xx card found (0).
> Jul  4 14:25:04 timbo kernel: bttv0: Bt878 (rev 2) at 01:0a.0, irq:=20
> 11, latency: 32, mmio: 0xe8000000
> Jul  4 14:25:04 timbo kernel: bttv0: detected: Hauppauge WinTV=20
> [card=10], PCI subsystem ID is 0070:13eb
> Jul  4 14:25:04 timbo kernel: bttv0: using: BT878(Hauppauge (bt878))=20
> [card=10,insmod option]
> Jul  4 14:25:04 timbo kernel: bttv0: Hauppauge/Voodoo msp34xx: reset=20
> line init [5]
> Jul  4 14:25:04 timbo kernel: Unable to handle kernel paging request=20
> at virtual address 0d83e14e
> Jul  4 14:25:04 timbo kernel:  printing eip:
> Jul  4 14:25:04 timbo kernel: 0d83e14e
> Jul  4 14:25:04 timbo kernel: *pde =3D 00000000
> Jul  4 14:25:04 timbo kernel: Oops: 0000
> Jul  4 14:25:04 timbo kernel: CPU:    0
> Jul  4 14:25:04 timbo kernel: EIP:    0010:[<0d83e14e>]    Not tainted
> Jul  4 14:25:04 timbo kernel: EFLAGS: 00010292
> Jul  4 14:25:04 timbo kernel: eax: e14f12e0   ebx: e14f12e0   ecx:=20
> e14f9764   edx: 00000000
> Jul  4 14:25:04 timbo kernel: esi: e14f9728   edi: 00000001   ebp:=20
> 00000000   esp: d468dbe0
> Jul  4 14:25:04 timbo kernel: ds: 0018   es: 0018   ss: 0018
> Jul  4 14:25:04 timbo kernel: Process modprobe (pid: 1443,=20
> stackpage=D468d000)
> Jul  4 14:25:04 timbo kernel: Stack: e149d07b 801005ff 00000000=20
> c0237048 00000292 00000292 c0237048 e14f9764=20
> Jul  4 14:25:04 timbo kernel:        e149dbd4 e14f12e0 c0237048=20
> c0237048 c0237048 00000000 c0279dc0 e14f12e0=20
> Jul  4 14:25:04 timbo kernel:        e14f9764 e14f9728 00000001=20
> 00000000 e146ac51 e14f9728 d468dc84 00000001=20
> Jul  4 14:25:04 timbo kernel: Call Trace:   =20
> [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.21/kernel/net/i=
pv+-298885/128]=20
> [<e14f9764>]=20
> [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.21/kernel/net/i=
pv+-295980/128]=20
> [<e14f12e0>] [<e14f12e0>]
> Jul  4 14:25:04 timbo kernel:   [<e14f9764>] [<e14f9728>]=20
> [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.21/kernel/net/i=
pv+-504751/128]=20
> [<e14f9728>]=20
> [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.21/kernel/net/i=
pv+-296004/128]=20
> [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.21/kernel/net/i=
pv+-501226/128]
> Jul  4 14:25:04 timbo kernel:   [<e14f9728>] [fbcon_scroll+1962/3216]=20
> [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.21/kernel/net/i=
pv+-500307/128]=20
> [<e14f9728>]=20
> [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.21/kernel/net/i=
pv+-291648/128]=20
> [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.21/kernel/net/i=
pv+-464416/128]
> Jul  4 14:25:04 timbo kernel:  =20
> [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.21/kernel/net/i=
pv+-464816/128]=20
> [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.21/kernel/net/i=
pv+-475221/128]=20
> [<e14f9728>] [<e14f9728>]=20
> [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.21/kernel/net/i=
pv+-494208/128]=20
> [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.21/kernel/net/i=
pv+-466826/128]
> Jul  4 14:25:04 timbo kernel:   [<e14f9728>]=20
> [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.21/kernel/net/i=
pv+-464416/128]=20
> [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.21/kernel/net/i=
pv+-466820/128]=20
> [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.21/kernel/net/i=
pv+-507581/128]=20
> [<e14f9728>] [vsnprintf+545/1104]
> Jul  4 14:25:04 timbo kernel:   [<e14f972f>] [<e14f9580>] [<e14f9728>]=20
> [<e14f980c>] [<e14f972e>] [<e14f9728>]
> Jul  4 14:25:04 timbo kernel:  =20
> [ipt_MASQUERADE:__insmod_ipt_MASQUERADE_O/lib/modules/2.4.21/kernel/net/i=
pv+-295623/128]=20
> [<e14f9728>] [<e14f4cd7>] [sprintf+31/48] [<e14f972d>] [<e14f4cd3>]
> Jul  4 14:25:04 timbo kernel:   [<e14f9580>] [<e14f1724>] [<e14f9728>]=20
> [<e14f9580>] [<e14ed06a>] [<e14f9580>]
> Jul  4 14:25:04 timbo kernel:   [pci_set_master+52/96] [<e14f9580>]=20
> [<e14edcf6>] [<e14f9580>] [<e14ed110>] [<e14f3e9c>]
> Jul  4 14:25:04 timbo kernel:   [<e14f9580>] [printk+279/336]=20
> [<e14f5438>] [<e14f54a0>] [pci_announce_device+53/112] [<e14f5438>]
> Jul  4 14:25:04 timbo kernel:   [<e14f54a0>]=20
> [pci_register_driver+92/96] [<e14f54a0>] [<e14ede61>] [<e14f54a0>]=20
> [sys_init_module+1201/1584]
> Jul  4 14:25:04 timbo kernel:   [<e14e8060>] [<e14f4f3c>] [<e14e8060>]=20
> [system_call+51/56]
> Jul  4 14:25:04 timbo kernel:=20
> Jul  4 14:25:04 timbo kernel: Code:  Bad EIP value.
>=20

From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 01 Dec 2011 00:26:39 +0000
Subject: Re: [lm-sensors] coretemp kernel opps lm-sensors
Message-Id: <20111201012639.04a57fc9@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Thu, 01 Dec 2011 07:25:15 +0800 (HKT), undersys wrote:
> Hi All,
>=20
> I can no longer load the core temp module, it gives me the following kern=
el Opps.
> "
> [   10.159508] coretemp coretemp.0: Errata AE18 not fixed, update BIOS or=
 microcode of the CPU!
> [   10.159527] BUG: unable to handle kernel NULL pointer dereference at 0=
0000010
> [   10.159810] IP: [<f81fb1b5>] coretemp_add_core+0x6a/0x3cd [coretemp]
> [   10.160003] *pde =3D 00000000=20
> [   10.160003] Oops: 0000 [#1] SMP=20
> [   10.160003] Modules linked in: coretemp(+) w83627hf hwmon_vid w83792d =
e1000e piix i2c_i801
> [   10.160003]=20
> [   10.160003] Pid: 1806, comm: modprobe Not tainted 3.0.6-gentoo #3 Supe=
rmicro X6DLP/X6DLP
> [   10.160003] EIP: 0060:[<f81fb1b5>] EFLAGS: 00010283 CPU: 3
> [   10.160003] EIP is at coretemp_add_core+0x6a/0x3cd [coretemp]
> [   10.160003] EAX: 00000000 EBX: 00000000 ECX: 00000002 EDX: 00000000
> [   10.160003] ESI: f52d6c08 EDI: c163d200 EBP: f5703f54 ESP: f5703f14
> [   10.160003]  DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068
> [   10.160003] Process modprobe (pid: 1806, ti=F5702000 task=F54a2be0 tas=
k.ti=F5702000)
> [   10.160003] Stack:
> [   10.160003]  f5703f24 00000000 349c8000 00000002 00000000 f52d6c00 000=
00000 f52d6c00
> [   10.160003]  00000000 ffffffea f5703f54 c12a4690 000080d0 00000000 f60=
05200 f5cc19d0
> [   10.160003]  f5703f6c f81fb93b f52d6c00 00000000 c15dd3e0 00000000 f57=
03f80 f81fe03f
> [   10.160003] Call Trace:
> [   10.160003]  [<c12a4690>] ? platform_device_add+0xe4/0x12b
> [   10.160003]  [<f81fb93b>] get_core_online+0x10c/0x114 [coretemp]
> [   10.160003]  [<f81fe03f>] coretemp_init+0x3f/0x69 [coretemp]
> [   10.160003]  [<c1001071>] do_one_initcall+0x71/0x113
> [   10.160003]  [<f81fe000>] ? 0xf81fdfff
> [   10.160003]  [<c105473b>] sys_init_module+0x61/0x18b
> [   10.160003]  [<c13ce1cc>] sysenter_do_call+0x12/0x22
> [   10.160003] Code: 45 d0 8b 04 85 b4 d2 5d c1 89 45 c8 75 17 0f b7 84 0=
7 ac 00 00 00 83 c0 02 89 45 cc 83 f8 11 0f 8f 3d 03 00 00 8b 4d cc 8b 45 c=
4=20
> [   10.160003]  7c 88 08 00 0f 85 50 03 00 00 a1 c8 d5 6a c1 bb 10 00 00 =
00=20
> [   10.160003] EIP: [<f81fb1b5>] coretemp_add_core+0x6a/0x3cd [coretemp] =
SS:ESP 0068:f5703f14
> [   10.160003] CR2: 0000000000000010
> [   10.173839] ---[ end trace 9066c45a15eac66e ]---
> "
>=20
> This used to work fine before I updated the kernel to 3.0.x. (...)

Ah, yes, I can reproduce that, and the bug is pretty obvious. I'll send
a patch tomorrow.

Meanwhile you may be able to work around the problem by installing the
microcode_ctl package and ensuring that the microcode is updated before
loading the coretemp driver.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:30 +0000
Subject: [OOPS] from 2.4.18-pre9-mjc2
Message-Id: <3C8033B4.7109E4ED@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020219055319.GG1328@manatee.fluffyspider.com.au>
In-Reply-To: <20020219055319.GG1328@manatee.fluffyspider.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

thanks.

i2cproc_bus_read generates the output for
the /proc/bus/i2c-x files.

I just tried 2.4.18 and I'm not getting an oops but
I'm getting 'invalid argument' from 'cat' so something is wrong.
Something must have changed in 2.4.18...

mds


Matt wrote:
>=20
> not sure if you guys are interested in this but here it is anyway..
>=20
> Unable to handle kernel NULL pointer dereference at virtual address 00000=
0e0
> e08dfbe9
> *pde =3D 00000000
> Oops: 0000
> CPU:    0
> EIP:    0010:[<e08dfbe9>]    Not tainted
> EFLAGS: 00210297
> eax: 00001197   ebx: d5203140   ecx: dee48640   edx: 00000000
> esi: ffffffea   edi: 00000000   ebp: 00000400   esp: cf30debc
> ds: 0018   es: 0018   ss: 0018
> Process cat (pid: 1285, stackpage=CF30d000)
> Stack: 400e6460 e08e22c0 dab1a398 00000400 00000000 c013704d d65727c8 000=
00f88
>        d2e03640 c014b36c d2e03640 c025e538 dd8ac00a 00000005 1104665a dee=
48640
>        ffffffeb 00008001 c0143e29 dee48640 00000004 00000000 00000004 dea=
a17c0
> Call Trace: [<e08e22c0>] [<c013704d>] [<c014b36c>] [<c0143e29>] [<c012852=
3>]
>    [<c0138d9f>] [<c0106eb3>]
> Code: 39 82 e0 00 00 00 74 16 83 44 24 04 04 81 7c 24 04 fc 22 8e
>=20
> >>EIP; e08dfbe8 <[i2c-core]i2cproc_bus_read+88/290>   <=3D=3D> Trace; e08=
e22c0 <[i2c-core]adapters+0/40>
> Trace; c013704c <page_remove_rmap+7c/90>
> Trace; c014b36c <dput+1c/1a0>
> Trace; c0143e28 <open_namei+228/570>
> Trace; c0128522 <unmap_fixup+162/170>
> Trace; c0138d9e <sys_read+ae/d0>
> Trace; c0106eb2 <system_call+32/38>
> Code;  e08dfbe8 <[i2c-core]i2cproc_bus_read+88/290>
> 00000000 <_EIP>:
> Code;  e08dfbe8 <[i2c-core]i2cproc_bus_read+88/290>   <=3D=3D>    0:   39=
 82 e0 00 00 00         cmp    %eax,0xe0(%edx)   <=3D=3D> Code;  e08dfbee <=
[i2c-core]i2cproc_bus_read+8e/290>
>    6:   74 16                     je     1e <_EIP+0x1e> e08dfc06 <[i2c-co=
re]i2cproc_bus_read+a6/290>
> Code;  e08dfbf0 <[i2c-core]i2cproc_bus_read+90/290>
>    8:   83 44 24 04 04            addl   $0x4,0x4(%esp,1)
> Code;  e08dfbf4 <[i2c-core]i2cproc_bus_read+94/290>
>    d:   81 7c 24 04 fc 22 8e      cmpl   $0x8e22fc,0x4(%esp,1)
> Code;  e08dfbfc <[i2c-core]i2cproc_bus_read+9c/290>
>   14:   00
>=20
> this was achieved by doing a cat of one of the proc files..

From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:31 +0000
Subject: i2c-core CVS oopsing 2.4; velleman won't compile
Message-Id: <3FF1F4AF.8000809@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

i2c-core oopsing for last couple of weeks.
Also, velleman won't compile.

Are these my problem or are we in the middle of changes or...?

Below are velleman compile output, and ksymoops from i2c-core.

----------------------------------------

kernel/i2c-velleman.c:172: variable `bit_velle_ops' has initializer but inc=
omplete type
kernel/i2c-velleman.c:173: warning: excess elements in struct initializer
kernel/i2c-velleman.c:173: warning: (near initialization for `bit_velle_ops=
')
kernel/i2c-velleman.c:174: `HW_B_LP' undeclared here (not in a function)
kernel/i2c-velleman.c:174: warning: excess elements in struct initializer
kernel/i2c-velleman.c:174: warning: (near initialization for `bit_velle_ops=
')
kernel/i2c-velleman.c:175: warning: excess elements in struct initializer
kernel/i2c-velleman.c:175: warning: (near initialization for `bit_velle_ops=
')
kernel/i2c-velleman.c:176: warning: excess elements in struct initializer
kernel/i2c-velleman.c:176: warning: (near initialization for `bit_velle_ops=
')
kernel/i2c-velleman.c:177: warning: excess elements in struct initializer
kernel/i2c-velleman.c:177: warning: (near initialization for `bit_velle_ops=
')
kernel/i2c-velleman.c:178: warning: excess elements in struct initializer
kernel/i2c-velleman.c:178: warning: (near initialization for `bit_velle_ops=
')
kernel/i2c-velleman.c:179: warning: excess elements in struct initializer
kernel/i2c-velleman.c:179: warning: (near initialization for `bit_velle_ops=
')
kernel/i2c-velleman.c:180: warning: excess elements in struct initializer
kernel/i2c-velleman.c:180: warning: (near initialization for `bit_velle_ops=
')
kernel/i2c-velleman.c:181: warning: excess elements in struct initializer
kernel/i2c-velleman.c:181: warning: (near initialization for `bit_velle_ops=
')
kernel/i2c-velleman.c:182: warning: excess elements in struct initializer
kernel/i2c-velleman.c:182: warning: (near initialization for `bit_velle_ops=
')
kernel/i2c-velleman.c:182: warning: excess elements in struct initializer
kernel/i2c-velleman.c:182: warning: (near initialization for `bit_velle_ops=
')
kernel/i2c-velleman.c:182: warning: excess elements in struct initializer
kernel/i2c-velleman.c:182: warning: (near initialization for `bit_velle_ops=
')
kernel/i2c-velleman.c: In function `bitvelle_init':
kernel/i2c-velleman.c:190: invalid use of undefined type `struct bit_adapte=
r'
kernel/i2c-velleman.c:192: warning: passing arg 1 of `i2c_bit_add_bus_R7898=
61dc' from incompatible pointer type
kernel/i2c-velleman.c:197: invalid use of undefined type `struct bit_adapte=
r'
kernel/i2c-velleman.c:199: warning: passing arg 1 of `i2c_bit_add_bus_R7898=
61dc' from incompatible pointer type
kernel/i2c-velleman.c: In function `cleanup_module':
kernel/i2c-velleman.c:222: warning: passing arg 1 of `i2c_bit_del_bus_Rb0ef=
5531' from incompatible pointer type
make: *** [kernel/i2c-velleman.o] Error 1



----------------------------------------


Unable to handle kernel paging request at virtual address 00050028
d0af1a3e
*pde =3D 00000000
Oops: 0000
CPU:    0
EIP:    0010:[<d0af1a3e>]    Tainted: P=20
EFLAGS: 00010296
eax: 00050000   ebx: 00000006   ecx: fffffffb   edx: d0af33ff
esi: ce4f7000   edi: 00000000   ebp: 00000000   esp: ceb95f50
ds: 0018   es: 0018   ss: 0018
Process sensors (pid: 334, stackpage=CEb95000)
Stack: 00000000 00000400 ce4f7000 00000400 c014eb5a ce4f7000 ceb95f98 00000=
000=20
       00000400 ceb95f94 00000000 00000000 ce714a80 ffffffea 00000400 ce50c=
780=20
       00000000 00000000 00000000 c0131d06 ce714a80 40015000 00000400 ce714=
aa0=20
Call Trace:    [<c014eb5a>] [<c0131d06>] [<c0108547>]
Code: 83 78 28 00 74 14 83 78 24 00 74 07 68 00 34 af d0 eb 19 68=20

>>EIP; d0af1a3e <[i2c-core]read_bus_i2c+3e/b0>   <=3D=3DTrace; c014eb5a <pr=
oc_file_read+f2/194>
Trace; c0131d06 <sys_read+96/f0>
Trace; c0108546 <system_call+32/38>
Code;  d0af1a3e <[i2c-core]read_bus_i2c+3e/b0>
00000000 <_EIP>:
Code;  d0af1a3e <[i2c-core]read_bus_i2c+3e/b0>   <=3D=3D   0:   83 78 28 00=
               cmpl   $0x0,0x28(%eax)   <=3D=3DCode;  d0af1a42 <[i2c-core]r=
ead_bus_i2c+42/b0>
   4:   74 14                     je     1a <_EIP+0x1a> d0af1a58 <[i2c-core=
]read
_bus_i2c+58/b0>
Code;  d0af1a44 <[i2c-core]read_bus_i2c+44/b0>
   6:   83 78 24 00               cmpl   $0x0,0x24(%eax)
Code;  d0af1a48 <[i2c-core]read_bus_i2c+48/b0>
   a:   74 07                     je     13 <_EIP+0x13> d0af1a50 <[i2c-core=
]read
_bus_i2c+50/b0>
Code;  d0af1a4a <[i2c-core]read_bus_i2c+4a/b0>
   c:   68 00 34 af d0            push   $0xd0af3400
Code;  d0af1a4e <[i2c-core]read_bus_i2c+4e/b0>
  11:   eb 19                     jmp    2c <_EIP+0x2c> d0af1a6a <[i2c-core=
]read
_bus_i2c+6a/b0>
Code;  d0af1a50 <[i2c-core]read_bus_i2c+50/b0>
  13:   68 00 00 00 00            push   $0x0


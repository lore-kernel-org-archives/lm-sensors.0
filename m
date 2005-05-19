From: miguel@rozsas.xx.nom.br (Miguel Angelo Rozsas)
Date: Thu, 19 May 2005 06:24:23 +0000
Subject: Can't access /proc file for writing
Message-Id: <1067944723.1782.12.camel@hahasiah.rozsas.xx.nom.br>
List-Id: <lm-sensors.vger.kernel.org>
References: <1067739926.5304.28.camel@hahasiah.rozsas.xx.nom.br>
In-Reply-To: <1067739926.5304.28.camel@hahasiah.rozsas.xx.nom.br>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Mon, 2003-11-03 at 19:00, Jean Delvare wrote:
>=20
> Could you please run "strace sensors -s 2> /tmp/sensors-s.strace" (as
> root) and send us the /tmp? I don't know much about strace but I
> remember that it's what we asked last time a similar problem was
> reported ;) Maybe someone else on the list will be able to interpret the
> trace.

Hi !

	The strace for "sensors -s" is attached.

	I hope you guys can figure out what is happening.

	I don't understand the strace either, but I saw several "Inappropriate
ioctl for device" and "(Permission denied)" messages in the output.

	Please, let me know if you need something else, ok ?

	Many thanks for the help.

[]s,
--=20
Miguel Angelo Rozsas
miguel@rozsas.xx.nom.br
-------------- next part --------------
execve("/usr/local/bin/sensors", ["/usr/local/bin/sensors", "-s"], [/* 39 v=
ars */]) =3D 0
uname({sys=3D"Linux", node=3D"hahasiah.rozsas.xx.nom.br", ...}) =3D 0
brk(0)                                  =3D 0x8060728
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0=
) =3D 0x40016000
open("/etc/ld.so.preload", O_RDONLY)    =3D -1 ENOENT (No such file or dire=
ctory)
open("/etc/ld.so.cache", O_RDONLY)      =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=89964, ...}) =3D 0
old_mmap(NULL, 89964, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x40017000
close(3)                                =3D 0
open("/usr/local/lib/libsensors.so.2", O_RDONLY) =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\214R\0"..., 512) =
=3D 512
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=116278, ...}) =3D 0
old_mmap(NULL, 177220, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =3D 0x4002d0=
00
old_mmap(0x4003a000, 57344, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3,=
 0xc000) =3D 0x4003a000
old_mmap(0x40048000, 66628, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP=
_ANONYMOUS, -1, 0) =3D 0x40048000
close(3)                                =3D 0
open("/lib/i686/libc.so.6", O_RDONLY)   =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\300Z\1"..., 512) =
=3D 512
fstat64(3, {st_mode=3DS_IFREG|0755, st_size=1548424, ...}) =3D 0
old_mmap(NULL, 1275588, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =3D 0x40059=
000
old_mmap(0x4018b000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3,=
 0x132000) =3D 0x4018b000
old_mmap(0x4018e000, 9924, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_=
ANONYMOUS, -1, 0) =3D 0x4018e000
close(3)                                =3D 0
open("/lib/i686/libm.so.6", O_RDONLY)   =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\2004\0"..., 512) =
=3D 512
fstat64(3, {st_mode=3DS_IFREG|0755, st_size!2020, ...}) =3D 0
old_mmap(NULL, 138496, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =3D 0x401910=
00
old_mmap(0x401b2000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, =
0x20000) =3D 0x401b2000
close(3)                                =3D 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0=
) =3D 0x401b3000
munmap(0x40017000, 89964)               =3D 0
brk(0)                                  =3D 0x8060728
brk(0x8061728)                          =3D 0x8061728
brk(0)                                  =3D 0x8061728
brk(0x8062000)                          =3D 0x8062000
open("/etc/sensors.conf", O_RDONLY)     =3D 3
_sysctl({{CTL_DEV, 2, 1}, 3, 0x40047340, 200, (nil), 0}) =3D 0
open("/proc/bus/i2c", O_RDONLY)         =3D 4
fstat64(4, {st_mode=3DS_IFREG|0444, st_size=3D0, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
=3D 0x40017000
read(4, "i2c-0\tsmbus    \tSMBus I801 adapt"..., 4096) =3D 82
read(4, "", 4096)                       =3D 0
close(4)                                =3D 0
munmap(0x40017000, 4096)                =3D 0
brk(0)                                  =3D 0x8062000
brk(0x8065000)                          =3D 0x8065000
ioctl(3, SNDCTL_TMR_TIMEBASE, 0xbfffe780) =3D -1 ENOTTY (Inappropriate ioct=
l for device)
fstat64(3, {st_mode=3DS_IFREG|0644, st_sizeC659, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
=3D 0x40017000
read(3, "# Sensors configuration file use"..., 8192) =3D 8192
read(3, "were detected first, \'i2c-0\' in\n"..., 8192) =3D 8192
brk(0)                                  =3D 0x8065000
brk(0x8066000)                          =3D 0x8066000
brk(0)                                  =3D 0x8066000
brk(0x8067000)                          =3D 0x8067000
brk(0)                                  =3D 0x8067000
brk(0x8068000)                          =3D 0x8068000
brk(0)                                  =3D 0x8068000
brk(0x8069000)                          =3D 0x8069000
read(3, "6_max -5 * 0.95\n    set in6_min "..., 8192) =3D 8192
brk(0)                                  =3D 0x8069000
brk(0x806a000)                          =3D 0x806a000
brk(0)                                  =3D 0x806a000
brk(0x806b000)                          =3D 0x806b000
brk(0)                                  =3D 0x806b000
brk(0x806c000)                          =3D 0x806c000
brk(0)                                  =3D 0x806c000
brk(0x806d000)                          =3D 0x806d000
brk(0)                                  =3D 0x806d000
brk(0x806e000)                          =3D 0x806e000
read(3, "OS.\n# Likewise, Johannes Drechse"..., 8192) =3D 8192
brk(0)                                  =3D 0x806e000
brk(0x806f000)                          =3D 0x806f000
read(3, "e reversed on your board, this i"..., 8192) =3D 8192
brk(0)                                  =3D 0x806f000
brk(0x8070000)                          =3D 0x8070000
brk(0)                                  =3D 0x8070000
brk(0x8071000)                          =3D 0x8071000
brk(0)                                  =3D 0x8071000
brk(0x8072000)                          =3D 0x8072000
read(3, " \"vt1211-*\" \"vt8231-*\"\n#\n# temp1"..., 8192) =3D 2699
read(3, "", 4096)                       =3D 0
brk(0)                                  =3D 0x8072000
brk(0x8073000)                          =3D 0x8073000
read(3, "", 8192)                       =3D 0
ioctl(3, SNDCTL_TMR_TIMEBASE, 0xbfffe770) =3D -1 ENOTTY (Inappropriate ioct=
l for device)
_sysctl({{CTL_DEV, 2, 100, 515}, 4, 0x40047340, 4, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 100, 515}, 4, (nil), 134725272, 0x40047340, 4}) =3D -=
1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 100, 514}, 4, 0x40047340, 4, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 100, 3e8}, 4, 0x40047340, 12, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 100, 3e8}, 4, (nil), 134725272, 0x40047340, 4}) =3D -=
1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 100, 514}, 4, 0x40047340, 4, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 100, 3e8}, 4, 0x40047340, 12, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 100, 3e8}, 4, (nil), 134725272, 0x40047340, 8}) =3D -=
1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 100, 514}, 4, 0x40047340, 4, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 100, 3e9}, 4, 0x40047340, 12, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 100, 3e9}, 4, (nil), 134725272, 0x40047340, 4}) =3D -=
1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 100, 514}, 4, 0x40047340, 4, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 100, 3e9}, 4, 0x40047340, 12, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 100, 3e9}, 4, (nil), 134725272, 0x40047340, 8}) =3D -=
1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 100, 3ea}, 4, 0x40047340, 12, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 100, 3ea}, 4, (nil), 134725272, 0x40047340, 4}) =3D -=
1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 100, 3ea}, 4, 0x40047340, 12, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 100, 3ea}, 4, (nil), 134725272, 0x40047340, 8}) =3D -=
1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 100, 3eb}, 4, 0x40047340, 12, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 100, 3eb}, 4, (nil), 134725272, 0x40047340, 4}) =3D -=
1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 100, 3eb}, 4, 0x40047340, 12, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 100, 3eb}, 4, (nil), 134725272, 0x40047340, 8}) =3D -=
1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 100, 3ec}, 4, 0x40047340, 12, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 100, 3ec}, 4, (nil), 134725272, 0x40047340, 4}) =3D -=
1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 100, 3ec}, 4, 0x40047340, 12, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 100, 3ec}, 4, (nil), 134725272, 0x40047340, 8}) =3D -=
1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 100, 3ed}, 4, 0x40047340, 12, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 100, 3ed}, 4, (nil), 134725272, 0x40047340, 4}) =3D -=
1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 100, 3ed}, 4, 0x40047340, 12, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 100, 3ed}, 4, (nil), 134725272, 0x40047340, 8}) =3D -=
1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 100, 3ee}, 4, 0x40047340, 12, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 100, 3ee}, 4, (nil), 134725272, 0x40047340, 4}) =3D -=
1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 100, 3ee}, 4, 0x40047340, 12, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 100, 3ee}, 4, (nil), 134725272, 0x40047340, 8}) =3D -=
1 EACCES (Permission denied)
write(2, "as99127f-i2c-0-2d: Can\'t access "..., 56as99127f-i2c-0-2d: Can't=
 access /proc file for writing;
) =3D 56
write(2, "Run as root?\n", 13Run as root?
)          =3D 13
exit_group(1)                           =3D ?

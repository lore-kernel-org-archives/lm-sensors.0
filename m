From: kus@free.net (Mikhail Kuzminsky)
Date: Thu, 19 May 2005 06:25:08 +0000
Subject: sensors -s & adm1027
Message-Id: <web-79069@free.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <web-77741@free.net>
In-Reply-To: <web-77741@free.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

In message from Jean Delvare <khali@linux-fr.org> (Wed, 4 Aug 2004=20
20:46:43 +0200):
>> sensors-detect works normally. But sensors -s says
>> "adm1027-i2c-1-2d can't read or write". It looks something like
>> Ticket#1682 (partially).
>
>Please provide the output of "strace sensors -s".
   Thanks for your reply !
Output from sensors -s follows. libsensors libraries are placed under
/usr/lib64

Yours
Mikhail

execve("/usr/bin/sensors", ["sensors", "-s"], [/* 66 vars */]) =3D 0
uname({sys=3D"Linux", node=3D"c5ws1", ...}) =3D 0
brk(0)                                  =3D 0x519f48
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,=20
0) =3D 0x2a9556b000
open("/etc/ld.so.preload", O_RDONLY)    =3D -1 ENOENT (No such file or=20
directory)
open("/opt/globus/lib/tls/x86_64/libsensors.so.2", O_RDONLY) =3D -1=20
ENOENT (No such file or directory)
stat("/opt/globus/lib/tls/x86_64", 0x7fbfffe860) =3D -1 ENOENT (No such=20
file or directory)
open("/opt/globus/lib/tls/libsensors.so.2", O_RDONLY) =3D -1 ENOENT (No=20
such file or directory)
stat("/opt/globus/lib/tls", 0x7fbfffe860) =3D -1 ENOENT (No such file or=20
directory)
open("/opt/globus/lib/x86_64/libsensors.so.2", O_RDONLY) =3D -1 ENOENT=20
(No such file or directory)
stat("/opt/globus/lib/x86_64", 0x7fbfffe860) =3D -1 ENOENT (No such file=20
or directory)
open("/opt/globus/lib/libsensors.so.2", O_RDONLY) =3D -1 ENOENT (No such=20
file or directory)
stat("/opt/globus/lib", {st_mode=3DS_IFDIR|0755, st_size=8192, ...}) =3D 0
open("/etc/ld.so.cache", O_RDONLY)      =3D 3
fstat(3, {st_mode=3DS_IFREG|0644, st_size=111115, ...}) =3D 0
mmap(NULL, 111115, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x2a9556c000
close(3)                                =3D 0
open("/usr/lib64/libsensors.so.2", O_RDONLY) =3D 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0P\306\0\0"...,=20
640) =3D 640
fstat(3, {st_mode=3DS_IFREG|0755, st_size=165011, ...}) =3D 0
mmap(NULL, 1269416, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =3D=20
0x2a9566d000
mprotect(0x2a95681000, 1187496, PROT_NONE) =3D 0
mmap(0x2a9576d000, 151552, PROT_READ|PROT_WRITE,=20
MAP_PRIVATE|MAP_FIXED, 3, 0) =3D 0x2a9576d000
mmap(0x2a95792000, 69288, PROT_READ|PROT_WRITE,=20
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x2a95792000
close(3)                                =3D 0
open("/opt/globus/lib/libc.so.6", O_RDONLY) =3D -1 ENOENT (No such file=20
or directory)
open("/lib64/libc.so.6", O_RDONLY)      =3D 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\20\335\1"...,=20
640) =3D 640
fstat(3, {st_mode=3DS_IFREG|0755, st_size=1534814, ...}) =3D 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,=20
0) =3D 0x2a95588000
mmap(NULL, 2365888, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =3D=20
0x2a957a3000
mprotect(0x2a958c7000, 1169856, PROT_NONE) =3D 0
mmap(0x2a959a3000, 253952, PROT_READ|PROT_WRITE,=20
MAP_PRIVATE|MAP_FIXED, 3, 0x100000) =3D 0x2a959a3000
mmap(0x2a959e1000, 14784, PROT_READ|PROT_WRITE,=20
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x2a959e1000
close(3)                                =3D 0
open("/opt/globus/lib/libm.so.6", O_RDONLY) =3D -1 ENOENT (No such file=20
or directory)
open("/lib64/libm.so.6", O_RDONLY)      =3D 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0@A\0\0\0"...,=20
640) =3D 640
fstat(3, {st_mode=3DS_IFREG|0755, st_sizeD1693, ...}) =3D 0
mmap(NULL, 1416488, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =3D=20
0x2a959e5000
mprotect(0x2a95a3b000, 1064232, PROT_NONE) =3D 0
mmap(0x2a95ae5000, 368640, PROT_READ|PROT_WRITE,=20
MAP_PRIVATE|MAP_FIXED, 3, 0) =3D 0x2a95ae5000
close(3)                                =3D 0
munmap(0x2a9556c000, 111115)            =3D 0
brk(0)                                  =3D 0x519f48
brk(0x53af48)                           =3D 0x53af48
brk(0)                                  =3D 0x53af48
brk(0x53b000)                           =3D 0x53b000
open("/etc/sensors.conf", O_RDONLY)     =3D 3
_sysctl({{CTL_DEV, 2, 1}, 3, 0x2a95791d40, 320, (nil), 0}) =3D 0
open("/proc/bus/i2c", O_RDONLY)         =3D 4
fstat(4, {st_mode=3DS_IFREG|0444, st_size=3D0, ...}) =3D 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,=20
0) =3D 0x2a9556c000
read(4, "i2c-0\tsmbus    \tSMBus2 AMD8111 a"..., 4096) =3D 247
read(4, "", 4096)                       =3D 0
close(4)                                =3D 0
munmap(0x2a9556c000, 4096)              =3D 0
ioctl(3, SNDCTL_TMR_TIMEBASE, 0x7fbfffd9d0) =3D -1 ENOTTY (Inappropriate=20
ioctl for device)
fstat(3, {st_mode=3DS_IFREG|0644, st_size$40, ...}) =3D 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,=20
0) =3D 0x2a9556c000
read(3, "#########\n#  Sensors configurati"..., 8192) =3D 2440
read(3, "", 4096)                       =3D 0
read(3, "", 8192)                       =3D 0
ioctl(3, SNDCTL_TMR_TIMEBASE, 0x7fbfffd9b0) =3D -1 ENOTTY (Inappropriate=20
ioctl for device)
write(2, "adm1027-i2c-1-2d: Can\'t read or "..., 38adm1027-i2c-1-2d:=20
Can't read or write
) =3D 38
_sysctl({{CTL_DEV, 2, 107, 3e8}, 4, 0x2a95791d40, 24, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 107, 3e8}, 4, (nil), 4294967295, 0x2a95791d40,=20
8}) =3D 0
_sysctl({{CTL_DEV, 2, 107, 3e8}, 4, 0x2a95791d40, 24, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 107, 3e8}, 4, (nil), 4294967295, 0x2a95791d40,=20
16}) =3D 0
_sysctl({{CTL_DEV, 2, 107, 3e9}, 4, 0x2a95791d40, 24, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 107, 3e9}, 4, (nil), 4294967295, 0x2a95791d40,=20
8}) =3D 0
_sysctl({{CTL_DEV, 2, 107, 3e9}, 4, 0x2a95791d40, 24, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 107, 3e9}, 4, (nil), 4294967295, 0x2a95791d40,=20
16}) =3D 0
_sysctl({{CTL_DEV, 2, 107, 3ea}, 4, 0x2a95791d40, 24, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 107, 3ea}, 4, (nil), 4294967295, 0x2a95791d40,=20
8}) =3D 0
_sysctl({{CTL_DEV, 2, 107, 3ea}, 4, 0x2a95791d40, 24, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 107, 3ea}, 4, (nil), 4294967295, 0x2a95791d40,=20
16}) =3D 0
_sysctl({{CTL_DEV, 2, 107, 3ec}, 4, 0x2a95791d40, 24, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 107, 3ec}, 4, (nil), 4294967295, 0x2a95791d40,=20
8}) =3D 0
_sysctl({{CTL_DEV, 2, 107, 3ec}, 4, 0x2a95791d40, 24, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 107, 3ec}, 4, (nil), 4294967295, 0x2a95791d40,=20
16}) =3D 0
_sysctl({{CTL_DEV, 2, 107, 3ed}, 4, 0x2a95791d40, 24, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 107, 3ed}, 4, (nil), 4294967295, 0x2a95791d40,=20
16}) =3D 0
_sysctl({{CTL_DEV, 2, 107, 3ed}, 4, 0x2a95791d40, 24, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 107, 3ed}, 4, (nil), 4294967295, 0x2a95791d40,=20
8}) =3D 0
_sysctl({{CTL_DEV, 2, 107, 3ee}, 4, 0x2a95791d40, 24, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 107, 3ee}, 4, (nil), 4294967295, 0x2a95791d40,=20
16}) =3D 0
_sysctl({{CTL_DEV, 2, 107, 3ee}, 4, 0x2a95791d40, 24, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 107, 3ee}, 4, (nil), 4294967295, 0x2a95791d40,=20
8}) =3D 0
_sysctl({{CTL_DEV, 2, 107, 5dd}, 4, 0x2a95791d40, 8, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 107, 5dd}, 4, (nil), 4294967295, 0x2a95791d40,=20
8}) =3D 0
_sysctl({{CTL_DEV, 2, 107, 5de}, 4, 0x2a95791d40, 8, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 107, 5de}, 4, (nil), 4294967295, 0x2a95791d40,=20
8}) =3D 0
_sysctl({{CTL_DEV, 2, 107, 5df}, 4, 0x2a95791d40, 8, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 107, 5df}, 4, (nil), 4294967295, 0x2a95791d40,=20
8}) =3D 0
_sysctl({{CTL_DEV, 2, 107, 4b0}, 4, 0x2a95791d40, 24, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 107, 4b0}, 4, (nil), 4294967295, 0x2a95791d40,=20
8}) =3D 0
_sysctl({{CTL_DEV, 2, 107, 4b0}, 4, 0x2a95791d40, 24, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 107, 4b0}, 4, (nil), 4294967295, 0x2a95791d40,=20
16}) =3D 0
_sysctl({{CTL_DEV, 2, 107, 4b1}, 4, 0x2a95791d40, 24, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 107, 4b1}, 4, (nil), 4294967295, 0x2a95791d40,=20
8}) =3D 0
_sysctl({{CTL_DEV, 2, 107, 4b1}, 4, 0x2a95791d40, 24, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 107, 4b1}, 4, (nil), 4294967295, 0x2a95791d40,=20
16}) =3D 0
_sysctl({{CTL_DEV, 2, 107, 4b2}, 4, 0x2a95791d40, 24, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 107, 4b2}, 4, (nil), 4294967295, 0x2a95791d40,=20
8}) =3D 0
_sysctl({{CTL_DEV, 2, 107, 4b2}, 4, 0x2a95791d40, 24, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 107, 4b2}, 4, (nil), 4294967295, 0x2a95791d40,=20
16}) =3D 0
exit_group(0)                           =3D ?

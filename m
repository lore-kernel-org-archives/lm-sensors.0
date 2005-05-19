From: dscott@phivedesign.com (D.Scott)
Date: Thu, 19 May 2005 06:23:51 +0000
Subject: new kernel ptrace vuln. patch fails lm_sensors
Message-Id: <3E7E8918.4020100@phivedesign.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi,
I hope this is the right list.  After applying the recent ptrace race=20
condition patch to my 2.4.20 gentoo kernel, the following condition=20
occurs after a sensors -s:


root@gentoo2 dscott # /usr/local/bin/sensors -s
w83782d-i2c-0-2d: Can't access /proc file for writing;
Run as root?

I am, of course, running this as root.  Prior to the kernel patch I did=20
not have this trouble.  When I revert to the pre-patched kernel, it all=20
functions once again.  i2c is compiled into the kernel and the chip=20
drivers are modules:

root@gentoo2 dscott # lsmod
Module                  Size  Used by    Tainted: P
w83781d                20752   0
eeprom                  3636   0
i2c-amd756              3828   0  (unused)

Finally, here is the strace of /usr/local/bin/sensors -s , any help=20
would be appreciated:

root@gentoo2 dscott # strace /usr/local/bin/sensors -s
execve("/usr/local/bin/sensors", ["/usr/local/bin/sensors", "-s"], [/*=20
44 vars */]) =3D 0
uname({sys=3D"Linux", node=3D"gentoo2", ...}) =3D 0
brk(0)                                  =3D 0x8062528
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,=20
0) =3D 0x40014000
open("/etc/ld.so.preload", O_RDONLY)    =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
close(3)                                =3D 0
open("/etc/ld.so.cache", O_RDONLY)      =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_sizex517, ...}) =3D 0
mmap2(NULL, 78517, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x40015000
close(3)                                =3D 0
open("/usr/local/lib/libsensors.so.1", O_RDONLY) =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\20E\0\000"...,=20
1024) =3D 1024
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=98988, ...}) =3D 0
mmap2(NULL, 160996, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =3D 0x40029000
mprotect(0x40035000, 111844, PROT_NONE) =3D 0
mmap2(0x40035000, 45056, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3,=20
0xb) =3D 0x40035000
mmap2(0x40040000, 66788, PROT_READ|PROT_WRITE,=20
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x40040000
close(3)                                =3D 0
open("/lib/libc.so.6", O_RDONLY)        =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\240Z\1"...,=20
1024) =3D 1024
fstat64(3, {st_mode=3DS_IFREG|0755, st_size=1442311, ...}) =3D 0
mmap2(NULL, 1228068, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =3D 0x40051000
mprotect(0x40175000, 32036, PROT_NONE)  =3D 0
mmap2(0x40175000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3,=20
0x123) =3D 0x40175000
mmap2(0x40179000, 15652, PROT_READ|PROT_WRITE,=20
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x40179000
close(3)                                =3D 0
munmap(0x40015000, 78517)               =3D 0
brk(0)                                  =3D 0x8062528
brk(0x8063528)                          =3D 0x8063528
brk(0x8064000)                          =3D 0x8064000
open("/etc/sensors.conf", O_RDONLY)     =3D 3
_sysctl({{CTL_DEV, 2, 1}, 3, 0x4003f3e0, 200, (nil), 0}) =3D 0
open("/proc/bus/i2c", O_RDONLY)         =3D 4
fstat64(4, {st_mode=3DS_IFREG|0444, st_size=3D0, ...}) =3D 0
mmap2(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,=20
0) =3D 0x40015000
read(4, "i2c-0\tsmbus    \tSMBus AMD766 ada"..., 8192) =3D 82
read(4, "", 8192)                       =3D 0
close(4)                                =3D 0
munmap(0x40015000, 8192)                =3D 0
brk(0x8067000)                          =3D 0x8067000
ioctl(3, SNDCTL_TMR_TIMEBASE, 0xbfffe660) =3D -1 ENOTTY (Inappropriate=20
ioctl for device)
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=1589, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,=20
0) =3D 0x40015000
read(3, "# Sensors configuration file use"..., 8192) =3D 1589
read(3, "", 4096)                       =3D 0
brk(0x8068000)                          =3D 0x8068000
brk(0x8069000)                          =3D 0x8069000
read(3, "", 8192)                       =3D 0
ioctl(3, SNDCTL_TMR_TIMEBASE, 0xbfffe630) =3D -1 ENOTTY (Inappropriate=20
ioctl for device)
_sysctl({{CTL_DEV, 2, 104, 514}, 4, 0x4003f3e0, 4, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 104, 3e8}, 4, 0x4003f3e0, 12, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 104, 3e8}, 4, ptrace: umoven: Input/output error
(nil), 0, 0x4003f3e0, 4}) =3D -1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 104, 514}, 4, 0x4003f3e0, 4, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 104, 3e8}, 4, 0x4003f3e0, 12, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 104, 3e8}, 4, ptrace: umoven: Input/output error
(nil), 0, 0x4003f3e0, 8}) =3D -1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 104, 514}, 4, 0x4003f3e0, 4, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 104, 3e9}, 4, 0x4003f3e0, 12, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 104, 3e9}, 4, ptrace: umoven: Input/output error
(nil), 0, 0x4003f3e0, 4}) =3D -1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 104, 514}, 4, 0x4003f3e0, 4, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 104, 3e9}, 4, 0x4003f3e0, 12, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 104, 3e9}, 4, ptrace: umoven: Input/output error
(nil), 0, 0x4003f3e0, 8}) =3D -1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 104, 3ea}, 4, 0x4003f3e0, 12, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 104, 3ea}, 4, ptrace: umoven: Input/output error
(nil), 0, 0x4003f3e0, 4}) =3D -1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 104, 3ea}, 4, 0x4003f3e0, 12, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 104, 3ea}, 4, ptrace: umoven: Input/output error
(nil), 0, 0x4003f3e0, 8}) =3D -1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 104, 3eb}, 4, 0x4003f3e0, 12, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 104, 3eb}, 4, ptrace: umoven: Input/output error
(nil), 0, 0x4003f3e0, 4}) =3D -1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 104, 3eb}, 4, 0x4003f3e0, 12, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 104, 3eb}, 4, ptrace: umoven: Input/output error
(nil), 0, 0x4003f3e0, 8}) =3D -1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 104, 3ec}, 4, 0x4003f3e0, 12, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 104, 3ec}, 4, ptrace: umoven: Input/output error
(nil), 0, 0x4003f3e0, 4}) =3D -1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 104, 3ec}, 4, 0x4003f3e0, 12, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 104, 3ec}, 4, ptrace: umoven: Input/output error
(nil), 0, 0x4003f3e0, 8}) =3D -1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 104, 3ed}, 4, 0x4003f3e0, 12, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 104, 3ed}, 4, ptrace: umoven: Input/output error
(nil), 0, 0x4003f3e0, 4}) =3D -1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 104, 3ed}, 4, 0x4003f3e0, 12, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 104, 3ed}, 4, ptrace: umoven: Input/output error
(nil), 0, 0x4003f3e0, 8}) =3D -1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 104, 3ee}, 4, 0x4003f3e0, 12, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 104, 3ee}, 4, ptrace: umoven: Input/output error
(nil), 0, 0x4003f3e0, 4}) =3D -1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 104, 3ee}, 4, 0x4003f3e0, 12, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 104, 3ee}, 4, ptrace: umoven: Input/output error
(nil), 0, 0x4003f3e0, 8}) =3D -1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 104, 3ef}, 4, 0x4003f3e0, 12, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 104, 3ef}, 4, ptrace: umoven: Input/output error
(nil), 0, 0x4003f3e0, 4}) =3D -1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 104, 3ef}, 4, 0x4003f3e0, 12, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 104, 3ef}, 4, ptrace: umoven: Input/output error
(nil), 0, 0x4003f3e0, 8}) =3D -1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 104, 3f0}, 4, 0x4003f3e0, 12, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 104, 3f0}, 4, ptrace: umoven: Input/output error
(nil), 0, 0x4003f3e0, 4}) =3D -1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 104, 3f0}, 4, 0x4003f3e0, 12, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 104, 3f0}, 4, ptrace: umoven: Input/output error
(nil), 0, 0x4003f3e0, 8}) =3D -1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 104, 5dd}, 4, 0x4003f3e0, 4, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 104, 5dd}, 4, ptrace: umoven: Input/output error
(nil), 0, 0x4003f3e0, 4}) =3D -1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 104, 5de}, 4, 0x4003f3e0, 4, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 104, 5de}, 4, ptrace: umoven: Input/output error
(nil), 0, 0x4003f3e0, 4}) =3D -1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 104, 5df}, 4, 0x4003f3e0, 4, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 104, 5df}, 4, ptrace: umoven: Input/output error
(nil), 0, 0x4003f3e0, 4}) =3D -1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 104, 4b0}, 4, 0x4003f3e0, 12, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 104, 4b0}, 4, ptrace: umoven: Input/output error
(nil), 0, 0x4003f3e0, 4}) =3D -1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 104, 4b0}, 4, 0x4003f3e0, 12, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 104, 4b0}, 4, ptrace: umoven: Input/output error
(nil), 0, 0x4003f3e0, 8}) =3D -1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 104, 4b1}, 4, 0x4003f3e0, 12, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 104, 4b1}, 4, ptrace: umoven: Input/output error
(nil), 0, 0x4003f3e0, 4}) =3D -1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 104, 4b1}, 4, 0x4003f3e0, 12, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 104, 4b1}, 4, ptrace: umoven: Input/output error
(nil), 0, 0x4003f3e0, 8}) =3D -1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 104, 4b2}, 4, 0x4003f3e0, 12, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 104, 4b2}, 4, ptrace: umoven: Input/output error
(nil), 0, 0x4003f3e0, 4}) =3D -1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 104, 4b2}, 4, 0x4003f3e0, 12, (nil), 0}) =3D 0
_sysctl({{CTL_DEV, 2, 104, 4b2}, 4, ptrace: umoven: Input/output error
(nil), 0, 0x4003f3e0, 8}) =3D -1 EACCES (Permission denied)
write(2, "w83782d-i2c-0-2d: Can\'t access /"..., 55w83782d-i2c-0-2d:=20
Can't access /proc file for writing;
) =3D 55
write(2, "Run as root?\n", 13Run as root?




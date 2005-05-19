From: chb@tzis.net (Christoph Breitler)
Date: Thu, 19 May 2005 06:24:36 +0000
Subject: Ticket #: 1533 / Cant use Sensors -s
Message-Id: <1075045807.2174.7.camel@Technetium.pse.local>
List-Id: <lm-sensors.vger.kernel.org>
References: <1074957554.5412.3.camel@Technetium.pse.local>
In-Reply-To: <1074957554.5412.3.camel@Technetium.pse.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Am Son, den 25.01.2004 schrieb Jean Delvare um 16:25:
> > > > Strange thing is that all is 777  :/=20
> >=20
> > After rebooting - the Permissions are back to normal.
>=20
> Interesting. No way to get them back to 777? I really wonder what caused
> that in the first place.

Dunno, but all Permissions back to normal now ..=20


> I guess that even with normal permissions (which by the way I'd like you
> to show us) your "sensors -s" problem is still there?

Yep :=20


-r--r--r--    1 root     root         4096 2004-01-25 14:07 alarms
-rw-r--r--    1 root     root         4096 2004-01-25 14:07 beep_enable
-rw-r--r--    1 root     root         4096 2004-01-25 14:07 beep_mask
-rw-r--r--    1 root     root         4096 2004-01-25 14:07 detach_state
-rw-r--r--    1 root     root         4096 2004-01-25 14:07 fan_div1
-rw-r--r--    1 root     root         4096 2004-01-25 14:07 fan_div2
-r--r--r--    1 root     root         4096 2004-01-25 14:07 fan_input1
-r--r--r--    1 root     root         4096 2004-01-25 14:07 fan_input2
-rw-r--r--    1 root     root         4096 2004-01-25 14:07 fan_min1
-rw-r--r--    1 root     root         4096 2004-01-25 14:07 fan_min2
-r--r--r--    1 root     root         4096 2004-01-25 14:07 in_input0
-r--r--r--    1 root     root         4096 2004-01-25 14:07 in_input2
-r--r--r--    1 root     root         4096 2004-01-25 14:07 in_input3
-r--r--r--    1 root     root         4096 2004-01-25 14:07 in_input4
-r--r--r--    1 root     root         4096 2004-01-25 14:07 in_input5
-r--r--r--    1 root     root         4096 2004-01-25 14:07 in_input6
-r--r--r--    1 root     root         4096 2004-01-25 14:07 in_input7
-r--r--r--    1 root     root         4096 2004-01-25 14:07 in_input8
-rw-r--r--    1 root     root            0 2004-01-25 15:26 in_max0
-rw-r--r--    1 root     root            0 2004-01-25 15:26 in_max2
-rw-r--r--    1 root     root            0 2004-01-25 15:26 in_max3
-rw-r--r--    1 root     root            0 2004-01-25 15:26 in_max4
-rw-r--r--    1 root     root            0 2004-01-25 15:26 in_max5
-rw-r--r--    1 root     root            0 2004-01-25 15:26 in_max6
-rw-r--r--    1 root     root            0 2004-01-25 15:26 in_max7
-rw-r--r--    1 root     root            0 2004-01-25 15:26 in_max8
-rw-r--r--    1 root     root            0 2004-01-25 15:26 in_min0
-rw-r--r--    1 root     root            0 2004-01-25 15:26 in_min2
-rw-r--r--    1 root     root            0 2004-01-25 15:26 in_min3
-rw-r--r--    1 root     root            0 2004-01-25 15:26 in_min4
-rw-r--r--    1 root     root            0 2004-01-25 15:26 in_min5
-rw-r--r--    1 root     root            0 2004-01-25 15:26 in_min6
-rw-r--r--    1 root     root            0 2004-01-25 15:26 in_min7
-rw-r--r--    1 root     root            0 2004-01-25 15:26 in_min8
-r--r--r--    1 root     root         4096 2004-01-25 14:07 name
drwxr-xr-x    2 root     root            0 2004-01-25 14:07 power/
-rw-r--r--    1 root     root         4096 2004-01-25 14:07 pwm1
-rw-r--r--    1 root     root         4096 2004-01-25 14:07 pwm2
-rw-r--r--    1 root     root         4096 2004-01-25 14:07 pwm_enable2
-rw-r--r--    1 root     root         4096 2004-01-25 14:07 sensor1
-rw-r--r--    1 root     root         4096 2004-01-25 14:07 sensor2
-rw-r--r--    1 root     root            0 2004-01-25 15:26 temp_hyst1
-rw-r--r--    1 root     root            0 2004-01-25 15:26 temp_hyst2
-r--r--r--    1 root     root         4096 2004-01-25 14:07 temp_input1
-r--r--r--    1 root     root         4096 2004-01-25 14:07 temp_input2
-rw-r--r--    1 root     root            0 2004-01-25 15:26 temp_max1
-rw-r--r--    1 root     root            0 2004-01-25 15:26 temp_max2



> Well, that was supposed to work ;) The common (and unsolved so far)
> problem is that people can write to the files using "echo" but not
> through libsensors (which sensors uses).

I see :)=20


>=20
> Yes it does. From what I can see there, you have a second i2c bus (a
> real one, as opposed to the isa emulation). Looks like there is much
> trouble on this second adapter. It is probably a completely different
> problem though. That said, please tell us what that second i2c bus is
> and what chips are present here, just in case there is some kind of
> interaction between both problems.

I really don't know where and what the second i2c bus is, I guess there
isn't something like lsi2c ?=20


> Back to the initial problem, I'd like you to strace "sensors -s". I put
> a trap in there some times ago, maybe it'll confirm my suspicions.


Here is the output.=20





-------------- next part --------------
execve("/usr/local/bin/sensors", ["/usr/local/bin/sensors", "-s"], [/* 35 v=
ars */]) =3D 0
brk(0)                                  =3D 0x8064000
open("/etc/ld.so.preload", O_RDONLY)    =3D -1 ENOENT (No such file or dire=
ctory)
open("/usr/local/lib/i686/mmx/libsensors.so.3", O_RDONLY) =3D -1 ENOENT (No=
 such file or directory)
stat64("/usr/local/lib/i686/mmx", 0xbfffec60) =3D -1 ENOENT (No such file o=
r directory)
open("/usr/local/lib/i686/libsensors.so.3", O_RDONLY) =3D -1 ENOENT (No suc=
h file or directory)
stat64("/usr/local/lib/i686", 0xbfffec60) =3D -1 ENOENT (No such file or di=
rectory)
open("/usr/local/lib/mmx/libsensors.so.3", O_RDONLY) =3D -1 ENOENT (No such=
 file or directory)
stat64("/usr/local/lib/mmx", 0xbfffec60) =3D -1 ENOENT (No such file or dir=
ectory)
open("/usr/local/lib/libsensors.so.3", O_RDONLY) =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\300\\\0"..., 1024)=
 =3D 1024
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=144966, ...}) =3D 0
old_mmap(NULL, 206148, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =3D 0x400160=
00
mprotect(0x40025000, 144708, PROT_NONE) =3D 0
old_mmap(0x40025000, 77824, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3,=
 0xe000) =3D 0x40025000
old_mmap(0x40038000, 66884, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP=
_ANONYMOUS, -1, 0) =3D 0x40038000
close(3)                                =3D 0
open("/usr/local/lib/libc.so.6", O_RDONLY) =3D -1 ENOENT (No such file or d=
irectory)
open("/etc/ld.so.cache", O_RDONLY)      =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=89755, ...}) =3D 0
old_mmap(NULL, 89755, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x40049000
close(3)                                =3D 0
open("/lib/libc.so.6", O_RDONLY)        =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\300]\1"..., 1024) =
=3D 1024
fstat64(3, {st_mode=3DS_IFREG|0755, st_size=1458907, ...}) =3D 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0=
) =3D 0x4005f000
old_mmap(NULL, 1268836, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =3D 0x40060=
000
mprotect(0x4018f000, 27748, PROT_NONE)  =3D 0
old_mmap(0x4018f000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3,=
 0x12f000) =3D 0x4018f000
old_mmap(0x40194000, 7268, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_=
ANONYMOUS, -1, 0) =3D 0x40194000
close(3)                                =3D 0
open("/usr/local/lib/libm.so.6", O_RDONLY) =3D -1 ENOENT (No such file or d=
irectory)
open("/usr/local/lib/libm.so.6", O_RDONLY) =3D -1 ENOENT (No such file or d=
irectory)
open("/lib/libm.so.6", O_RDONLY)        =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\0006\0"..., 1024) =
=3D 1024
fstat64(3, {st_mode=3DS_IFREG|0755, st_size=177047, ...}) =3D 0
old_mmap(NULL, 140432, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =3D 0x401960=
00
mprotect(0x401b8000, 1168, PROT_NONE)   =3D 0
old_mmap(0x401b8000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, =
0x21000) =3D 0x401b8000
close(3)                                =3D 0
munmap(0x40049000, 89755)               =3D 0
brk(0)                                  =3D 0x8064000
brk(0x8065000)                          =3D 0x8065000
brk(0)                                  =3D 0x8065000
open("/etc/sensors.conf", O_RDONLY)     =3D 3
open("/proc/mounts", O_RDONLY)          =3D 4
fstat64(4, {st_mode=3DS_IFREG|0444, st_size=3D0, ...}) =3D 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0=
) =3D 0x40049000
read(4, "rootfs / rootfs rw 0 0\n/dev/root"..., 1024) =3D 875
close(4)                                =3D 0
munmap(0x40049000, 4096)                =3D 0
open("/dev/null", O_RDONLY|O_NONBLOCK|O_DIRECTORY) =3D -1 ENOTDIR (Not a di=
rectory)
open("/sys/bus/i2c/devices", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) =
=3D 4
fstat64(4, {st_mode=3DS_IFDIR|0755, st_size=3D0, ...}) =3D 0
fcntl64(4, F_SETFD, FD_CLOEXEC)         =3D 0
brk(0)                                  =3D 0x8065000
brk(0x8066000)                          =3D 0x8066000
getdents64(4, /* 3 entries */, 4096)    =3D 80
open("/sys/bus/i2c/devices/0-0290/name", O_RDONLY) =3D 5
fstat64(5, {st_mode=3DS_IFREG|0444, st_size@96, ...}) =3D 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0=
) =3D 0x40049000
read(5, "w83697hf\n", 4096)             =3D 9
close(5)                                =3D 0
munmap(0x40049000, 4096)                =3D 0
open("/sys/class/i2c-adapter/i2c-0/device/name", O_RDONLY) =3D 5
fstat64(5, {st_mode=3DS_IFREG|0444, st_size@96, ...}) =3D 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0=
) =3D 0x40049000
read(5, "ISA main adapter\n", 4096)     =3D 17
close(5)                                =3D 0
munmap(0x40049000, 4096)                =3D 0
getdents64(4, /* 0 entries */, 4096)    =3D 0
close(4)                                =3D 0
open("/sys/class/i2c-adapter", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY)=
 =3D 4
fstat64(4, {st_mode=3DS_IFDIR|0755, st_size=3D0, ...}) =3D 0
fcntl64(4, F_SETFD, FD_CLOEXEC)         =3D 0
getdents64(4, /* 4 entries */, 4096)    =3D 112
open("/sys/class/i2c-adapter/i2c-1/device/name", O_RDONLY) =3D 5
fstat64(5, {st_mode=3DS_IFREG|0444, st_size@96, ...}) =3D 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0=
) =3D 0x40049000
read(5, "SMBus Via Pro adapter at 5000\n", 4096) =3D 30
close(5)                                =3D 0
munmap(0x40049000, 4096)                =3D 0
open("/sys/class/i2c-adapter/i2c-0/device/name", O_RDONLY) =3D 5
fstat64(5, {st_mode=3DS_IFREG|0444, st_size@96, ...}) =3D 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0=
) =3D 0x40049000
read(5, "ISA main adapter\n", 4096)     =3D 17
close(5)                                =3D 0
munmap(0x40049000, 4096)                =3D 0
getdents64(4, /* 0 entries */, 4096)    =3D 0
close(4)                                =3D 0
brk(0)                                  =3D 0x8066000
brk(0x806a000)                          =3D 0x806a000
ioctl(3, SNDCTL_TMR_TIMEBASE, 0xbfffe770) =3D -1 ENOTTY (Inappropriate ioct=
l for device)
fstat64(3, {st_mode=3DS_IFREG|0644, st_sizeU115, ...}) =3D 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0=
) =3D 0x40049000
read(3, "# Sensors configuration file use"..., 8192) =3D 8192
read(3, " SMBus adapter\"\n#\n# If we refer "..., 8192) =3D 8192
brk(0)                                  =3D 0x806a000
brk(0x806b000)                          =3D 0x806b000
brk(0)                                  =3D 0x806b000
brk(0x806c000)                          =3D 0x806c000
read(3, "ard\n# uses the recommended resis"..., 8192) =3D 8192
brk(0)                                  =3D 0x806c000
brk(0x806d000)                          =3D 0x806d000
brk(0)                                  =3D 0x806d000
brk(0x806e000)                          =3D 0x806e000
brk(0)                                  =3D 0x806e000
brk(0x806f000)                          =3D 0x806f000
brk(0)                                  =3D 0x806f000
brk(0x8070000)                          =3D 0x8070000
read(3, "@\n\n\nchip \"gl518sm-*\"\n\n# IMPORTAN"..., 8192) =3D 8192
brk(0)                                  =3D 0x8070000
brk(0x8071000)                          =3D 0x8071000
brk(0)                                  =3D 0x8071000
brk(0x8072000)                          =3D 0x8072000
brk(0)                                  =3D 0x8072000
brk(0x8073000)                          =3D 0x8073000
brk(0)                                  =3D 0x8073000
brk(0x8074000)                          =3D 0x8074000
read(3, "or at least one Tyan S1598, the "..., 8192) =3D 8192
brk(0)                                  =3D 0x8074000
brk(0x8075000)                          =3D 0x8075000
read(3, "el temp1 \"CPU2 Temp\"\n    label t"..., 8192) =3D 8192
brk(0)                                  =3D 0x8075000
brk(0x8076000)                          =3D 0x8076000
brk(0)                                  =3D 0x8076000
brk(0x8077000)                          =3D 0x8077000
read(3, "note #1: hyst2 will be automatic"..., 8192) =3D 5963
read(3, "", 4096)                       =3D 0
brk(0)                                  =3D 0x8077000
brk(0x8078000)                          =3D 0x8078000
brk(0)                                  =3D 0x8078000
brk(0x8079000)                          =3D 0x8079000
brk(0)                                  =3D 0x8079000
brk(0x807a000)                          =3D 0x807a000
brk(0)                                  =3D 0x807a000
brk(0x807b000)                          =3D 0x807b000
read(3, "", 8192)                       =3D 0
ioctl(3, SNDCTL_TMR_TIMEBASE, 0xbfffe760) =3D -1 ENOTTY (Inappropriate ioct=
l for device)
close(3)                                =3D 0
munmap(0x40049000, 4096)                =3D 0
open("/sys/bus/i2c/devices/0-0290/in_min0", O_WRONLY|O_CREAT|O_TRUNC, 0666)=
 =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0=
) =3D 0x40049000
write(3, "1710", 4)                     =3D 4
close(3)                                =3D 0
munmap(0x40049000, 4096)                =3D 0
open("/sys/bus/i2c/devices/0-0290/in_max0", O_WRONLY|O_CREAT|O_TRUNC, 0666)=
 =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0=
) =3D 0x40049000
write(3, "1890", 4)                     =3D 4
close(3)                                =3D 0
munmap(0x40049000, 4096)                =3D 0
open("/sys/bus/i2c/devices/0-0290/in_min2", O_WRONLY|O_CREAT|O_TRUNC, 0666)=
 =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0=
) =3D 0x40049000
write(3, "3135", 4)                     =3D 4
close(3)                                =3D 0
munmap(0x40049000, 4096)                =3D 0
open("/sys/bus/i2c/devices/0-0290/in_max2", O_WRONLY|O_CREAT|O_TRUNC, 0666)=
 =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0=
) =3D 0x40049000
write(3, "3465", 4)                     =3D 4
close(3)                                =3D 0
munmap(0x40049000, 4096)                =3D 0
open("/sys/bus/i2c/devices/0-0290/in_min3", O_WRONLY|O_CREAT|O_TRUNC, 0666)=
 =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0=
) =3D 0x40049000
write(3, "2827", 4)                     =3D 4
close(3)                                =3D 0
munmap(0x40049000, 4096)                =3D 0
open("/sys/bus/i2c/devices/0-0290/in_max3", O_WRONLY|O_CREAT|O_TRUNC, 0666)=
 =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0=
) =3D 0x40049000
write(3, "3125", 4)                     =3D 4
close(3)                                =3D 0
munmap(0x40049000, 4096)                =3D 0
open("/sys/bus/i2c/devices/0-0290/in_min4", O_WRONLY|O_CREAT|O_TRUNC, 0666)=
 =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0=
) =3D 0x40049000
write(3, "2842", 4)                     =3D 4
close(3)                                =3D 0
munmap(0x40049000, 4096)                =3D 0
open("/sys/bus/i2c/devices/0-0290/in_max4", O_WRONLY|O_CREAT|O_TRUNC, 0666)=
 =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0=
) =3D 0x40049000
write(3, "3473", 4)                     =3D 4
close(3)                                =3D 0
munmap(0x40049000, 4096)                =3D 0
open("/sys/bus/i2c/devices/0-0290/in_max5", O_WRONLY|O_CREAT|O_TRUNC, 0666)=
 =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0=
) =3D 0x40049000
write(3, "799", 3)                      =3D 3
close(3)                                =3D 0
munmap(0x40049000, 4096)                =3D 0
open("/sys/bus/i2c/devices/0-0290/in_min5", O_WRONLY|O_CREAT|O_TRUNC, 0666)=
 =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0=
) =3D 0x40049000
write(3, "332", 3)                      =3D 3
close(3)                                =3D 0
munmap(0x40049000, 4096)                =3D 0
open("/sys/bus/i2c/devices/0-0290/in_max6", O_WRONLY|O_CREAT|O_TRUNC, 0666)=
 =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0=
) =3D 0x40049000
write(3, "942", 3)                      =3D 3
close(3)                                =3D 0
munmap(0x40049000, 4096)                =3D 0
open("/sys/bus/i2c/devices/0-0290/in_min6", O_WRONLY|O_CREAT|O_TRUNC, 0666)=
 =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0=
) =3D 0x40049000
write(3, "783", 3)                      =3D 3
close(3)                                =3D 0
munmap(0x40049000, 4096)                =3D 0
open("/sys/bus/i2c/devices/0-0290/in_min7", O_WRONLY|O_CREAT|O_TRUNC, 0666)=
 =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0=
) =3D 0x40049000
write(3, "2827", 4)                     =3D 4
close(3)                                =3D 0
munmap(0x40049000, 4096)                =3D 0
open("/sys/bus/i2c/devices/0-0290/in_max7", O_WRONLY|O_CREAT|O_TRUNC, 0666)=
 =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0=
) =3D 0x40049000
write(3, "3125", 4)                     =3D 4
close(3)                                =3D 0
munmap(0x40049000, 4096)                =3D 0
open("/sys/bus/i2c/devices/0-0290/in_min8", O_WRONLY|O_CREAT|O_TRUNC, 0666)=
 =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0=
) =3D 0x40049000
write(3, "2400", 4)                     =3D 4
close(3)                                =3D 0
munmap(0x40049000, 4096)                =3D 0
open("/sys/bus/i2c/devices/0-0290/in_max8", O_WRONLY|O_CREAT|O_TRUNC, 0666)=
 =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0=
) =3D 0x40049000
write(3, "3600", 4)                     =3D 4
close(3)                                =3D 0
munmap(0x40049000, 4096)                =3D 0
open("/sys/bus/i2c/devices/0-0290/sensor3", O_WRONLY|O_CREAT|O_TRUNC, 0666)=
 =3D -1 EACCES (Permission denied)
open("/sys/bus/i2c/devices/0-0290/temp_max1", O_WRONLY|O_CREAT|O_TRUNC, 066=
6) =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0=
) =3D 0x40049000
write(3, "40000", 5)                    =3D 5
close(3)                                =3D 0
munmap(0x40049000, 4096)                =3D 0
open("/sys/bus/i2c/devices/0-0290/temp_hyst1", O_WRONLY|O_CREAT|O_TRUNC, 06=
66) =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0=
) =3D 0x40049000
write(3, "37000", 5)                    =3D 5
close(3)                                =3D 0
munmap(0x40049000, 4096)                =3D 0
open("/sys/bus/i2c/devices/0-0290/temp_max2", O_WRONLY|O_CREAT|O_TRUNC, 066=
6) =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0=
) =3D 0x40049000
write(3, "52000", 5)                    =3D 5
close(3)                                =3D 0
munmap(0x40049000, 4096)                =3D 0
open("/sys/bus/i2c/devices/0-0290/temp_hyst2", O_WRONLY|O_CREAT|O_TRUNC, 06=
66) =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0=
) =3D 0x40049000
write(3, "47000", 5)                    =3D 5
close(3)                                =3D 0
munmap(0x40049000, 4096)                =3D 0
open("/sys/bus/i2c/devices/0-0290/temp_max3", O_WRONLY|O_CREAT|O_TRUNC, 066=
6) =3D -1 EACCES (Permission denied)
open("/sys/bus/i2c/devices/0-0290/temp_hyst3", O_WRONLY|O_CREAT|O_TRUNC, 06=
66) =3D -1 EACCES (Permission denied)
write(2, "w83697hf-isa-0290: Can\'t access "..., 63) =3D 63
write(2, "Run as root?\n", 13)          =3D 13
exit_group(1)                           =3D ?

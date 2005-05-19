From: zayets@comcast.net (Rob)
Date: Thu, 19 May 2005 06:25:22 +0000
Subject: Please list which file to etc/rc* file modiify
Message-Id: <1100800537.2362.3.camel@Oneniisama>
List-Id: <lm-sensors.vger.kernel.org>
References: <1100659621.2956.12.camel@Oneniisama>
In-Reply-To: <1100659621.2956.12.camel@Oneniisama>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

http://www.linuxquestions.org/questions/showthread.php?s=3D&threadid%5402

This is the webforum where we are trying to get this working as well.=20
And that ticket site, is exactly what I'm going through.  Would you like
the Mandrake rpms to look at?

Rob



[root@Oneniisama rob]# strace sensors -s
execve("/usr/bin/sensors", ["sensors", "-s"], [/* 62 vars */]) =3D 0
uname({sys=3D"Linux", node=3D"Oneniisama", ...}) =3D 0
brk(0)                                  =3D 0x8063000
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) =3D 0
x40017000
open("/etc/ld.so.preload", O_RDONLY)    =3D -1 ENOENT (No such file or
directory)
open("/etc/ld.so.cache", O_RDONLY)      =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=95558, ...}) =3D 0
old_mmap(NULL, 95558, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x40018000
close(3)                                =3D 0
open("//usr/lib/libsensors.so.3", O_RDONLY) =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\300]\0"...,
512) =3D 512
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=133520, ...}) =3D 0
old_mmap(NULL, 206884, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) 0x40030000
old_mmap(0x4003f000, 77824, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED,
3, 0xe0
00) =3D 0x4003f000
old_mmap(0x40052000, 67620, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANON
YMOUS, -1, 0) =3D 0x40052000
close(3)                                =3D 0
open("/lib/tls/libc.so.6", O_RDONLY)    =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0@Z\1\000"...,
512) =3D 512
fstat64(3, {st_mode=3DS_IFREG|0755, st_size=1334740, ...}) =3D 0
old_mmap(NULL, 1340908, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) 0x40063000
old_mmap(0x401a5000, 12288, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED,
3, 0x14
2000) =3D 0x401a5000
old_mmap(0x401a8000, 9708, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONY
MOUS, -1, 0) =3D 0x401a8000
close(3)                                =3D 0
open("/lib/tls/libm.so.6", O_RDONLY)    =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0 5\0\000"...,
512) =3D 512
fstat64(3, {st_mode=3DS_IFREG|0755, st_size=139108, ...}) =3D 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS,
-1, 0) =3D 0
x401ab000
old_mmap(NULL, 141600, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) 0x401ac000
old_mmap(0x401ce000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED,
3, 0x210
00) =3D 0x401ce000
close(3)                                =3D 0
set_thread_area({entry_number:-1 -> 6, base_addr:0x401ab8a0,
limit:1048575, seg_
32bit:1, contents:0, read_exec_only:0, limit_in_pages:1,
seg_not_present:0, usea
ble:1}) =3D 0
munmap(0x40018000, 95558)               =3D 0
open("/usr/share/locale/locale-archive", O_RDONLY|O_LARGEFILE) =3D -1
ENOENT (No s
uch file or directory)
brk(0)                                  =3D 0x8063000
brk(0x8084000)                          =3D 0x8084000
brk(0)                                  =3D 0x8084000
open("/usr/share/locale/locale.alias", O_RDONLY) =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size%86, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) =3D 0x40
018000
read(3, "# Locale name alias data base.\n#"..., 4096) =3D 2586
read(3, "", 4096)                       =3D 0
close(3)                                =3D 0
munmap(0x40018000, 4096)                =3D 0
open("/usr/share/locale/en_US/LC_CTYPE", O_RDONLY) =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=178476, ...}) =3D 0
mmap2(NULL, 178476, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x401cf000
close(3)                                =3D 0
open("/etc/sensors.conf", O_RDONLY)     =3D 3
open("/proc/mounts", O_RDONLY)          =3D 4
fstat64(4, {st_mode=3DS_IFREG|0444, st_size=3D0, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) =3D 0x40
1fb000
read(4, "rootfs / rootfs rw 0 0\n/dev/root"..., 1024) =3D 344
close(4)                                =3D 0
munmap(0x401fb000, 4096)                =3D 0
open("/sys/bus/i2c/devices",
O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) =3D 4
fstat64(4, {st_mode=3DS_IFDIR|0755, st_size=3D0, ...}) =3D 0
fcntl64(4, F_SETFD, FD_CLOEXEC)         =3D 0
getdents64(4, /* 7 entries */, 4096)    =3D 208
open("/sys/bus/i2c/devices/0-0051/name", O_RDONLY) =3D 5
fstat64(5, {st_mode=3DS_IFREG|0444, st_size@96, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) =3D 0x40
1fb000
read(5, "eeprom\n", 4096)               =3D 7
read(5, "", 4096)                       =3D 0
close(5)                                =3D 0
munmap(0x401fb000, 4096)                =3D 0
open("/sys/class/i2c-adapter/i2c-0/device/name", O_RDONLY) =3D 5
fstat64(5, {st_mode=3DS_IFREG|0444, st_size@96, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) =3D 0x40
1fb000
read(5, "SMBus nForce2 adapter at 5000\n", 4096) =3D 30
close(5)                                =3D 0
munmap(0x401fb000, 4096)                =3D 0
open("/sys/bus/i2c/devices/0-0050/name", O_RDONLY) =3D 5
fstat64(5, {st_mode=3DS_IFREG|0444, st_size@96, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) =3D 0x40
1fb000
read(5, "eeprom\n", 4096)               =3D 7
read(5, "", 4096)                       =3D 0
close(5)                                =3D 0
munmap(0x401fb000, 4096)                =3D 0
open("/sys/class/i2c-adapter/i2c-0/device/name", O_RDONLY) =3D 5
fstat64(5, {st_mode=3DS_IFREG|0444, st_size@96, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) =3D 0x40
1fb000
read(5, "SMBus nForce2 adapter at 5000\n", 4096) =3D 30
close(5)                                =3D 0
munmap(0x401fb000, 4096)                =3D 0
open("/sys/bus/i2c/devices/1-0048/name", O_RDONLY) =3D 5
fstat64(5, {st_mode=3DS_IFREG|0444, st_size@96, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) =3D 0x40
1fb000
read(5, "asb100 subclient\n", 4096)     =3D 17
close(5)                                =3D 0
munmap(0x401fb000, 4096)                =3D 0
open("/sys/bus/i2c/devices/1-0049/name", O_RDONLY) =3D 5
fstat64(5, {st_mode=3DS_IFREG|0444, st_size@96, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) =3D 0x40
1fb000
read(5, "asb100 subclient\n", 4096)     =3D 17
close(5)                                =3D 0
munmap(0x401fb000, 4096)                =3D 0
open("/sys/bus/i2c/devices/1-002d/name", O_RDONLY) =3D 5
fstat64(5, {st_mode=3DS_IFREG|0444, st_size@96, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) =3D 0x40
1fb000
read(5, "asb100\n", 4096)               =3D 7
read(5, "", 4096)                       =3D 0
close(5)                                =3D 0
munmap(0x401fb000, 4096)                =3D 0
open("/sys/class/i2c-adapter/i2c-1/device/name", O_RDONLY) =3D 5
fstat64(5, {st_mode=3DS_IFREG|0444, st_size@96, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) =3D 0x40
1fb000
read(5, "SMBus nForce2 adapter at 5500\n", 4096) =3D 30
close(5)                                =3D 0
munmap(0x401fb000, 4096)                =3D 0
getdents64(4, /* 0 entries */, 4096)    =3D 0
close(4)                                =3D 0
open("/sys/class/i2c-adapter",
O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) =3D 4
fstat64(4, {st_mode=3DS_IFDIR|0755, st_size=3D0, ...}) =3D 0
fcntl64(4, F_SETFD, FD_CLOEXEC)         =3D 0
getdents64(4, /* 4 entries */, 4096)    =3D 112
open("/sys/class/i2c-adapter/i2c-1/device/name", O_RDONLY) =3D 5
fstat64(5, {st_mode=3DS_IFREG|0444, st_size@96, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) =3D 0x40
1fb000
read(5, "SMBus nForce2 adapter at 5500\n", 4096) =3D 30
close(5)                                =3D 0
munmap(0x401fb000, 4096)                =3D 0
open("/sys/class/i2c-adapter/i2c-0/device/name", O_RDONLY) =3D 5
fstat64(5, {st_mode=3DS_IFREG|0444, st_size@96, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) =3D 0x40
1fb000
read(5, "SMBus nForce2 adapter at 5000\n", 4096) =3D 30
close(5)                                =3D 0
munmap(0x401fb000, 4096)                =3D 0
getdents64(4, /* 0 entries */, 4096)    =3D 0
close(4)                                =3D 0
ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, 0xbfffe488) =3D -1 ENOTTY
(Inappropriate i
octl for device)
fstat64(3, {st_mode=3DS_IFREG|0644, st_sizeV775, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) =3D 0x40
1fb000
read(3, "# Sensors configuration file use"..., 8192) =3D 8192
read(3, " SMBus adapter\"\n#\n# If we refer "..., 8192) =3D 8192
read(3, "ard\n# uses the recommended resis"..., 8192) =3D 8192
read(3, " 3.3 * 1.05\n    set in3_min 5.0 "..., 8192) =3D 8192
read(3, "u typically get the\n# most serio"..., 8192) =3D 8192
read(3, "ith double quotes.\n#\n#   label \""..., 8192) =3D 8192
read(3, " set pwm1          255\n#    set "..., 8192) =3D 7623
read(3, "", 4096)                       =3D 0
read(3, "", 8192)                       =3D 0
ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, 0xbfffe478) =3D -1 ENOTTY
(Inappropriate i
octl for device)
close(3)                                =3D 0
munmap(0x401fb000, 4096)                =3D 0
open("/sys/bus/i2c/devices/1-002d/vrm", O_WRONLY|O_CREAT|O_TRUNC, 0666)
=3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) =3D 0x40
1fb000
write(3, "90", 2)                       =3D 2
close(3)                                =3D 0
munmap(0x401fb000, 4096)                =3D 0
open("/sys/bus/i2c/devices/1-002d/vid", O_RDONLY) =3D 3
fstat64(3, {st_mode=3DS_IFREG|0444, st_size@96, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) =3D 0x40
1fb000
read(3, "1650\n", 4096)                 =3D 5
close(3)                                =3D 0
munmap(0x401fb000, 4096)                =3D 0
open("/sys/bus/i2c/devices/1-002d/in_min0", O_WRONLY|O_CREAT|O_TRUNC,
0666) =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) =3D 0x40
1fb000
write(3, "1567", 4)                     =3D 4
close(3)                                =3D 0
munmap(0x401fb000, 4096)                =3D 0
open("/sys/bus/i2c/devices/1-002d/vid", O_RDONLY) =3D 3
fstat64(3, {st_mode=3DS_IFREG|0444, st_size@96, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) =3D 0x40
1fb000
read(3, "1650\n", 4096)                 =3D 5
close(3)                                =3D 0
munmap(0x401fb000, 4096)                =3D 0
open("/sys/bus/i2c/devices/1-002d/in_max0", O_WRONLY|O_CREAT|O_TRUNC,
0666) =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) =3D 0x40
1fb000
write(3, "1732", 4)                     =3D 4
close(3)                                =3D 0
munmap(0x401fb000, 4096)                =3D 0
open("/sys/bus/i2c/devices/1-002d/vid", O_RDONLY) =3D 3
fstat64(3, {st_mode=3DS_IFREG|0444, st_size@96, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) =3D 0x40
1fb000
read(3, "1650\n", 4096)                 =3D 5
close(3)                                =3D 0
munmap(0x401fb000, 4096)                =3D 0
open("/sys/bus/i2c/devices/1-002d/in_min1", O_WRONLY|O_CREAT|O_TRUNC,
0666) =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) =3D 0x40
1fb000
write(3, "1567", 4)                     =3D 4
close(3)                                =3D 0
munmap(0x401fb000, 4096)                =3D 0
open("/sys/bus/i2c/devices/1-002d/vid", O_RDONLY) =3D 3
fstat64(3, {st_mode=3DS_IFREG|0444, st_size@96, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) =3D 0x40
1fb000
read(3, "1650\n", 4096)                 =3D 5
close(3)                                =3D 0
munmap(0x401fb000, 4096)                =3D 0
open("/sys/bus/i2c/devices/1-002d/in_max1", O_WRONLY|O_CREAT|O_TRUNC,
0666) =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) =3D 0x40
1fb000
write(3, "1732", 4)                     =3D 4
close(3)                                =3D 0
munmap(0x401fb000, 4096)                =3D 0
open("/sys/bus/i2c/devices/1-002d/in_min2", O_WRONLY|O_CREAT|O_TRUNC,
0666) =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) =3D 0x40
1fb000
write(3, "3135", 4)                     =3D 4
close(3)                                =3D 0
munmap(0x401fb000, 4096)                =3D 0
open("/sys/bus/i2c/devices/1-002d/in_max2", O_WRONLY|O_CREAT|O_TRUNC,
0666) =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) =3D 0x40
1fb000
write(3, "3465", 4)                     =3D 4
close(3)                                =3D 0
munmap(0x401fb000, 4096)                =3D 0
open("/sys/bus/i2c/devices/1-002d/in_min3", O_WRONLY|O_CREAT|O_TRUNC,
0666) =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) =3D 0x40
1fb000
write(3, "2827", 4)                     =3D 4
close(3)                                =3D 0
munmap(0x401fb000, 4096)                =3D 0
open("/sys/bus/i2c/devices/1-002d/in_max3", O_WRONLY|O_CREAT|O_TRUNC,
0666) =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) =3D 0x40
1fb000
write(3, "3125", 4)                     =3D 4
close(3)                                =3D 0
munmap(0x401fb000, 4096)                =3D 0
open("/sys/bus/i2c/devices/1-002d/in_min4", O_WRONLY|O_CREAT|O_TRUNC,
0666) =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) =3D 0x40
1fb000
write(3, "2842", 4)                     =3D 4
close(3)                                =3D 0
munmap(0x401fb000, 4096)                =3D 0
open("/sys/bus/i2c/devices/1-002d/in_max4", O_WRONLY|O_CREAT|O_TRUNC,
0666) =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) =3D 0x40
1fb000
write(3, "3473", 4)                     =3D 4
close(3)                                =3D 0
munmap(0x401fb000, 4096)                =3D 0
open("/sys/bus/i2c/devices/1-002d/in_max5", O_WRONLY|O_CREAT|O_TRUNC,
0666) =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) =3D 0x40
1fb000
write(3, "2720", 4)                     =3D 4
close(3)                                =3D 0
munmap(0x401fb000, 4096)                =3D 0
open("/sys/bus/i2c/devices/1-002d/in_min5", O_WRONLY|O_CREAT|O_TRUNC,
0666) =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) =3D 0x40
1fb000
write(3, "3324", 4)                     =3D 4
close(3)                                =3D 0
munmap(0x401fb000, 4096)                =3D 0
open("/sys/bus/i2c/devices/1-002d/in_max6", O_WRONLY|O_CREAT|O_TRUNC,
0666) =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) =3D 0x40
1fb000
write(3, "2851", 4)                     =3D 4
close(3)                                =3D 0
munmap(0x401fb000, 4096)                =3D 0
open("/sys/bus/i2c/devices/1-002d/in_min6", O_WRONLY|O_CREAT|O_TRUNC,
0666) =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) =3D 0x40
1fb000
write(3, "3151", 4)                     =3D 4
close(3)                                =3D 0
munmap(0x401fb000, 4096)                =3D 0
open("/sys/bus/i2c/devices/1-002d/temp_max1", O_WRONLY|O_CREAT|O_TRUNC,
0666) 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) =3D 0x40
1fb000
write(3, "45000", 5)                    =3D 5
close(3)                                =3D 0
munmap(0x401fb000, 4096)                =3D 0
open("/sys/bus/i2c/devices/1-002d/temp_hyst1", O_WRONLY|O_CREAT|O_TRUNC,
0666)  3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) =3D 0x40
1fb000
write(3, "40000", 5)                    =3D 5
close(3)                                =3D 0
munmap(0x401fb000, 4096)                =3D 0
open("/sys/bus/i2c/devices/1-002d/temp_max2", O_WRONLY|O_CREAT|O_TRUNC,
0666) 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) =3D 0x40
1fb000
write(3, "60000", 5)                    =3D 5
close(3)                                =3D 0
munmap(0x401fb000, 4096)                =3D 0
open("/sys/bus/i2c/devices/1-002d/temp_hyst2", O_WRONLY|O_CREAT|O_TRUNC,
0666)  3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) =3D 0x40
1fb000
write(3, "50000", 5)                    =3D 5
close(3)                                =3D 0
munmap(0x401fb000, 4096)                =3D 0
open("/sys/bus/i2c/devices/1-002d/temp_max3", O_WRONLY|O_CREAT|O_TRUNC,
0666) 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) =3D 0x40
1fb000
write(3, "45000", 5)                    =3D 5
close(3)                                =3D 0
munmap(0x401fb000, 4096)                =3D 0
open("/sys/bus/i2c/devices/1-002d/temp_hyst3", O_WRONLY|O_CREAT|O_TRUNC,
0666)  3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) =3D 0x40
1fb000
write(3, "40000", 5)                    =3D 5
close(3)                                =3D 0
munmap(0x401fb000, 4096)                =3D 0
open("/sys/bus/i2c/devices/1-002d/temp_max4", O_WRONLY|O_CREAT|O_TRUNC,
0666) 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) =3D 0x40
1fb000
write(3, "60000", 5)                    =3D 5
close(3)                                =3D 0
munmap(0x401fb000, 4096)                =3D 0
open("/sys/bus/i2c/devices/1-002d/temp_hyst4", O_WRONLY|O_CREAT|O_TRUNC,
0666)  3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) =3D 0x40
1fb000
write(3, "50000", 5)                    =3D 5
close(3)                                =3D 0
munmap(0x401fb000, 4096)                =3D 0
open("/sys/bus/i2c/devices/1-002d/fan_div1", O_WRONLY|O_CREAT|O_TRUNC,
0666) =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) =3D 0x40
1fb000
write(3, "4", 1)                        =3D 1
close(3)                                =3D 0
munmap(0x401fb000, 4096)                =3D 0
open("/sys/bus/i2c/devices/1-002d/fan_min1", O_WRONLY|O_CREAT|O_TRUNC,
0666) =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) =3D 0x40
1fb000
write(3, "2000", 4)                     =3D 4
close(3)                                =3D 0
munmap(0x401fb000, 4096)                =3D 0
open("/sys/bus/i2c/devices/1-002d/fan_div2", O_WRONLY|O_CREAT|O_TRUNC,
0666) =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) =3D 0x40
1fb000
write(3, "2", 1)                        =3D 1
close(3)                                =3D 0
munmap(0x401fb000, 4096)                =3D 0
open("/sys/bus/i2c/devices/1-002d/fan_min2", O_WRONLY|O_CREAT|O_TRUNC,
0666) =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) 0x40                                                                    =
       1fb000
write(3, "4000", 4)                     =3D 4
close(3)                                =3D 0
munmap(0x401fb000, 4096)                =3D 0
open("/sys/bus/i2c/devices/1-002d/fan_div3", O_WRONLY|O_CREAT|O_TRUNC,
0666) =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) 0x40                                                                    =
       1fb000
write(3, "2", 1)                        =3D 1
close(3)                                =3D 0
munmap(0x401fb000, 4096)                =3D 0
open("/sys/bus/i2c/devices/1-002d/fan_min3", O_WRONLY|O_CREAT|O_TRUNC,
0666) =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=3D0, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) 0x40                                                                    =
       1fb000
write(3, "4000", 4)                     =3D 4
close(3)                                =3D 0
munmap(0x401fb000, 4096)                =3D 0
exit_group(0)                           =3D ?
[root@Oneniisama rob]#

























On Thu, 2004-11-18 at 08:19, Jean Delvare wrote:
> > This appears to be an issue that many are having, in a
> > webforum i particpate in, we are all encountering sensors not responding
> > to changes in the conf file. One user even deleted the conf file and
> > replaced it with a dummy file, and sensors still worked. As of now, we
> > still cant find out how to talk to sensors and modify its output and
> > computations.
>=20
> Please take a look at ticket #1817:
> http://www2.lm-sensors.nu/~lm78/readticket.cgi?ticket=1817
>=20
> Looks exactly like your problem. Mandrake too. Isn't by any chance your
> webforum Mandrake-related?
>=20
> I really want to see the output of "strace sensors -s" for users having
> the problem. It would also be very interesting to see if Mandrake
> applied some patches to lm_sensors when building the RPM.
>=20
> Thanks,
> Jean

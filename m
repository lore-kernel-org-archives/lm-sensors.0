From: Michael Brian Willis <willis@arlut.utexas.edu>
Date: Tue, 06 Nov 2007 18:10:39 +0000
Subject: Re: [lm-sensors] LM75: "ERROR: Can't get temperature data!"
Message-Id: <1194372639.4874.6.camel@louie>
List-Id: <lm-sensors.vger.kernel.org>
References: <1194039013.25315.2.camel@louie>
In-Reply-To: <1194039013.25315.2.camel@louie>
MIME-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Jean,=20

Thank you for your response. Below is the information you requested.=20
Thanks again for your help!

Michael Willis

-----

> Odd. Please check that no older libsensors version gets in the way
> (sensors -v).
[root@myboard /]# sensors -v
sensors version 2.10.5 with libsensors version 2.10.5


> Also, please provide the output of "ls -lR /sys/class/hwmon/*/device/".
[root@myboard /]# ls -lR /sys/class/hwmon/*/device/
/sys/class/hwmon/hwmon0/device/:
total 0
-r--r--r-- 1 root root 4096 Dec 31  1969 alarms
lrwxrwxrwx 1 root root    0 Dec 31  1969 bus -> ../../../../../bus/i2c
lrwxrwxrwx 1 root root    0 Dec 31  1969 driver -
> ../../../../../bus/i2c/drivers/max1619
lrwxrwxrwx 1 root root    0 Dec 31  1969 hwmon:hwmon0 -
> ../../../../../class/hwmon/hwmon0
-r--r--r-- 1 root root 4096 Dec 31  1969 name
lrwxrwxrwx 1 root root    0 Dec 31  1969 subsystem -
> ../../../../../bus/i2c
-r--r--r-- 1 root root 4096 Dec 31  1969 temp1_input
-rw-r--r-- 1 root root 4096 Dec 31  1969 temp2_crit
-rw-r--r-- 1 root root 4096 Dec 31  1969 temp2_crit_hyst
-r--r--r-- 1 root root 4096 Dec 31  1969 temp2_input
-rw-r--r-- 1 root root 4096 Dec 31  1969 temp2_max
-rw-r--r-- 1 root root 4096 Dec 31  1969 temp2_min
--w------- 1 root root 4096 Dec 31  1969 uevent

/sys/class/hwmon/hwmon1/device/:
total 0
lrwxrwxrwx 1 root root    0 Dec 31  1969 bus -> ../../../../../bus/i2c
lrwxrwxrwx 1 root root    0 Dec 31  1969 driver -
> ../../../../../bus/i2c/drivers/lm75
lrwxrwxrwx 1 root root    0 Dec 31  1969 hwmon:hwmon1 -
> ../../../../../class/hwmon/hwmon1
drwxr-xr-x 2 root root    0 Dec 31  1969 lm75
-r--r--r-- 1 root root 4096 Dec 31  1969 name
lrwxrwxrwx 1 root root    0 Dec 31  1969 subsystem -
> ../../../../../bus/i2c
--w------- 1 root root 4096 Dec 31  1969 uevent

/sys/class/hwmon/hwmon1/device/lm75:
total 0
-r--r--r-- 1 root root 4096 Dec 31  1969 temp1_input
-rw-r--r-- 1 root root 4096 Dec 31  1969 temp1_max
-rw-r--r-- 1 root root 4096 Dec 31  1969 temp1_max_hyst



>  If you have strace installed, please provide the output
> of "strace sensors".
[root@myboard /]# strace sensors
execve("/usr/local/bin/sensors", ["sensors"], [/* 19 vars */]) =3D 0
brk(0)                                  =3D 0x10039000
access("/etc/ld.so.preload", R_OK)      =3D -1 ENOENT (No such file or
directory)
open("/usr/local/lib/tls/ppc8540/libsensors.so.3", O_RDONLY) =3D -1 ENOENT
(No such file or directory)
stat64("/usr/local/lib/tls/ppc8540", 0x7ff84088) =3D -1 ENOENT (No such
file or directory)
open("/usr/local/lib/tls/libsensors.so.3", O_RDONLY) =3D -1 ENOENT (No
such file or directory)
stat64("/usr/local/lib/tls", 0x7ff84088) =3D -1 ENOENT (No such file or
directory)
open("/usr/local/lib/ppc8540/libsensors.so.3", O_RDONLY) =3D -1 ENOENT (No
such file or directory)
stat64("/usr/local/lib/ppc8540", 0x7ff84088) =3D -1 ENOENT (No such file
or directory)
open("/usr/local/lib/libsensors.so.3", O_RDONLY) =3D 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\0\320"...,
512) =3D 512
fstat64(3, {st_mode=3DS_IFREG|0755, st_size%1817, ...}) =3D 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
=3D 0x30000000
mmap(0xff65000, 306020, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE,
3, 0) =3D 0xff65000
mprotect(0xff7f000, 61440, PROT_NONE)   =3D 0
mmap(0xff8e000, 135168, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|
MAP_DENYWRITE, 3, 0x19000) =3D 0xff8e000
mmap(0xffaf000, 2916, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|
MAP_ANONYMOUS, -1, 0) =3D 0xffaf000
close(3)                                =3D 0
open("/usr/local/lib/libc.so.6", O_RDONLY) =3D -1 ENOENT (No such file or
directory)
open("/etc/ld.so.cache", O_RDONLY)      =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size8842, ...}) =3D 0
mmap(NULL, 38842, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x30001000
close(3)                                =3D 0
open("/lib/libc.so.6", O_RDONLY)        =3D 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\17\345"...,
512) =3D 512
fstat64(3, {st_mode=3DS_IFREG|0755, st_size=1793784, ...}) =3D 0
mmap(0xfe40000, 1520028, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE,
3, 0) =3D 0x3000b000
mprotect(0x3016a000, 53248, PROT_NONE)  =3D 0
mmap(0x30177000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|
MAP_DENYWRITE, 3, 0x16c000) =3D 0x30177000
mmap(0x3017c000, 8604, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|
MAP_ANONYMOUS, -1, 0) =3D 0x3017c000
close(3)                                =3D 0
open("/usr/local/lib/libm.so.6", O_RDONLY) =3D -1 ENOENT (No such file or
directory)
open("/lib/libm.so.6", O_RDONLY)        =3D 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\17\323"...,
512) =3D 512
fstat64(3, {st_mode=3DS_IFREG|0755, st_size=865520, ...}) =3D 0
mmap(0xfd30000, 852680, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE,
3, 0) =3D 0xfd30000
mprotect(0xfde2000, 106496, PROT_NONE)  =3D 0
mmap(0xfdfc000, 20480, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|
MAP_DENYWRITE, 3, 0xbc000) =3D 0xfdfc000
close(3)                                =3D 0
open("/usr/local/lib/libsysfs.so.2", O_RDONLY) =3D 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\0-`"...,
512) =3D 512
fstat64(3, {st_mode=3DS_IFREG|0755, st_size=113414, ...}) =3D 0
mmap(0xfd05000, 109684, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE,
3, 0) =3D 0xfd05000
mprotect(0xfd10000, 61440, PROT_NONE)   =3D 0
mmap(0xfd1f000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|
MAP_DENYWRITE, 3, 0xa000) =3D 0xfd1f000
close(3)                                =3D 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
=3D 0x3017f000
mprotect(0xfdfc000, 16384, PROT_READ)   =3D 0
mprotect(0x30177000, 16384, PROT_READ)  =3D 0
mprotect(0xffef000, 4096, PROT_READ)    =3D 0
munmap(0x30001000, 38842)               =3D 0
brk(0)                                  =3D 0x10039000
brk(0x1005a000)                         =3D 0x1005a000
open("/usr/lib/locale/locale-archive", O_RDONLY|O_LARGEFILE) =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_sizeU553968, ...}) =3D 0
mmap2(NULL, 2097152, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x30180000
close(3)                                =3D 0
open("/etc/sensors.conf", O_RDONLY)     =3D 3
lstat64("/sys/class/i2c-adapter", {st_mode=3DS_IFDIR|0755,
st_size=3D0, ...}) =3D 0
open("/sys/class/i2c-adapter", O_RDONLY|O_NONBLOCK|O_LARGEFILE|
O_DIRECTORY) =3D 4
fstat64(4, {st_mode=3DS_IFDIR|0755, st_size=3D0, ...}) =3D 0
fcntl64(4, F_SETFD, FD_CLOEXEC)         =3D 0
getdents(4, /* 3 entries */, 4096)      =3D 52
lstat64("/sys/class/i2c-adapter/i2c-0", {st_mode=3DS_IFDIR|0755,
st_size=3D0, ...}) =3D 0
getdents(4, /* 0 entries */, 4096)      =3D 0
close(4)                                =3D 0
lstat64("/sys/class/i2c-adapter/i2c-0", {st_mode=3DS_IFDIR|0755,
st_size=3D0, ...}) =3D 0
open("/sys/class/i2c-adapter", O_RDONLY|O_NONBLOCK|O_LARGEFILE|
O_DIRECTORY) =3D 4
fstat64(4, {st_mode=3DS_IFDIR|0755, st_size=3D0, ...}) =3D 0
fcntl64(4, F_SETFD, FD_CLOEXEC)         =3D 0
getdents(4, /* 3 entries */, 4096)      =3D 52
lstat64("/sys/class/i2c-adapter/i2c-0", {st_mode=3DS_IFDIR|0755,
st_size=3D0, ...}) =3D 0
getdents(4, /* 0 entries */, 4096)      =3D 0
close(4)                                =3D 0
lstat64("/sys/class/i2c-adapter/i2c-0/name", {st_mode=3DS_IFREG|0444,
st_size@96, ...}) =3D 0
stat64("/sys/class/i2c-adapter/i2c-0/name", {st_mode=3DS_IFREG|0444,
st_size@96, ...}) =3D 0
open("/sys/class/i2c-adapter/i2c-0/name", O_RDONLY) =3D 4
read(4, "MPC adapter\n", 4096)          =3D 12
close(4)                                =3D 0
lstat64("/sys/class/hwmon", {st_mode=3DS_IFDIR|0755, st_size=3D0, ...}) =3D=
 0
open("/sys/class/hwmon", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) 4
fstat64(4, {st_mode=3DS_IFDIR|0755, st_size=3D0, ...}) =3D 0
fcntl64(4, F_SETFD, FD_CLOEXEC)         =3D 0
getdents(4, /* 4 entries */, 4096)      =3D 72
lstat64("/sys/class/hwmon/hwmon1", {st_mode=3DS_IFDIR|0755,
st_size=3D0, ...}) =3D 0
lstat64("/sys/class/hwmon/hwmon0", {st_mode=3DS_IFDIR|0755,
st_size=3D0, ...}) =3D 0
getdents(4, /* 0 entries */, 4096)      =3D 0
close(4)                                =3D 0
lstat64("/sys/class/hwmon/hwmon0", {st_mode=3DS_IFDIR|0755,
st_size=3D0, ...}) =3D 0
lstat64("/sys/class/hwmon/hwmon1", {st_mode=3DS_IFDIR|0755,
st_size=3D0, ...}) =3D 0
open("/sys/class/hwmon", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) 4
fstat64(4, {st_mode=3DS_IFDIR|0755, st_size=3D0, ...}) =3D 0
fcntl64(4, F_SETFD, FD_CLOEXEC)         =3D 0
getdents(4, /* 4 entries */, 4096)      =3D 72
lstat64("/sys/class/hwmon/hwmon1", {st_mode=3DS_IFDIR|0755,
st_size=3D0, ...}) =3D 0
lstat64("/sys/class/hwmon/hwmon0", {st_mode=3DS_IFDIR|0755,
st_size=3D0, ...}) =3D 0
getdents(4, /* 0 entries */, 4096)      =3D 0
close(4)                                =3D 0
lstat64("/sys/class/hwmon/hwmon0/device", {st_mode=3DS_IFLNK|0777,
st_size=3D0, ...}) =3D 0
readlink("/sys/class/hwmon/hwmon0/device",
"../../../devices/platform/fsl-i2c.1/i2c-0/0-001a", 256) =3D 48
lstat64("/sys/devices/platform/fsl-i2c.1/i2c-0/0-001a",
{st_mode=3DS_IFDIR|0755, st_size=3D0, ...}) =3D 0
lstat64("/sys/devices/platform/fsl-i2c.1/i2c-0/0-001a/bus",
{st_mode=3DS_IFLNK|0777, st_size=3D0, ...}) =3D 0
readlink("/sys/devices/platform/fsl-i2c.1/i2c-0/0-001a/bus",
"../../../../../bus/i2c", 256) =3D 22
lstat64("/sys/devices/platform/fsl-i2c.1/i2c-0/0-001a/driver",
{st_mode=3DS_IFLNK|0777, st_size=3D0, ...}) =3D 0
readlink("/sys/devices/platform/fsl-i2c.1/i2c-0/0-001a/driver",
"../../../../../bus/i2c/drivers/max1619", 256) =3D 38
lstat64("/sys/devices/platform/fsl-i2c.1/i2c-0/0-001a/subsystem",
{st_mode=3DS_IFLNK|0777, st_size=3D0, ...}) =3D 0
readlink("/sys/devices/platform/fsl-i2c.1/i2c-0/0-001a/subsystem",
"../../../../../bus/i2c", 256) =3D 22
lstat64("/sys/devices/platform/fsl-i2c.1/i2c-0/0-001a/name",
{st_mode=3DS_IFREG|0444, st_size@96, ...}) =3D 0
stat64("/sys/devices/platform/fsl-i2c.1/i2c-0/0-001a/name",
{st_mode=3DS_IFREG|0444, st_size@96, ...}) =3D 0
open("/sys/devices/platform/fsl-i2c.1/i2c-0/0-001a/name", O_RDONLY) =3D 4
read(4, "max1619\n", 4096)              =3D 8
close(4)                                =3D 0
stat64("/sys/class/i2c-adapter/i2c-0/device/name", {st_mode=3DS_IFREG|
0444, st_size@96, ...}) =3D 0
open("/sys/class/i2c-adapter/i2c-0/device/name", O_RDONLY) =3D 4
read(4, "MPC adapter\n", 4096)          =3D 12
close(4)                                =3D 0
lstat64("/sys/class/hwmon/hwmon1/device", {st_mode=3DS_IFLNK|0777,
st_size=3D0, ...}) =3D 0
readlink("/sys/class/hwmon/hwmon1/device",
"../../../devices/platform/fsl-i2c.1/i2c-0/0-0048", 256) =3D 48
lstat64("/sys/devices/platform/fsl-i2c.1/i2c-0/0-0048",
{st_mode=3DS_IFDIR|0755, st_size=3D0, ...}) =3D 0
lstat64("/sys/devices/platform/fsl-i2c.1/i2c-0/0-0048/bus",
{st_mode=3DS_IFLNK|0777, st_size=3D0, ...}) =3D 0
readlink("/sys/devices/platform/fsl-i2c.1/i2c-0/0-0048/bus",
"../../../../../bus/i2c", 256) =3D 22
lstat64("/sys/devices/platform/fsl-i2c.1/i2c-0/0-0048/driver",
{st_mode=3DS_IFLNK|0777, st_size=3D0, ...}) =3D 0
readlink("/sys/devices/platform/fsl-i2c.1/i2c-0/0-0048/driver",
"../../../../../bus/i2c/drivers/lm75", 256) =3D 35
lstat64("/sys/devices/platform/fsl-i2c.1/i2c-0/0-0048/subsystem",
{st_mode=3DS_IFLNK|0777, st_size=3D0, ...}) =3D 0
readlink("/sys/devices/platform/fsl-i2c.1/i2c-0/0-0048/subsystem",
"../../../../../bus/i2c", 256) =3D 22
lstat64("/sys/devices/platform/fsl-i2c.1/i2c-0/0-0048/name",
{st_mode=3DS_IFREG|0444, st_size@96, ...}) =3D 0
stat64("/sys/devices/platform/fsl-i2c.1/i2c-0/0-0048/name",
{st_mode=3DS_IFREG|0444, st_size@96, ...}) =3D 0
open("/sys/devices/platform/fsl-i2c.1/i2c-0/0-0048/name", O_RDONLY) =3D 4
read(4, "lm75\n", 4096)                 =3D 5
close(4)                                =3D 0
stat64("/sys/class/i2c-adapter/i2c-0/device/name", {st_mode=3DS_IFREG|
0444, st_size@96, ...}) =3D 0
open("/sys/class/i2c-adapter/i2c-0/device/name", O_RDONLY) =3D 4
read(4, "MPC adapter\n", 4096)          =3D 12
close(4)                                =3D 0
ioctl(3, TCGETS, 0x7ff84848)            =3D -1 ENOTTY (Inappropriate ioctl
for device)
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=85179, ...}) =3D 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
=3D 0x30001000
read(3, "# Sensors configuration file use"..., 8192) =3D 8192
read(3, "its may have all sorts of weird "..., 8192) =3D 8192
read(3, "+12V\"\n    label in5 \"-12V\"\n    l"..., 8192) =3D 8192
read(3, "1 \"Fan1\"\n    label fan2 \"Fan2\"\n "..., 8192) =3D 8192
read(3, "\n# What is your VCore? It is pro"..., 8192) =3D 8192
read(3, "fixed inside\n# the chip for thes"..., 8192) =3D 8192
read(3, " compute in5 -(36/10)*@, -@/(36/"..., 8192) =3D 8192
read(3, "r kernels only.\n#  set    ain_co"..., 8192) =3D 8192
read(3, "(^ (3435 / 298.15 - 3435 / (273."..., 8192) =3D 8192
read(3, "@/2\n   compute in10  @*2, @/2\n\n#"..., 8192) =3D 8192
read(3, "an3 \"SYS FAN Speed\"\n   label fan"..., 8192) =3D 3259
read(3, "", 4096)                       =3D 0
read(3, "", 8192)                       =3D 0
ioctl(3, TCGETS, 0x7ff83868)            =3D -1 ENOTTY (Inappropriate ioctl
for device)
close(3)                                =3D 0
munmap(0x30001000, 4096)                =3D 0
open("/usr/lib/gconv/gconv-modules.cache", O_RDONLY) =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size%460, ...}) =3D 0
mmap(NULL, 25460, PROT_READ, MAP_SHARED, 3, 0) =3D 0x30001000
close(3)                                =3D 0
open("/usr/lib/gconv/ISO8859-1.so", O_RDONLY) =3D 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\0\4"...,
512) =3D 512
fstat64(3, {st_mode=3DS_IFREG|0755, st_sizef876, ...}) =3D 0
mmap(0xfcd4000, 131096, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE,
3, 0) =3D 0xfcd4000
mprotect(0xfcd6000, 118784, PROT_NONE)  =3D 0
mmap(0xfcf3000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|
MAP_DENYWRITE, 3, 0xf000) =3D 0xfcf3000
close(3)                                =3D 0
mprotect(0xfcf3000, 4096, PROT_READ)    =3D 0
brk(0x1007f000)                         =3D 0x1007f000
brk(0x10077000)                         =3D 0x10077000
fstat64(1, {st_mode=3DS_IFCHR|0620, st_rdev=3Dmakedev(4, 64), ...}) =3D 0
ioctl(1, TCGETS, {B115200 opost isig icanon echo ...}) =3D 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
=3D 0x30008000
write(1, "max1619-i2c-0-1a\n", 17max1619-i2c-0-1a
)      =3D 17
write(1, "Adapter: MPC adapter\n", 21Adapter: MPC adapter
)  =3D 21
open("/sys/devices/platform/fsl-i2c.1/i2c-0/0-001a/temp1_input",
O_RDONLY) =3D 3
fstat64(3, {st_mode=3DS_IFREG|0444, st_size@96, ...}) =3D 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
=3D 0x30009000
read(3, "28000\n", 4096)                =3D 6
close(3)                                =3D 0
munmap(0x30009000, 4096)                =3D 0
write(1, "M/B Temp: 28.00 (temp1)\n", 24M/B Temp: 28.00 (temp1)
) =3D 24
open("/sys/devices/platform/fsl-i2c.1/i2c-0/0-001a/temp2_input",
O_RDONLY) =3D 3
fstat64(3, {st_mode=3DS_IFREG|0444, st_size@96, ...}) =3D 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
=3D 0x30009000
read(3, "127000\n", 4096)               =3D 7
close(3)                                =3D 0
munmap(0x30009000, 4096)                =3D 0
write(1, "CPU Temp: 127.00 (temp2)\n", 25CPU Temp: 127.00 (temp2)
) =3D 25
open("/sys/devices/platform/fsl-i2c.1/i2c-0/0-001a/temp2_min_label",
O_RDONLY) =3D -1 ENOENT (No such file or directory)
open("/sys/devices/platform/fsl-i2c.1/i2c-0/0-001a/temp2_min", O_RDONLY)
=3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size@96, ...}) =3D 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
=3D 0x30009000
read(3, "-55000\n", 4096)               =3D 7
close(3)                                =3D 0
munmap(0x30009000, 4096)                =3D 0
write(1, "  temp2_min: -55.00 (temp2_min)\n", 32  temp2_min: -55.00
(temp2_min)
) =3D 32
open("/sys/devices/platform/fsl-i2c.1/i2c-0/0-001a/temp2_max_label",
O_RDONLY) =3D -1 ENOENT (No such file or directory)
open("/sys/devices/platform/fsl-i2c.1/i2c-0/0-001a/temp2_max", O_RDONLY)
=3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size@96, ...}) =3D 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
=3D 0x30009000
read(3, "127000\n", 4096)               =3D 7
close(3)                                =3D 0
munmap(0x30009000, 4096)                =3D 0
write(1, "  temp2_max: 127.00 (temp2_max)\n", 32  temp2_max: 127.00
(temp2_max)
) =3D 32
open("/sys/devices/platform/fsl-i2c.1/i2c-0/0-001a/temp2_crit_label",
O_RDONLY) =3D -1 ENOENT (No such file or directory)
open("/sys/devices/platform/fsl-i2c.1/i2c-0/0-001a/temp2_crit",
O_RDONLY) =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size@96, ...}) =3D 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
=3D 0x30009000
read(3, "100000\n", 4096)               =3D 7
close(3)                                =3D 0
munmap(0x30009000, 4096)                =3D 0
write(1, "  temp2_crit: 100.00 (temp2_crit"..., 34  temp2_crit: 100.00
(temp2_crit)
) =3D 34
open("/sys/devices/platform/fsl-i2c.1/i2c-0/0-001a/temp2_hyst_label",
O_RDONLY) =3D -1 ENOENT (No such file or directory)
open("/sys/devices/platform/fsl-i2c.1/i2c-0/0-001a/temp2_crit_hyst",
O_RDONLY) =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size@96, ...}) =3D 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
=3D 0x30009000
read(3, "95000\n", 4096)                =3D 6
close(3)                                =3D 0
munmap(0x30009000, 4096)                =3D 0
write(1, "  temp2_hyst: 95.00 (temp2_hyst)"..., 33  temp2_hyst: 95.00
(temp2_hyst)
) =3D 33
open("/sys/devices/platform/fsl-i2c.1/i2c-0/0-001a/alarms_label",
O_RDONLY) =3D -1 ENOENT (No such file or directory)
open("/sys/devices/platform/fsl-i2c.1/i2c-0/0-001a/alarms", O_RDONLY) 3
fstat64(3, {st_mode=3DS_IFREG|0444, st_size@96, ...}) =3D 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
=3D 0x30009000
read(3, "148\n", 4096)                  =3D 4
close(3)                                =3D 0
munmap(0x30009000, 4096)                =3D 0
write(1, "alarms: 148.00 (alarms)\n", 24alarms: 148.00 (alarms)
) =3D 24
write(1, "\n", 1
)                       =3D 1
write(1, "lm75-i2c-0-48\n", 14lm75-i2c-0-48
)         =3D 14
write(1, "Adapter: MPC adapter\n", 21Adapter: MPC adapter
)  =3D 21
open("/sys/devices/platform/fsl-i2c.1/i2c-0/0-0048/temp_label",
O_RDONLY) =3D -1 ENOENT (No such file or directory)
open("/sys/devices/platform/fsl-i2c.1/i2c-0/0-0048/temp1_input",
O_RDONLY) =3D -1 ENOENT (No such file or directory)
open("/sys/devices/platform/fsl-i2c.1/i2c-0/0-0048/_", O_RDONLY) =3D -1
ENOENT (No such file or directory)
write(1, "ERROR: Can\'t get temperature dat"..., 35ERROR: Can't get
temperature data!
) =3D 35
write(1, "\n", 1
)                       =3D 1
exit_group(0)                           =3D ?
Process 1966 detached

---------




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

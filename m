From: Marc.Kalberer@programmers.ch (Marc Kalberer)
Date: Sat, 09 Sep 2006 23:11:43 +0000
Subject: [lm-sensors] VT1211-ISA-6000 &  procfs/sysfs
Message-Id: <45034A2F.2020701@programmers.ch>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,
I dont know if my problem is related to lm-sensors or VT1211 I2C patch 
but I have the following prob when executing sensors -s :

vt1211-isa-6000: Can't access procfs/sysfs file for writing;

Conclusion : pwmconfig  give me a : No sensors found!

Sys is populated,  kernel is a pure vanilla 2.6.18-rc5 patched with the 
one given at 
http://khali.linux-fr.org/devel/i2c/linux-2.6/hwmon-vt1211-new-driver.patch.  
With the latest lm_sensors-2.10.0 and gcc4.0.3-1

I both compile the full set of the I2C drivers in modules or built-in.  
It gave me the same result.

Hardware is EPIA M10000.

It is supposed to work, but it doesn't ? Any Idea of the prob ? 

I joined :
1) strace sensors -s
2) lspci
3) dmesg

++

Marc

sensor:
------------------------------------------
execve("/usr/local/bin/sensors", ["sensors", "-s"], [/* 18 vars */]) = 0
uname({sys="Linux", node="mediabox", ...}) = 0
brk(0)                                  = 0x806b000
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, 
-1, 0) = 0xb7fc7000
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or 
directory)
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, 
-1, 0) = 0xb7fc6000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or 
directory)
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, 
-1, 0) = 0xb7fc5000
open("/usr/local/lib/tls/i686/cmov/libsensors.so.3", O_RDONLY) = -1 
ENOENT (No such file or directory)
stat64("/usr/local/lib/tls/i686/cmov", 0xbfb494d4) = -1 ENOENT (No such 
file or directory)
open("/usr/local/lib/tls/i686/libsensors.so.3", O_RDONLY) = -1 ENOENT 
(No such file or directory)
stat64("/usr/local/lib/tls/i686", 0xbfb494d4) = -1 ENOENT (No such file 
or directory)
open("/usr/local/lib/tls/cmov/libsensors.so.3", O_RDONLY) = -1 ENOENT 
(No such file or directory)
stat64("/usr/local/lib/tls/cmov", 0xbfb494d4) = -1 ENOENT (No such file 
or directory)
open("/usr/local/lib/tls/libsensors.so.3", O_RDONLY) = -1 ENOENT (No 
such file or directory)
stat64("/usr/local/lib/tls", 0xbfb494d4) = -1 ENOENT (No such file or 
directory)
open("/usr/local/lib/i686/cmov/libsensors.so.3", O_RDONLY) = -1 ENOENT 
(No such file or directory)
stat64("/usr/local/lib/i686/cmov", 0xbfb494d4) = -1 ENOENT (No such file 
or directory)
open("/usr/local/lib/i686/libsensors.so.3", O_RDONLY) = -1 ENOENT (No 
such file or directory)
stat64("/usr/local/lib/i686", 0xbfb494d4) = -1 ENOENT (No such file or 
directory)
open("/usr/local/lib/cmov/libsensors.so.3", O_RDONLY) = -1 ENOENT (No 
such file or directory)
stat64("/usr/local/lib/cmov", 0xbfb494d4) = -1 ENOENT (No such file or 
directory)
open("/usr/local/lib/libsensors.so.3", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\320q\0"..., 
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size6729, ...}) = 0
old_mmap(NULL, 170596, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 
3, 0) = 0xb7f9b000
old_mmap(0xb7fac000, 98304, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x10000) = 0xb7fac000
old_mmap(0xb7fc4000, 2660, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7fc4000
close(3)                                = 0
open("/usr/local/lib/libc.so.6", O_RDONLY) = -1 ENOENT (No such file or 
directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size8895, ...}) = 0
old_mmap(NULL, 38895, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7f91000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or 
directory)
open("/lib/tls/i686/cmov/libc.so.6", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\220O\1"..., 
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size32784, ...}) = 0
old_mmap(NULL, 1238972, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 
3, 0) = 0xb7e62000
old_mmap(0xb7f87000, 28672, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x125000) = 0xb7f87000
old_mmap(0xb7f8e000, 10172, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7f8e000
close(3)                                = 0
open("/usr/local/lib/libm.so.6", O_RDONLY) = -1 ENOENT (No such file or 
directory)
open("/usr/local/lib/libm.so.6", O_RDONLY) = -1 ENOENT (No such file or 
directory)
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or 
directory)
open("/lib/tls/i686/cmov/libm.so.6", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0 at 3\0\000"..., 
512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size6368, ...}) = 0
old_mmap(NULL, 138800, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 
3, 0) = 0xb7e40000
old_mmap(0xb7e61000, 4096, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x20000) = 0xb7e61000
close(3)                                = 0
open("/usr/local/lib/libsysfs.so.2", O_RDONLY) = -1 ENOENT (No such file 
or directory)
open("/usr/local/lib/libsysfs.so.2", O_RDONLY) = -1 ENOENT (No such file 
or directory)
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or 
directory)
open("/lib/libsysfs.so.2", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\340\34"..., 
512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size2288, ...}) = 0
old_mmap(NULL, 35300, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 
0) = 0xb7e37000
old_mmap(0xb7e3f000, 4096, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x7000) = 0xb7e3f000
close(3)                                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, 
-1, 0) = 0xb7e36000
set_thread_area({entry_number:-1 -> 6, base_addr:0xb7e36a00, 
limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, 
limit_in_pages:1, seg_not_present:0, useable:1}) = 0
munmap(0xb7f91000, 38895)               = 0
brk(0)                                  = 0x806b000
brk(0x808c000)                          = 0x808c000
open("/usr/lib/locale/locale-archive", O_RDONLY|O_LARGEFILE) = -1 ENOENT 
(No such file or directory)
open("/usr/share/locale/locale.alias", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size%86, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 
0) = 0xb7f9a000
read(3, "# Locale name alias data base.\n#"..., 4096) = 2586
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0xb7f9a000, 4096)                = 0
open("/usr/lib/locale/fr_CH.UTF-8/LC_CTYPE", O_RDONLY) = -1 ENOENT (No 
such file or directory)
open("/usr/lib/locale/fr_CH.utf8/LC_CTYPE", O_RDONLY) = -1 ENOENT (No 
such file or directory)
open("/usr/lib/locale/fr_CH/LC_CTYPE", O_RDONLY) = -1 ENOENT (No such 
file or directory)
open("/usr/lib/locale/fr.UTF-8/LC_CTYPE", O_RDONLY) = -1 ENOENT (No such 
file or directory)
open("/usr/lib/locale/fr.utf8/LC_CTYPE", O_RDONLY) = -1 ENOENT (No such 
file or directory)
open("/usr/lib/locale/fr/LC_CTYPE", O_RDONLY) = -1 ENOENT (No such file 
or directory)
open("/usr/share/locale-langpack/fr_CH.UTF-8/LC_CTYPE", O_RDONLY) = -1 
ENOENT (No such file or directory)
open("/usr/share/locale-langpack/fr_CH.utf8/LC_CTYPE", O_RDONLY) = -1 
ENOENT (No such file or directory)
open("/usr/share/locale-langpack/fr_CH/LC_CTYPE", O_RDONLY) = -1 ENOENT 
(No such file or directory)
open("/usr/share/locale-langpack/fr.UTF-8/LC_CTYPE", O_RDONLY) = -1 
ENOENT (No such file or directory)
open("/usr/share/locale-langpack/fr.utf8/LC_CTYPE", O_RDONLY) = -1 
ENOENT (No such file or directory)
open("/usr/share/locale-langpack/fr/LC_CTYPE", O_RDONLY) = -1 ENOENT (No 
such file or directory)
open("/etc/sensors.conf", O_RDONLY)     = 3
open("/proc/mounts", O_RDONLY)          = 4
fstat64(4, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 
0) = 0xb7f9a000
read(4, "rootfs / rootfs rw 0 0\n/dev/root"..., 1024) = 428
close(4)                                = 0
munmap(0xb7f9a000, 4096)                = 0
open("/proc/mounts", O_RDONLY)          = 4
fstat64(4, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 
0) = 0xb7f9a000
read(4, "rootfs / rootfs rw 0 0\n/dev/root"..., 1024) = 428
close(4)                                = 0
munmap(0xb7f9a000, 4096)                = 0
lstat64("/sys/class/hwmon", {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
open("/sys/class/hwmon", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) = 4
fstat64(4, {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
fcntl64(4, F_SETFD, FD_CLOEXEC)         = 0
getdents64(4, /* 3 entries */, 4096)    = 80
lstat64("/sys/class/hwmon/hwmon0", {st_mode=S_IFDIR|0755, st_size=0, 
...}) = 0
getdents64(4, /* 0 entries */, 4096)    = 0
close(4)                                = 0
lstat64("/sys/class/hwmon/hwmon0", {st_mode=S_IFDIR|0755, st_size=0, 
...}) = 0
open("/sys/class/hwmon", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) = 4
fstat64(4, {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
fcntl64(4, F_SETFD, FD_CLOEXEC)         = 0
getdents64(4, /* 3 entries */, 4096)    = 80
lstat64("/sys/class/hwmon/hwmon0", {st_mode=S_IFDIR|0755, st_size=0, 
...}) = 0
getdents64(4, /* 0 entries */, 4096)    = 0
close(4)                                = 0
lstat64("/sys/class/hwmon/hwmon0/device", {st_mode=S_IFLNK|0777, 
st_size=0, ...}) = 0
readlink("/sys/class/hwmon/hwmon0/device", 
"../../../devices/platform/vt1211.24576", 256) = 38
lstat64("/sys/devices/platform/vt1211.24576", {st_mode=S_IFDIR|0755, 
st_size=0, ...}) = 0
lstat64("/sys/devices/platform/vt1211.24576/bus", {st_mode=S_IFLNK|0777, 
st_size=0, ...}) = 0
readlink("/sys/devices/platform/vt1211.24576/bus", 
"../../../bus/platform", 256) = 21
lstat64("/sys/devices/platform/vt1211.24576/driver", 
{st_mode=S_IFLNK|0777, st_size=0, ...}) = 0
readlink("/sys/devices/platform/vt1211.24576/driver", 
"../../../bus/platform/drivers/vt1211", 256) = 36
lstat64("/sys/devices/platform/vt1211.24576/name", 
{st_mode=S_IFREG|0444, st_size@96, ...}) = 0
stat64("/sys/devices/platform/vt1211.24576/name", {st_mode=S_IFREG|0444, 
st_size@96, ...}) = 0
open("/sys/devices/platform/vt1211.24576/name", O_RDONLY) = 4
read(4, "vt1211\n", 4096)               = 7
close(4)                                = 0
open("/proc/mounts", O_RDONLY)          = 4
fstat64(4, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 
0) = 0xb7f9a000
read(4, "rootfs / rootfs rw 0 0\n/dev/root"..., 1024) = 428
close(4)                                = 0
munmap(0xb7f9a000, 4096)                = 0
lstat64("/sys/class/i2c-adapter", {st_mode=S_IFDIR|0755, st_size=0, 
...}) = 0
open("/sys/class/i2c-adapter", 
O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) = 4
fstat64(4, {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
fcntl64(4, F_SETFD, FD_CLOEXEC)         = 0
getdents64(4, /* 4 entries */, 4096)    = 112
lstat64("/sys/class/i2c-adapter/i2c-9191", {st_mode=S_IFDIR|0755, 
st_size=0, ...}) = 0
lstat64("/sys/class/i2c-adapter/i2c-0", {st_mode=S_IFDIR|0755, 
st_size=0, ...}) = 0
getdents64(4, /* 0 entries */, 4096)    = 0
close(4)                                = 0
lstat64("/sys/class/i2c-adapter/i2c-0", {st_mode=S_IFDIR|0755, 
st_size=0, ...}) = 0
lstat64("/sys/class/i2c-adapter/i2c-9191", {st_mode=S_IFDIR|0755, 
st_size=0, ...}) = 0
open("/sys/class/i2c-adapter", 
O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) = 4
fstat64(4, {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
fcntl64(4, F_SETFD, FD_CLOEXEC)         = 0
getdents64(4, /* 4 entries */, 4096)    = 112
lstat64("/sys/class/i2c-adapter/i2c-9191", {st_mode=S_IFDIR|0755, 
st_size=0, ...}) = 0
lstat64("/sys/class/i2c-adapter/i2c-0", {st_mode=S_IFDIR|0755, 
st_size=0, ...}) = 0
getdents64(4, /* 0 entries */, 4096)    = 0
close(4)                                = 0
lstat64("/sys/class/i2c-adapter/i2c-0/device", {st_mode=S_IFLNK|0777, 
st_size=0, ...}) = 0
readlink("/sys/class/i2c-adapter/i2c-0/device", 
"../../../devices/pci0000:00/0000:00:11.0/i2c-0", 256) = 46
lstat64("/sys/devices/pci0000:00/0000:00:11.0/i2c-0", 
{st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
lstat64("/sys/devices/pci0000:00/0000:00:11.0/i2c-0/bus", 0xbfb4945c) = 
-1 ENOENT (No such file or directory)
lstat64("/sys/devices/pci0000:00/0000:00:11.0/i2c-0/driver", 0xbfb4968c) 
= -1 ENOENT (No such file or directory)
lstat64("/sys/devices/pci0000:00/0000:00:11.0/i2c-0/name", 
{st_mode=S_IFREG|0444, st_size@96, ...}) = 0
stat64("/sys/devices/pci0000:00/0000:00:11.0/i2c-0/name", 
{st_mode=S_IFREG|0444, st_size@96, ...}) = 0
open("/sys/devices/pci0000:00/0000:00:11.0/i2c-0/name", O_RDONLY) = 4
read(4, "SMBus Via Pro adapter at 0500\n", 4096) = 30
close(4)                                = 0
lstat64("/sys/class/i2c-adapter/i2c-9191/device", {st_mode=S_IFLNK|0777, 
st_size=0, ...}) = 0
readlink("/sys/class/i2c-adapter/i2c-9191/device", 
"../../../devices/platform/i2c-9191", 256) = 34
lstat64("/sys/devices/platform/i2c-9191", {st_mode=S_IFDIR|0755, 
st_size=0, ...}) = 0
lstat64("/sys/devices/platform/i2c-9191/bus", 0xbfb4945c) = -1 ENOENT 
(No such file or directory)
lstat64("/sys/devices/platform/i2c-9191/driver", 0xbfb4968c) = -1 ENOENT 
(No such file or directory)
lstat64("/sys/devices/platform/i2c-9191/name", {st_mode=S_IFREG|0444, 
st_size@96, ...}) = 0
stat64("/sys/devices/platform/i2c-9191/name", {st_mode=S_IFREG|0444, 
st_size@96, ...}) = 0
open("/sys/devices/platform/i2c-9191/name", O_RDONLY) = 4
read(4, "ISA main adapter\n", 4096)     = 17
close(4)                                = 0
ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, 0xbfb48b38) = -1 ENOTTY 
(Inappropriate ioctl for device)
fstat64(3, {st_mode=S_IFREG|0644, st_sizeR42, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 
0) = 0xb7f9a000
read(3, "chip \"vt1211-*\" \"vt8231-*\"\n#\n# t"..., 8192) = 5242
read(3, "", 4096)                       = 0
read(3, "", 8192)                       = 0
ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, 0xbfb48b38) = -1 ENOTTY 
(Inappropriate ioctl for device)
close(3)                                = 0
munmap(0xb7f9a000, 4096)                = 0
open("/usr/lib/gconv/gconv-modules.cache", O_RDONLY) = -1 ENOENT (No 
such file or directory)
open("/usr/lib/gconv/gconv-modules", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_sizeE568, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 
0) = 0xb7f9a000
read(3, "# GNU libc iconv configuration.\n"..., 4096) = 4096
read(3, "lias\tJS//\t\t\tJUS_I.B1.002//\nalias"..., 4096) = 4096
read(3, "ule\tINTERNAL\t\tISO-8859-3//\t\tISO8"..., 4096) = 4096
read(3, "lias\tISO-IR-199//\t\tISO-8859-14//"..., 4096) = 4096
read(3, "\t\tto\t\t\tmodule\t\tcost\nalias\tCSEBCD"..., 4096) = 4096
read(3, "ule\t\tcost\nalias\tCP284//\t\t\tIBM284"..., 4096) = 4096
read(3, "lias\tCP864//\t\t\tIBM864//\nalias\t86"..., 4096) = 4096
read(3, "module\tIBM937//\t\tINTERNAL\t\tIBM93"..., 4096) = 4096
read(3, "\tEUC-JP//\nalias\tUJIS//\t\t\tEUC-JP/"..., 4096) = 4096
read(3, "module\t\tcost\nalias\tISO-IR-143//\t"..., 4096) = 4096
read(3, "-BOX//\nmodule\tISO_10367-BOX//\t\tI"..., 4096) = 4096
read(3, "module\tINTERNAL\t\tEUC-JISX0213//\t"..., 4096) = 512
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0xb7f9a000, 4096)                = 0
open("/usr/lib/gconv/ISO8859-1.so", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0T\4\0\000"..., 
512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_sizeU76, ...}) = 0
old_mmap(NULL, 4368, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 
0) = 0xb7f99000
old_mmap(0xb7f9a000, 4096, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1000) = 0xb7f9a000
close(3)                                = 0
brk(0x80b0000)                          = 0x80b0000
brk(0x80a8000)                          = 0x80a8000
open("/sys/devices/platform/vt1211.24576/vrm", O_WRONLY|O_CREAT|O_TRUNC, 
0666) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 
0) = 0xb7f98000
write(3, "91", 2)                       = 2
close(3)                                = 0
munmap(0xb7f98000, 4096)                = 0
open("/sys/devices/platform/vt1211.24576/in2_min", 
O_WRONLY|O_CREAT|O_TRUNC, 0666) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 
0) = 0xb7f98000
write(3, "1284", 4)                     = 4
close(3)                                = 0
munmap(0xb7f98000, 4096)                = 0
open("/sys/devices/platform/vt1211.24576/in2_max", 
O_WRONLY|O_CREAT|O_TRUNC, 0666) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 
0) = 0xb7f98000
write(3, "1362", 4)                     = 4
close(3)                                = 0
munmap(0xb7f98000, 4096)                = 0
open("/sys/devices/platform/vt1211.24576/in3_min", 
O_WRONLY|O_CREAT|O_TRUNC, 0666) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 
0) = 0xb7f98000
write(3, "1759", 4)                     = 4
close(3)                                = 0
munmap(0xb7f98000, 4096)                = 0
open("/sys/devices/platform/vt1211.24576/in3_max", 
O_WRONLY|O_CREAT|O_TRUNC, 0666) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 
0) = 0xb7f98000
write(3, "1941", 4)                     = 4
close(3)                                = 0
munmap(0xb7f98000, 4096)                = 0
open("/sys/devices/platform/vt1211.24576/in4_min", 
O_WRONLY|O_CREAT|O_TRUNC, 0666) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 
0) = 0xb7f98000
write(3, "1844", 4)                     = 4
close(3)                                = 0
munmap(0xb7f98000, 4096)                = 0
open("/sys/devices/platform/vt1211.24576/in4_max", 
O_WRONLY|O_CREAT|O_TRUNC, 0666) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 
0) = 0xb7f98000
write(3, "2248", 4)                     = 4
close(3)                                = 0
munmap(0xb7f98000, 4096)                = 0
open("/sys/devices/platform/vt1211.24576/in5_min", 
O_WRONLY|O_CREAT|O_TRUNC, 0666) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 
0) = 0xb7f98000
write(3, "1920", 4)                     = 4
close(3)                                = 0
munmap(0xb7f98000, 4096)                = 0
open("/sys/devices/platform/vt1211.24576/in5_max", 
O_WRONLY|O_CREAT|O_TRUNC, 0666) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 
0) = 0xb7f98000
write(3, "2119", 4)                     = 4
close(3)                                = 0
munmap(0xb7f98000, 4096)                = 0
open("/sys/devices/platform/vt1211.24576/temp2_max_hyst", 
O_WRONLY|O_CREAT|O_TRUNC, 0666) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 
0) = 0xb7f98000
write(3, "91259", 5)                    = 5
close(3)                                = 0
munmap(0xb7f98000, 4096)                = 0
open("/sys/devices/platform/vt1211.24576/temp2_max", 
O_WRONLY|O_CREAT|O_TRUNC, 0666) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 
0) = 0xb7f98000
write(3, "99443", 5)                    = 5
close(3)                                = 0
munmap(0xb7f98000, 4096)                = 0
open("/sys/devices/platform/vt1211.24576/temp3_max_hyst", 
O_WRONLY|O_CREAT|O_TRUNC, 0666) = -1 EACCES (Permission denied)
open("/sys/devices/platform/vt1211.24576/_", O_WRONLY|O_CREAT|O_TRUNC, 
0666) = -1 EACCES (Permission denied)
open("/sys/devices/platform/vt1211.24576/temp3_max", 
O_WRONLY|O_CREAT|O_TRUNC, 0666) = -1 EACCES (Permission denied)
open("/sys/devices/platform/vt1211.24576/_", O_WRONLY|O_CREAT|O_TRUNC, 
0666) = -1 EACCES (Permission denied)
open("/sys/devices/platform/vt1211.24576/temp4_max_hyst", 
O_WRONLY|O_CREAT|O_TRUNC, 0666) = -1 EACCES (Permission denied)
open("/sys/devices/platform/vt1211.24576/_", O_WRONLY|O_CREAT|O_TRUNC, 
0666) = -1 EACCES (Permission denied)
open("/sys/devices/platform/vt1211.24576/temp4_max", 
O_WRONLY|O_CREAT|O_TRUNC, 0666) = -1 EACCES (Permission denied)
open("/sys/devices/platform/vt1211.24576/_", O_WRONLY|O_CREAT|O_TRUNC, 
0666) = -1 EACCES (Permission denied)
open("/sys/devices/platform/vt1211.24576/fan1_min", 
O_WRONLY|O_CREAT|O_TRUNC, 0666) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 
0) = 0xb7f98000
write(3, "0", 1)                        = 1
close(3)                                = 0
munmap(0xb7f98000, 4096)                = 0
open("/sys/devices/platform/vt1211.24576/fan2_min", 
O_WRONLY|O_CREAT|O_TRUNC, 0666) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 
0) = 0xb7f98000
write(3, "0", 1)                        = 1
close(3)                                = 0
munmap(0xb7f98000, 4096)                = 0
write(2, "vt1211-isa-6000: Can\'t access pr"..., 61vt1211-isa-6000: 
Can't access procfs/sysfs file for writing;
) = 61
write(2, "Run as root?\n", 13Run as root?
)          = 13
exit_group(1)                           = ?

------------------------------------------
lspci:
------------------------------------------
0000:00:00.0 Host bridge: VIA Technologies, Inc. VT8623 [Apollo CLE266]
0000:00:01.0 PCI bridge: VIA Technologies, Inc. VT8633 [Apollo Pro266 AGP]
0000:00:0d.0 FireWire (IEEE 1394): VIA Technologies, Inc. IEEE 1394 Host 
Controller (rev 80)
0000:00:10.0 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 
1.1 Controller (rev 80)
0000:00:10.1 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 
1.1 Controller (rev 80)
0000:00:10.2 USB Controller: VIA Technologies, Inc. VT82xxxxx UHCI USB 
1.1 Controller (rev 80)
0000:00:10.3 USB Controller: VIA Technologies, Inc. USB 2.0 (rev 82)
0000:00:11.0 ISA bridge: VIA Technologies, Inc. VT8235 ISA Bridge
0000:00:11.1 IDE interface: VIA Technologies, Inc. 
VT82C586A/B/VT82C686/A/B/VT823x/A/C PIPC Bus Master IDE (rev 06)
0000:00:11.5 Multimedia audio controller: VIA Technologies, Inc. 
VT8233/A/8235/8237 AC97 Audio Controller (rev 50)
0000:00:12.0 Ethernet controller: VIA Technologies, Inc. VT6102 
[Rhine-II] (rev 74)
0000:01:00.0 VGA compatible controller: VIA Technologies, Inc. VT8623 
[Apollo CLE266] integrated CastleRock graphics (rev 03)
------------------------------------------
dmesg:
------------------------------------------
Linux version 2.6.18-rc5-11 (root at mediabox) (gcc version 4.0.3 (Ubuntu 
4.0.3-1ubuntu5)) #9 Sat Sep 9 23:52:30 CEST 2006
BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 00000000000a0000 (usable)
 BIOS-e820: 00000000000f0000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000001dff0000 (usable)
 BIOS-e820: 000000001dff0000 - 000000001dff3000 (ACPI NVS)
 BIOS-e820: 000000001dff3000 - 000000001e000000 (ACPI data)
 BIOS-e820: 00000000ffff0000 - 0000000100000000 (reserved)
0MB HIGHMEM available.
479MB LOWMEM available.
On node 0 totalpages: 122864
  DMA zone: 4096 pages, LIFO batch:0
  Normal zone: 118768 pages, LIFO batch:31
DMI 2.2 present.
ACPI: RSDP (v000 VT9174                                ) @ 0x000f6620
ACPI: RSDT (v001 VT9174 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1dff3000
ACPI: FADT (v001 VT9174 AWRDACPI 0x42302e31 AWRD 0x00000000) @ 0x1dff3040
ACPI: DSDT (v001 VT9174 AWRDACPI 0x00001000 MSFT 0x0100000c) @ 0x00000000
ACPI: PM-Timer IO Port: 0x408
Allocating PCI resources starting at 20000000 (gap: 1e000000:e1ff0000)
Detected 999.873 MHz processor.
Built 1 zonelists.  Total pages: 122864
Kernel command line: root=/dev/hda2 vga=0x317:off resume2=swap:/dev/hda1
No local APIC present or hardware disabled
mapped APIC to ffffd000 (013c2000)
Enabling fast FPU save and restore... done.
Enabling unmasked SIMD FPU exception support... done.
Initializing CPU#0
PID hash table entries: 2048 (order: 11, 8192 bytes)
Console: colour VGA+ 80x25
Dentry cache hash table entries: 65536 (order: 6, 262144 bytes)
Inode-cache hash table entries: 32768 (order: 5, 131072 bytes)
Memory: 478468k/491456k available (4142k kernel code, 12444k reserved, 
1958k data, 340k init, 0k highmem)
Checking if this processor honours the WP bit even in supervisor mode... Ok.
Calibrating delay using timer specific routine.. 2000.60 BogoMIPS 
(lpj00303)
Mount-cache hash table entries: 512
CPU: After generic identify, caps: 0381b83f 00000000 00000000 00000000 
00000000 00000000 00000000
CPU: L1 I Cache: 64K (32 bytes/line), D cache 64K (32 bytes/line)
CPU: L2 Cache: 64K (32 bytes/line)
CPU: After all inits, caps: 0381b93f 00000000 00000000 00000000 00000000 
000000dd 00000000
Compat vDSO mapped to ffffe000.
CPU: Centaur VIA Nehemiah stepping 08
Checking 'hlt' instruction... OK.
ACPI: Core revision 20060707
ACPI: setting ELCR to 0200 (from 1e20)
NET: Registered protocol family 16
EISA bus registered
ACPI: bus type pci registered
PCI: PCI BIOS revision 2.10 entry at 0xfb260, last bus=1
PCI: Using configuration type 1
Setting up standard PCI resources
ACPI: Interpreter enabled
ACPI: Using PIC for interrupt routing
ACPI: PCI Root Bridge [PCI0] (0000:00)
PCI: Probing PCI hardware (bus 00)
PCI quirk: region 0400-047f claimed by vt8235 PM
PCI quirk: region 0500-050f claimed by vt8235 SMB
Boot video device is 0000:01:00.0
ACPI: PCI Interrupt Routing Table [\_SB_.PCI0._PRT]
ACPI: PCI Interrupt Link [LNKA] (IRQs 1 3 4 5 6 7 10 *11 12 14 15)
ACPI: PCI Interrupt Link [LNKB] (IRQs 1 3 4 5 6 7 10 11 *12 14 15)
ACPI: PCI Interrupt Link [LNKC] (IRQs 1 3 4 5 6 7 *10 11 12 14 15)
ACPI: PCI Interrupt Link [LNKD] (IRQs 1 3 4 *5 6 7 10 11 12 14 15)
Linux Plug and Play Support v0.97 (c) Adam Belay
pnp: PnP ACPI init
pnp: PnP ACPI: found 13 devices
VIA RNG detected
SCSI subsystem initialized
usbcore: registered new driver usbfs
usbcore: registered new driver hub
PCI: Using ACPI for IRQ routing
PCI: If a device doesn't work, try "pci=routeirq".  If it helps, post a 
report
NET: Registered protocol family 23
pnp: 00:02: ioport range 0x400-0x47f could not be reserved
pnp: 00:02: ioport range 0x500-0x50f has been reserved
PCI: Bridge: 0000:00:01.0
  IO window: disabled.
  MEM window: dc000000-ddffffff
  PREFETCH window: d8000000-dbffffff
PCI: Setting latency timer of device 0000:00:01.0 to 64
NET: Registered protocol family 2
IP route cache hash table entries: 4096 (order: 2, 16384 bytes)
TCP established hash table entries: 16384 (order: 4, 65536 bytes)
TCP bind hash table entries: 8192 (order: 3, 32768 bytes)
TCP: Hash tables configured (established 16384 bind 8192)
TCP reno registered
IA-32 Microcode Update Driver: v1.14a <tigran at veritas.com>
Total HugeTLB memory allocated, 0
VFS: Disk quotas dquot_6.5.1
Dquot-cache hash table entries: 1024 (order 0, 4096 bytes)
Installing knfsd (copyright (C) 1996 okir at monad.swb.de).
NTFS driver 2.1.27 [Flags: R/W].
fuse init (API version 7.7)
Initializing Cryptographic API
io scheduler noop registered
io scheduler anticipatory registered (default)
io scheduler deadline registered
io scheduler cfq registered
vga16fb: initializing
vga16fb: mapped to 0xc00a0000
fb0: VGA16 VGA frame buffer device
Real Time Clock Driver v1.12ac
Linux agpgart interface v0.101 (c) Dave Jones
agpgart: Detected VIA CLE266 chipset
agpgart: AGP aperture is 128M @ 0xd0000000
[drm] Initialized drm 1.0.1 20051102
ACPI: PCI Interrupt Link [LNKA] enabled at IRQ 11
PCI: setting IRQ 11 as level-triggered
ACPI: PCI Interrupt 0000:01:00.0[A] -> Link [LNKA] -> GSI 11 (level, 
low) -> IRQ 11
[drm] Initialized via 2.7.4 20051116 on minor 0
Hangcheck: starting hangcheck timer 0.9.0 (tick is 180 seconds, margin 
is 60 seconds).
Hangcheck: Using get_cycles().
intelfb: Framebuffer driver for Intel(R) 
830M/845G/852GM/855GM/865G/915G/915GM/945G/945GM chipsets
intelfb: Version 0.9.4
Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
serial8250: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
serial8250: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
00:09: ttyS0 at I/O 0x3f8 (irq = 4) is a 16550A
00:0a: ttyS1 at I/O 0x2f8 (irq = 3) is a 16550A
Floppy drive(s): fd0 is 1.44M
FDC 0 is a post-1991 82077
RAMDISK driver initialized: 16 RAM disks of 4096K size 1024 blocksize
loop: loaded (max 8 devices)
nbd: registered device at major 43
Intel(R) PRO/1000 Network Driver - version 7.1.9-k4
Copyright (c) 1999-2006 Intel Corporation.
e100: Intel(R) PRO/100 Network Driver, 3.5.10-k2-NAPI
e100: Copyright(c) 1999-2005 Intel Corporation
via-rhine.c:v1.10-LK1.4.1 July-24-2006 Written by Donald Becker
ACPI: PCI Interrupt 0000:00:12.0[A] -> Link [LNKA] -> GSI 11 (level, 
low) -> IRQ 11
eth0: VIA Rhine II at 0xde002000, 00:40:63:e4:3a:ca, IRQ 11.
eth0: MII PHY found at address 1, status 0x786d advertising 05e1 Link 45e1.
forcedeth.c: Reverse Engineered nForce ethernet driver. Version 0.56.
ipddp.c:v0.01 8/28/97 Bradford W. Johnson <johns393 at maroon.tc.umn.edu>
ipddp0: Appletalk-IP Encap. mode by Bradford W. Johnson 
<johns393 at maroon.tc.umn.edu>
usbcore: registered new driver irda-usb
USB IrDA support registered
netconsole: not configured, aborting
Linux video capture interface: v2.00
V4L-Driver for Vision CPiA based cameras v1.2.3
Since in-kernel colorspace conversion is not allowed, it is disabled by 
default now. Users should fix the applications in case they don't work 
without conversion reenabled by setting the 'colorspace_conv' module 
parameter to 1
USB driver for Vision CPiA based cameras v1.2.3
usbcore: registered new driver cpia
cpia2: V4L-Driver for Vision CPiA2 based cameras v2.0.0
usbcore: registered new driver cpia2
saa7146: register extension 'Multimedia eXtension Board'.
saa7146: register extension 'hexium HV-PCI6 Orion'.
saa7146: register extension 'hexium gemini'.
saa7146: register extension 'dpc7146 demonstration board'.
usbcore: registered new driver dsbr100
drivers/media/radio/dsbr100.c: v0.40:D-Link DSB-R100 USB FM radio driver
Uniform Multi-Platform E-IDE driver Revision: 7.00alpha2
ide: Assuming 33MHz system bus speed for PIO modes; override with idebus=xx
VP_IDE: IDE controller at PCI slot 0000:00:11.1
ACPI: PCI Interrupt 0000:00:11.1[A] -> Link [LNKA] -> GSI 11 (level, 
low) -> IRQ 11
PCI: VIA IRQ fixup for 0000:00:11.1, from 255 to 11
VP_IDE: chipset revision 6
VP_IDE: not 100% native mode: will probe irqs later
VP_IDE: VIA vt8235 (rev 00) IDE UDMA133 controller on pci0000:00:11.1
    ide0: BM-DMA at 0xe000-0xe007, BIOS settings: hda:DMA, hdb:pio
    ide1: BM-DMA at 0xe008-0xe00f, BIOS settings: hdc:pio, hdd:pio
Probing IDE interface ide0...
hda: HTS541080G9AT00, ATA DISK drive
ide0 at 0x1f0-0x1f7,0x3f6 on irq 14
Probing IDE interface ide1...
Probing IDE interface ide1...
hda: max request size: 512KiB
hda: 156301488 sectors (80026 MB) w/7539KiB Cache, CHS383/255/63, 
UDMA(33)
hda: cache flushes supported
 hda: hda1 hda2 hda3
3ware Storage Controller device driver for Linux v1.26.02.001.
libata version 2.00 loaded.
ACPI: PCI Interrupt Link [LNKB] enabled at IRQ 12
PCI: setting IRQ 12 as level-triggered
ACPI: PCI Interrupt 0000:00:0d.0[A] -> Link [LNKB] -> GSI 12 (level, 
low) -> IRQ 12
ohci1394: fw-host0: OHCI-1394 1.1 (PCI): IRQ=[12]  
MMIO=[de000000-de0007ff]  Max Packet=[2048]  IR/IT contexts=[4/8]
ieee1394: raw1394: /dev/raw1394 device initialized
block2mtd: version $Revision: 1.30 $
ACPI: PCI Interrupt Link [LNKD] enabled at IRQ 5
PCI: setting IRQ 5 as level-triggered
ACPI: PCI Interrupt 0000:00:10.3[D] -> Link [LNKD] -> GSI 5 (level, low) 
-> IRQ 5
ehci_hcd 0000:00:10.3: EHCI Host Controller
ehci_hcd 0000:00:10.3: new USB bus registered, assigned bus number 1
ehci_hcd 0000:00:10.3: irq 5, io mem 0xde001000
ehci_hcd 0000:00:10.3: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004
usb usb1: configuration #1 chosen from 1 choice
hub 1-0:1.0: USB hub found
hub 1-0:1.0: 6 ports detected
ohci_hcd: 2005 April 22 USB 1.1 'Open' Host Controller (OHCI) Driver (PCI)
USB Universal Host Controller Interface driver v3.0
ACPI: PCI Interrupt 0000:00:10.0[A] -> Link [LNKA] -> GSI 11 (level, 
low) -> IRQ 11
uhci_hcd 0000:00:10.0: UHCI Host Controller
uhci_hcd 0000:00:10.0: new USB bus registered, assigned bus number 2
uhci_hcd 0000:00:10.0: irq 11, io base 0x0000d400
usb usb2: configuration #1 chosen from 1 choice
hub 2-0:1.0: USB hub found
hub 2-0:1.0: 2 ports detected
ACPI: PCI Interrupt 0000:00:10.1[B] -> Link [LNKB] -> GSI 12 (level, 
low) -> IRQ 12
uhci_hcd 0000:00:10.1: UHCI Host Controller
uhci_hcd 0000:00:10.1: new USB bus registered, assigned bus number 3
uhci_hcd 0000:00:10.1: irq 12, io base 0x0000d800
usb usb3: configuration #1 chosen from 1 choice
hub 3-0:1.0: USB hub found
hub 3-0:1.0: 2 ports detected
ACPI: PCI Interrupt Link [LNKC] enabled at IRQ 10
PCI: setting IRQ 10 as level-triggered
ACPI: PCI Interrupt 0000:00:10.2[C] -> Link [LNKC] -> GSI 10 (level, 
low) -> IRQ 10
uhci_hcd 0000:00:10.2: UHCI Host Controller
uhci_hcd 0000:00:10.2: new USB bus registered, assigned bus number 4
uhci_hcd 0000:00:10.2: irq 10, io base 0x0000dc00
usb usb4: configuration #1 chosen from 1 choice
hub 4-0:1.0: USB hub found
hub 4-0:1.0: 2 ports detected
usb 3-1: new low speed USB device using uhci_hcd and address 2
usb 3-1: configuration #1 chosen from 1 choice
usb 3-2: new low speed USB device using uhci_hcd and address 3
ieee1394: Host added: ID:BUS[0-00:1023]  GUID[004063500006d583]
usb 3-2: configuration #1 chosen from 1 choice
usbcore: registered new driver usblp
drivers/usb/class/usblp.c: v0.13: USB Printer Device Class driver
Initializing USB Mass Storage driver...
usbcore: registered new driver usb-storage
USB Mass Storage support registered.
usbcore: registered new driver ati_remote2
ati_remote2: ATI/Philips USB RF remote driver 0.1
input: HID 1241:1177 as /class/input/input0
input: USB HID v1.00 Mouse [HID 1241:1177] on usb-0000:00:10.1-1
input: DELL DELL USB Keyboard as /class/input/input1
input: USB HID v1.10 Keyboard [DELL DELL USB Keyboard] on usb-0000:00:10.1-2
usbcore: registered new driver usbhid
drivers/usb/input/hid-core.c: v2.6:USB HID core driver
PNP: PS/2 Controller [PNP0303:PS2K] at 0x60,0x64 irq 1
PNP: PS/2 controller doesn't have AUX irq; using default 12
serio: i8042 AUX port at 0x60,0x64 irq 12
serio: i8042 KBD port at 0x60,0x64 irq 1
mice: PS/2 mouse device common for all mice
I2O subsystem v1.325
i2o: max drivers = 8
I2O Configuration OSM v1.323
I2O Bus Adapter OSM v1.317
I2O Block Device OSM v1.325
I2O SCSI Peripheral OSM v1.316
I2O ProcFS OSM v1.316
EISA: Probing bus 0 at eisa.0
EISA: Detected 0 cards.
ad1816: AD1816 sounddriver Copyright (C) 1998-2003 by Thorsten Knabe and 
others
Via 686a/8233/8235 audio driver 1.9.1-ac4-2.5
ACPI: PCI Interrupt 0000:00:11.5[C] -> Link [LNKC] -> GSI 10 (level, 
low) -> IRQ 10
via82cxxx: Six channel audio available
PCI: Setting latency timer of device 0000:00:11.5 to 64
ac97_codec: AC97 Audio codec, id: ICE82 (Unknown)
via82cxxx: board #1 at 0xE400, IRQ 10
Advanced Linux Sound Architecture Driver Version 1.0.12rc1 (Thu Jun 22 
13:55:50 2006 UTC).
can't register device seq
input: AT Translated Set 2 keyboard as /class/input/input2
no UART detected at 0x1
unable to register OSS mixer device 0:0
Motu MidiTimePiece on parallel port irq: 7 ioport: 0x378
ALSA device list:
  #0: MTPAV on parallel port at 0x378
IPv4 over IPv4 tunneling driver
TCP bic registered
NET: Registered protocol family 1
NET: Registered protocol family 10
IPv6 over IPv4 tunneling driver
NET: Registered protocol family 17
NET: Registered protocol family 5
IrCOMM protocol (Dag Brattli)
Using IPI Shortcut mode
Suspend2 Core.
Suspend2 Compression Driver loading.
Suspend2 Encryption Driver loading.
Suspend2 Swap Writer loading.
Suspend2 FileWriter loading.
Time: tsc clocksource has been installed.
Suspend2 2.2.7.5: Swapwriter: Signature found.
Suspend2 2.2.7.5: Resuming enabled.
Suspend2 2.2.7.5: Normal swapspace found.
Suspend2 2.2.7.5: No image found.
Suspend2 2.2.7.5: Read image returned -61.
ACPI: (supports S0 S1 S3 S4 S5)
drivers/rtc/hctosys.c: unable to open rtc device (rtc0)
EXT3-fs: INFO: recovery required on readonly filesystem.
EXT3-fs: write access will be enabled during recovery.
kjournald starting.  Commit interval 5 seconds
EXT3-fs: recovery complete.
EXT3-fs: mounted filesystem with ordered data mode.
VFS: Mounted root (ext3 filesystem) readonly.
Freeing unused kernel memory: 340k freed
vt1211: Found VT1211 chip at 0x6000, revision 2
Adding 2931820k swap on /dev/hda1.  Priority:-1 extents:1 across:2931820k
EXT3 FS on hda2, internal journal
eth0: link up, 100Mbps, full-duplex, lpa 0x45E1
kjournald starting.  Commit interval 5 seconds
EXT3 FS on hda3, internal journal
EXT3-fs: mounted filesystem with ordered data mode.
ACPI: Power Button (FF) [PWRF]
ACPI: Power Button (CM) [PWRB]
Using specific hotkey driver
ibm_acpi: ec object not found
ACPI: CPU0 (power states: C1[C1] C2[C2])
ACPI: Processor [CPU0] (supports 2 throttling states)
Time: acpi_pm clocksource has been installed.
toshiba_acpi: Unknown parameter `hotkeys_over_acpi'
mtrr: 0xd8000000,0x2000000 overlaps existing 0xd8000000,0x800000
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 4x mode
agpgart: Putting AGP V2 device at 0000:01:00.0 into 4x mode
eth0: no IPv6 routers present
i2c /dev entries driver

------------------------------------------

-- 
Programmers.ch
Solutions libres et Opensources
Tel: ++41 76 44 888 72
Site: http://www.programmers.ch
Site: http://openprojects.ch



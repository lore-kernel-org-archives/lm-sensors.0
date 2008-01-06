From: Antonio RAGO <antonio.rago@gmail.com>
Date: Sun, 06 Jan 2008 20:29:36 +0000
Subject: Re: [lm-sensors] Needed support for SMSC LPC47M292
Message-Id: <47813A30.9060406@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <477E2B2A.5010707@gmail.com>
In-Reply-To: <477E2B2A.5010707@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Antonio,
>
> On Fri, 04 Jan 2008 12:48:42 +0000, Antonio RAGO wrote:
>   
>> Hi all
>> I'm writing you about an LPC47M292 chip.
>> I have and ibm thinkcenter with kernel 2.6.22-3-686 (debian)
>> and I'm trying to recognize the sensors.
>> sensors-detect claim that there is the chip 
>>     `SMSC LPC47M292 Super IO Fan Sensors'
>> and I've loaded the corresponding module
>> but even if the module is loaded and according to the messages log it's 
>> the right one
>> when I try to run sensors, the program claims that no chipset has been 
>> found.
>> (In the following i'm reporting also i2c stuff even if it seems to me 
>> that they are useless)
>>
>> raven:~# sensors
>> No sensors found!
>> Make sure you loaded all the kernel drivers you need.
>> Try sensors-detect to find out which these are.
>> raven:~# ls -l /dev/i2c*
>> crw-rw---- 1 root root 89, 0 2008-01-04 10:58 /dev/i2c-0
>> raven:~# lsmod | head -6
>> Module                  Size  Used by
>> smsc47m1                9508  0
>> i2c_isa                 4192  0
>> i2c_dev                 7140  0
>> i2c_i801                8656  0
>> i2c_core               23552  3 i2c_isa,i2c_dev,i2c_i801
>> raven:~# dmesg  | tail -1
>> smsc47m1: Found SMSC LPC47M292
>> (...)
>> raven:~# dpkg -l lm-sensors
>> (...)
>> ii  lm-sensors                    1:3.0.0-4                     
>> utilities to read temperature/voltage/fan sensors
>>
>> Maybe I'm missing something, but it seems to me that it's not working.
>> I can easily do any test on this computer if it's needed.
>>     
>
> This is indeed strange. Please provide the output of:
> strace sensors
> ls -l /sys/class/hwmon
> ls -R /sys/class/hwmon/*
>
>   
Hi Jean,
here is what you asked for.
Thank you for the reply.
Antonio

raven:~# strace sensors
execve("/usr/bin/sensors", ["sensors"], [/* 16 vars */]) = 0
brk(0)                                  = 0x804c000
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or
directory)
mmap2(NULL, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xb7ef8000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or
directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size4334, ...}) = 0
mmap2(NULL, 34334, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7eef000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or
directory)
open("/usr/lib/libsensors.so.4", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\240&\0"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_sizeG496, ...}) = 0
mmap2(NULL, 46860, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0)
= 0xb7ee3000
mmap2(0xb7eee000, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xb) = 0xb7eee000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or
directory)
open("/lib/i686/cmov/libc.so.6", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\260e\1"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size56196, ...}) = 0
mmap2(NULL, 1361520, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) = 0xb7d96000
mmap2(0xb7edd000, 12288, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x147) = 0xb7edd000
mmap2(0xb7ee0000, 9840, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xb7ee0000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or
directory)
open("/lib/i686/cmov/libm.so.6", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0@4\0\000"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size9328, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xb7d95000
mmap2(NULL, 147584, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3,
0) = 0xb7d70000
mmap2(0xb7d93000, 8192, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x23) = 0xb7d93000
close(3)                                = 0
access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or
directory)
open("/lib/libsysfs.so.2", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0p \0\000"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_size7788, ...}) = 0
mmap2(NULL, 40756, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0)
= 0xb7d66000
mmap2(0xb7d6f000, 4096, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x8) = 0xb7d6f000
close(3)                                = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xb7d65000
set_thread_area({entry_number:-1 -> 6, base_addr:0xb7d656b0,
limit:1048575, seg_32bit:1, contents:0, read_exec_only:0,
limit_in_pages:1, seg_not_present:0, useable:1}) = 0
mprotect(0xb7edd000, 4096, PROT_READ)   = 0
munmap(0xb7eef000, 34334)               = 0
brk(0)                                  = 0x804c000
brk(0x806d000)                          = 0x806d000
open("/usr/lib/locale/locale-archive", O_RDONLY|O_LARGEFILE) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size97600, ...}) = 0
mmap2(NULL, 1797600, PROT_READ, MAP_PRIVATE, 3, 0) = 0xb7bae000
close(3)                                = 0
open("/proc/mounts", O_RDONLY)          = 3
fstat64(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xb7ef7000
read(3, "rootfs / rootfs rw 0 0\nnone /sys"..., 1024) = 503
close(3)                                = 0
munmap(0xb7ef7000, 4096)                = 0
stat64("/sys", {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
open("/proc/mounts", O_RDONLY)          = 3
fstat64(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xb7ef7000
read(3, "rootfs / rootfs rw 0 0\nnone /sys"..., 1024) = 503
close(3)                                = 0
munmap(0xb7ef7000, 4096)                = 0
lstat64("/sys/class/i2c-adapter", {st_mode=S_IFDIR|0755, st_size=0,
...}) = 0
open("/sys/class/i2c-adapter",
O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY|0x80000) = 3
fstat64(3, {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
fcntl64(3, F_GETFD)                     = 0
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
getdents(3, /* 3 entries */, 4096)      = 52
lstat64("/sys/class/i2c-adapter/i2c-0", {st_mode=S_IFDIR|0755,
st_size=0, ...}) = 0
getdents(3, /* 0 entries */, 4096)      = 0
close(3)                                = 0
lstat64("/sys/class/i2c-adapter/i2c-0", {st_mode=S_IFDIR|0755,
st_size=0, ...}) = 0
open("/sys/class/i2c-adapter",
O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY|0x80000) = 3
fstat64(3, {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
getdents(3, /* 3 entries */, 4096)      = 52
lstat64("/sys/class/i2c-adapter/i2c-0", {st_mode=S_IFDIR|0755,
st_size=0, ...}) = 0
getdents(3, /* 0 entries */, 4096)      = 0
close(3)                                = 0
lstat64("/sys/class/i2c-adapter/i2c-0/name", {st_mode=S_IFREG|0444,
st_size@96, ...}) = 0
stat64("/sys/class/i2c-adapter/i2c-0/name", {st_mode=S_IFREG|0444,
st_size@96, ...}) = 0
open("/sys/class/i2c-adapter/i2c-0/name", O_RDONLY) = 3
read(3, "SMBus I801 adapter at 18a0\n", 4096) = 27
close(3)                                = 0
open("/proc/mounts", O_RDONLY)          = 3
fstat64(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xb7ef7000
read(3, "rootfs / rootfs rw 0 0\nnone /sys"..., 1024) = 503
close(3)                                = 0
munmap(0xb7ef7000, 4096)                = 0
lstat64("/sys/class/hwmon", {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
open("/sys/class/hwmon",
O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY|0x80000) = 3
fstat64(3, {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
getdents(3, /* 3 entries */, 4096)      = 52
lstat64("/sys/class/hwmon/hwmon0", {st_mode=S_IFDIR|0755, st_size=0,
...}) = 0
getdents(3, /* 0 entries */, 4096)      = 0
close(3)                                = 0
lstat64("/sys/class/hwmon/hwmon0", {st_mode=S_IFDIR|0755, st_size=0,
...}) = 0
open("/sys/class/hwmon",
O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY|0x80000) = 3
fstat64(3, {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
getdents(3, /* 3 entries */, 4096)      = 52
lstat64("/sys/class/hwmon/hwmon0", {st_mode=S_IFDIR|0755, st_size=0,
...}) = 0
getdents(3, /* 0 entries */, 4096)      = 0
close(3)                                = 0
lstat64("/sys/class/hwmon/hwmon0/device", {st_mode=S_IFLNK|0777,
st_size=0, ...}) = 0
readlink("/sys/class/hwmon/hwmon0/device",
"../../../devices/platform/smsc47m1.2048", 256) = 39
lstat64("/sys/devices/platform/smsc47m1.2048", {st_mode=S_IFDIR|0755,
st_size=0, ...}) = 0
lstat64("/sys/devices/platform/smsc47m1.2048/bus",
{st_mode=S_IFLNK|0777, st_size=0, ...}) = 0
readlink("/sys/devices/platform/smsc47m1.2048/bus",
"../../../bus/platform", 256) = 21
lstat64("/sys/devices/platform/smsc47m1.2048/driver",
{st_mode=S_IFLNK|0777, st_size=0, ...}) = 0
readlink("/sys/devices/platform/smsc47m1.2048/driver",
"../../../bus/platform/drivers/smsc47m1", 256) = 38
lstat64("/sys/devices/platform/smsc47m1.2048/subsystem",
{st_mode=S_IFLNK|0777, st_size=0, ...}) = 0
readlink("/sys/devices/platform/smsc47m1.2048/subsystem",
"../../../bus/platform", 256) = 21
lstat64("/sys/devices/platform/smsc47m1.2048/name",
{st_mode=S_IFREG|0444, st_size@96, ...}) = 0
stat64("/sys/devices/platform/smsc47m1.2048/name",
{st_mode=S_IFREG|0444, st_size@96, ...}) = 0
open("/sys/devices/platform/smsc47m1.2048/name", O_RDONLY) = 3
read(3, "smsc47m2\n", 4096)             = 9
close(3)                                = 0
open("/sys/devices/platform/smsc47m1.2048",
O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY|0x80000) = 3
fstat64(3, {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
getdents(3, /* 15 entries */, 4096)     = 292
lstat64("/sys/devices/platform/smsc47m1.2048/hwmon:hwmon0",
{st_mode=S_IFLNK|0777, st_size=0, ...}) = 0
lstat64("/sys/devices/platform/smsc47m1.2048/name",
{st_mode=S_IFREG|0444, st_size@96, ...}) = 0
lstat64("/sys/devices/platform/smsc47m1.2048/alarms",
{st_mode=S_IFREG|0444, st_size@96, ...}) = 0
stat64("/sys/devices/platform/smsc47m1.2048/alarms",
{st_mode=S_IFREG|0444, st_size@96, ...}) = 0
open("/sys/devices/platform/smsc47m1.2048/alarms", O_RDONLY) = 4
read(4, "1\n", 4096)                    = 2
close(4)                                = 0
lstat64("/sys/devices/platform/smsc47m1.2048/pwm2_enable",
{st_mode=S_IFREG|0644, st_size@96, ...}) = 0
stat64("/sys/devices/platform/smsc47m1.2048/pwm2_enable",
{st_mode=S_IFREG|0644, st_size@96, ...}) = 0
open("/sys/devices/platform/smsc47m1.2048/pwm2_enable", O_RDONLY) = 4
read(4, "1\n", 4096)                    = 2
close(4)                                = 0
lstat64("/sys/devices/platform/smsc47m1.2048/pwm2",
{st_mode=S_IFREG|0644, st_size@96, ...}) = 0
stat64("/sys/devices/platform/smsc47m1.2048/pwm2",
{st_mode=S_IFREG|0644, st_size@96, ...}) = 0
open("/sys/devices/platform/smsc47m1.2048/pwm2", O_RDONLY) = 4
read(4, "32\n", 4096)                   = 3
close(4)                                = 0
lstat64("/sys/devices/platform/smsc47m1.2048/pwm1_enable",
{st_mode=S_IFREG|0644, st_size@96, ...}) = 0
stat64("/sys/devices/platform/smsc47m1.2048/pwm1_enable",
{st_mode=S_IFREG|0644, st_size@96, ...}) = 0
open("/sys/devices/platform/smsc47m1.2048/pwm1_enable", O_RDONLY) = 4
read(4, "1\n", 4096)                    = 2
close(4)                                = 0
lstat64("/sys/devices/platform/smsc47m1.2048/pwm1",
{st_mode=S_IFREG|0644, st_size@96, ...}) = 0
stat64("/sys/devices/platform/smsc47m1.2048/pwm1",
{st_mode=S_IFREG|0644, st_size@96, ...}) = 0
open("/sys/devices/platform/smsc47m1.2048/pwm1", O_RDONLY) = 4
read(4, "32\n", 4096)                   = 3
close(4)                                = 0
lstat64("/sys/devices/platform/smsc47m1.2048/driver",
{st_mode=S_IFLNK|0777, st_size=0, ...}) = 0
lstat64("/sys/devices/platform/smsc47m1.2048/bus",
{st_mode=S_IFLNK|0777, st_size=0, ...}) = 0
lstat64("/sys/devices/platform/smsc47m1.2048/subsystem",
{st_mode=S_IFLNK|0777, st_size=0, ...}) = 0
lstat64("/sys/devices/platform/smsc47m1.2048/modalias",
{st_mode=S_IFREG|0444, st_size@96, ...}) = 0
stat64("/sys/devices/platform/smsc47m1.2048/modalias",
{st_mode=S_IFREG|0444, st_size@96, ...}) = 0
open("/sys/devices/platform/smsc47m1.2048/modalias", O_RDONLY) = 4
read(4, "smsc47m1\n", 4096)             = 9
close(4)                                = 0
lstat64("/sys/devices/platform/smsc47m1.2048/power",
{st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
lstat64("/sys/devices/platform/smsc47m1.2048/uevent",
{st_mode=S_IFREG|0644, st_size@96, ...}) = 0
stat64("/sys/devices/platform/smsc47m1.2048/uevent",
{st_mode=S_IFREG|0644, st_size@96, ...}) = 0
open("/sys/devices/platform/smsc47m1.2048/uevent", O_RDONLY) = 4
read(4, "", 4096)                       = 0
close(4)                                = 0
getdents(3, /* 0 entries */, 4096)      = 0
close(3)                                = 0
open("/etc/sensors3.conf", O_RDONLY)    = 3
ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, 0xbfcbefc8) = -1 ENOTTY
(Inappropriate ioctl for device)
fstat64(3, {st_mode=S_IFREG|0644, st_sizeq800, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) = 0xb7ef7000
read(3, "# Sensors configuration file use"..., 8192) = 8192
read(3, "tatements can go in any order, E"..., 8192) = 8192
read(3, "05\n#    set in2_min 3.3 * 0.95\n#"..., 8192) = 8192
read(3, "in2 \"Vtt\"\n    label in5 \"+3.3V\"\n"..., 8192) = 8192
read(3, "at temp3 is an internal temp sen"..., 8192) = 8192
read(3, "\n# 2 = thermistor; 3 = thermal d"..., 8192) = 8192
read(3, ", relative value\n# for both chan"..., 8192) = 8192
read(3, "#set temp1_max      45\n    #set "..., 8192) = 8192
read(3, "  @*(1+100/47),  @/(1+100/47)\n  "..., 8192) = 6264
read(3, "", 4096)                       = 0
read(3, "", 8192)                       = 0
ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, 0xbfcbdfa8) = -1 ENOTTY
(Inappropriate ioctl for device)
close(3)                                = 0
munmap(0xb7ef7000, 4096)                = 0
open("/usr/lib/gconv/gconv-modules.cache", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size%700, ...}) = 0
mmap2(NULL, 25700, PROT_READ, MAP_SHARED, 3, 0) = 0xb7ef1000
close(3)                                = 0
open("/usr/lib/gconv/ISO8859-1.so", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0p\3\0\000"...,
512) = 512
fstat64(3, {st_mode=S_IFREG|0644, st_sizeS84, ...}) = 0
mmap2(NULL, 8220, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0)
= 0xb7bab000
mmap2(0xb7bac000, 8192, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0) = 0xb7bac000
close(3)                                = 0
write(2, "No sensors found!\nMake sure you "..., 120No sensors found!
Make sure you loaded all the kernel drivers you need.
Try sensors-detect to find out which these are.
) = 120
exit_group(0)                           = ?
Process 13799 detached
raven:~# ls -l /sys/class/hwmon
total 0
drwxr-xr-x 2 root root 0 2008-01-04 13:43 hwmon0
raven:~# ls -R /sys/class/hwmon/*
/sys/class/hwmon/hwmon0:
device    subsystem  uevent


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

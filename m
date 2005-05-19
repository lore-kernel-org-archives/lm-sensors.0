From: goofee79@hotmail.com (tom paris)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: Ticket 1671
Message-Id: <BAY18-F97c0D543Tuyl0000e248@hotmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <BAY18-F35Ejb0zNqBRH0000e079@hotmail.com>
In-Reply-To: <BAY18-F35Ejb0zNqBRH0000e079@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Ok, here goes:

1-002d:
alarms           fan3_div    in2_input  in5_max         temp2_input
detach_state     fan3_input  in2_max    in5_min         temp2_max
fan1_div         fan3_min    in2_min    in6_input       temp2_max_hyst
fan1_input       in0_input   in3_input  in6_max         temp3_input
fan1_min         in0_max     in3_max    in6_min         temp3_max
fan1_pwm         in0_min     in3_min    name            temp3_max_hyst
fan1_pwm_enable  in0_ref     in4_input  power           temp4_input
fan2_div         in1_input   in4_max    temp1_input     temp4_max
fan2_input       in1_max     in4_min    temp1_max       temp4_max_hyst
fan2_min         in1_min     in5_input  temp1_max_hyst  vrm

1-002e:
detach_state  name  power  temp1_input  temp1_max

strace sensors:
execve("/usr/local/bin/sensors", ["sensors"], [/* 70 vars */]) =3D 0
uname({sys=3D"Linux", node=3D"scrooge", ...}) =3D 0
brk(0)                                  =3D 0x8062000
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) =3D 0x40017000
open("/etc/ld.so.preload", O_RDONLY)    =3D -1 ENOENT (No such file or
directory)
open("/usr/local/lib/tls/i686/libsensors.so.3", O_RDONLY) =3D -1 ENOENT (No
such file or directory)
stat64("/usr/local/lib/tls/i686", 0xbfffe7f8) =3D -1 ENOENT (No such file or
directory)
open("/usr/local/lib/tls/libsensors.so.3", O_RDONLY) =3D -1 ENOENT (No such
file or directory)
stat64("/usr/local/lib/tls", 0xbfffe7f8) =3D -1 ENOENT (No such file or
directory)
open("/usr/local/lib/i686/libsensors.so.3", O_RDONLY) =3D -1 ENOENT (No such
file or directory)
stat64("/usr/local/lib/i686", 0xbfffe7f8) =3D -1 ENOENT (No such file or
directory)
open("/usr/local/lib/libsensors.so.3", O_RDONLY) =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0p]\0\000"..., 512)
=3D 512
fstat64(3, {st_mode=3DS_IFREG|0644, st_size=147281, ...}) =3D 0
old_mmap(NULL, 204484, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) 0x40018000
madvise(0x40018000, 204484, MADV_SEQUENTIAL|0x1) =3D 0
old_mmap(0x40027000, 73728, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED,
3, 0xf000) =3D 0x40027000
old_mmap(0x40039000, 69316, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x40039000
close(3)                                =3D 0
open("/usr/local/lib/libc.so.6", O_RDONLY) =3D -1 ENOENT (No such file or
directory)
open("/etc/ld.so.cache", O_RDONLY)      =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_sizer871, ...}) =3D 0
old_mmap(NULL, 72871, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x4004a000
close(3)                                =3D 0
open("/lib/tls/libc.so.6", O_RDONLY)    =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\360U\1"..., 512)
=3D 512
fstat64(3, {st_mode=3DS_IFREG|0755, st_size=1349081, ...}) =3D 0
old_mmap(NULL, 1132940, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) 0x4005c000
madvise(0x4005c000, 1132940, MADV_SEQUENTIAL|0x1) =3D 0
old_mmap(0x40166000, 32768, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED,
3, 0x10a000) =3D 0x40166000
old_mmap(0x4016e000, 10636, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0x4016e000
close(3)                                =3D 0
open("/lib/tls/libm.so.6", O_RDONLY)    =3D 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0p5\0\000"..., 512)
=3D 512
fstat64(3, {st_mode=3DS_IFREG|0755, st_size=170563, ...}) =3D 0
old_mmap(NULL, 137712, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) 0x40171000
madvise(0x40171000, 137712, MADV_SEQUENTIAL|0x1) =3D 0
old_mmap(0x40192000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3,
0x20000) =3D 0x40192000
close(3)                                =3D 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1,
0) =3D 0x40193000
set_thread_area({entry_number:-1 -> 6, base_addr:0x401934e0,
limit:1048575, seg_32bit:1, contents:0, read_exec_only:0,
limit_in_pages:1, seg_not_present:0, useable:1}) =3D 0
munmap(0x4004a000, 72871)               =3D 0
brk(0)                                  =3D 0x8062000
brk(0x8083000)                          =3D 0x8083000
brk(0)                                  =3D 0x8083000
open("/usr/lib/locale/locale-archive", O_RDONLY|O_LARGEFILE) =3D -1 ENOENT
(No such file or directory)
open("/usr/share/locale/locale.alias", O_RDONLY) =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size%28, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
=3D 0x4004a000
read(3, "# Locale name alias data base.\n#"..., 4096) =3D 2528
read(3, "", 4096)                       =3D 0
close(3)                                =3D 0
munmap(0x4004a000, 4096)                =3D 0
open("/usr/lib/locale/en_US.UTF-8/LC_CTYPE", O_RDONLY) =3D -1 ENOENT (No
such file or directory)
open("/usr/lib/locale/en_US.utf8/LC_CTYPE", O_RDONLY) =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size 8464, ...}) =3D 0
mmap2(NULL, 208464, PROT_READ, MAP_PRIVATE, 3, 0) =3D 0x40194000
close(3)                                =3D 0
open("/usr/lib/gconv/gconv-modules.cache", O_RDONLY) =3D 3
fstat64(3, {st_mode=3DS_IFREG|0644, st_size!436, ...}) =3D 0
mmap2(NULL, 21436, PROT_READ, MAP_SHARED, 3, 0) =3D 0x401c7000
close(3)                                =3D 0
open("/etc/sensors.conf", O_RDONLY)     =3D 3
open("/proc/mounts", O_RDONLY)          =3D 4
fstat64(4, {st_mode=3DS_IFREG|0444, st_size=3D0, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
=3D 0x401cd000
read(4, "rootfs / rootfs rw 0 0\n/dev/root"..., 1024) =3D 305
close(4)                                =3D 0
munmap(0x401cd000, 4096)                =3D 0
open("/sys/bus/i2c/devices", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY)
=3D 4
fstat64(4, {st_mode=3DS_IFDIR|0755, st_size=3D0, ...}) =3D 0
fcntl64(4, F_SETFD, FD_CLOEXEC)         =3D 0
getdents(4, /* 6 entries */, 4096)      =3D 112
open("/sys/bus/i2c/devices/1-002e/name", O_RDONLY) =3D 5
fstat64(5, {st_mode=3DS_IFREG|0444, st_size@96, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
=3D 0x401cd000
read(5, "w83l785ts\n", 4096)            =3D 10
close(5)                                =3D 0
munmap(0x401cd000, 4096)                =3D 0
open("/sys/class/i2c-adapter/i2c-1/device/name", O_RDONLY) =3D 5
fstat64(5, {st_mode=3DS_IFREG|0444, st_size@96, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
=3D 0x401cd000
read(5, "SMBus nForce2 adapter at 5500\n", 4096) =3D 30
close(5)                                =3D 0
munmap(0x401cd000, 4096)                =3D 0
open("/sys/bus/i2c/devices/1-0048/name", O_RDONLY) =3D 5
fstat64(5, {st_mode=3DS_IFREG|0444, st_size@96, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
=3D 0x401cd000
read(5, "asb100 subclient\n", 4096)     =3D 17
close(5)                                =3D 0
munmap(0x401cd000, 4096)                =3D 0
open("/sys/bus/i2c/devices/1-0049/name", O_RDONLY) =3D 5
fstat64(5, {st_mode=3DS_IFREG|0444, st_size@96, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
=3D 0x401cd000
read(5, "asb100 subclient\n", 4096)     =3D 17
close(5)                                =3D 0
munmap(0x401cd000, 4096)                =3D 0
open("/sys/bus/i2c/devices/1-002d/name", O_RDONLY) =3D 5
fstat64(5, {st_mode=3DS_IFREG|0444, st_size@96, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
=3D 0x401cd000
read(5, "asb100\n", 4096)               =3D 7
close(5)                                =3D 0
munmap(0x401cd000, 4096)                =3D 0
open("/sys/class/i2c-adapter/i2c-1/device/name", O_RDONLY) =3D 5
fstat64(5, {st_mode=3DS_IFREG|0444, st_size@96, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
=3D 0x401cd000
read(5, "SMBus nForce2 adapter at 5500\n", 4096) =3D 30
close(5)                                =3D 0
munmap(0x401cd000, 4096)                =3D 0
getdents(4, /* 0 entries */, 4096)      =3D 0
close(4)                                =3D 0
open("/sys/class/i2c-adapter",
O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) =3D 4
fstat64(4, {st_mode=3DS_IFDIR|0755, st_size=3D0, ...}) =3D 0
fcntl64(4, F_SETFD, FD_CLOEXEC)         =3D 0
getdents(4, /* 4 entries */, 4096)      =3D 72
open("/sys/class/i2c-adapter/i2c-1/device/name", O_RDONLY) =3D 5
fstat64(5, {st_mode=3DS_IFREG|0444, st_size@96, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
=3D 0x401cd000
read(5, "SMBus nForce2 adapter at 5500\n", 4096) =3D 30
close(5)                                =3D 0
munmap(0x401cd000, 4096)                =3D 0
open("/sys/class/i2c-adapter/i2c-0/device/name", O_RDONLY) =3D 5
fstat64(5, {st_mode=3DS_IFREG|0444, st_size@96, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
=3D 0x401cd000
read(5, "SMBus nForce2 adapter at 5000\n", 4096) =3D 30
close(5)                                =3D 0
munmap(0x401cd000, 4096)                =3D 0
getdents(4, /* 0 entries */, 4096)      =3D 0
close(4)                                =3D 0
ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, 0xbfffdcb8) =3D -1 ENOTTY
(Inappropriate ioctl for device)
fstat64(3, {st_mode=3DS_IFREG|0644, st_sizeW010, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
=3D 0x401cd000
read(3, "# Sensors configuration file use"..., 8192) =3D 8192
read(3, " SMBus adapter\"\n#\n# If we refer "..., 8192) =3D 8192
read(3, "ard\n# uses the recommended resis"..., 8192) =3D 8192
read(3, "0.90\n    set in4_max 12 * 1.10\n "..., 8192) =3D 8192
read(3, "mething to\n# reduce the temp, th"..., 8192) =3D 8192
read(3, "\"\n#   label \"5V\" \"xxx\"\n#   label"..., 8192) =3D 8192
read(3, "t pwm1          0\n#    set pwm2 "..., 8192) =3D 7858
read(3, "", 4096)                       =3D 0
read(3, "", 8192)                       =3D 0
ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, 0xbfffdcc8) =3D -1 ENOTTY
(Inappropriate ioctl for device)
close(3)                                =3D 0
munmap(0x401cd000, 4096)                =3D 0
fstat64(1, {st_mode=3DS_IFCHR|0600, st_rdev=3Dmakedev(136, 43), ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
=3D 0x401cd000
write(1, "w83l785ts-i2c-1-2e\n", 19w83l785ts-i2c-1-2e
)    =3D 19
write(1, "Adapter: SMBus nForce2 adapter a"..., 39Adapter: SMBus nForce2
adapter at 5500
) =3D 39
open("/sys/bus/i2c/devices/1-002e/temp_input1", O_RDONLY) =3D -1 ENOENT (No
such file or directory)
write(1, "ERROR: Can\'t get temperature dat"..., 35ERROR: Can't get
temperature data!
) =3D 35
write(1, "\n", 1
)                       =3D 1
write(1, "asb100-i2c-1-2d\n", 16asb100-i2c-1-2d
)       =3D 16
write(1, "Adapter: SMBus nForce2 adapter a"..., 39Adapter: SMBus nForce2
adapter at 5500
) =3D 39
open("/sys/bus/i2c/devices/1-002d/alarms", O_RDONLY) =3D 3
fstat64(3, {st_mode=3DS_IFREG|0444, st_size@96, ...}) =3D 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
=3D 0x401ce000
read(3, "64\n", 4096)                   =3D 3
close(3)                                =3D 0
munmap(0x401ce000, 4096)                =3D 0
open("/sys/bus/i2c/devices/1-002d/in_input0", O_RDONLY) =3D -1 ENOENT (No
such file or directory)
write(1, "ERROR: Can\'t get IN data! (0x000"..., 35ERROR: Can't get IN
data! (0x0001)
) =3D 35
open("/sys/bus/i2c/devices/1-002d/in_input1", O_RDONLY) =3D -1 ENOENT (No
such file or directory)
write(1, "ERROR: Can\'t get IN data! (0x000"..., 35ERROR: Can't get IN
data! (0x0002)
) =3D 35
open("/sys/bus/i2c/devices/1-002d/in_input2", O_RDONLY) =3D -1 ENOENT (No
such file or directory)
write(1, "ERROR: Can\'t get IN data! (0x000"..., 35ERROR: Can't get IN
data! (0x0003)
) =3D 35
open("/sys/bus/i2c/devices/1-002d/in_input3", O_RDONLY) =3D -1 ENOENT (No
such file or directory)
write(1, "ERROR: Can\'t get IN data! (0x000"..., 35ERROR: Can't get IN
data! (0x0004)
) =3D 35
open("/sys/bus/i2c/devices/1-002d/in_input4", O_RDONLY) =3D -1 ENOENT (No
such file or directory)
write(1, "ERROR: Can\'t get IN data! (0x000"..., 35ERROR: Can't get IN
data! (0x0005)
) =3D 35
open("/sys/bus/i2c/devices/1-002d/in_input5", O_RDONLY) =3D -1 ENOENT (No
such file or directory)
write(1, "ERROR: Can\'t get IN data! (0x000"..., 35ERROR: Can't get IN
data! (0x0006)
) =3D 35
open("/sys/bus/i2c/devices/1-002d/in_input6", O_RDONLY) =3D -1 ENOENT (No
such file or directory)
write(1, "ERROR: Can\'t get IN data! (0x000"..., 35ERROR: Can't get IN
data! (0x0007)
) =3D 35
open("/sys/bus/i2c/devices/1-002d/fan_input1", O_RDONLY) =3D -1 ENOENT (No
such file or directory)
write(1, "ERROR: Can\'t get FAN data! (0x00"..., 36ERROR: Can't get FAN
data! (0x0031)
) =3D 36
open("/sys/bus/i2c/devices/1-002d/fan_input2", O_RDONLY) =3D -1 ENOENT (No
such file or directory)
write(1, "ERROR: Can\'t get FAN data! (0x00"..., 36ERROR: Can't get FAN
data! (0x0032)
) =3D 36
open("/sys/bus/i2c/devices/1-002d/fan_input3", O_RDONLY) =3D -1 ENOENT (No
such file or directory)
write(1, "ERROR: Can\'t get FAN data! (0x00"..., 36ERROR: Can't get FAN
data! (0x0033)
) =3D 36
open("/sys/bus/i2c/devices/1-002d/temp_input1", O_RDONLY) =3D -1 ENOENT (No
such file or directory)
write(1, "ERROR: Can\'t get TEMP data! (0x0"..., 37ERROR: Can't get TEMP
data! (0x0051)
) =3D 37
open("/sys/bus/i2c/devices/1-002d/temp_input2", O_RDONLY) =3D -1 ENOENT (No
such file or directory)
write(1, "ERROR: Can\'t get TEMP data! (0x0"..., 37ERROR: Can't get TEMP
data! (0x0054)
) =3D 37
open("/sys/bus/i2c/devices/1-002d/temp_input3", O_RDONLY) =3D -1 ENOENT (No
such file or directory)
write(1, "ERROR: Can\'t get TEMP data! (0x0"..., 37ERROR: Can't get TEMP
data! (0x0057)
) =3D 37
open("/sys/bus/i2c/devices/1-002d/temp_input4", O_RDONLY) =3D -1 ENOENT (No
such file or directory)
write(1, "ERROR: Can\'t get TEMP data! (0x0"..., 37ERROR: Can't get TEMP
data! (0x005a)
) =3D 37
open("/sys/bus/i2c/devices/1-002d/vid", O_RDONLY) =3D -1 ENOENT (No such
file or directory)
write(1, "ERROR: Can\'t get VID data!\n", 27ERROR: Can't get VID data!
) =3D 27
write(1, "alarms:   \n", 11alarms:
)            =3D 11
write(1, "\n", 1
)                       =3D 1
munmap(0x401cd000, 4096)                =3D 0
exit_group(0)                           =3D ?

kernel log:
System Boot Control: Running /etc/init.d/boot.local
asb100-i2c-1-2d: Can't access procfs/sysfs file for writing;
Run as root?

dmesg:
i2c_adapter i2c-0: nForce2 SMBus adapter at 0x5000
i2c_adapter i2c-1: nForce2 SMBus adapter at 0x5500

Hope this helps us! Thanks!

Goofee


>From: Jean Delvare <khali@linux-fr.org>
>Reply-To: sensors@stimpy.netroedge.com
>To: "tom paris" <goofee79@hotmail.com>
>CC: LM Sensors <sensors@stimpy.netroedge.com>
>Subject: Re: Ticket 1671
>Date: Sat, 8 May 2004 19:57:22 +0200
>
> > 1. I load i2c-dev in modules.conf yes.
> > 2. The sensors -v reveals 2.8.5 and sensors is located in
> > /usr/local/bin. I simply wrote wrong.
> > 3. /sys/bus/i2c/devices contains these directories 1-002d,  1-002e,
> > 1-0048 and  1-0049.
>
>Hmm, OK.
>
>Please provide the full listing of files under 1-002d and 1-002e (exact
>names matter) as well as full log of "strace sensors" and kernel
>logs/dmesg of the moment you inserted both drivers (asb100 and
>w83l785ts).
>
>Thanks.
>
>--
>Jean Delvare
>http://khali.linux-fr.org/

_________________________________________________________________
The new MSN 8: advanced junk mail protection and 2 months FREE*=20
http://join.msn.com/?page=FEatures/junkmail

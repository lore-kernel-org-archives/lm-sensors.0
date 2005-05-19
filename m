From: jon@jonrkc.com (Jon Rutherford)
Date: Thu, 19 May 2005 06:25:24 +0000
Subject: Ticket no. 1817
Message-Id: <41A4F107.5050905@jonrkc.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <41A4C939.8050404@jonrkc.com>
In-Reply-To: <41A4C939.8050404@jonrkc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I finally figured out how to get the output of strace
sensors.  It is attached
as a text file to this email.

Thanks for your help so far!

Jon Rutherford

-------------- next part --------------
execve("/usr/bin/sensors", ["sensors"], [/* 48 vars */]) = 0
uname({sys="Linux", node="bodhisattva", ...}) = 0
brk(0)                                  = 0x8063000
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40015000
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_sizev444, ...}) = 0
old_mmap(NULL, 76444, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40016000
close(3)                                = 0
open("/usr/lib/libsensors.so.3", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0 c\0\000"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size1104, ...}) = 0
old_mmap(NULL, 210372, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x40029000
old_mmap(0x40038000, 81920, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0xf000) = 0x40038000
old_mmap(0x4004c000, 67012, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4004c000
close(3)                                = 0
open("/lib/tls/libc.so.6", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\220O\1"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size65108, ...}) = 0
old_mmap(NULL, 1175436, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x4005d000
old_mmap(0x40176000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x118000) = 0x40176000
old_mmap(0x4017a000, 8076, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4017a000
close(3)                                = 0
open("/lib/tls/libm.so.6", O_RDONLY)    = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\0005\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size9908, ...}) = 0
old_mmap(NULL, 142400, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x4017c000
old_mmap(0x4019e000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x21000) = 0x4019e000
close(3)                                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x4019f000
set_thread_area({entry_number:-1 -> 6, base_addr:0x4019f2a0, limit:1048575, seg_32bit:1, contents:0, read_exec_only:0, limit_in_pages:1, seg_not_present:0, useable:1}) = 0
munmap(0x40016000, 76444)               = 0
open("/usr/share/locale/locale-archive", O_RDONLY|O_LARGEFILE) = -1 ENOENT (No such file or directory)
brk(0)                                  = 0x8063000
brk(0x8084000)                          = 0x8084000
open("/usr/share/locale/locale.alias", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size%86, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40016000
read(3, "# Locale name alias data base.\n#"..., 4096) = 2586
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x40016000, 4096)                = 0
open("/usr/share/locale/en_US/LC_CTYPE", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size8476, ...}) = 0
mmap2(NULL, 178476, PROT_READ, MAP_PRIVATE, 3, 0) = 0x401a0000
close(3)                                = 0
open("/etc/sensors.conf", O_RDONLY)     = 3
open("/proc/mounts", O_RDONLY)          = 4
fstat64(4, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401cc000
read(4, "rootfs / rootfs rw 0 0\n/dev /dev"..., 1024) = 419
close(4)                                = 0
munmap(0x401cc000, 4096)                = 0
open("/sys/bus/i2c/devices", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) = 4
fstat64(4, {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
fcntl64(4, F_SETFD, FD_CLOEXEC)         = 0
getdents64(4, /* 3 entries */, 4096)    = 80
open("/sys/bus/i2c/devices/0-6000/name", O_RDONLY) = 5
fstat64(5, {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401cc000
read(5, "via686a\n", 4096)              = 8
close(5)                                = 0
munmap(0x401cc000, 4096)                = 0
open("/sys/class/i2c-adapter/i2c-0/device/name", O_RDONLY) = 5
fstat64(5, {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401cc000
read(5, "ISA main adapter\n", 4096)     = 17
close(5)                                = 0
munmap(0x401cc000, 4096)                = 0
getdents64(4, /* 0 entries */, 4096)    = 0
close(4)                                = 0
open("/sys/class/i2c-adapter", O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY) = 4
fstat64(4, {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
fcntl64(4, F_SETFD, FD_CLOEXEC)         = 0
getdents64(4, /* 3 entries */, 4096)    = 80
open("/sys/class/i2c-adapter/i2c-0/device/name", O_RDONLY) = 5
fstat64(5, {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401cc000
read(5, "ISA main adapter\n", 4096)     = 17
close(5)                                = 0
munmap(0x401cc000, 4096)                = 0
getdents64(4, /* 0 entries */, 4096)    = 0
close(4)                                = 0
ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, 0xbfffe2a8) = -1 ENOTTY (Inappropriate ioctl for device)
fstat64(3, {st_mode=S_IFREG|0644, st_sizee759, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401cc000
read(3, "# Sensors configuration file use"..., 8192) = 8192
read(3, " SMBus adapter\"\n#\n# If we refer "..., 8192) = 8192
read(3, "nsor types (thermistor is defaul"..., 8192) = 8192
read(3, " work for temp3.\n    compute tem"..., 8192) = 8192
read(3, "5V\'\n# line below.\n\n    label \"2."..., 8192) = 8192
read(3, " 3000\n   set fan2_min 3000\n\n   s"..., 8192) = 8192
read(3, "an2\n#    ignore fan3\n\n\nchip \"fsc"..., 8192) = 8192
read(3, "n3_min 5.0 * 0.95\n    set in3_ma"..., 8192) = 8192
read(3, "t\"\n\n   set temp1_max  60\n   set "..., 8192) = 223
read(3, "", 4096)                       = 0
read(3, "", 8192)                       = 0
ioctl(3, SNDCTL_TMR_TIMEBASE or TCGETS, 0xbfffe2b8) = -1 ENOTTY (Inappropriate ioctl for device)
close(3)                                = 0
munmap(0x401cc000, 4096)                = 0
open("/usr/lib/gconv/gconv-modules.cache", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
close(3)                                = 0
open("/usr/lib/gconv/gconv-modules", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_sizeF743, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401cc000
read(3, "# GNU libc iconv configuration.\n"..., 4096) = 4096
read(3, "lias\tJS//\t\t\tJUS_I.B1.002//\nalias"..., 4096) = 4096
read(3, "ule\tINTERNAL\t\tISO-8859-3//\t\tISO8"..., 4096) = 4096
read(3, "lias\tISO-IR-199//\t\tISO-8859-14//"..., 4096) = 4096
brk(0x80a5000)                          = 0x80a5000
read(3, "\t\tto\t\t\tmodule\t\tcost\nalias\tCSEBCD"..., 4096) = 4096
read(3, "ule\t\tcost\nalias\tCP284//\t\t\tIBM284"..., 4096) = 4096
read(3, "lias\tCP864//\t\t\tIBM864//\nalias\t86"..., 4096) = 4096
read(3, "module\tIBM937//\t\tINTERNAL\t\tIBM93"..., 4096) = 4096
read(3, "\tEUC-JP//\nalias\tUJIS//\t\t\tEUC-JP/"..., 4096) = 4096
read(3, "module\t\tcost\nalias\tISO-IR-143//\t"..., 4096) = 4096
read(3, "-BOX//\nmodule\tISO_10367-BOX//\t\tI"..., 4096) = 4096
read(3, "dule\tTCVN5712-1//\t\tINTERNAL\t\tTCV"..., 4096) = 1687
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x401cc000, 4096)                = 0
open("/usr/lib/gconv/ISO8859-1.so", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\20\6\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_sizeU24, ...}) = 0
old_mmap(NULL, 4364, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x401cc000
old_mmap(0x401cd000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x1000) = 0x401cd000
close(3)                                = 0
fstat64(1, {st_mode=S_IFCHR|0622, st_rdev=makedev(136, 1), ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401ce000
write(1, "via686a-isa-6000\n", 17)      = 17
write(1, "Adapter: ISA adapter\n", 21)  = 21
open("/sys/bus/i2c/devices/0-6000/alarms", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size@96, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401cf000
read(3, "4877\n", 4096)                 = 5
close(3)                                = 0
munmap(0x401cf000, 4096)                = 0
open("/sys/bus/i2c/devices/0-6000/in0_input", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401cf000
read(3, "1669\n", 4096)                 = 5
close(3)                                = 0
munmap(0x401cf000, 4096)                = 0
open("/sys/bus/i2c/devices/0-6000/in0_min", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size@96, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401cf000
read(3, "325\n", 4096)                  = 4
close(3)                                = 0
munmap(0x401cf000, 4096)                = 0
open("/sys/bus/i2c/devices/0-6000/in0_max", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size@96, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401cf000
read(3, "1514\n", 4096)                 = 5
close(3)                                = 0
munmap(0x401cf000, 4096)                = 0
write(1, "2.0V:      +1.67 V  (min =  +0.3"..., 61) = 61
open("/sys/bus/i2c/devices/0-6000/in1_input", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401cf000
read(3, "2513\n", 4096)                 = 5
close(3)                                = 0
munmap(0x401cf000, 4096)                = 0
open("/sys/bus/i2c/devices/0-6000/in1_min", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size@96, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401cf000
read(3, "2334\n", 4096)                 = 5
close(3)                                = 0
munmap(0x401cf000, 4096)                = 0
open("/sys/bus/i2c/devices/0-6000/in1_max", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size@96, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401cf000
read(3, "3000\n", 4096)                 = 5
close(3)                                = 0
munmap(0x401cf000, 4096)                = 0
write(1, "2.5V:      +2.51 V  (min =  +2.3"..., 56) = 56
open("/sys/bus/i2c/devices/0-6000/in2_input", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401cf000
read(3, "3309\n", 4096)                 = 5
close(3)                                = 0
munmap(0x401cf000, 4096)                = 0
open("/sys/bus/i2c/devices/0-6000/in2_min", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size@96, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401cf000
read(3, "4008\n", 4096)                 = 5
close(3)                                = 0
munmap(0x401cf000, 4096)                = 0
open("/sys/bus/i2c/devices/0-6000/in2_max", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size@96, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401cf000
read(3, "2563\n", 4096)                 = 5
close(3)                                = 0
munmap(0x401cf000, 4096)                = 0
write(1, "3.3V:      +3.31 V  (min =  +4.0"..., 61) = 61
open("/sys/bus/i2c/devices/0-6000/in3_input", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401cf000
read(3, "5128\n", 4096)                 = 5
close(3)                                = 0
munmap(0x401cf000, 4096)                = 0
open("/sys/bus/i2c/devices/0-6000/in3_min", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size@96, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401cf000
read(3, "2852\n", 4096)                 = 5
close(3)                                = 0
munmap(0x401cf000, 4096)                = 0
open("/sys/bus/i2c/devices/0-6000/in3_max", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size@96, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401cf000
read(3, "1764\n", 4096)                 = 5
close(3)                                = 0
munmap(0x401cf000, 4096)                = 0
write(1, "5.0V:      +5.13 V  (min =  +2.8"..., 61) = 61
open("/sys/bus/i2c/devices/0-6000/in4_input", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401cf000
read(3, "12125\n", 4096)                = 6
close(3)                                = 0
munmap(0x401cf000, 4096)                = 0
open("/sys/bus/i2c/devices/0-6000/in4_min", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size@96, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401cf000
read(3, "15362\n", 4096)                = 6
close(3)                                = 0
munmap(0x401cf000, 4096)                = 0
open("/sys/bus/i2c/devices/0-6000/in4_max", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size@96, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401cf000
read(3, "11586\n", 4096)                = 6
close(3)                                = 0
munmap(0x401cf000, 4096)                = 0
write(1, "12V:      +12.12 V  (min = +15.3"..., 61) = 61
open("/sys/bus/i2c/devices/0-6000/fan1_input", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401cf000
read(3, "2986\n", 4096)                 = 5
close(3)                                = 0
munmap(0x401cf000, 4096)                = 0
open("/sys/bus/i2c/devices/0-6000/fan1_div", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size@96, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401cf000
read(3, "2\n", 4096)                    = 2
close(3)                                = 0
munmap(0x401cf000, 4096)                = 0
open("/sys/bus/i2c/devices/0-6000/fan1_min", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size@96, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401cf000
read(3, "2667\n", 4096)                 = 5
close(3)                                = 0
munmap(0x401cf000, 4096)                = 0
write(1, "fan1:     2986 RPM  (min = 2667 "..., 56) = 56
open("/sys/bus/i2c/devices/0-6000/fan2_input", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401cf000
read(3, "0\n", 4096)                    = 2
close(3)                                = 0
munmap(0x401cf000, 4096)                = 0
open("/sys/bus/i2c/devices/0-6000/fan2_div", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size@96, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401cf000
read(3, "2\n", 4096)                    = 2
close(3)                                = 0
munmap(0x401cf000, 4096)                = 0
open("/sys/bus/i2c/devices/0-6000/fan2_min", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size@96, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401cf000
read(3, "3260\n", 4096)                 = 5
close(3)                                = 0
munmap(0x401cf000, 4096)                = 0
write(1, "fan2:        0 RPM  (min = 3260 "..., 56) = 56
open("/sys/bus/i2c/devices/0-6000/temp1_input", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401cf000
read(3, "29300\n", 4096)                = 6
close(3)                                = 0
munmap(0x401cf000, 4096)                = 0
open("/sys/bus/i2c/devices/0-6000/temp1_max_hyst", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size@96, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401cf000
read(3, "21100\n", 4096)                = 6
close(3)                                = 0
munmap(0x401cf000, 4096)                = 0
open("/sys/bus/i2c/devices/0-6000/temp1_max", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size@96, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401cf000
read(3, "46900\n", 4096)                = 6
close(3)                                = 0
munmap(0x401cf000, 4096)                = 0
write(1, "temp1:     +29.3\260C  (high =   +4"..., 56) = 56
open("/sys/bus/i2c/devices/0-6000/temp2_input", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401cf000
read(3, "27400\n", 4096)                = 6
close(3)                                = 0
munmap(0x401cf000, 4096)                = 0
open("/sys/bus/i2c/devices/0-6000/temp2_max_hyst", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size@96, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401cf000
read(3, "100800\n", 4096)               = 7
close(3)                                = 0
munmap(0x401cf000, 4096)                = 0
open("/sys/bus/i2c/devices/0-6000/temp2_max", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size@96, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401cf000
read(3, "40900\n", 4096)                = 6
close(3)                                = 0
munmap(0x401cf000, 4096)                = 0
write(1, "temp2:     +27.4\260C  (high =   +4"..., 56) = 56
open("/sys/bus/i2c/devices/0-6000/temp3_input", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401cf000
read(3, "22400\n", 4096)                = 6
close(3)                                = 0
munmap(0x401cf000, 4096)                = 0
open("/sys/bus/i2c/devices/0-6000/temp3_max_hyst", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size@96, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401cf000
read(3, "69800\n", 4096)                = 6
close(3)                                = 0
munmap(0x401cf000, 4096)                = 0
open("/sys/bus/i2c/devices/0-6000/temp3_max", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size@96, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x401cf000
read(3, "47500\n", 4096)                = 6
close(3)                                = 0
munmap(0x401cf000, 4096)                = 0
write(1, "temp3:     +22.4\260C  (high =   +4"..., 56) = 56
write(1, "\n", 1)                       = 1
munmap(0x401ce000, 4096)                = 0
exit_group(0)                           = ?

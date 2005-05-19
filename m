From: garman@raw-sewage.net (Matt Garman)
Date: Thu, 19 May 2005 06:24:40 +0000
Subject: Ticket 1564 (Can't access /proc file for writing);
Message-Id: <20040205170115.GA5432@raw-sewage.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040205141827.GA3115@raw-sewage.net>
In-Reply-To: <20040205141827.GA3115@raw-sewage.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Re: ticket 1564

On Thu, Feb 05, 2004 at 04:40:14PM +0100, Jean Delvare wrote:
> Erf, the trap is not activated by default :/ my bad. Please recompile
> lm_sensors with DEBUG defined (changeable in the Makefile) so that
> libsensors includes the trap, and redo the test. Sorry that I did not
> mention that earlier.

No problem!  I thought that trace I sent before looked awfully similar
to the one on the link. :)

Anyway, here it is with debugging enabled.  Please let me know if you
need any more information!

Thanks again for your help,
Matt




execve("./sensors", ["./sensors", "-s"], [/* 31 vars */]) = 0
uname({sys="Linux", node="septictank", ...}) = 0
brk(0)                                  = 0x806672c
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40015000
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/home/garman/lm_sensors-2.8.2/lib/i686/mmx/libsensors.so.3", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/home/garman/lm_sensors-2.8.2/lib/i686/mmx", 0xbffff0b4) = -1 ENOENT (No such file or directory)
open("/home/garman/lm_sensors-2.8.2/lib/i686/libsensors.so.3", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/home/garman/lm_sensors-2.8.2/lib/i686", 0xbffff0b4) = -1 ENOENT (No such file or directory)
open("/home/garman/lm_sensors-2.8.2/lib/mmx/libsensors.so.3", O_RDONLY) = -1 ENOENT (No such file or directory)
stat64("/home/garman/lm_sensors-2.8.2/lib/mmx", 0xbffff0b4) = -1 ENOENT (No such file or directory)
open("/home/garman/lm_sensors-2.8.2/lib/libsensors.so.3", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\340]\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size8158, ...}) = 0
mmap2(NULL, 205380, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40016000
mmap2(0x40025000, 73728, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0xe) = 0x40025000
mmap2(0x40037000, 70212, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40037000
close(3)                                = 0
open("/home/garman/lm_sensors-2.8.2/lib/libc.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size188, ...}) = 0
mmap2(NULL, 19188, PROT_READ, MAP_PRIVATE, 3, 0) = 0x40049000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\200^\1"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size73344, ...}) = 0
mmap2(NULL, 1236740, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x4004e000
mmap2(0x40176000, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x127) = 0x40176000
mmap2(0x4017a000, 7940, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x4017a000
close(3)                                = 0
open("/home/garman/lm_sensors-2.8.2/lib/libm.so.6", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/lib/libm.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\3004\0"..., 512) = 512
fstat64(3, {st_mode=S_IFREG|0755, st_size4357, ...}) = 0
mmap2(NULL, 134400, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x4017c000
mmap2(0x4019c000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x1f) = 0x4019c000
close(3)                                = 0
munmap(0x40049000, 19188)               = 0
open("/dev/urandom", O_RDONLY)          = 3
read(3, "\214$\363\f\353EN!\307\202;\377t\214\7\257\330\371s\341"..., 32) = 32
close(3)                                = 0
brk(0)                                  = 0x806672c
brk(0x808772c)                          = 0x808772c
brk(0)                                  = 0x808772c
brk(0x8088000)                          = 0x8088000
open("/etc/sensors.conf", O_RDONLY)     = 3
open("/proc/mounts", O_RDONLY)          = 4
fstat64(4, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40049000
read(4, "rootfs / rootfs rw 0 0\n/dev/root"..., 4096) = 321
read(4, "", 4096)                       = 0
close(4)                                = 0
munmap(0x40049000, 4096)                = 0
brk(0)                                  = 0x8088000
brk(0)                                  = 0x8088000
brk(0x8087000)                          = 0x8087000
brk(0)                                  = 0x8087000
_sysctl({{CTL_DEV, 2, 1}, 3, 0x40037020, 40, (nil), 0}) = 0
open("/proc/bus/i2c", O_RDONLY)         = 4
fstat64(4, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40049000
read(4, "i2c-0\tsmbus    \tSMBus nForce2 ad"..., 4096) = 247
read(4, "", 4096)                       = 0
close(4)                                = 0
munmap(0x40049000, 4096)                = 0
ioctl(3, SNDCTL_TMR_TIMEBASE, 0xbfffe81c) = -1 ENOTTY (Inappropriate ioctl for device)
fstat64(3, {st_mode=S_IFREG|0644, st_sizeT489, ...}) = 0
mmap2(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40049000
read(3, "# Sensors configuration file use"..., 8192) = 8192
read(3, " SMBus adapter\"\n#\n# If we refer "..., 8192) = 8192
read(3, "ard\n# uses the recommended resis"..., 8192) = 8192
read(3, ", in1, and in2 values (+5, +3, a"..., 8192) = 8192
read(3, "ing corrections make the sensors"..., 8192) = 8192
read(3, "CPU1 Temp\"\n    ignore \"2.5V\" # T"..., 8192) = 8192
read(3, "\t\ttemp5\t\t0x10 (16)\n#\tUCH4\t\tin3\t\t"..., 8192) = 5337
read(3, "", 4096)                       = 0
read(3, "", 8192)                       = 0
ioctl(3, SNDCTL_TMR_TIMEBASE, 0xbfffe7ec) = -1 ENOTTY (Inappropriate ioctl for device)
close(3)                                = 0
munmap(0x40049000, 4096)                = 0
_sysctl({{CTL_DEV, 2, 100, 3e8}, 4, 0x40037020, 12, (nil), 0}) = 0
getuid32()                              = 0
geteuid32()                             = 0
getgid32()                              = 0
getegid32()                             = 0
_sysctl({{CTL_DEV, 2, 100, 3e8}, 4, (nil), 0, 0x40037020, 4}) = -1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 100, 3e8}, 4, 0x40037020, 12, (nil), 0}) = 0
getuid32()                              = 0
geteuid32()                             = 0
getgid32()                              = 0
getegid32()                             = 0
_sysctl({{CTL_DEV, 2, 100, 3e8}, 4, (nil), 0, 0x40037020, 8}) = -1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 100, 3e9}, 4, 0x40037020, 12, (nil), 0}) = 0
getuid32()                              = 0
geteuid32()                             = 0
getgid32()                              = 0
getegid32()                             = 0
_sysctl({{CTL_DEV, 2, 100, 3e9}, 4, (nil), 0, 0x40037020, 4}) = -1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 100, 3e9}, 4, 0x40037020, 12, (nil), 0}) = 0
getuid32()                              = 0
geteuid32()                             = 0
getgid32()                              = 0
getegid32()                             = 0
_sysctl({{CTL_DEV, 2, 100, 3e9}, 4, (nil), 0, 0x40037020, 8}) = -1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 100, 3ea}, 4, 0x40037020, 12, (nil), 0}) = 0
getuid32()                              = 0
geteuid32()                             = 0
getgid32()                              = 0
getegid32()                             = 0
_sysctl({{CTL_DEV, 2, 100, 3ea}, 4, (nil), 0, 0x40037020, 4}) = -1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 100, 3ea}, 4, 0x40037020, 12, (nil), 0}) = 0
getuid32()                              = 0
geteuid32()                             = 0
getgid32()                              = 0
getegid32()                             = 0
_sysctl({{CTL_DEV, 2, 100, 3ea}, 4, (nil), 0, 0x40037020, 8}) = -1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 100, 3eb}, 4, 0x40037020, 12, (nil), 0}) = 0
getuid32()                              = 0
geteuid32()                             = 0
getgid32()                              = 0
getegid32()                             = 0
_sysctl({{CTL_DEV, 2, 100, 3eb}, 4, (nil), 0, 0x40037020, 4}) = -1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 100, 3eb}, 4, 0x40037020, 12, (nil), 0}) = 0
getuid32()                              = 0
geteuid32()                             = 0
getgid32()                              = 0
getegid32()                             = 0
_sysctl({{CTL_DEV, 2, 100, 3eb}, 4, (nil), 0, 0x40037020, 8}) = -1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 100, 3ec}, 4, 0x40037020, 12, (nil), 0}) = 0
getuid32()                              = 0
geteuid32()                             = 0
getgid32()                              = 0
getegid32()                             = 0
_sysctl({{CTL_DEV, 2, 100, 3ec}, 4, (nil), 0, 0x40037020, 4}) = -1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 100, 3ec}, 4, 0x40037020, 12, (nil), 0}) = 0
getuid32()                              = 0
geteuid32()                             = 0
getgid32()                              = 0
getegid32()                             = 0
_sysctl({{CTL_DEV, 2, 100, 3ec}, 4, (nil), 0, 0x40037020, 8}) = -1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 100, 3ed}, 4, 0x40037020, 12, (nil), 0}) = 0
getuid32()                              = 0
geteuid32()                             = 0
getgid32()                              = 0
getegid32()                             = 0
_sysctl({{CTL_DEV, 2, 100, 3ed}, 4, (nil), 0, 0x40037020, 8}) = -1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 100, 3ed}, 4, 0x40037020, 12, (nil), 0}) = 0
getuid32()                              = 0
geteuid32()                             = 0
getgid32()                              = 0
getegid32()                             = 0
_sysctl({{CTL_DEV, 2, 100, 3ed}, 4, (nil), 0, 0x40037020, 4}) = -1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 100, 3ee}, 4, 0x40037020, 12, (nil), 0}) = 0
getuid32()                              = 0
geteuid32()                             = 0
getgid32()                              = 0
getegid32()                             = 0
_sysctl({{CTL_DEV, 2, 100, 3ee}, 4, (nil), 0, 0x40037020, 8}) = -1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 100, 3ee}, 4, 0x40037020, 12, (nil), 0}) = 0
getuid32()                              = 0
geteuid32()                             = 0
getgid32()                              = 0
getegid32()                             = 0
_sysctl({{CTL_DEV, 2, 100, 3ee}, 4, (nil), 0, 0x40037020, 4}) = -1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 100, 3ef}, 4, 0x40037020, 12, (nil), 0}) = 0
getuid32()                              = 0
geteuid32()                             = 0
getgid32()                              = 0
getegid32()                             = 0
_sysctl({{CTL_DEV, 2, 100, 3ef}, 4, (nil), 0, 0x40037020, 4}) = -1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 100, 3ef}, 4, 0x40037020, 12, (nil), 0}) = 0
getuid32()                              = 0
geteuid32()                             = 0
getgid32()                              = 0
getegid32()                             = 0
_sysctl({{CTL_DEV, 2, 100, 3ef}, 4, (nil), 0, 0x40037020, 8}) = -1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 100, 4b0}, 4, 0x40037020, 12, (nil), 0}) = 0
getuid32()                              = 0
geteuid32()                             = 0
getgid32()                              = 0
getegid32()                             = 0
_sysctl({{CTL_DEV, 2, 100, 4b0}, 4, (nil), 0, 0x40037020, 4}) = -1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 100, 4b0}, 4, 0x40037020, 12, (nil), 0}) = 0
getuid32()                              = 0
geteuid32()                             = 0
getgid32()                              = 0
getegid32()                             = 0
_sysctl({{CTL_DEV, 2, 100, 4b0}, 4, (nil), 0, 0x40037020, 8}) = -1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 100, 4b1}, 4, 0x40037020, 12, (nil), 0}) = 0
getuid32()                              = 0
geteuid32()                             = 0
getgid32()                              = 0
getegid32()                             = 0
_sysctl({{CTL_DEV, 2, 100, 4b1}, 4, (nil), 0, 0x40037020, 4}) = -1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 100, 4b1}, 4, 0x40037020, 12, (nil), 0}) = 0
getuid32()                              = 0
geteuid32()                             = 0
getgid32()                              = 0
getegid32()                             = 0
_sysctl({{CTL_DEV, 2, 100, 4b1}, 4, (nil), 0, 0x40037020, 8}) = -1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 100, 4b2}, 4, 0x40037020, 12, (nil), 0}) = 0
getuid32()                              = 0
geteuid32()                             = 0
getgid32()                              = 0
getegid32()                             = 0
_sysctl({{CTL_DEV, 2, 100, 4b2}, 4, (nil), 0, 0x40037020, 4}) = -1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 100, 4b2}, 4, 0x40037020, 12, (nil), 0}) = 0
getuid32()                              = 0
geteuid32()                             = 0
getgid32()                              = 0
getegid32()                             = 0
_sysctl({{CTL_DEV, 2, 100, 4b2}, 4, (nil), 0, 0x40037020, 8}) = -1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 100, 44d}, 4, 0x40037020, 8, (nil), 0}) = 0
getuid32()                              = 0
geteuid32()                             = 0
getgid32()                              = 0
getegid32()                             = 0
_sysctl({{CTL_DEV, 2, 100, 44d}, 4, (nil), 0, 0x40037020, 4}) = -1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 100, 44e}, 4, 0x40037020, 8, (nil), 0}) = 0
getuid32()                              = 0
geteuid32()                             = 0
getgid32()                              = 0
getegid32()                             = 0
_sysctl({{CTL_DEV, 2, 100, 44e}, 4, (nil), 0, 0x40037020, 4}) = -1 EACCES (Permission denied)
_sysctl({{CTL_DEV, 2, 100, 44f}, 4, 0x40037020, 8, (nil), 0}) = 0
getuid32()                              = 0
geteuid32()                             = 0
getgid32()                              = 0
getegid32()                             = 0
_sysctl({{CTL_DEV, 2, 100, 44f}, 4, (nil), 0, 0x40037020, 4}) = -1 EACCES (Permission denied)
write(2, "it87-isa-0290: Can\'t access /pro"..., 52it87-isa-0290: Can't access /proc file for writing;
) = 52
write(2, "Run as root?\n", 13Run as root?
)          = 13
_exit(1)                                = ?


-- 
Matt Garman
email at: http://raw-sewage.net/index.php?file=email

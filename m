From: phil@mindfart.com (=?iso-8859-1?B?pCBQaGlsIKQ=?=)
Date: Thu, 19 May 2005 06:25:11 +0000
Subject: Support question:  segault in sensors
Message-Id: <013901c480a8$af2fc120$4400000a@phil>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I am running Linux 2.4.17 with lm_sensors 2.8.7

lsmod:
Module                  Size  Used by
smsc47m1                5920   0  (unused)
eeprom                  5224   0  (unused)
adm1025                 5976   0  (unused)
i2c-proc                5856   0  [smsc47m1 eeprom adm1025]
i2c-isa                  944   0  (unused)
i2c-i801                4932   0  (unused)
i2c-core               14276   0  [smsc47m1 eeprom adm1025 i2c-proc i2c-isa i2c-i801]

Everything works properly until I exec sensors -s, when I get a segfault.  Here is the strace:
execve("/usr/local/bin/sensors", ["sensors", "-s"], [/* 23 vars */]) = 0
brk(0)                                  = 0x80628f0
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
open("/usr/local/lib/i686/mmx/libsensors.so.3", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0pc\0\000"..., 1024) = 1024
fstat64(0x3, 0xbfffee8c)                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40015000
old_mmap(NULL, 209700, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40016000
mprotect(0x40025000, 148260, PROT_NONE) = 0
old_mmap(0x40025000, 81920, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0xf000) = 0x40025000
old_mmap(0x40039000, 66340, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40039000
close(3)                                = 0
open("/usr/local/lib/i686/mmx/libc.so.6", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\230\325"..., 1024) = 1024
fstat64(0x3, 0xbfffee7c)                = 0
old_mmap(NULL, 1170948, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x4004a000
mprotect(0x4015e000, 40452, PROT_NONE)  = 0
old_mmap(0x4015e000, 24576, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x113000) = 0x4015e000
old_mmap(0x40164000, 15876, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x40164000
close(3)                                = 0
open("/usr/local/lib/i686/mmx/libm.so.6", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\300H\0"..., 1024) = 1024
fstat64(0x3, 0xbfffedfc)                = 0
old_mmap(NULL, 136756, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x40168000
mprotect(0x40189000, 1588, PROT_NONE)   = 0
old_mmap(0x40189000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x20000) = 0x40189000
close(3)                                = 0
brk(0)                                  = 0x80628f0
brk(0x8062918)                          = 0x8062918
brk(0x8063000)                          = 0x8063000
open("/etc/sensors.conf", O_RDONLY)     = 3
open("/proc/mounts", O_RDONLY)          = 4
fstat64(0x4, 0xbffff08c)                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x4018a000
read(4, "/dev/root / ext2 rw 0 0\n/dev/hda"..., 4096) = 103
read(4, "", 4096)                       = 0
close(4)                                = 0
munmap(0x4018a000, 4096)                = 0
_sysctl({{CTL_DEV, 2, 1}, 3, 0x40038100, 200, (nil), 0}) = 0
open("/proc/bus/i2c", O_RDONLY)         = 4
fstat64(0x4, 0xbffff29c)                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x4018a000
read(4, "i2c-0\tsmbus    \tSMBus I801 adapt"..., 4096) = 165
read(4, "", 4096)                       = 0
close(4)                                = 0
munmap(0x4018a000, 4096)                = 0
brk(0x8068000)                          = 0x8068000
ioctl(3, TCGETS, 0xbfffe918)            = -1 ENOTTY (Inappropriate ioctl for device)
fstat64(0x3, 0xbfffe87c)                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x4018a000
read(3, "chip \"adm1025-*\"\n\n# The ADM1025 "..., 8192) = 1624
read(3, "", 4096)                       = 0
read(3, "", 8192)                       = 0
ioctl(3, TCGETS, 0xbfffe8e8)            = -1 ENOTTY (Inappropriate ioctl for device)
close(3)                                = 0
munmap(0x4018a000, 4096)                = 0
open("/usr/lib/gconv/gconv-modules.cache", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/usr/lib/gconv/gconv-modules", O_RDONLY) = 3
fstat64(0x3, 0xbffff5cc)                = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x4018a000
read(3, "# GNU libc iconv configuration.\n"..., 4096) = 4096
brk(0x8069000)                          = 0x8069000
brk(0x806a000)                          = 0x806a000
read(3, "20-1969-RO//\nmodule\tJIS_C6220-19"..., 4096) = 4096
brk(0x806b000)                          = 0x806b000
brk(0x806c000)                          = 0x806c000
read(3, "RNAL\t\tISO8859-3\t1\nmodule\tINTERNA"..., 4096) = 4096
brk(0x806d000)                          = 0x806d000
read(3, "SO_6937-2\t1\n\n#\tfrom\t\t\tto\t\t\tmodul"..., 4096) = 4096
brk(0x806e000)                          = 0x806e000
brk(0x806f000)                          = 0x806f000
read(3, "M256//\nmodule\tIBM256//\t\tINTERNAL"..., 4096) = 4096
brk(0x8070000)                          = 0x8070000
brk(0x8071000)                          = 0x8071000
read(3, "module\t\tcost\nalias\tCP855//\t\t\tIBM"..., 4096) = 4096
brk(0x8072000)                          = 0x8072000
brk(0x8073000)                          = 0x8073000
read(3, "IBM1004//\nalias\tOS2LATIN1//\t\tIBM"..., 4096) = 4096
brk(0x8074000)                          = 0x8074000
brk(0x8075000)                          = 0x8075000
read(3, "_P27-1\t1\nmodule\tINTERNAL\t\tIEC_P2"..., 4096) = 4096
brk(0x8076000)                          = 0x8076000
read(3, "le\tINTERNAL\t\tNATS-DANO//\t\tNATS-D"..., 4096) = 943
brk(0x8077000)                          = 0x8077000
read(3, "", 4096)                       = 0
close(3)                                = 0
munmap(0x4018a000, 4096)                = 0
open("/usr/lib/gconv/ISO8859-1.so", O_RDONLY) = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\3\0\1\0\0\0\260\7\0"..., 1024) = 1024
fstat64(0x3, 0xbfffeef4)                = 0
old_mmap(NULL, 7456, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x4018a000
mprotect(0x4018b000, 3360, PROT_NONE)   = 0
old_mmap(0x4018b000, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0) = 0x4018b000
close(3)                                = 0
brk(0x807f000)                          = 0x807f000
--- SIGSEGV (Segmentation fault) ---
+++ killed by SIGSEGV +++

Any ideas?  Thanks in advance!
-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040812/e6b89b90/attachment.html

From: Axel.Thimm@ATrpms.net (Axel Thimm)
Date: Thu, 19 May 2005 06:25:12 +0000
Subject: Tyan S2882 and S2880 (was: Tyan S2882 (ticket #1756))
Message-Id: <20040818225046.GC5092@neu.physik.fu-berlin.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Aug 17, 2004 at 06:53:13PM +0200, Jean Delvare wrote:
> Regarding ticket #1756, I have not much idea what you are supposed
> to do. Tyan should know their motherboard and hopefully provide
> working configuration files for them. Maybe you could get in touch
> with them if you can't get it to work?

OK, I emailed the tech support.

> I seriously doubt that the same sensor could be used by two
> chips. For one thing, it wouldn't be very useful. For another, it
> would be technically difficult.
> 
> The high temperatures you obtain are not impossible if they are
> reported by CPU built-in thermal diodes (very near from the CPU
> core) and the fans are insufficent. Maybe you should consider that
> case. After all, this is why monitoring is important ;)

Yes, the machine is question is hanging after a few minutes of
load. :/

I just wonder that there are 6 different tempereature sensors around,
and that there were three at 35-45? and three at 70-80?, so it looks
like a wrong multiplier has been applied to one set.

> I remember one post on LKML about the S2882:
> http://marc.theaimsgroup.com/?l=linux-kernel&m8237636318994&w=2
> You may want to get in touch with that person and share your experience together.

I did so, he is using the sysfs values directly.

> Also, one thing made me curious in your report:
> 
> > adm1027-i2c-1-2e
> > Adapter: SMBus AMD756 adapter at 50e0
> > ERROR: Can?t get alarm mask data!
> 
> This isn't supposed to happen. Could you check that the lm85 driver exports an
> "alarms" file and that you can read from it using "cat"?

The broken machine is currently unavailable, but I have an S2880 to
test this (same error message):

# sensors adm1027-i2c-0-2d
adm1027-i2c-0-2d
Adapter: SMBus AMD756 adapter at 50e0
ERROR: Can't get alarm mask data!
VDD 2.5V:  +0.013 V  (min =  +0.00 V, max =  +3.32 V)   
DDR VTT:   +0.000 V  (min =  +0.00 V, max =  +2.99 V)   ALARM
3VSB:      +3.317 V  (min =  +0.00 V, max =  +4.38 V)   
+5 V:     +5.156 V  (min =  +0.00 V, max =  +6.64 V)   
+12V:     +12.250 V  (min =  +0.00 V, max = +15.94 V)   
chs1 fan:     0 RPM  (min =    0 RPM)                     
chs2 fan:  6521 RPM  (min =    0 RPM)                     
chs3 fan:     0 RPM  (min =    0 RPM)                     
CPU2 Temp:-128.00?C  (low  =  -127?C, high =  +127?C)     ALARM FAULT 
CPU1 Temp:+40.00?C  (low  =  -127?C, high =  +127?C)       

# grep . /sys/bus/i2c/*/*/*/alarm*
/sys/bus/i2c/drivers/lm85/0-002d/alarms:16530
/sys/bus/i2c/drivers/w83627hf/2-0290/alarms:2

(BTW the funny temp readings for CPU2 are due to CPU2 being absent).

> I wonder what's going on. If you can read from the file (meaning
> that the driver itself is OK), please strace sensors and report.

I can read the "alarm" file, sensors is looking for "alarm_mask" which
does not exist:

# strace sensors adm1027-i2c-0-2d 2>&1|grep -10 /sys/bus/i2c/devices/0-002d/alarm
close(3)                                = 0
open("/usr/lib64/gconv/ISO8859-1.so", O_RDONLY) = 3
read(3, "\177ELF\2\1\1\0\0\0\0\0\0\0\0\0\3\0>\0\1\0\0\0\0\6\0\0"..., 640) = 640
fstat(3, {st_mode=S_IFREG|0755, st_size54608, ...}) = 0
mmap(NULL, 1052720, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x2a97be7000
mprotect(0, 1044528, PROT_NONE)         = -1 ENOMEM (Cannot allocate memory)
mmap(0x2a97ce7000, 8192, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3, 0x100000) = 0x2a97ce7000
close(3)                                = 0
fstat(1, {st_mode=S_IFIFO|0600, st_size=0, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2a97ce9000
open("/sys/bus/i2c/devices/0-002d/alarms", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2a97cea000
read(3, "16530\n", 4096)                = 6
close(3)                                = 0
munmap(0x2a97cea000, 4096)              = 0
open("/sys/bus/i2c/devices/0-002d/alarm_mask", O_RDONLY) = -1 ENOENT (No such file or directory)
open("/sys/bus/i2c/devices/0-002d/in0_input", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2a97cea000
read(3, "13\n", 4096)                   = 3
close(3)                                = 0
munmap(0x2a97cea000, 4096)              = 0
open("/sys/bus/i2c/devices/0-002d/in0_min", O_RDONLY) = 3
fstat(3, {st_mode=S_IFREG|0644, st_size@96, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2a97cea000
read(3, "0\n", 4096)                    = 2
-- 
Axel.Thimm at ATrpms.net
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040819/2149699a/attachment.bin

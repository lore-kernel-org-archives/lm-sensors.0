From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 06 Jan 2008 22:10:00 +0000
Subject: Re: [lm-sensors] Needed support for SMSC LPC47M292
Message-Id: <20080106231000.3be80ed0@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <477E2B2A.5010707@gmail.com>
In-Reply-To: <477E2B2A.5010707@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 06 Jan 2008 20:29:36 +0000, Antonio RAGO wrote:
> raven:~# strace sensors
> (...)
> getdents(3, /* 3 entries */, 4096)      = 52
> lstat64("/sys/class/hwmon/hwmon0", {st_mode=S_IFDIR|0755, st_size=0,
> ...}) = 0
> getdents(3, /* 0 entries */, 4096)      = 0
> close(3)                                = 0
> lstat64("/sys/class/hwmon/hwmon0/device", {st_mode=S_IFLNK|0777,
> st_size=0, ...}) = 0
> readlink("/sys/class/hwmon/hwmon0/device",
> "../../../devices/platform/smsc47m1.2048", 256) = 39
> lstat64("/sys/devices/platform/smsc47m1.2048", {st_mode=S_IFDIR|0755,
> st_size=0, ...}) = 0
> lstat64("/sys/devices/platform/smsc47m1.2048/bus",
> {st_mode=S_IFLNK|0777, st_size=0, ...}) = 0
> readlink("/sys/devices/platform/smsc47m1.2048/bus",
> "../../../bus/platform", 256) = 21
> lstat64("/sys/devices/platform/smsc47m1.2048/driver",
> {st_mode=S_IFLNK|0777, st_size=0, ...}) = 0
> readlink("/sys/devices/platform/smsc47m1.2048/driver",
> "../../../bus/platform/drivers/smsc47m1", 256) = 38
> lstat64("/sys/devices/platform/smsc47m1.2048/subsystem",
> {st_mode=S_IFLNK|0777, st_size=0, ...}) = 0
> readlink("/sys/devices/platform/smsc47m1.2048/subsystem",
> "../../../bus/platform", 256) = 21
> lstat64("/sys/devices/platform/smsc47m1.2048/name",
> {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
> stat64("/sys/devices/platform/smsc47m1.2048/name",
> {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
> open("/sys/devices/platform/smsc47m1.2048/name", O_RDONLY) = 3
> read(3, "smsc47m2\n", 4096)             = 9
> close(3)                                = 0
> open("/sys/devices/platform/smsc47m1.2048",
> O_RDONLY|O_NONBLOCK|O_LARGEFILE|O_DIRECTORY|0x80000) = 3
> fstat64(3, {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
> fcntl64(3, F_SETFD, FD_CLOEXEC)         = 0
> getdents(3, /* 15 entries */, 4096)     = 292
> lstat64("/sys/devices/platform/smsc47m1.2048/hwmon:hwmon0",
> {st_mode=S_IFLNK|0777, st_size=0, ...}) = 0
> lstat64("/sys/devices/platform/smsc47m1.2048/name",
> {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
> lstat64("/sys/devices/platform/smsc47m1.2048/alarms",
> {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
> stat64("/sys/devices/platform/smsc47m1.2048/alarms",
> {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
> open("/sys/devices/platform/smsc47m1.2048/alarms", O_RDONLY) = 4
> read(4, "1\n", 4096)                    = 2
> close(4)                                = 0
> lstat64("/sys/devices/platform/smsc47m1.2048/pwm2_enable",
> {st_mode=S_IFREG|0644, st_size@96, ...}) = 0
> stat64("/sys/devices/platform/smsc47m1.2048/pwm2_enable",
> {st_mode=S_IFREG|0644, st_size@96, ...}) = 0
> open("/sys/devices/platform/smsc47m1.2048/pwm2_enable", O_RDONLY) = 4
> read(4, "1\n", 4096)                    = 2
> close(4)                                = 0
> lstat64("/sys/devices/platform/smsc47m1.2048/pwm2",
> {st_mode=S_IFREG|0644, st_size@96, ...}) = 0
> stat64("/sys/devices/platform/smsc47m1.2048/pwm2",
> {st_mode=S_IFREG|0644, st_size@96, ...}) = 0
> open("/sys/devices/platform/smsc47m1.2048/pwm2", O_RDONLY) = 4
> read(4, "32\n", 4096)                   = 3
> close(4)                                = 0
> lstat64("/sys/devices/platform/smsc47m1.2048/pwm1_enable",
> {st_mode=S_IFREG|0644, st_size@96, ...}) = 0
> stat64("/sys/devices/platform/smsc47m1.2048/pwm1_enable",
> {st_mode=S_IFREG|0644, st_size@96, ...}) = 0
> open("/sys/devices/platform/smsc47m1.2048/pwm1_enable", O_RDONLY) = 4
> read(4, "1\n", 4096)                    = 2
> close(4)                                = 0
> lstat64("/sys/devices/platform/smsc47m1.2048/pwm1",
> {st_mode=S_IFREG|0644, st_size@96, ...}) = 0
> stat64("/sys/devices/platform/smsc47m1.2048/pwm1",
> {st_mode=S_IFREG|0644, st_size@96, ...}) = 0
> open("/sys/devices/platform/smsc47m1.2048/pwm1", O_RDONLY) = 4
> read(4, "32\n", 4096)                   = 3
> close(4)                                = 0
> lstat64("/sys/devices/platform/smsc47m1.2048/driver",
> {st_mode=S_IFLNK|0777, st_size=0, ...}) = 0
> lstat64("/sys/devices/platform/smsc47m1.2048/bus",
> {st_mode=S_IFLNK|0777, st_size=0, ...}) = 0
> lstat64("/sys/devices/platform/smsc47m1.2048/subsystem",
> {st_mode=S_IFLNK|0777, st_size=0, ...}) = 0
> lstat64("/sys/devices/platform/smsc47m1.2048/modalias",
> {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
> stat64("/sys/devices/platform/smsc47m1.2048/modalias",
> {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
> open("/sys/devices/platform/smsc47m1.2048/modalias", O_RDONLY) = 4
> read(4, "smsc47m1\n", 4096)             = 9
> close(4)                                = 0
> lstat64("/sys/devices/platform/smsc47m1.2048/power",
> {st_mode=S_IFDIR|0755, st_size=0, ...}) = 0
> lstat64("/sys/devices/platform/smsc47m1.2048/uevent",
> {st_mode=S_IFREG|0644, st_size@96, ...}) = 0
> stat64("/sys/devices/platform/smsc47m1.2048/uevent",
> {st_mode=S_IFREG|0644, st_size@96, ...}) = 0
> open("/sys/devices/platform/smsc47m1.2048/uevent", O_RDONLY) = 4
> read(4, "", 4096)                       = 0
> close(4)                                = 0

OK, this is your hardware monitoring chip. The "problem" is that the
driver only created fan speed _control_ files (pwm*) and no speed
_monitoring_ files (fan*). This is why libsensors doesn't recognize it.

The SMSC LPC47M292 features can be individually disabled (the pins can
be used for alternate functions). It seems that this is the case for
you. If you can rebuild the smsc47m1 driver with
CONFIG_HWMON_DEBUG_CHIP=y it should tell you about disabled features.

It is possible that there is a bug in the driver. After all I only
added LPC47M292 support recently, it did not get much testing yet. If
you send me a dump of your chip (use isadump -f 2048 128) I can
double-check. But it could also be that your system is not wired for
fan speed monitoring. Do you have any reason to believe that it is? Is
it documented by the manufacturer? Does your BIOS display fan speed
values?

As long as you don't get fan speed monitoring to work, I suggest that
you don't play with the fan speed control features (if they are wired
at all...) Changing the fan speeds with no way to validate these
changes sounds a bit dangerous.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

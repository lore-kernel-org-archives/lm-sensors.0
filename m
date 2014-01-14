From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 14 Jan 2014 13:54:51 +0000
Subject: Re: [lm-sensors] Sensors shows only 8 of 10 cores on 4-Socket Intel(R) Xeon(R) CPU E7- 4850 machine
Message-Id: <20140114145451.256bcc4c@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAGz0_-0VUOd_-SAncqUY99CBPLmRVuMV98aiedpqwd9jGqOv1Q@mail.gmail.com>
In-Reply-To: <CAGz0_-0VUOd_-SAncqUY99CBPLmRVuMV98aiedpqwd9jGqOv1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Andreas,

On Tue, 14 Jan 2014 14:34:15 +0100, Andreas Hollmann wrote:
> 2014/1/14 Jean Delvare <khali@linux-fr.org>:
> > Please also provide the output of:
> > $ strace sensors "coretemp-isa-0000"
>
> (...)
> openat(AT_FDCWD, "/sys/class/hwmon/hwmon0/device", O_RDONLY|O_NONBLOCK|O_DIRECTORY|O_CLOEXEC) = 4
> brk(0x652000)                           = 0x652000
> getdents(4, /* 59 entries */, 32768)    = 1944
> stat("/sys/class/hwmon/hwmon0/device/temp2_input", {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
> stat("/sys/class/hwmon/hwmon0/device/temp2_max", {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
> stat("/sys/class/hwmon/hwmon0/device/temp2_crit", {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
> stat("/sys/class/hwmon/hwmon0/device/temp2_crit_alarm", {st_mode=S_IFREG|0444, st_size@96, ...}) = 0

I'm reordering the entries to make it easier to read... This is Core 0.

> stat("/sys/class/hwmon/hwmon0/device/temp3_input", {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
> stat("/sys/class/hwmon/hwmon0/device/temp3_max", {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
> stat("/sys/class/hwmon/hwmon0/device/temp3_crit", {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
> stat("/sys/class/hwmon/hwmon0/device/temp3_crit_alarm", {st_mode=S_IFREG|0444, st_size@96, ...}) = 0

This is Core 1.

> stat("/sys/class/hwmon/hwmon0/device/temp4_input", {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
> stat("/sys/class/hwmon/hwmon0/device/temp4_max", {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
> stat("/sys/class/hwmon/hwmon0/device/temp4_crit", {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
> stat("/sys/class/hwmon/hwmon0/device/temp4_crit_alarm", {st_mode=S_IFREG|0444, st_size@96, ...}) = 0

This is Core 2.

> stat("/sys/class/hwmon/hwmon0/device/temp10_input", {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
> stat("/sys/class/hwmon/hwmon0/device/temp10_max", {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
> stat("/sys/class/hwmon/hwmon0/device/temp10_crit", {st_mode=S_IFREG|0444, st_size@96, ...}) = 0

This is Core 8, alarm flag is missing.

> stat("/sys/class/hwmon/hwmon0/device/temp11_input", {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
> stat("/sys/class/hwmon/hwmon0/device/temp11_max", {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
> stat("/sys/class/hwmon/hwmon0/device/temp11_crit", {st_mode=S_IFREG|0444, st_size@96, ...}) = 0

This is Core 9, alarm flag is missing.

> stat("/sys/class/hwmon/hwmon0/device/temp18_input", {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
> stat("/sys/class/hwmon/hwmon0/device/temp18_max", {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
> stat("/sys/class/hwmon/hwmon0/device/temp18_crit", {st_mode=S_IFREG|0444, st_size@96, ...}) = 0

This is Core 16, alarm flag is missing.

> stat("/sys/class/hwmon/hwmon0/device/temp19_input", {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
> stat("/sys/class/hwmon/hwmon0/device/temp19_max", {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
> stat("/sys/class/hwmon/hwmon0/device/temp19_crit", {st_mode=S_IFREG|0444, st_size@96, ...}) = 0

This is Core 17, alarm flag is missing.

> stat("/sys/class/hwmon/hwmon0/device/temp20_input", {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
> stat("/sys/class/hwmon/hwmon0/device/temp20_max", {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
> stat("/sys/class/hwmon/hwmon0/device/temp20_crit", {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
> getdents(4, /* 0 entries */, 32768)     = 0
> close(4)                                = 0

This is Core 18, alarm flag is missing.

This matches the output of sensors, but raises two questions:
1* Why are the alarm flags missing for 5 inputs?
2* getdents says 59 entries, but the above are only 27. Even adding 2
for . and .. and 8 for the label files, we're only at 37. So there must
be more files to read than libsensors is actually reading - presumably
your two missing cores are there.

So please provide the output of:

$ ls -l /sys/devices/platform/coretemp.0

I suspect this constant in libsensors is causing the problem:

#define MAX_SENSORS_PER_TYPE	24

The library assumes linear numbering, so anything beyond temp23 would
be ignored, which I suspect is the problem here.

This however doesn't explain the missing alarm files. I'm curious if
the "ls" command above will show them.

I would also like to see the output of:

$ grep '^\(processor\|core id\)' /proc/cpuinfo

-- 
Jean Delvare
http://jdelvare.nerim.net/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

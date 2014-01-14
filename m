From: Andreas Hollmann <hollmann@in.tum.de>
Date: Tue, 14 Jan 2014 14:09:36 +0000
Subject: Re: [lm-sensors] Sensors shows only 8 of 10 cores on 4-Socket Intel(R) Xeon(R) CPU E7- 4850 machine
Message-Id: <CAGz0_-24NJj9BpkiW+3hpT2n4+_XLw+T0SxZP_xw3pNt74JzHQ@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAGz0_-0VUOd_-SAncqUY99CBPLmRVuMV98aiedpqwd9jGqOv1Q@mail.gmail.com>
In-Reply-To: <CAGz0_-0VUOd_-SAncqUY99CBPLmRVuMV98aiedpqwd9jGqOv1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks for your quick response.


Here is the requested output and if there is anything missing I willy reply as
quick as possible.

[hollmann@inwest ~]$ ls -l /sys/devices/platform/coretemp.0
total 0
lrwxrwxrwx 1 root root    0 Jan 14 15:05 driver ->
../../../bus/platform/drivers/coretemp
drwxr-xr-x 3 root root    0 Jan 10 18:51 hwmon
-r--r--r-- 1 root root 4096 Jan 14 14:43 modalias
-r--r--r-- 1 root root 4096 Jan 10 18:51 name
drwxr-xr-x 2 root root    0 Jan 14 11:54 power
lrwxrwxrwx 1 root root    0 Jan 10 18:51 subsystem -> ../../../bus/platform
-r--r--r-- 1 root root 4096 Jan 10 18:51 temp10_crit
-r--r--r-- 1 root root 4096 Jan 14 14:43 temp10_crit_alar
-r--r--r-- 1 root root 4096 Jan 10 18:51 temp10_input
-r--r--r-- 1 root root 4096 Jan 13 15:42 temp10_label
-r--r--r-- 1 root root 4096 Jan 10 18:51 temp10_max
-r--r--r-- 1 root root 4096 Jan 10 18:51 temp11_crit
-r--r--r-- 1 root root 4096 Jan 14 14:43 temp11_crit_alar
-r--r--r-- 1 root root 4096 Jan 10 18:51 temp11_input
-r--r--r-- 1 root root 4096 Jan 13 15:42 temp11_label
-r--r--r-- 1 root root 4096 Jan 10 18:51 temp11_max
-r--r--r-- 1 root root 4096 Jan 10 18:51 temp18_crit
-r--r--r-- 1 root root 4096 Jan 14 14:43 temp18_crit_alar
-r--r--r-- 1 root root 4096 Jan 10 18:51 temp18_input
-r--r--r-- 1 root root 4096 Jan 13 15:42 temp18_label
-r--r--r-- 1 root root 4096 Jan 10 18:51 temp18_max
-r--r--r-- 1 root root 4096 Jan 10 18:51 temp19_crit
-r--r--r-- 1 root root 4096 Jan 14 14:43 temp19_crit_alar
-r--r--r-- 1 root root 4096 Jan 10 18:51 temp19_input
-r--r--r-- 1 root root 4096 Jan 13 15:42 temp19_label
-r--r--r-- 1 root root 4096 Jan 10 18:51 temp19_max
-r--r--r-- 1 root root 4096 Jan 10 18:51 temp20_crit
-r--r--r-- 1 root root 4096 Jan 14 14:43 temp20_crit_alar
-r--r--r-- 1 root root 4096 Jan 10 18:51 temp20_input
-r--r--r-- 1 root root 4096 Jan 13 15:42 temp20_label
-r--r--r-- 1 root root 4096 Jan 10 18:51 temp20_max
-r--r--r-- 1 root root 4096 Jan 14 14:43 temp26_crit
-r--r--r-- 1 root root 4096 Jan 14 14:43 temp26_crit_alar
-r--r--r-- 1 root root 4096 Jan 14 14:43 temp26_input
-r--r--r-- 1 root root 4096 Jan 14 14:43 temp26_label
-r--r--r-- 1 root root 4096 Jan 14 14:43 temp26_max
-r--r--r-- 1 root root 4096 Jan 14 14:43 temp27_crit
-r--r--r-- 1 root root 4096 Jan 14 14:43 temp27_crit_alar
-r--r--r-- 1 root root 4096 Jan 14 14:43 temp27_input
-r--r--r-- 1 root root 4096 Jan 14 14:43 temp27_label
-r--r--r-- 1 root root 4096 Jan 14 14:43 temp27_max
-r--r--r-- 1 root root 4096 Jan 10 18:51 temp2_crit
-r--r--r-- 1 root root 4096 Jan 10 18:51 temp2_crit_alarm
-r--r--r-- 1 root root 4096 Jan 10 18:51 temp2_input
-r--r--r-- 1 root root 4096 Jan 13 15:42 temp2_label
-r--r--r-- 1 root root 4096 Jan 10 18:51 temp2_max
-r--r--r-- 1 root root 4096 Jan 10 18:51 temp3_crit
-r--r--r-- 1 root root 4096 Jan 10 18:51 temp3_crit_alarm
-r--r--r-- 1 root root 4096 Jan 10 18:51 temp3_input
-r--r--r-- 1 root root 4096 Jan 13 15:42 temp3_label
-r--r--r-- 1 root root 4096 Jan 10 18:51 temp3_max
-r--r--r-- 1 root root 4096 Jan 10 18:51 temp4_crit
-r--r--r-- 1 root root 4096 Jan 10 18:51 temp4_crit_alarm
-r--r--r-- 1 root root 4096 Jan 10 18:51 temp4_input
-r--r--r-- 1 root root 4096 Jan 13 15:42 temp4_label
-r--r--r-- 1 root root 4096 Jan 10 18:51 temp4_max
-rw-r--r-- 1 root root 4096 Jan 10 18:51 uevent

[hollmann@inwest ~]$ grep '^\(processor\|core id\)' /proc/cpuinfo
processor       : 0
core id         : 0
processor       : 1
core id         : 1
processor       : 2
core id         : 2
processor       : 3
core id         : 8
processor       : 4
core id         : 9
processor       : 5
core id         : 16
processor       : 6
core id         : 17
processor       : 7
core id         : 18
processor       : 8
core id         : 24
processor       : 9
core id         : 25
processor       : 10
core id         : 0
processor       : 11
core id         : 1
processor       : 12
core id         : 2
processor       : 13
core id         : 8
processor       : 14
core id         : 9
processor       : 15
core id         : 16
processor       : 16
core id         : 17
processor       : 17
core id         : 18
processor       : 18
core id         : 24
processor       : 19
core id         : 25
processor       : 20
core id         : 0
processor       : 21
core id         : 1
processor       : 22
core id         : 2
processor       : 23
core id         : 8
processor       : 24
core id         : 9
processor       : 25
core id         : 16
processor       : 26
core id         : 17
processor       : 27
core id         : 18
processor       : 28
core id         : 24
processor       : 29
core id         : 25
processor       : 30
core id         : 0
processor       : 31
core id         : 1
processor       : 32
core id         : 2
processor       : 33
core id         : 8
processor       : 34
core id         : 9
processor       : 35
core id         : 16
processor       : 36
core id         : 17
processor       : 37
core id         : 18
processor       : 38
core id         : 24
processor       : 39
core id         : 25
processor       : 40
core id         : 0
processor       : 41
core id         : 1
processor       : 42
core id         : 2
processor       : 43
core id         : 8
processor       : 44
core id         : 9
processor       : 45
core id         : 16
processor       : 46
core id         : 17
processor       : 47
core id         : 18
processor       : 48
core id         : 24
processor       : 49
core id         : 25
processor       : 50
core id         : 0
processor       : 51
core id         : 1
processor       : 52
core id         : 2
processor       : 53
core id         : 8
processor       : 54
core id         : 9
processor       : 55
core id         : 16
processor       : 56
core id         : 17
processor       : 57
core id         : 18
processor       : 58
core id         : 24
processor       : 59
core id         : 25
processor       : 60
core id         : 0
processor       : 61
core id         : 1
processor       : 62
core id         : 2
processor       : 63
core id         : 8
processor       : 64
core id         : 9
processor       : 65
core id         : 16
processor       : 66
core id         : 17
processor       : 67
core id         : 18
processor       : 68
core id         : 24
processor       : 69
core id         : 25
processor       : 70
core id         : 0
processor       : 71
core id         : 1
processor       : 72
core id         : 2
processor       : 73
core id         : 8
processor       : 74
core id         : 9
processor       : 75
core id         : 16
processor       : 76
core id         : 17
processor       : 77
core id         : 18
processor       : 78
core id         : 24
processor       : 79
core id         : 25
[hollmann@inwest ~]$

2014/1/14 Jean Delvare <khali@linux-fr.org>:
> Hi Andreas,
>
> On Tue, 14 Jan 2014 14:34:15 +0100, Andreas Hollmann wrote:
>> 2014/1/14 Jean Delvare <khali@linux-fr.org>:
>> > Please also provide the output of:
>> > $ strace sensors "coretemp-isa-0000"
>>
>> (...)
>> openat(AT_FDCWD, "/sys/class/hwmon/hwmon0/device", O_RDONLY|O_NONBLOCK|O_DIRECTORY|O_CLOEXEC) = 4
>> brk(0x652000)                           = 0x652000
>> getdents(4, /* 59 entries */, 32768)    = 1944
>> stat("/sys/class/hwmon/hwmon0/device/temp2_input", {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
>> stat("/sys/class/hwmon/hwmon0/device/temp2_max", {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
>> stat("/sys/class/hwmon/hwmon0/device/temp2_crit", {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
>> stat("/sys/class/hwmon/hwmon0/device/temp2_crit_alarm", {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
>
> I'm reordering the entries to make it easier to read... This is Core 0.
>
>> stat("/sys/class/hwmon/hwmon0/device/temp3_input", {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
>> stat("/sys/class/hwmon/hwmon0/device/temp3_max", {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
>> stat("/sys/class/hwmon/hwmon0/device/temp3_crit", {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
>> stat("/sys/class/hwmon/hwmon0/device/temp3_crit_alarm", {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
>
> This is Core 1.
>
>> stat("/sys/class/hwmon/hwmon0/device/temp4_input", {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
>> stat("/sys/class/hwmon/hwmon0/device/temp4_max", {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
>> stat("/sys/class/hwmon/hwmon0/device/temp4_crit", {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
>> stat("/sys/class/hwmon/hwmon0/device/temp4_crit_alarm", {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
>
> This is Core 2.
>
>> stat("/sys/class/hwmon/hwmon0/device/temp10_input", {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
>> stat("/sys/class/hwmon/hwmon0/device/temp10_max", {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
>> stat("/sys/class/hwmon/hwmon0/device/temp10_crit", {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
>
> This is Core 8, alarm flag is missing.
>
>> stat("/sys/class/hwmon/hwmon0/device/temp11_input", {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
>> stat("/sys/class/hwmon/hwmon0/device/temp11_max", {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
>> stat("/sys/class/hwmon/hwmon0/device/temp11_crit", {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
>
> This is Core 9, alarm flag is missing.
>
>> stat("/sys/class/hwmon/hwmon0/device/temp18_input", {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
>> stat("/sys/class/hwmon/hwmon0/device/temp18_max", {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
>> stat("/sys/class/hwmon/hwmon0/device/temp18_crit", {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
>
> This is Core 16, alarm flag is missing.
>
>> stat("/sys/class/hwmon/hwmon0/device/temp19_input", {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
>> stat("/sys/class/hwmon/hwmon0/device/temp19_max", {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
>> stat("/sys/class/hwmon/hwmon0/device/temp19_crit", {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
>
> This is Core 17, alarm flag is missing.
>
>> stat("/sys/class/hwmon/hwmon0/device/temp20_input", {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
>> stat("/sys/class/hwmon/hwmon0/device/temp20_max", {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
>> stat("/sys/class/hwmon/hwmon0/device/temp20_crit", {st_mode=S_IFREG|0444, st_size@96, ...}) = 0
>> getdents(4, /* 0 entries */, 32768)     = 0
>> close(4)                                = 0
>
> This is Core 18, alarm flag is missing.
>
> This matches the output of sensors, but raises two questions:
> 1* Why are the alarm flags missing for 5 inputs?
> 2* getdents says 59 entries, but the above are only 27. Even adding 2
> for . and .. and 8 for the label files, we're only at 37. So there must
> be more files to read than libsensors is actually reading - presumably
> your two missing cores are there.
>
> So please provide the output of:
>
> $ ls -l /sys/devices/platform/coretemp.0
>
> I suspect this constant in libsensors is causing the problem:
>
> #define MAX_SENSORS_PER_TYPE    24
>
> The library assumes linear numbering, so anything beyond temp23 would
> be ignored, which I suspect is the problem here.
>
> This however doesn't explain the missing alarm files. I'm curious if
> the "ls" command above will show them.
>
> I would also like to see the output of:
>
> $ grep '^\(processor\|core id\)' /proc/cpuinfo
>
> --
> Jean Delvare
> http://jdelvare.nerim.net/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

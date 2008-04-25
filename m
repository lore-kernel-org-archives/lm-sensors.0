From: "=?UTF-8?Q?Alessandro_Calor=C3=AC?=" <axelgenus@gmail.com>
Date: Fri, 25 Apr 2008 08:51:26 +0000
Subject: [lm-sensors] VIA VT1211
Message-Id: <eeb7df810804250151n93dcd2ds5112e8cf9c5e199e@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi guys,

I bought a VIA VB7001G which implements the VT1211 monitoring chip.
I'm having a couple of problems.

1) the CPU temperature isn't realistic (~ -70 °C). I tried the various
computation available in the configuration file but my CPU isn't in
the list!

# cat /proc/cpuinfo
processor       : 0
vendor_id       : CentaurHauls
cpu family      : 6
model           : 10
model name      : VIA Esther processor 1500MHz
stepping        : 9
cpu MHz         : 1496.279
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic mtrr pge
cmov pat clflush acpi mmx fxsr sse sse2 tm nx pni tm2 rng rng_en ace
ace_en ace2 ace2_en phe phe_en pmm pmm_en
bogomips        : 2996.78
clflush size    : 64

# cat /sys/devices/platform/vt1211.24576/temp1_input
39000

BTW, the other sensor (Internal temperature) does seem to work
correctly (I read that it's scaled by the chip itself). I also tried
to read ACPI thermal zone but it's always -245 °C.

2) the fan speed control doesn't work. Ok, lm-sensors can't control
the fan speed manually but I can't even change the values in
/sys/devices/platform/vt1211.24576/pwm[1-2]_auto_point[1-4]_[temp-pwm].
Those values are always 0 for the temperatures and 255 for the pwm.

Anyone can help me?

Thanks, Alessandro.
_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

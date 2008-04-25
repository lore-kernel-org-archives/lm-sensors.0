From: "Juerg Haefliger" <juergh@gmail.com>
Date: Fri, 25 Apr 2008 22:21:50 +0000
Subject: Re: [lm-sensors] VIA VT1211
Message-Id: <191fb4ca0804251521h6d87877cv156bab3f22aab859@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <eeb7df810804250151n93dcd2ds5112e8cf9c5e199e@mail.gmail.com>
In-Reply-To: <eeb7df810804250151n93dcd2ds5112e8cf9c5e199e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Alessandro,


> Hi guys,
>
>  I bought a VIA VB7001G which implements the VT1211 monitoring chip.
>  I'm having a couple of problems.
>
>  1) the CPU temperature isn't realistic (~ -70 =B0C). I tried the various
>  computation available in the configuration file but my CPU isn't in
>  the list!

What's wrong with 70C? :-) That's still within spec. Does the board
have a CPU fan?


>  # cat /proc/cpuinfo
>  processor       : 0
>  vendor_id       : CentaurHauls
>  cpu family      : 6
>  model           : 10
>  model name      : VIA Esther processor 1500MHz
>  stepping        : 9
>  cpu MHz         : 1496.279
>  cache size      : 128 KB
>  fdiv_bug        : no
>  hlt_bug         : no
>  f00f_bug        : no
>  coma_bug        : no
>  fpu             : yes
>  fpu_exception   : yes
>  cpuid level     : 1
>  wp              : yes
>  flags           : fpu vme de pse tsc msr pae mce cx8 apic mtrr pge
>  cmov pat clflush acpi mmx fxsr sse sse2 tm nx pni tm2 rng rng_en ace
>  ace_en ace2 ace2_en phe phe_en pmm pmm_en
>  bogomips        : 2996.78
>  clflush size    : 64

There is no info available for Esther from VIA. Or I couldn't find it.


>  # cat /sys/devices/platform/vt1211.24576/temp1_input
>  39000

Can you please send the output of 'grep ""
/sys/devices/platform/vt1211*/*' and the full output of 'sensors'?


>  BTW, the other sensor (Internal temperature) does seem to work
>  correctly (I read that it's scaled by the chip itself). I also tried
>  to read ACPI thermal zone but it's always -245 =B0C.
>
>  2) the fan speed control doesn't work. Ok, lm-sensors can't control
>  the fan speed manually but I can't even change the values in
>  /sys/devices/platform/vt1211.24576/pwm[1-2]_auto_point[1-4]_[temp-pwm].
>  Those values are always 0 for the temperatures and 255 for the pwm.

VIA is known to not use the fan control feature of the VT1211 on its
EPIA boards. You might be out of luck. But send the requested info and
we'll go from there.

...juerg


>  Anyone can help me?
>
>  Thanks, Alessandro.
>  _______________________________________________
>  lm-sensors mailing list
>  lm-sensors@lm-sensors.org
>  http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

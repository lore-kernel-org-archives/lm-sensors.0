From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 20 Jun 2012 18:48:16 +0000
Subject: Re: [lm-sensors] Lifebook E8020, no sensors
Message-Id: <20120620204816.00a5063d@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4FE0EE87.8080806@gmx.de>
In-Reply-To: <4FE0EE87.8080806@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 20 Jun 2012 18:40:05 +0200, Michael Markusch wrote:
> Hi Jean,
> 
> thank you for your answer!
> 
> >> I'm not sure. Please try:
> >> * The latest version of sensors-detect:
> >>   http://dl.lm-sensors.org/lm-sensors/files/sensors-detect
> >> * Loading the coretemp driver manually even if sensors-detect did not
> >>   recommend it.
> 
> I tried this steps, but it doesn't work.
> 
> >> If that doesn't work, please provide the contents of /proc/cpuinfo.
> 
> processor	: 0
> vendor_id	: GenuineIntel
> cpu family	: 6
> model		: 13
> model name	: Intel(R) Pentium(R) M processor 2.00GHz
> stepping	: 8
> microcode	: 0x20
> cpu MHz		: 2000.000
> cache size	: 2048 KB
> fdiv_bug	: no
> hlt_bug		: no
> f00f_bug	: no
> coma_bug	: no
> fpu		: yes
> fpu_exception	: yes
> cpuid level	: 2

Ah, got it. Detection requires cpuid level >= 6, that's why both
sensors-detect and the coretemp driver skip this CPU.

> wp		: yes
> flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
> clflush dts acpi mmx fxsr sse sse2 ss tm pbe nx up bts est tm2

Furthermore, we have a kernel flaw. Two different CPU features are
reported as "dts" here: Debug Store (which your CPU has) and Digital
Thermal Sensor (which it does not.) Not sure why "dts" was used instead
of just "ds" for the former... Maybe an old version of the CPUID
document used a different name.

Bottom line is that I don't think this CPU is supported by the coretemp
driver (which matches my memory that model 14 was the first one with
the DTS feature.) So if you ever saw a temperature reported on this
machine, that must have been through a different means (no idea which
one sorry). Or maybe you're confusing with a different machine.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 04 Jun 2011 11:08:18 +0000
Subject: Re: [lm-sensors] sensor details for W83627HG-AW
Message-Id: <20110604130818.5386d0c4@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <838315.8004.qm@web95806.mail.in.yahoo.com>
In-Reply-To: <838315.8004.qm@web95806.mail.in.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

Hi Krunal,

On Fri, 3 Jun 2011 11:31:32 +0530 (IST), krunal patel wrote:
> I am trying to run lm-sensor on my machine. It is having W83627HG-AW chip.
> I am using linux-2.6.27.45.=20
> Module loaded are hwmon, hwmon-vid, w83627hf. I am getting error in dmesg=
 as=20
>=20
> w83627hf: Found W83627HF chip at 0x290
> hwmon-vid: Unknown VRM version of your x86 CPU

Indeed we don't know yet the VID conversion table for this CPU
family/model. I looked at the VIA website but couldn't find a public
datasheet for it.

> output of cpuinfo:
> # cat /proc/cpuinfo=20
> processor=A0=A0=A0=A0=A0=A0 : 0
> vendor_id=A0=A0=A0=A0=A0=A0 : CentaurHauls
> cpu family=A0=A0=A0=A0=A0 : 6
> model=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 : 13
> model name=A0=A0=A0=A0=A0 : VIA Eden Processor=A0 500MHz
> stepping=A0=A0=A0=A0=A0=A0=A0 : 0
> cpu MHz=A0=A0=A0=A0=A0=A0=A0=A0 : 499.938
> cache size=A0=A0=A0=A0=A0 : 128 KB
> fdiv_bug=A0=A0=A0=A0=A0=A0=A0 : no
> hlt_bug=A0=A0=A0=A0=A0=A0=A0=A0 : no
> f00f_bug=A0=A0=A0=A0=A0=A0=A0 : no
> coma_bug=A0=A0=A0=A0=A0=A0=A0 : no
> fpu=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 : yes
> fpu_exception=A0=A0 : yes
> cpuid level=A0=A0=A0=A0 : 1
> wp=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 : yes
> flags=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 : fpu vme de pse tsc msr pae mce cx8 =
apic sep mtrr pge cmov pat clflush acpi mmx fxsr sse sse2 tm nx pni est tm2=
 xtpr rng rng_en ace ace_en ace2 ace2_en phe phe_en pmm pmm_en
> bogomips=A0=A0=A0=A0=A0=A0=A0 : 999.87
> clflush size=A0=A0=A0 : 64
> power management:

Brilly, Kary, can you help us here, please? Where can we get the VID pin
codes -> Vcore voltage conversion table for VIA CPU family 6, model 13?
This is needed to update drivers/hwmon/hwmon-vid.c.

Thanks,
--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

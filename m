From: udovdh@xs4all.nl (Udo van den Heuvel)
Date: Sun, 25 Feb 2007 17:02:50 +0000
Subject: [lm-sensors] hwmon-vid: Unknown VRM version of your x86 CPU
Message-Id: <45E1C13A.2020506@xs4all.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <43834A86.6090205@sh.cvut.cz>
In-Reply-To: <43834A86.6090205@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

Same problem as some time ago when
Rudolf Marek wrote:
> Please apply it and see the system log for result. (and of course mail it back)

I now have a VIA Epia EN12000 which shows in dmesg:

hwmon-vid: Unknown VRM version of your x86 CPU

# cat /proc/cpuinfo
processor       : 0
vendor_id       : CentaurHauls
cpu family      : 6
model           : 10
model name      : VIA Esther processor 1200MHz
stepping        : 9
cpu MHz         : 1197.098
cache size      : 128 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
cmov pat clflush acpi mmx fxsr sse sse2 tm pni est tm2 rng rng_en ace
ace_en ace2 ace2_en phe phe_en pmm pmm_en
bogomips        : 2396.86
clflush size    : 64


Need more info?

Thanks in advance!

Kind regards,
Udo


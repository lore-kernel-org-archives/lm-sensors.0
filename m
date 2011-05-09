From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 09 May 2011 20:07:10 +0000
Subject: Re: [lm-sensors] Will there ever be EMC6w201 support?
Message-Id: <20110509220710.5aa0812f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110414034609.476411A9866@localhost.localdomain>
In-Reply-To: <20110414034609.476411A9866@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 09 May 2011 13:50:41 -0600, Harry G McGavran Jr wrote:
> On Mon, 9 May 2011 21:42:31 +0200 Jean Delvare wrote:
> > This is a valuable observation. I presume that these CPUs are too old
> > to be multicore, best they could have it hyperthreading. Harry, can you
> > please share the contents of /proc/cpuinfo?
> 
> Attached below ...

processor	: 0
vendor_id	: GenuineIntel
cpu family	: 15
model		: 4
model name	: Intel(R) Xeon(TM) CPU 3.00GHz
stepping	: 10
cpu MHz		: 2992.603
cache size	: 2048 KB
physical id	: 0
siblings	: 1
core id		: 0
cpu cores	: 1
apicid		: 0
initial apicid	: 0
fpu		: yes
fpu_exception	: yes
cpuid level	: 5
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx lm constant_tsc up pebs bts pni dtes64 monitor ds_cpl cid cx16 xtpr lahf_lm
bogomips	: 5985.20
clflush size	: 64
cache_alignment	: 128
address sizes	: 36 bits physical, 48 bits virtual
power management:

Interesting... Your CPU is slightly more recent than Jeff's (stepping
10 instead of 1), both advertise HT but yours has it disabled. Maybe
there's an option in the BIOS to enable or disable HT? Or maybe Linux
didn't like HT for some reason (in which case it should say so in the
boot messages.)

It also seems like Jeff has CPUfreq enabled on his system and you do
not. It's unrelated to hardware monitoring, but for the sake of power
savings, it might be worth investigating.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

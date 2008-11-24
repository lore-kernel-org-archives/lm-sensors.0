From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 24 Nov 2008 12:15:00 +0000
Subject: Re: [lm-sensors] Gigabyte GA-MA69G-S3H it8716 temperatures?
Message-Id: <20081124131500.148ec964@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <d76c7b8f0811240127y1e8d1f5etdc5dd76fd0b5b29@mail.gmail.com>
In-Reply-To: <d76c7b8f0811240127y1e8d1f5etdc5dd76fd0b5b29@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jon,

On Mon, 24 Nov 2008 10:15:12 +0000, Jon Hewer wrote:
> I've just tried running two "md5sum /dev/zero" commands in parallel.
> After about 30 seconds or so temp2 increased from 25 to 31 and temp3
> from 19 to 28.  I suppose this along with your comment about thermal
> diode measurement type suggests temp3 is my CPU temp.

Indeed. And temp2 isn't fake as I first thought, which is good news.

> My CPU isn't water cooled, however it is an Athlon X2 4450e which is
> meant to run pretty cool, and I've also upgraded to a better heatsink
> than the retail one.
> 
> After building my server I did check the temperatures in the BIOS,
> which returned a temperature of about 26 degrees or so for the CPU.  I
> don't have a monitor hooked up to my server at the moment, but might
> do so to check the BIOS again now that I have the lm-sensors output
> for comparison.
> 
> As requested, here is the contents of /proc/cpuinfo
> 
> $ cat /proc/cpuinfo
> processor	: 0
> vendor_id	: AuthenticAMD
> cpu family	: 15
> model		: 107
> model name	: AMD Processor model unknown
> stepping	: 2
> cpu MHz		: 2305.229
> cache size	: 512 KB
> physical id	: 0
> siblings	: 2
> core id		: 0
> cpu cores	: 2
> apicid		: 0
> initial apicid	: 0
> fpu		: yes
> fpu_exception	: yes
> cpuid level	: 1
> wp		: yes
> flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
> pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
> rdtscp lm 3dnowext 3dnow rep_good pni cx16 lahf_lm cmp_legacy svm
> extapic cr8_legacy 3dnowprefetch
> bogomips	: 4614.17
> TLB size	: 1024 4K pages
> clflush size	: 64
> cache_alignment	: 64
> address sizes	: 40 bits physical, 48 bits virtual
> power management: ts fid vid ttp tm stc 100mhzsteps
> 
> processor	: 1
> vendor_id	: AuthenticAMD
> cpu family	: 15
> model		: 107
> model name	: AMD Processor model unknown
> stepping	: 2
> cpu MHz		: 2305.229
> cache size	: 512 KB
> physical id	: 0
> siblings	: 2
> core id		: 1
> cpu cores	: 2
> apicid		: 1
> initial apicid	: 1
> fpu		: yes
> fpu_exception	: yes
> cpuid level	: 1
> wp		: yes
> flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
> pat pse36 clflush mmx fxsr sse sse2 ht syscall nx mmxext fxsr_opt
> rdtscp lm 3dnowext 3dnow rep_good pni cx16 lahf_lm cmp_legacy svm
> extapic cr8_legacy 3dnowprefetch
> bogomips	: 4610.51
> TLB size	: 1024 4K pages
> clflush size	: 64
> cache_alignment	: 64
> address sizes	: 40 bits physical, 48 bits virtual
> power management: ts fid vid ttp tm stc 100mhzsteps

Thanks, I've added this data point to my collection.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

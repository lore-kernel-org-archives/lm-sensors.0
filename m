From: Harry G McGavran Jr <w5pny@w5pny.com>
Date: Mon, 09 May 2011 19:50:41 +0000
Subject: Re: [lm-sensors] Will there ever be EMC6w201 support?
Message-Id: <20110509195041.4D03D1A987F@localhost.localdomain>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="==_Exmh_1304970638_16180"
List-Id: <lm-sensors.vger.kernel.org>
References: <20110414034609.476411A9866@localhost.localdomain>
In-Reply-To: <20110414034609.476411A9866@localhost.localdomain>
To: lm-sensors@vger.kernel.org

This is a multipart MIME message.

--==_Exmh_1304970638_16180
Content-Type: text/plain; charset=us-ascii

On Mon, 9 May 2011 21:42:31 +0200 Jean Delvare wrote:
> Hi Jeff,
> 
> On Sun, 08 May 2011 22:32:16 -0500, Jeff Rickman wrote:
> > What Harry's comments tell me is the original "i8k" code lacks 
> > appropriate code to operate in a SMP environment. I think the Console 
> > messages are trying to say that for "non-programmers" like myself.
> > 
> > Note these differences:
> > - Harry has a single CPU; I have 2 CPU.
> 
> This is a valuable observation. I presume that these CPUs are too old
> to be multicore, best they could have it hyperthreading. Harry, can you
> please share the contents of /proc/cpuinfo?

Attached below ...

> 
> Jeff, could you please try booting with parameter max_cpus=1? I wonder
> if it would make a difference. If it does, that would confirm your
> theory.
> 
> > - We both run the same Dell BIOS A07 code.
> > - Harry's Linux kernel is slightly older than my 2.6.35.12-90 Fedora code.
> > - I think we would all agree that Jean's changes do not cause my crash 
> > since that code works on Harry's machine but not on mine.
> > 
> > Time permitting, I will start doing the research to submit a properly 
> > documented bug against Fedora Core 14 regarding this code. I suspect 
> > this issue will also reside in FC15 so that is another point to check if 
> > time allows. jean raises the real question: does anyone in the Fedora 
> > team want to fix this?
> 
> I've seen this nug hit an openSUSE user (on a laptop with one
> multi-core CPU), so it's definitely not specific to Fedora. It may be
> related to the version of gcc used by the distribution though. If
> Fedora people aren't interested, we may open a bug on
> bugzilla.kernel.org instead.
> 
> > In closing, I agree with Harry: it is very nice to have some hardware 
> > monitoring in a Dell platform.
> 
> I'm glad you like it :)
> 
> -- 
> Jean Delvare
> http://khali.linux-fr.org/wishlist.html


--==_Exmh_1304970638_16180
Content-Type: text/plain ; name="cpuinfo.txt"; charset=us-ascii
Content-Description: cpuinfo.txt
Content-Disposition: attachment; filename="cpuinfo.txt"

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


--==_Exmh_1304970638_16180
Content-Type: text/plain; charset=us-ascii


Harry G. McGavran, Jr.

E-mail: w5pny@w5pny.com


--==_Exmh_1304970638_16180
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--==_Exmh_1304970638_16180--



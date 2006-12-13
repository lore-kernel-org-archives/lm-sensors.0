From: hpa@zytor.com (H. Peter Anvin)
Date: Wed, 13 Dec 2006 22:19:52 +0000
Subject: [lm-sensors] [RFC] new MSR r/w functions per CPU
Message-Id: <45807C88.6060807@zytor.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <45807469.6040609@assembler.cz> <20061213221026.GF2418@redhat.com>
In-Reply-To: <20061213221026.GF2418@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Dave Jones <davej@redhat.com>, Rudolf Marek <r.marek@assembler.cz>, hpa@zytor.com, norsk5@xmission.com, lkml <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>, bluesmoke-devel@lists.sourceforge.net

Dave Jones wrote:
> 
> Exposing the guts of the msr driver like that doesn't seem too clean.
> For in-kernel use, why not just add something like this..
> (note:not even compile tested)..
> 

Well, that *is* the guts of the MSR driver.

> void rdmsr_on_cpu(unsigned int cpu, unsigned long msr, unsigned long *lo, unsigned long *hi)
> {
>     cpumask_t oldmask;
> 
>     oldmask = current->cpus_allowed;
>     set_cpus_allowed(current, cpumask_of_cpu(cpu));
> 
> 	rdmsr(msr, &lo, &hi);
> 
>     set_cpus_allowed(current, oldmask);
> }
> 

[The above doesn't work, by the way.  This approach was discussed a long 
time ago, and vetoed due to the potential for deadlock.]

	-hpa


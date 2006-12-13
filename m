From: davej@redhat.com (Dave Jones)
Date: Wed, 13 Dec 2006 22:26:16 +0000
Subject: [lm-sensors] [RFC] new MSR r/w functions per CPU
Message-Id: <20061213222616.GJ2418@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <45807469.6040609@assembler.cz> <20061213221026.GF2418@redhat.com> <45807C88.6060807@zytor.com>
In-Reply-To: <45807C88.6060807@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Rudolf Marek <r.marek@assembler.cz>, norsk5@xmission.com, lkml <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>, bluesmoke-devel@lists.sourceforge.net

On Wed, Dec 13, 2006 at 02:19:52PM -0800, H. Peter Anvin wrote:

 > > void rdmsr_on_cpu(unsigned int cpu, unsigned long msr, unsigned long *lo, unsigned long *hi)
 > > {
 > >     cpumask_t oldmask;
 > > 
 > >     oldmask = current->cpus_allowed;
 > >     set_cpus_allowed(current, cpumask_of_cpu(cpu));
 > > 
 > > 	rdmsr(msr, &lo, &hi);
 > > 
 > >     set_cpus_allowed(current, oldmask);
 > > }
 > > 
 > 
 > [The above doesn't work, by the way.  This approach was discussed a long 
 > time ago, and vetoed due to the potential for deadlock.]

Can you explain this a little further? I'm fairly certain
there are places in the kernel already doing this (or similar).
In fact, I cut-n-pasted most of the above from similar code in the
powernow-k8 driver.  What exactly can we deadlock on?

		Dave

-- 
http://www.codemonkey.org.uk


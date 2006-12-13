From: davej@redhat.com (Dave Jones)
Date: Wed, 13 Dec 2006 22:10:26 +0000
Subject: [lm-sensors] [RFC] new MSR r/w functions per CPU
Message-Id: <20061213221026.GF2418@redhat.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <45807469.6040609@assembler.cz>
In-Reply-To: <45807469.6040609@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rudolf Marek <r.marek@assembler.cz>
Cc: hpa@zytor.com, norsk5@xmission.com, lkml <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>, bluesmoke-devel@lists.sourceforge.net

On Wed, Dec 13, 2006 at 10:45:13PM +0100, Rudolf Marek wrote:
 > Hello all,
 > 
 > For my new coretemp driver[1], I need to execute the rdmsr on particular 
 > processor.  There is no such "global" function for that in the kernel so far.
 > 
 > The per CPU msr_read and msr_write are used in following drivers:
 > 
 > msr.c (it is static there now)
 > k8-edac.c  (duplicated right now -> driver in -mm)
 > coretemp.c (my new Core temperature sensor -> driver [1])
 > 
 > Question is how make an access to that functions. Enclosed patch does simple 
 > EXPORT_SYMBOL_GPL for them, but then both drivers (k8-edac.c and coretemp.c) 
 > would depend on the MSR driver. The ultimate solution would be to move this type
 > of function to separate module, but perhaps this is just bit overkill?

Exposing the guts of the msr driver like that doesn't seem too clean.
For in-kernel use, why not just add something like this..
(note:not even compile tested)..

void rdmsr_on_cpu(unsigned int cpu, unsigned long msr, unsigned long *lo, unsigned long *hi)
{
    cpumask_t oldmask;

    oldmask = current->cpus_allowed;
    set_cpus_allowed(current, cpumask_of_cpu(cpu));

	rdmsr(msr, &lo, &hi);

    set_cpus_allowed(current, oldmask);
}


		Dave

-- 
http://www.codemonkey.org.uk


From: hpa@zytor.com (H. Peter Anvin)
Date: Wed, 13 Dec 2006 22:01:42 +0000
Subject: [lm-sensors] [RFC] new MSR r/w functions per CPU
Message-Id: <45807846.3010705@zytor.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <45807469.6040609@assembler.cz>
In-Reply-To: <45807469.6040609@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Rudolf Marek <r.marek@assembler.cz>
Cc: norsk5@xmission.com, lkml <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>, bluesmoke-devel@lists.sourceforge.net

Rudolf Marek wrote:
> Hello all,
> 
> For my new coretemp driver[1], I need to execute the rdmsr on particular 
> processor.  There is no such "global" function for that in the kernel so 
> far.
> 
> The per CPU msr_read and msr_write are used in following drivers:
> 
> msr.c (it is static there now)
> k8-edac.c  (duplicated right now -> driver in -mm)
> coretemp.c (my new Core temperature sensor -> driver [1])
> 
> Question is how make an access to that functions. Enclosed patch does 
> simple EXPORT_SYMBOL_GPL for them, but then both drivers (k8-edac.c and 
> coretemp.c) would depend on the MSR driver. The ultimate solution would 
> be to move this type
> of function to separate module, but perhaps this is just bit overkill?
> 
> Any ideas what would be the best solution?
> 

For now I think you could just export these and allow the dependency. 
I've been meaning to rewrite the MSR and CPUID drivers to use a common 
core, which would also allow invoking nnostandard CPUID and msrs which 
need the entire register file to be set; that should probably be 
included in that.

In fact, I've made that change something like four times (it seems to be 
an airplane project that I never get around to submitting), so I should 
actually get it finished and sent in.

	-hpa


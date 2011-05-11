From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 11 May 2011 19:03:02 +0000
Subject: Re: [lm-sensors] Will there ever be EMC6w201 support?
Message-Id: <20110511210302.22ffd227@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110414034609.476411A9866@localhost.localdomain>
In-Reply-To: <20110414034609.476411A9866@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 11 May 2011 14:43:35 +0200, Luca Tettamanti wrote:
> lahf is present in the assembly block inside the driver in i8k_smm; lahf
> moves the lowest byte of eflags into ah.
> Wikipedia[1] tells me that:
> 
>   Early AMD64 and Intel 64 CPUs lacked LAHF and SAHF instructions. AMD
>   introduced the instructions with their Athlon 64, Opteron and Turion 64
>   revision D processors in March 2005 while Intel introduced
>   the instructions with the Pentium 4 G1 stepping in December 2005.
> 
> Jeff's CPU does indeed lack lahf (see cpuinfo), so the driver should not
> unconditionally use the intruction.
> The driver should check X86_FEATURE_LAHF_LM or use use a different
> method to read EFLAFS (pushf?).

Thanks for the investigation, BTW... Brilliant!

> drivers/char/toshiba.c (tosh_smm) also suffers from the same issue.

That one currently depends on X86_32, which I seem to understand is
unaffected by the bug. But if this driver is ever extended to work on
64-bit machines, then yes, care will be needed.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

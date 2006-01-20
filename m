From: BGardner@Wabtec.com (BGardner@Wabtec.com)
Date: Fri, 20 Jan 2006 20:58:33 +0000
Subject: [lm-sensors] scx200_acb compilation breakage
Message-Id: <F06EB2894F3F0D45AD9BEA7246DE9C9002160B1B@WCSEXCMBS1.ad.wabtec.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060120210612.6bcb6e8e.khali@linux-fr.org>
In-Reply-To: <20060120210612.6bcb6e8e.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

The scx200/CS5535/etc only exist with/on the Geode processor, which is
x86.
So, I think the best option is to make it depend on X86.

Thank,
Ben

> -----Original Message-----
> From: Jean Delvare [mailto:khali at linux-fr.org] 
> Sent: Friday, January 20, 2006 2:06 PM
> To: Gardner, Ben
> Cc: LM Sensors
> Subject: scx200_acb compilation breakage
> 
> Hi Ben,
> 
> Andrew Morton is reporting scx200_acb compilation breakage on non-x86
> due to the use of asm/msr.h, which only i386 and x86_64 have. This is
> caused by your patch adding CS5535 support.
> 
> Now, how do we fix the problem?
> 
> First solution is to make the driver depend on X86. But are 
> there other
> architectures where this driver may be used? I'd guess not.
> 
> Second solution is to surround the CS5535 specific parts with #ifdef
> X86 so that the driver can still be compiled on other architectures.
> 
> Opinions?
> 
> Thanks,
> -- 
> Jean Delvare
> 
> 



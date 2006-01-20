From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 20 Jan 2006 20:06:12 +0000
Subject: [lm-sensors] scx200_acb compilation breakage
Message-Id: <20060120210612.6bcb6e8e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ben,

Andrew Morton is reporting scx200_acb compilation breakage on non-x86
due to the use of asm/msr.h, which only i386 and x86_64 have. This is
caused by your patch adding CS5535 support.

Now, how do we fix the problem?

First solution is to make the driver depend on X86. But are there other
architectures where this driver may be used? I'd guess not.

Second solution is to surround the CS5535 specific parts with #ifdef
X86 so that the driver can still be compiled on other architectures.

Opinions?

Thanks,
-- 
Jean Delvare


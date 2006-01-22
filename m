From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 22 Jan 2006 10:42:40 +0000
Subject: [lm-sensors] scx200_acb compilation breakage
Message-Id: <20060122114240.4ceb970c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060120210612.6bcb6e8e.khali@linux-fr.org>
In-Reply-To: <20060120210612.6bcb6e8e.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi again Ben,

> > The scx200/CS5535/etc only exist with/on the Geode processor, which is
> > x86.
> > So, I think the best option is to make it depend on X86.

I just found this proposed patch from Dave Jones:

http://lkml.org/lkml/2006/1/20/121

Basically it adds a dependency on SCX200 rather than X86. It's more
specific so I would tend to prefer it.

However, is it OK with regards to the CS5535/CS5536? Is SCX200 set for
them? If not, Dave's fix isn't acceptable. Is there something more
specific than X86 for the CS5535/CS5536 case? If there is we could make
the driver depend on (SCX200 || CS553X) or something like that. If not
we'll have to stick to X86.

Thanks,
-- 
Jean Delvare


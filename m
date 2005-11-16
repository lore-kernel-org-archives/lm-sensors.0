From: mgreer@mvista.com (Mark A. Greer)
Date: Wed, 16 Nov 2005 03:57:34 +0000
Subject: [lm-sensors] Re: [PATCH 1/1] Added support of ST m41t85 rtc chip
Message-Id: <20051116025714.GK5546@mag.az.mvista.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4378960F.8030800@varma-el.com> <20051115215226.4e6494e0.khali@linux-fr.org>
In-Reply-To: <20051115215226.4e6494e0.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Andrey Volkov <avolkov@varma-el.com>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, "Mark A. Greer" <mgreer@mvista.com>

Hi Jean,

On Tue, Nov 15, 2005 at 09:52:26PM +0100, Jean Delvare wrote:

<snip>

> First, a question. Can't you merge the M41T85 support into the m41t00
> driver?
> 
> Mark, care to comment on that possibility, and/or on the code itself?

Sure.

I wrestled with the ST website for the m41t85 datasheet but lost so I
I can only guess from the patch.  The drivers do look very similar.
It looks like the m41t85 is basically a m41t00 with an alarm (watchdog
timer never used AFAICT).  Also there are some differences in register
offsets and [maybe] some minor differences within the registers but
nothing that serious.

I think we can combine the two into an m41txx.c and pass the exact type
in via platform_data--that would be the correct mechanism, right?
The platform_data could also be used to seed the correct SQW freq and
eliminate all the Kconfig noise.

Comments?

As for Jean's and Andrew's comments about the driver, they seem valid
to me and should be addressed.  In Andrey's defense, many of them are my
fault.  Once there is a consensus on the merging m41t00 & m41t85
question, I'll try to get a fixed up patch within a couple weeks.

Mark

From: mgreer@mvista.com (Mark A. Greer)
Date: Wed, 16 Nov 2005 04:15:38 +0000
Subject: [lm-sensors] Re: [PATCH 1/1] Added support of ST m41t85 rtc chip
Message-Id: <20051116031520.GL5546@mag.az.mvista.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4378960F.8030800@varma-el.com> <20051115215226.4e6494e0.khali@linux-fr.org> <437A57CB.8090302@varma-el.com>
In-Reply-To: <437A57CB.8090302@varma-el.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrey Volkov <avolkov@varma-el.com>
Cc: Jean Delvare <khali@linux-fr.org>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, "Mark A. Greer" <mgreer@mvista.com>

On Wed, Nov 16, 2005 at 12:48:59AM +0300, Andrey Volkov wrote:

<snip>

> > 
> > Mark, care to comment on that possibility, and/or on the code itself?
> > 
> And, please, remove unnecessary PPC dependence from Kconfig.

When I originally submitted the m41t00 patch, I made it clear that it
was PPC only and gave the reason why:

http://archives.andrew.net.au/lm-sensors/msg29280.html

What processor arch did you test your m41t85 driver on?
AFAICT, PPC is the only arch that uses that exact definition of
get/set_rtc_time().

Mark

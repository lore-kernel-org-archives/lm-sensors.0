From: adi@hexapodia.org (Andy Isaacson)
Date: Wed, 16 Nov 2005 20:59:20 +0000
Subject: [lm-sensors] Re: [PATCH 1/1] Added support of ST m41t85 rtc chip
Message-Id: <20051116185513.GB18217@hexapodia.org>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <20051116031520.GL5546@mag.az.mvista.com>
References: <4378960F.8030800@varma-el.com>
In-Reply-To: <4378960F.8030800@varma-el.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: Andrey Volkov <avolkov@varma-el.com>, Jean Delvare <khali@linux-fr.org>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Tue, Nov 15, 2005 at 08:15:20PM -0700, Mark A. Greer wrote:
> On Wed, Nov 16, 2005 at 12:48:59AM +0300, Andrey Volkov wrote:
> > > Mark, care to comment on that possibility, and/or on the code itself?
> > > 
> > And, please, remove unnecessary PPC dependence from Kconfig.
> 
> When I originally submitted the m41t00 patch, I made it clear that it
> was PPC only and gave the reason why:
> 
> http://archives.andrew.net.au/lm-sensors/msg29280.html

I have a MIPS platform with M41T81 (SiByte SWARM,
arch/mips/sibyte/swarm/rtc_m41t81.c) that I would dearly love to
decruftify.  (Don't pay too much attention to the kernel.org trees for
MIPS, you need to pull the git repo on linux-mips.org for the real
stuff.)

So I'm definitely interested in this work.

-andy

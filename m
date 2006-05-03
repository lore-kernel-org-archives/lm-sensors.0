From: tandrews@grok.co.za (Thomas Andrews)
Date: Wed, 03 May 2006 12:21:03 +0000
Subject: [lm-sensors] Address configuration for scx200_acb
Message-Id: <20060503122103.GD19375@grok.co.za>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060427234114.941c9657.khali@linux-fr.org>
In-Reply-To: <20060427234114.941c9657.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, May 03, 2006 at 01:39:45PM +0200, Alexander Krause wrote:

> > Not currently, but I will have one ready in roughly a week. The delay is
> > because I am actually modifying an older version suitable for the 2.4
> > kernel. On my WRAP platform I don't yet have a suitable 2.6 kernel for
> > testing it. If you want a patch urgently to try out, I can perhaps make
> > one, but I'll have to rely on you to test it.
> i could simply add your function to the lastest 2.6.17 and implement that auto 
> mode.

You can, but (a) I know that the test works on the WRAP card, and (b) my
patch will make a cleaner job of it I believe.
 
> I'm not quite sure if it's helpfull to change the io-base as described in the 
> other posts but i could try that stuff later too.

I've found out the 'proper' way to read the base address. Depending on
various bit settings in the F0 and F5 configuration spaces, the base
address can be either 2e, 4e, or 15c. I have prototype code that can
read all of these settings so that it is no longer required to 'guess'.
There is one last issue outstanding, but I should have that sorted out
soon. I'm going to have to break my changes up into several patches,
because I'm messing with interrupts, base addresses, and speed settings
all at the same time.
 
> And I'm open for tests ;-)

Thanks, I appreciate it!


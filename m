From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:59 +0000
Subject: [RFC] Dynamic fan clock divider changes (long)
Message-Id: <20040522164651.1f8099a0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040516222809.2c3d1ea2.khali@linux-fr.org>
	<40AC947E.2050706@grupopie.com>
In-Reply-To: <40AC947E.2050706@grupopie.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Paulo Marques <pmarques@grupopie.com>
Cc: sensors@Stimpy.netroedge.com, linux-kernel@vger.kernel.org

> > The user still doesn't have to care, which is fine, but if the user
> > has a fan speed between 2000 and 5000 RPM, with low limit set to
> > 1500 RPM, he/she will have a "bad" accuracy at 5000 RPM (+/- 104
> > RPM). I see this as the low limit "nailing" the divider ;)
> 
> This doesn't sound so bad at all. And this seems to be the simplest
> approach.

Agreed.

> > This is what I implemented in my new pc87360 driver (after trying
> > #1). I use 85 and 224 as the arbitrary limits for changing
> > dividers.
> 
> This confused me a bit. It seems that a direct consequence of
> implementation #2 is that the divider will be set in a way that the
> low limit will be between 128 and 255, and that there is no point in
> changing the divider, because it will only get worse.

You're absolutely right.

> This leads directly to implementation #4. Am I missing something?

You are. In #4, the divider is arbitrarily chosen by "us", regardless of
the user's setup. In #2, the divider is chosen according to the user's
hardware and fan use. The common point is that (after setting the low
limit for #2) the divider will no longer change (until the low limit
changes for #2). But in #2 the divider is optimal, in #4 it is
arbitrary.

This makes a big difference because we cannot possibly arbitrarily pick
a divider and not allow the user to change it, so in #4 we would have to
keep the manual interface as well, as it exists for now. For #2, we can
reasonably hope to get rid of the manual interface after some times
(once the automatic mode will have been tested and is believed to be
correct).

> Anyway, if the user is really concerned about accuracy an average of
> several measurements should increase precision in this kind of
> problem.

Yes, that's a possibility. Not sure it's even worth the extra code, but
someone motivated could do it, you're right.

Thanks for your comments :)

-- 
Jean Delvare
http://khali.linux-fr.org/

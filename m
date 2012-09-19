From: Pawel Moll <pawel.moll@arm.com>
Date: Wed, 19 Sep 2012 17:04:48 +0000
Subject: Re: [lm-sensors] [PATCH v2 03/13] hwmon: Versatile Express hwmon driver
Message-Id: <1348074288.11116.86.camel@hornet>
List-Id: <lm-sensors.vger.kernel.org>
References: <1347977875-16855-1-git-send-email-pawel.moll@arm.com>
 <1347977875-16855-4-git-send-email-pawel.moll@arm.com>
 <20120918152430.GA5911@roeck-us.net>
In-Reply-To: <20120918152430.GA5911@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Guenter,

Thanks for your quick response (and apologies about me being delayed), I
appreciate your time!

On Tue, 2012-09-18 at 16:24 +0100, Guenter Roeck wrote:
> and a highly unusual way of, as much as I understand of it, bypass the hwmon
> infrastructure as much as possible.

I can assure you that it wasn't my aim. Generally, my platform has a lot
of small "control" devices providing one sensor each. And as they are
separate from the device model point of view, I wanted them to be
logically grouped around a single hwmon device (I was actually looking
at the coretemp driver). But it's not a big deal, really.

> I don't even understand what you are trying to do, much less why you don't
> just use the existing infrastructure, and I don't have time to try to figure
> it out. Maybe Jean has time to review this driver, but not me.
> 
> So, no, for my part I don't think it would be a good idea to rush this driver
> into 3.7.
> 
> Really, I would suggest to submit a standard hwmon driver (there are lots of
> examples out there).

Sure thing, I'll quickly spin a simplified version and post it for
review.

Thanks!

Pawel



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

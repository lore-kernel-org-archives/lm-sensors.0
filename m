From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 05 Jun 2008 13:59:44 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] lm87: Convert into a new-style driver
Message-Id: <20080605155944.25d610ff@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080604184401.GG11300@solarflare.com>
In-Reply-To: <20080604184401.GG11300@solarflare.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 5 Jun 2008 13:14:01 +0100, Ben Hutchings wrote:
> Jean Delvare wrote:
> > I fully agree. Plus, it would give you a chance to explain why this
> > noisy change is needed. At a quick glance I admit I don't quite get the
> > point.
> 
> The point is to allow platform_data to provide all the settings and to
> allow polling of the values, without exposing any of the implementation
> variables.

The question is: why do you want to provide the "settings" (I think you
mean the high and low limits of each sensor?) and allow polling of the
values inside the kernel, when we have a standard user-space interface
and library that takes care of this, with a dozen applications that can
be used on top of it? It makes sense to pass _some_ settings as
platform data (e.g. fan polarity) but passing all the limits doesn't
make any sense to me.

> I did consider splitting this into two patches, but there is no point
> in creating those two structures except to support the rest of the
> changes.  Howver, I can repost as two if you like.

Yes, please. A new-style lm87 driver is something other people would be
interested in, regardless of the platform data you want to add to it.
I expect some discussions about the platform data in question. So I'd
rather have the patch converting to a new-style driver written first
and applied quickly, and then build the platform data patch on top of
it and we can take the time to discuss it.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

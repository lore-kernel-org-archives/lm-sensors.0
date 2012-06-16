From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 16 Jun 2012 11:57:03 +0000
Subject: Re: [lm-sensors] [PATCH 17/95] hwmon: (adt7411) Convert to use devm_ functions
Message-Id: <20120616135703.3cc854b3@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1339773856-3443-18-git-send-email-linux@roeck-us.net>
In-Reply-To: <1339773856-3443-18-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 15 Jun 2012 09:51:47 -0700, Guenter Roeck wrote:
> On Fri, 2012-06-15 at 11:52 -0400, Wolfram Sang wrote:
> > I won't NACK it, but I don't think it is worth it. It increases runtime
> > memory usage and execution time. Marginally, yes, but the gain in code
> > size reduction is also marginally. If there is lots of devm_* in a
> > driver, this is usually good, but I wouldn't care about converting
> > single kzalloc calls.
> 
> code size reduction on x86_64 is about 15 kBytes for all drivers. With
> most of the hwmon drivers built but not loaded on a typical system, that
> does make a difference in disk space usage, and I think it is a bit more
> than marginal. The runtime execution time increase only occurs once,
> when a module is loaded or unloaded, and the increase in memory usage
> only applies to loaded drivers.
> 
> In addition to that, it does help preventing memory leaks, and it does
> make the code a bit simpler.
> 
> So, overall I do think it is worth it. Maybe not if I only look at one
> driver, but very much so if I look at the overall impact.

I agree with Guenter here. In fact, I suspect it's only a matter of
time before the use of devm_* functions becomes mandatory. Fewer lines
of code and fewer bugs is definitely something we want to achieve. If
it was deemed not worth the cost, the devm_* infrastructure would have
been rejected in the first place. Now that it is in place, it is meant
to be used as much as possible.

Gunter, I think it would make sense do document it
Documentation/hwmon/submitting-patches, section 3, so that you don't
have to do the same again in the future.

Great work, BTW. I don't intend to review all of it, no time, sorry,
but I ack the general idea.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

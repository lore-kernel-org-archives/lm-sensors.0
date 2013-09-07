From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 07 Sep 2013 15:33:42 +0000
Subject: Re: [lm-sensors] Backporting updated lm85 on RHEL5
Message-Id: <20130907173342.6c38fc3b@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <5229DE5D.7060104@elrepo.org>
In-Reply-To: <5229DE5D.7060104@elrepo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Phil,

On Fri, 06 Sep 2013 21:55:56 +0100, Phil Perry wrote:
> I'm trying to backport to RHEL5. The original RHEL5 kernel was based on 
> kernel-2.6.18, but as you are probably aware Red Hat backport all sorts 
> of functionality into their kernel over the 10 year lifetime of the 
> product so it's not really possible to refer to the RHEL kernel as being 
> of a particular version number. As far as I can tell, the kernel in RHEL 
> 5.5 received a hwmon update and the complete hwmon tree was pulled in 
> (backported) from around kernel-2.6.26. I believe this was the last 
> major update of hwmon stuff in the RHEL5 kernel, so it's probably best 
> to assume this as the base we are working from.
> 
> The main issue I have when pulling the lm85 code from longterm kernels 
> 3.0.x or 3.2.x, or the more recent 3.10.10 kernel and trying to compile 
> against the RHEL kernel is caused by the update to a new-style i2c 
> driver [Patch 2008-10-17 Convert to a new-style i2c driver].

I tried backporting the lm85 driver back to kernel 2.6.18 and hit
exactly the same roadblock. Everything else went more or less smoothly
but the change of driver model is just too much.

For my standalone drivers, the goal has always been to have a single
driver version that would work for all supported kernels. This has
worked fine so far as long as "all supported kernels" meant "2.6.32 and
up." I maintain each driver as a compatibility patch, which I
periodically apply on top of the latest version of the driver, make the
needed adjustments (if any) and publish.

Having slept over it, I think this model simply can't work going back
to 2.6.18, or for that matter, back to any version not supporting the
"new" i2c driver binding model (which was finalized in kernel 2.6.25.)
So I'm not going to extend my drivers to support anything older than
2.6.25. Which means I might as well stick to 2.6.32 as I don't think
a lot of people are still using kernels in the 2.6.25-2.6.31 range.

> I can 
> probably fix other issues but I don't know how best to work around/fix 
> that. I assume the RHEL kernel does not have some updated i2c 
> functionality hence that particular patch causing issues. Your 
> standalone driver code was giving errors around the same section of code.
> 
> My initial thought was to try reverting that patch and see if I can then 
> fix other remaining build issues by backporting the relevant 
> functionality. Does this sound viable or a non-starter?

The patch is too old to be reverted I'm afraid, you'd have to do it all
manually and this could be tricky.

I think I would do it the other way around: start with the lm85 driver
as it existed right before the i2c driver model conversion. Backport
that to RHEL 5 to start with, it shouldn't be too difficult. Then,
check the driver history and cherry-pick all the patches after the i2c
driver model conversion, which are either a bug fix or a feature. In
other words, skip all API updates and coding style cleanups.

The drawback is that the remaining patches most likely won't apply
cleanly and you'll have to backport all the changes manually. The
bright side is that there most likely won't be that many patches left
to backport, so it should be manageable.

> If you'd like to take a look for yourself I can probably arrange remote 
> access to our RHEL build systems for you, or I'm happy to copy and paste 
> build log errors here so you can see where it's failing.

I'd rather let you do the job, as I am not using Redhat systems myself,
and don't have a huge interest in unpaid driver backporting work.

But feel free to send me any error message you get along the way that
you can't figure out, and I'll be happy to try and help you get through
it. I'll also answer questions like "should I backport this specific
commit" or "how do I backport this specific commit on top of what I
have."

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

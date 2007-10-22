From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 22 Oct 2007 13:55:08 +0000
Subject: Re: [lm-sensors] lm-sensors 3.0.0-rc1 has been released!
Message-Id: <20071022155508.57a0a283@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070925233316.7afaa297@hyperion.delvare>
In-Reply-To: <20070925233316.7afaa297@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 22 Oct 2007 15:15:51 +0200, Hans de Goede wrote:
> Jean Delvare wrote:
> > On Mon, 22 Oct 2007 11:40:11 +0200, Hans de Goede wrote:
> >> I've also added a comment how to use it in future versions. The idea is to 
> >> increment the lower digit when for example new features are added to the 
> >> featuretype enum, so that applications can check the SENSORS_API_VERSION and 
> >> conditionally support new features for example (if they don't/can't check they 
> >> will no longer compile against an older libsensors).
> > 
> > I think I wouldn't have bothered. If applications no longer compile
> > with an older libsensors, then just upgrade libsensors.
> 
> That would mean much pain for distro developers which want to minimize churn, 
> but may still need to upgrade an application because of security reasons.

My experience is that distributions backport fixes for security bugs,
rather than upgrading to the next version of the application or the
library. But I don't actually think this is the right way to do it, so
I'll buy your argument :)

> > If someone is willing to maintain the API number, that's fine with me.
> > Me, I'll try to remember, but as I know myself, chances are good that
> > I'll forget sometimes if nobody is watching over me.
> 
> I'll try to keep an eye on it. I hope that if we forget users will complain.

The problem with this kind of thing is that, by the time users
complain, it's too late: you have a released version with a broken
define and you can't change that. So let's just hope it won't happen.

> > Just one thing I'm curious about: are you sure you want to set the API
> > to 400 _decimal_? Setting it to 0x400 instead seems to be more
> > flexible, as is allows for constructs like:
> > 
> > #if (SENSORS_API_VERSION >> 16) = 4
> > 
> > which is plain impossible to do with a decimal version number.
> 
> Well with mine one can do:
> #if (SENSORS_API_VERSION / 100) = 4
> 
> But I'm fine with either.

Ah right, I tend to forget that >> is nothing more than a division ;)
But... still, I think I'd feel more confident if we used hexadecimal.

> > Another thing: don't you want to define SENSORS_API_VERSION in trunk as
> > well? If not, you'll always have to test for SENSORS_API_VERSION's
> > existence before checking its value. I know that versions up to and
> > including 2.10.4 do not have the define and we can't change that, but
> > maybe applications will want to support all versions >= 2.10.5 so that
> > the #if magic can be limited to something sane.
> 
> Not necessary, if an identifier which is not a MACRO gets used in an #if 
> statement it is considered zero, so to take you example:
> #if (SENSORS_API_VERSION / 100) = 4
> 
> Would expand to:
> #if (0 / 100) = 4
> 
> And thus be false.

Unless the application is built with -Wundef (which is our case now),
in which case a warning is issued. That's what I would like to avoid.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

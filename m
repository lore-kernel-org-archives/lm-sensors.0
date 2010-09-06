From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 06 Sep 2010 16:18:58 +0000
Subject: Re: [lm-sensors] lmsensors doesn't detect core-i7 sensors
Message-Id: <20100906181858.2fd7d733@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <929339.59525.qm@web50002.mail.re2.yahoo.com>
In-Reply-To: <929339.59525.qm@web50002.mail.re2.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 4 Sep 2010 10:28:32 -0700, Guenter Roeck wrote:
> On Sat, Sep 04, 2010 at 11:55:29AM -0400, Jean Delvare wrote:
> > On Sat, 4 Sep 2010 07:25:34 -0700, Guenter Roeck wrote:
> > > Removing it sounds like overkill to me. After all, it _does_
> > > provide value (when it works). Maybe we should do the above,
> > > and spend some time getting it to work w/ Ubuntu given its
> > > distribution. I should be able to do that.
> > 
> > Where does it work? All distributions I know of, ship their own
> 
> Good question ...
> 
> > initialization script. There are so many dependencies (as you just
> > found out) and conventions (e.g. service naming, as you just found out
> > as well) involved, we can't make everyone happy.
> > 
> > The initialization script is only useful to people installing
> > lm-sensors from the sources on distributions which do not have
> > it already installed via a package. There aren't many doing that these
> > days, I think. And these can probably just add a couple modprobe lines
> > in a custom init script, as sensors-detect suggests. lm_sensors isn't
> > really a service, there's no daemon running (unless you throw sensord
> > into the game) so stopping it is totally optional.
>
> Maybe the best approach is to not (try to) install it at all, but just provide
> it as hint.

Isn't it exactly what we're doing today?

> Or maybe check if /etc/init.d/lm-sensors exists, and if it does
> don't install anything at all.

We could do that, but that's an invitation for distribution to use
lm-sensors instead of lm_sensors as the service name. I'd rather push
all distributions to stick to lm_sensors.

> The shared library locations are yet another problem. Not sure how to address
> that either.

I have no idea what you're talking about, sorry.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

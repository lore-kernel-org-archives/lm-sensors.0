From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 04 Sep 2010 17:28:32 +0000
Subject: Re: [lm-sensors] lmsensors doesn't detect core-i7 sensors
Message-Id: <20100904172831.GA31733@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <929339.59525.qm@web50002.mail.re2.yahoo.com>
In-Reply-To: <929339.59525.qm@web50002.mail.re2.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, Sep 04, 2010 at 11:55:29AM -0400, Jean Delvare wrote:
> On Sat, 4 Sep 2010 07:25:34 -0700, Guenter Roeck wrote:
> > Jean,
> > 
> > On Sat, Sep 04, 2010 at 09:49:42AM -0400, Jean Delvare wrote:
> > > Guenter,
> > > 
> > > On Wed, 1 Sep 2010 07:32:25 -0700, Guenter Roeck wrote:
> > > > How about some kind of warning, or at least use different wording in sensors-detect ?
> > > > 
> > > > The current text is quite absolute ("Copy prog/init/lm_sensors.init to /etc/init.d/lm_sensors")
> > > > and really invites users to overwrite the distribution specific scripts.
> > > 
> > > Actually it doesn't:
> > > 
> > > 		print "Copy prog/init/lm_sensors.init to /etc/init.d/lm_sensors\n".
> > > 		      "for initialization at boot time.\n"
> > > 			unless -f "/etc/init.d/lm_sensors";
> > > 
> > > So the message isn't printed if there is already a script there.
> > > 
> > > In Mahmood's case, the script is named /etc/init.d/lm-sensors instead,
> > > so the message would be printed, but running the suggested command
> > > would _not_ overwrite the file. Not sure what happens where both
> > > scripts are present though...
> > > 
> > Problem is two-fold: 
> > 1) People will/may remove lm-sensors anyway, being intelligent and assuming
> >    this is what they should do.
> > 2) lm_sensors doesn't work with Ubuntu anyway, since /etc/init.d/functions
> >    does not exist.
> > 
> > > So I would suggest that we simply extend the test to:
> > > 
> > > 			unless -f "/etc/init.d/lm_sensors"
> > > 			    or -f "/etc/init.d/lm-sensors";
> > > 
> > > Would that be OK with you?
> > > 
> > Yes.
> 
> Hmmm. The problem is that there's more than /etc/init.d/lm_sensors. We
> also have /etc/modprobe.d/lm_sensors.conf and /etc/sysconfig/lm_sensors.
> More generally, "lm_sensors" is the service name here, if a
> distribution changes /etc/init.d/lm_sensors to /etc/init.d/lm-sensors,
> I expect them to be consistent and change to "lm-sensors" everywhere.
> 
> Debian uses "lm-sensors" for the service name for some time now, but
> they don't use sysconfig, so we didn't care. If we now have
> distributions using sysconfig _and_ not using the standard "lm_sensors"
> name for the service, sensors-detect would have to be a lot smarter.
> 
> Or we can see it the other way around: sensors-detect assumes that the
> service is named "lm_sensors", if distributions can't stick to that,
> it's their pain, not ours. What's the point of diverging from us on the
> service name after all?
> 
> Note that the lm_sensors.init script we ship _does_ assume that the
> service is named "lm_sensors". So just updating sensors-detect wouldn't
> be enough.
> 
> > Another question is if we can get rid of the inclusion of /etc/init.d/functions.
> > I browsed through the code, but don't immediately see which functions
> > are used from it, and if they can be replaced. What do you think ?
> 
> openSUSE doesn't have this file either. I presume it is included for
> echo_warning, echo_success and echo_failure.
> 
> Do what you want with the script. Me, I don't want to spend one single
> minute on it.
> 
Having second thoughts there, given all the complexity involved.

> > > If you have a better proposal, I'm listening. The only alternative I
> > > have in mind is to get rid of the message altogether and delete the
> > > init script from our repository, leaving integration up to each
> > > distribution (which at least openSUSE and derivatives already do.)
> > > 
> > Removing it sounds like overkill to me. After all, it _does_
> > provide value (when it works). Maybe we should do the above,
> > and spend some time getting it to work w/ Ubuntu given its
> > distribution. I should be able to do that.
> 
> Where does it work? All distributions I know of, ship their own

Good question ...

> initialization script. There are so many dependencies (as you just
> found out) and conventions (e.g. service naming, as you just found out
> as well) involved, we can't make everyone happy.
> 
> The initialization script is only useful to people installing
> lm-sensors from the sources on distributions which do not have
> it already installed via a package. There aren't many doing that these
> days, I think. And these can probably just add a couple modprobe lines
> in a custom init script, as sensors-detect suggests. lm_sensors isn't
> really a service, there's no daemon running (unless you throw sensord
> into the game) so stopping it is totally optional.
> 
Maybe the best approach is to not (try to) install it at all, but just provide
it as hint. Or maybe check if /etc/init.d/lm-sensors exists, and if it does
don't install anything at all.

The shared library locations are yet another problem. Not sure how to address
that either.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

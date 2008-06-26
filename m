From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 26 Jun 2008 08:32:03 +0000
Subject: Re: [lm-sensors] fscpos and fscher drivers
Message-Id: <20080626103203.0bd37c05@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080626090548.3024bab0@hyperion.delvare>
In-Reply-To: <20080626090548.3024bab0@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 26 Jun 2008 09:09:34 +0200, Hans de Goede wrote:
> Jean Delvare wrote:
> > Hi Hans,
> > 
> > Do you have a plan to phase out the fscpos and fscher drivers? Now that
> > your fschmd driver supports all known FSC hardware monitoring chips, it
> > would be great if we could get rid of the legacy fscpos and fscher
> > drivers to make the configuration, maintenance and support easier.
> > 
> 
> Agreed, the reason this hasn't been done until now is because the fscpos and 
> fscher drivers support the watchdog function of the fscXXX family whereas my 
> fschmd driver doesn't (note the fscpos and fscher drivers do not support the 
> watchdog driver through the standard watchdog interface, instead they use 
> custom sysfs attr under the hwmon class).

Ah, I had forgotten about this watchdog issue. This makes the situation
a bit more complex of course.

> I've adding support for the watchdog part on my todo list for some time now. 
> But I have too many OSS projects, so I have to prioritize and sofar haven't 
> given adding watchdog support a priority.
> 
> > A first step could be to mark both drivers DEPRECATED in Kconfig, and
> > add an entry for their removal in
> > Documentation/feature-removal-schedule.txt. You could also add a
> > warning message when these drivers are loaded, pointing the user to the
> > replacement fschmd driver. I don't think these chips are very popular
> > so it will take some time before your new driver gets enough testing
> > and we can safely remove the legacy drivers. But the earlier we ask
> > the users to migrate, the earlier we will be able to remove the legacy
> > drivers.
> 
> I don't think many people if any at all use the watchdog feature, esp. as its 
> exported using a non standard interface, so if this is not a blocker, we could 
> still schedule fscher and fscpos for removal.

I guess you could add the DEPRECATED marks in Kconfig already, and
maybe the warnings when loading the drivers as well, but without
scheduling the drivers for removal yet. If users need the watchdog
function, they'll see it is missing from the new driver and will
hopefully report to you. This will give you an idea if implementing the
watchdog feature in the new driver is worth your time at all, and if it
is, where in your todo list it should go.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

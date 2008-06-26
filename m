From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Thu, 26 Jun 2008 07:09:34 +0000
Subject: Re: [lm-sensors] fscpos and fscher drivers
Message-Id: <486340AE.8060009@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080626090548.3024bab0@hyperion.delvare>
In-Reply-To: <20080626090548.3024bab0@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Hans,
> 
> Do you have a plan to phase out the fscpos and fscher drivers? Now that
> your fschmd driver supports all known FSC hardware monitoring chips, it
> would be great if we could get rid of the legacy fscpos and fscher
> drivers to make the configuration, maintenance and support easier.
> 

Agreed, the reason this hasn't been done until now is because the fscpos and 
fscher drivers support the watchdog function of the fscXXX family whereas my 
fschmd driver doesn't (note the fscpos and fscher drivers do not support the 
watchdog driver through the standard watchdog interface, instead they use 
custom sysfs attr under the hwmon class).

I've adding support for the watchdog part on my todo list for some time now. 
But I have too many OSS projects, so I have to prioritize and sofar haven't 
given adding watchdog support a priority.

> A first step could be to mark both drivers DEPRECATED in Kconfig, and
> add an entry for their removal in
> Documentation/feature-removal-schedule.txt. You could also add a
> warning message when these drivers are loaded, pointing the user to the
> replacement fschmd driver. I don't think these chips are very popular
> so it will take some time before your new driver gets enough testing
> and we can safely remove the legacy drivers. But the earlier we ask
> the users to migrate, the earlier we will be able to remove the legacy
> drivers.
> 

I don't think many people if any at all use the watchdog feature, esp. as its 
exported using a non standard interface, so if this is not a blocker, we could 
still schedule fscher and fscpos for removal.

Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

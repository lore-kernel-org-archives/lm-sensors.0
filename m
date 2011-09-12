From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 12 Sep 2011 17:23:17 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] hwmon/f71882fg: Make the decision
Message-Id: <1315848197.2455.189.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1315563155-15774-3-git-send-email-hdegoede@redhat.com>
In-Reply-To: <1315563155-15774-3-git-send-email-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 2011-09-09 at 06:12 -0400, Hans de Goede wrote:
> Before this patch the f71882fg driver completely fails to initialize
> on systems which have reserved settings in the pwm enable register, and
> it disables all auto pwm sysfs attributes if any fan is controlled by
> a digital sensor reading.
> 
> This patch changes the fail to initialize into don't register any attributes
> for the fan for which there are reserved settings in the pwm enable register
> and also makes the not registering of auto pwm sysfs attributes a per fan
> thing.
> 
> Signed-off-by: Hans de Goede <hdegoede@redhat.com>

Given that this is no longer a pure hwmon driver, it may make sense to
split it into separate mfd/hwmon/watchdog drivers. But on the other side
I notice that other drivers in the hwmon directory implement watchdog
functionality as well. Bad precedent :(. Wonder what happens with those
watchdogs if HWMON is disabled.

Not really sure if we should let this happen, or start being more
restrictive and enforce cleaner code. Jean, any thoughts/comments ?

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

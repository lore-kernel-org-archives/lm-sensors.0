From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 13 Oct 2010 16:34:10 +0000
Subject: Re: [lm-sensors] [PATCH 4/5] hwmon: DNS323 rev C1 fan support
Message-Id: <1286987650.9690.175.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1274525694.1931.142.camel@pasglop>
	<20101013115951.GA5649@kw.sim.vm.gnt>
In-Reply-To: <20101013115951.GA5649@kw.sim.vm.gnt>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, 2010-10-13 at 07:59 -0400, Simon Guinot wrote:
> Hi Benjamin,
> 
> What is the status for the DNS323 fan support ?
> Have this patch been merged yet ?
> 
The most recent version I found on the web (dated June 13) has problems
with error detection and reporting, and fails to remove sysfs files in
some error conditions. So I would be surprised if it was merged, unless
there is a more recent version which I missed.

On a side note, there are several versions of the patch on the web, none
indicating what has changed between versions. Would be great to have
such data attached to the various patch versions.

> I am currently looking to add hwmon support for the GPIO fan found
> on Network Space Max v2 boards. Obviously, some attributes are shared
> with the DNS323 fan. Maybe there is some room for a generic GPIO fan
> driver ?
> 
> Platform data could provide the board specific GPIO pinout and a speed
> conversion array (rpm from/to GPIO value). Here is a proposal for this
> platform data interface:
> 
> struct gpio_fan {
>         const char      *name;
>         unsigned        gpio;
>         unsigned        active_low;
> };
> 
> struct gpio_fan_speed {
>         int value;
>         int rpm;
> };
> 
> struct gpio_fan_platform_data {
>         struct gpio_fan         *alarm; /* fan alarm GPIO. */
>         struct gpio_fan         *ctrl;  /* fan control GPIOs. */
>         int                     num_ctrl;
>         /*
>          * Speed conversion array: rpm from/to GPIO bit field.
>          * This array _must_ be sorted in ascending rpm order.
>          */
>         struct gpio_fan_speed   *speed;
>         int                     num_speed;
> };
> 
> Based on this informations the GPIO fan driver could perform the
> speed conversions (pwm, rpm, GPIO value) and then provide a hwmon
> interface.
> 
Sounds like a good idea to me.

Couple of comments.

Personally, I prefer to see num_XXX variables before the actual objects,
but maybe that is just a personal preference. 

I am not sure what one would do with "active_low". Would that be used
for the alarm ?

Adding a "fault" object might make sense.

It seems that bit write order is missing. Since it is not always the
same, as the proposed dns323 driver indicates, that might be a tricky
problem to solve. You would have to come up with an at least somewhat
generic solution for that.

Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

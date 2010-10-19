From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 19 Oct 2010 15:15:12 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: add generic GPIO fan driver
Message-Id: <20101019151512.GB13908@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101017154021.GB29120@kw.sim.vm.gnt>
	<1287330612-11256-1-git-send-email-simon@sequanux.org>
	<20101018160830.GB9033@ericsson.com>
	<20101018203610.GD29120@kw.sim.vm.gnt>
	<20101019065221.GA12406@ericsson.com>
	<20101019083656.GE29120@kw.sim.vm.gnt>
In-Reply-To: <20101019083656.GE29120@kw.sim.vm.gnt>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Simon,

On Tue, Oct 19, 2010 at 04:36:56AM -0400, Simon Guinot wrote:

[ ... ]

> /* Designed for fan 40x40x16: ADDA AD0412LB-D50 6000rpm@12v */
> static struct gpio_fan_speed netspace_max_v2_fan_speed[] = {
>         {    0,  0 },
>         { 1500, 15 },
>         { 1700, 14 },
>         { 1800, 13 },
>         { 2100, 12 },
>         { 3100, 11 },
>         { 3300, 10 },
>         { 4300,  9 },
>         { 5500,  8 },
> };
> 
> The function rpm_speed(index) is really not linear. I am not sure about
> the resulting behaviour when this will be used by a userland fan control
> process...
> 
> If the pwm interface must be exported, I think we have to respect the
> fan speed array. But as you said, maybe the work is rather on the
> fancontrol script side.
> 
Not sure if there is an expectation that the mapping pwm->speed has
to be linear. One might as well argue that steps should be equally
far apart to ensure that results are better predictable.

> As a first step, we could keep the heavy pwm interface. Once the
> fancontrol script (or something else) will be able to handle the rpm
> attributes, we will drop the pwm compatibility.
> Simply remove the gpio-fan pwm interface seems a good option too...
> 
I think we should keep the pwm interface after all. Changing fancontrol
is a possibility, but the change would take a while to make it upstream.

As for the actual code, I would prefer the simpler implementation, but I am willing 
to go with the complex one if you feel wtrongly about it. Only thing I would ask you
to do is to add an explanation of what is done and why.

Reminds me - you'll also have to provide Documentation/hwmon/gpio-fan.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

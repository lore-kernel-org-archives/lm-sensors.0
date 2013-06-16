From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 16 Jun 2013 01:59:39 +0000
Subject: Re: [lm-sensors] [RESEND, PATCHv6 1/1] Add support for GMT G762/G763 PWM fan controllers
Message-Id: <20130616015939.GA5535@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <87sj0jhuhn.fsf@natisbad.org>
In-Reply-To: <87sj0jhuhn.fsf-LkuqDEemtHBg9hUCZPvPmw@public.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Arnaud Ebalard <arno-LkuqDEemtHBg9hUCZPvPmw@public.gmane.org>
Cc: Andrew Lunn <andrew-g2DYL2Zd6BY@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Jason Cooper <jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org>, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Olivier Mouchet <olivier.mouchet-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, Jean Delvare <khali-PUYAD+kWke1g9hUCZPvPmw@public.gmane.org>, Linux ARM Kernel Mailing List <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Simon Guinot <simon.guinot-jKBdWWKqtFpg9hUCZPvPmw@public.gmane.org>

On Sun, Jun 16, 2013 at 12:36:20AM +0200, Arnaud Ebalard wrote:
> 
> GMT G762/763 fan speed PWM controller is connected directly to a fan
> and performs closed-loop or open-loop control of the fan speed. Two
> modes - PWM or DC - are supported by the chip. Introduced driver
> provides various knobs to control the operations of the chip (via
> sysfs interface). Specific characteristics of the system can be passed
> either using board init code or via DT. Documentation for both the
> driver and DT bindings are also provided.
> 
> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
> ---
> Hi Guenter,
> 
> In the end, I think handling the clock properly for DT path
> (clk_prepare_enable() and associated clk_disable_unprepare()
> for both error and module unloading) adds some code but I
> do not see how to spare this. Comments welcome.
> 
> If you have additional comments and a new version is required,
> I'll handle those with Simon's tests on its platform.
> 
We might need to be more careful with the clocks. Several drivers
save the value retrieved with of_clk_get() and call clk_put()
afterwards. But some drivers don't do that, so I don't really
know the implications.

I'll look into it some more to make sure everything is correct.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

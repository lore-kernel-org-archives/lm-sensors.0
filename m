From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 30 Mar 2015 21:50:37 +0000
Subject: Re: [lm-sensors] [PATCH 06/15] hwmon: (it87) Add support for IT8620E
Message-Id: <5519C52D.2060608@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1427697235-23566-7-git-send-email-linux@roeck-us.net>
In-Reply-To: <1427697235-23566-7-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 03/29/2015 11:33 PM, Guenter Roeck wrote:
> IT8620E is mostly compatible to IT7828F. Add generic support for it.
>
> IT8620E supports up to 6 fan tachometers and 6 pwm controls.
> Support for the 6th tachometer and for the additional pwm controls
> are addded in separate patches.
>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---

[ ... ]

> +	} else if (sio_data->type = it8620) {
> +		int reg;
> +
> +		superio_select(GPIO);
> +
> +		/* Check for fan4, fan5 */
> +		reg = superio_inb(IT87_SIO_GPIO2_REG);

To safe reviewers some time ... IT87_SIO_GPIO2_REG is only introduced
in a later patch, breaking ability to bisect. I fixed it up.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

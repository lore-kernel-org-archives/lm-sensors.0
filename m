From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 22 Oct 2010 01:51:41 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon: add generic GPIO fan driver
Message-Id: <1287712301.9690.376.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101021223555.GT29120@kw.sim.vm.gnt>
	<1287701059-2226-1-git-send-email-simon@sequanux.org>
In-Reply-To: <1287701059-2226-1-git-send-email-simon@sequanux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

Hi Simon,

On Thu, 2010-10-21 at 18:44 -0400, Simon Guinot wrote:
> From: Simon Guinot <sguinot@lacie.com>
> 
> This patch adds hwmon support for the GPIO connected fan.
> 
I rephrased this to ".. for fans connected to GPIO pins."

> Platform specific informations as GPIO pinout and speed conversion array
> (rpm from/to GPIO value) are passed to the driver via platform_data.
> 
> Signed-off-by: Simon Guinot <sguinot@lacie.com>

[ ... ]
> +static int __devinit gpio_fan_probe(struct platform_device *pdev)
> +{
> +       int err = 0;

and this variable initialization is not needed.

Otherwise looks good. Applied with the above changed to my -next tree.

I'll let it rest there for a couple of days. Unless some unforeseen
problems show up, it might just make it into .37.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

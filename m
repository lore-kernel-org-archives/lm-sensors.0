From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Date: Tue, 20 Nov 2007 12:59:37 +0000
Subject: Re: [lm-sensors] switching from at91 to gpio driver
Message-Id: <20071120.215937.126571551.anemo@mba.ocn.ne.jp>
List-Id: <lm-sensors.vger.kernel.org>
References: <loom.20071115T225659-359@post.gmane.org>
In-Reply-To: <loom.20071115T225659-359@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 18 Nov 2007 17:43:54 +0100, Jean Delvare <khali@linux-fr.org> wrote:
> Indeed there needs to be a way to set the class of i2c-gpio buses to
> I2C_CLASS_HWMON. We could change the driver to set the class to
> I2C_CLASS_HWMON for all buses by default, but that's not very flexible.
> It would IMHO make more sense to add a field to struct
> i2c_gpio_platform_data, and let each user of i2c-gpio set the class to
> whatever they want.
> 
> Maybe you, Haavard or Atsushi can submit a patch doing this? I'd be
> happy to review and merge it quickly.

I think just setting I2C_CLASS_HWMON (or I2C_CLASS_ALL) in
i2c_gpio_probe would be enough.

Well, frankly, I cannot understand the purpose of I2C_CLASS_XXX at
all.  For example, what is an requirement for I2C_CLASS_HWMON?

---
Atsushi Nemoto

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

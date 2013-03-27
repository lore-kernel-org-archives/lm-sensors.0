From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 27 Mar 2013 19:48:07 +0000
Subject: Re: [lm-sensors] [PATCH v7 5/5] hwmon: add ST-Ericsson ABX500 hwmon driver
Message-Id: <20130327194807.GB11086@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1364368412-12810-1-git-send-email-hongbo.zhang@linaro.org>
 <1364368412-12810-6-git-send-email-hongbo.zhang@linaro.org>
In-Reply-To: <1364368412-12810-6-git-send-email-hongbo.zhang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hongbo Zhang <hongbo.zhang@linaro.org>
Cc: khali@linux-fr.org, lm-sensors@lm-sensors.org, cbou@mail.ru, dwmw2@infradead.org, linaro-kernel@lists.linaro.org, STEricsson_nomadik_linux@list.st.com, linus.walleij@linaro.org, lee.jones@linaro.org, linux-kernel@vger.kernel.org

On Wed, Mar 27, 2013 at 03:13:32PM +0800, Hongbo Zhang wrote:
> Each of ST-Ericsson X500 chip set series consists of both ABX500 and DBX500
> chips. This is ABX500 hwmon driver, where the abx500.c is a common layer for
> all ABX500s, and the ab8500.c is specific for AB8500 chip. Under this designed
> structure, other chip specific files can be added simply using the same common
> layer abx500.c.
> 
> Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

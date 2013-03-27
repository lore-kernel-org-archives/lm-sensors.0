From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 27 Mar 2013 19:47:43 +0000
Subject: Re: [lm-sensors] [PATCH v7 4/5] ab8500: power: export abx500_res_to_temp tables for hwmon
Message-Id: <20130327194743.GA11086@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1364368412-12810-1-git-send-email-hongbo.zhang@linaro.org>
 <1364368412-12810-5-git-send-email-hongbo.zhang@linaro.org>
In-Reply-To: <1364368412-12810-5-git-send-email-hongbo.zhang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hongbo Zhang <hongbo.zhang@linaro.org>
Cc: khali@linux-fr.org, lm-sensors@lm-sensors.org, cbou@mail.ru, dwmw2@infradead.org, linaro-kernel@lists.linaro.org, STEricsson_nomadik_linux@list.st.com, linus.walleij@linaro.org, lee.jones@linaro.org, linux-kernel@vger.kernel.org

On Wed, Mar 27, 2013 at 03:13:31PM +0800, Hongbo Zhang wrote:
> This patch exports the thermistor resistance-to-temperature tables, so that the
> hwmon driver can access them, and also adds the corresponding table size
> variables.
> 
> Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>

Acked-by: Guenter Roeck <linux@roeck-us.net>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

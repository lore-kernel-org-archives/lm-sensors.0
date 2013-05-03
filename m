From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 03 May 2013 15:10:33 +0000
Subject: Re: [lm-sensors] [PATCH 4/5] hwmon: ntc_thermistor: Remove redundant platform_set_drvdata()
Message-Id: <20130503151033.GD8781@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1367574220-15787-4-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1367574220-15787-4-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, May 03, 2013 at 03:13:39PM +0530, Sachin Kamat wrote:
> Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
> driver is bound) removes the need to set driver data field to
> NULL.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>

Applied to -next

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

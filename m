From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 03 May 2013 15:11:41 +0000
Subject: Re: [lm-sensors] [PATCH 5/5] hwmon: w83627ehf: Remove redundant platform_set_drvdata()
Message-Id: <20130503151141.GE8781@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1367574220-15787-5-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1367574220-15787-5-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, May 03, 2013 at 03:13:40PM +0530, Sachin Kamat wrote:
> Commit 0998d06310 (device-core: Ensure drvdata = NULL when no
> driver is bound) removes the need to set driver data field to
> NULL.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Jean Delvare <khali@linux-fr.org>

Applied to -next. Jean, let me know if you want to take this one, and I'll drop
it. In that case,

Acked-by: Guenter Roeck <linux@roeck-us.net>

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 25 Mar 2014 13:32:04 +0000
Subject: Re: [lm-sensors] [PATCH 07/19] hwmon: lm75: expose to thermal fw via DT nodes
Message-Id: <53318554.7090507@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1395744572-20014-1-git-send-email-alex.shi@linaro.org> <1395744572-20014-8-git-send-email-alex.shi@linaro.org>
In-Reply-To: <1395744572-20014-8-git-send-email-alex.shi@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Alex Shi <alex.shi@linaro.org>, mark.hambleton@broadcom.com, mark.brown@linaro.org, eduardo.valentin@ti.com, mporter@linaro.org, lsk-interest@linaro.org, linaro-kernel@linaro.org
Cc: Jean Delvare <khali@linux-fr.org>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On 03/25/2014 03:49 AM, Alex Shi wrote:
> From: Eduardo Valentin <eduardo.valentin@ti.com>
>
> This patch adds to lm75 temperature sensor the possibility
> to expose itself as thermal zone device, registered on the
> thermal framework.
>
> The thermal zone is built only if a device tree node
> describing a thermal zone for this sensor is present
> inside the lm75 DT node. Otherwise, the driver behavior
> will be the same.
>
> Note: This patch has also been reviewed by Jean D. He has
> requested to perform a wider inspection of possible
> users of thermal and hwmon interaction API. On the other
> hand, the change on this patch is acceptable on first
> step of overall code change.
>
> Cc: Jean Delvare <khali@linux-fr.org>
> Cc: lm-sensors@lm-sensors.org
> Cc: linux-kernel@vger.kernel.org
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
> (cherry picked from commit 22e731838b0e337fed5f16c67aa0b954028dfe93)
>
> Signed-off-by: Alex Shi <alex.shi@linaro.org>

Not entirely sure why you are sending this patch to a public list.
This patch as well as patch 8/19 have already been applied.
Ok, it appears that you plan to apply it to some other branch.
So what ?

Can you clarify ?

Reason for asking is that I don't want to get flooded with e-mail
each time someone applies a patch to some arbitrary branch,
and I end up being confused and looking through the code
trying to figure out what is going on. Whatever it is, your branch
isn't that special that you need to tell the rest of the world
what you are doing.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Samuel Ortiz <sameo@linux.intel.com>
Date: Sun, 03 Feb 2013 22:32:19 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] ARM: ux500: rename ab8500 to abx500 for hwmon driver
Message-Id: <20130203223219.GZ8476@sortiz-mobl>
List-Id: <lm-sensors.vger.kernel.org>
References: <1359541288-6657-1-git-send-email-hongbo.zhang@linaro.org>
 <1359541288-6657-2-git-send-email-hongbo.zhang@linaro.org>
In-Reply-To: <1359541288-6657-2-git-send-email-hongbo.zhang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Hongbo Zhang <hongbo.zhang@linaro.org>
Cc: linux@roeck-us.net, khali@linux-fr.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, STEricsson_nomadik_linux@list.st.com, linaro-dev@lists.linaro.org, patches@linaro.org, linus.walleij@linaro.org, lee.jones@linaro.org

Hi Hongbo,

On Wed, Jan 30, 2013 at 06:21:27PM +0800, Hongbo Zhang wrote:
> We are using a generic abx500 hwmon layer, so rename specific ab8500 to generic
> abx500 for hwmon device and driver matching.
> 
> Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>
> ---
>  drivers/mfd/ab8500-core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
Patch applied, after fixing the subject. Thanks.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

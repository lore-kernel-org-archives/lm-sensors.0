From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 11 Sep 2013 05:56:53 +0000
Subject: Re: [lm-sensors] [PATCH 1/5] hwmon: (emc2103) Fix return value
Message-Id: <52300625.2090505@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1378873192-6297-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1378873192-6297-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 09/10/2013 09:19 PM, Sachin Kamat wrote:
> kstrtol() returns appropriate error values. Use those instead of
> hardcoding. Silences several sparse messages of following type:
> "why not propagate 'result' from kstrtol() instead of (-22)?"
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Steve Glendinning <steve.glendinning@shawell.net>
> ---
> Series is compile tested.

Series looks good to me. I have applied all five patches.

Jean, please let me know if you want to take any; otherwise I'll push
it all to Linus around Thursday.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

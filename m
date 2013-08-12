From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 12 Aug 2013 11:18:38 +0000
Subject: Re: [lm-sensors] [PATCH 1/1] hwmon: (asus_atk0110) Fix incorrect placement of __initconst
Message-Id: <5208C48E.9060309@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1376299240-26943-1-git-send-email-sachin.kamat@linaro.org>
In-Reply-To: <1376299240-26943-1-git-send-email-sachin.kamat@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 08/12/2013 02:20 AM, Sachin Kamat wrote:
> __initconst should be placed between the variable name and equal
> sign for the variable to be placed in the intended section.
>
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Luca Tettamanti <kronos.it@gmail.com>
> ---

Applied to -next.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

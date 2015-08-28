From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 28 Aug 2015 14:45:05 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: The code crashes
Message-Id: <55E073F1.5040002@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1440770651-11085-1-git-send-email-corone.il.han@gmail.com>
In-Reply-To: <1440770651-11085-1-git-send-email-corone.il.han@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 08/28/2015 07:04 AM, Il Han wrote:
> The code crashes, since dev is not an i2c client device.
> ---
> Mistakes were made in the process of merging.
>

Pretty non-descriptive subject line. Sounds like the entire hwmon
subsystem was crashing.

Please, just send a single patch for the new driver.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 26 Aug 2015 14:06:23 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: The Code Crashes
Message-Id: <55DDC7DF.8080705@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1440567719-27643-2-git-send-email-corone.il.han@gmail.com>
In-Reply-To: <1440567719-27643-2-git-send-email-corone.il.han@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 08/25/2015 10:41 PM, Il Han wrote:
> The code crashes, since dev is not an i2c client device.
>
> Signed-off-by: Il Han <corone.il.han@gmail.com>

You lost me a bit here. Why did you make this a separate patch ?

Also, please version your patches and provide a change log.
I am sure I asked for that before.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

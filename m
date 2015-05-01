From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 01 May 2015 18:03:56 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: sht15: Constify platform_device_id
Message-Id: <20150501180356.GF7712@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1430495783-31969-1-git-send-email-k.kozlowski.k@gmail.com>
 <1430495783-31969-2-git-send-email-k.kozlowski.k@gmail.com>
In-Reply-To: <1430495783-31969-2-git-send-email-k.kozlowski.k@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
Cc: Jean Delvare <jdelvare@suse.de>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Sat, May 02, 2015 at 12:56:23AM +0900, Krzysztof Kozlowski wrote:
> The platform_device_id is not modified by the driver and core uses it as
> const.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>

Applied to -next.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

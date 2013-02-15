From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Feb 2013 20:07:34 +0000
Subject: Re: [lm-sensors] [PATCH 3/9] hwmon: (adt7410) Use the SIMPLE_DEV_PM_OPS helper macro
Message-Id: <20130215200734.GC32433@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1360947438-2550-1-git-send-email-lars@metafoo.de>
 <1360947438-2550-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1360947438-2550-3-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jean Delvare <khali@linux-fr.org>, Hartmut Knaack <knaack.h@gmx.de>, Jonathan Cameron <jic23@cam.ac.uk>, lm-sensors@lm-sensors.org, linux-iio@vger.kernel.org

On Fri, Feb 15, 2013 at 05:57:12PM +0100, Lars-Peter Clausen wrote:
> Use the SIMPLE_DEV_PM_OPS macro to declare the driver's pm_ops.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Applied to hwmon-next.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

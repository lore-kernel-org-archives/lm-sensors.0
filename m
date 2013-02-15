From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Feb 2013 20:07:08 +0000
Subject: Re: [lm-sensors] [PATCH 2/9] hwmon: (adt7410) Let suspend/resume depend on CONFIG_PM_SLEEP
Message-Id: <20130215200708.GB32433@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1360947438-2550-1-git-send-email-lars@metafoo.de>
 <1360947438-2550-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1360947438-2550-2-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jean Delvare <khali@linux-fr.org>, Hartmut Knaack <knaack.h@gmx.de>, Jonathan Cameron <jic23@cam.ac.uk>, lm-sensors@lm-sensors.org, linux-iio@vger.kernel.org

On Fri, Feb 15, 2013 at 05:57:11PM +0100, Lars-Peter Clausen wrote:
> Only build the suspend/resume code if CONFIG_PM_SLEEP is selected. Currently the
> code is built if CONFIG_PM is selected, but it will also be selected if only
> runtime PM support is built into the kernel.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Applied to hwmon-next.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

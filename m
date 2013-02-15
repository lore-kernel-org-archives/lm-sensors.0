From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 15 Feb 2013 20:06:37 +0000
Subject: Re: [lm-sensors] [PATCH 1/9] hwmon: (adt7410) Clear unwanted bits in the config register
Message-Id: <20130215200637.GA32433@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1360947438-2550-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1360947438-2550-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Jean Delvare <khali@linux-fr.org>, Hartmut Knaack <knaack.h@gmx.de>, Jonathan Cameron <jic23@cam.ac.uk>, lm-sensors@lm-sensors.org, linux-iio@vger.kernel.org

On Fri, Feb 15, 2013 at 05:57:10PM +0100, Lars-Peter Clausen wrote:
> Make sure to clear the mode bits from the config register before setting the new
> mode. Otherwise we might end up with a different mode than we want to.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Applied to hwmon-next.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Kevin Hilman <khilman@kernel.org>
Date: Thu, 15 Jan 2015 01:30:15 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (ina2xx) Add ina231 compatible string
Message-Id: <7hppagq194.fsf@deeprootsystems.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1421279852-27965-1-git-send-email-khilman@kernel.org>
	<20150115005642.GA31033@roeck-us.net>
In-Reply-To: <20150115005642.GA31033@roeck-us.net> (Guenter Roeck's message of
	"Wed, 14 Jan 2015 16:56:42 -0800")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: lm-sensors@lm-sensors.org, linux-samsung-soc@vger.kernel.org, Jean Delvare <jdelvare@suse.de>, open list <linux-kernel@vger.kernel.org>

Guenter Roeck <linux@roeck-us.net> writes:

> On Wed, Jan 14, 2015 at 03:57:32PM -0800, Kevin Hilman wrote:
>> From: Kevin Hilman <khilman@linaro.org>
>> 
>> Add support for "ina231" as compatible string.
>> 
>> Tested with the Exynos5422-based odroid-xu3 board which has on-board
>> INA231 sensors.
>> 
>> Signed-off-by: Kevin Hilman <khilman@linaro.org>
>
> Hi Kevin,
>
> can you also update Documentation/hwmon/ina2xx and Documentation/hwmon/Kconfig ?
>

Sure... coming right up.

Kevin


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

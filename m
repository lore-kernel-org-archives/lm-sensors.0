From: Kevin Hilman <khilman@kernel.org>
Date: Thu, 15 Jan 2015 16:56:55 +0000
Subject: Re: [lm-sensors] [PATCH v2] hwmon: (ina2xx) Add ina231 compatible string
Message-Id: <7hegqwouco.fsf@deeprootsystems.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1421285699-8469-1-git-send-email-khilman@kernel.org>
	<54B745B4.2040807@roeck-us.net>
In-Reply-To: <54B745B4.2040807@roeck-us.net> (Guenter Roeck's message of "Wed,
	14 Jan 2015 20:44:36 -0800")
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-samsung-soc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>, DOCUMENTATION <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, linaro-kernel@lists.linaro.org

Guenter Roeck <linux@roeck-us.net> writes:

> On 01/14/2015 05:34 PM, Kevin Hilman wrote:
>> From: Kevin Hilman <khilman@linaro.org>
>>
>> Add support for "ina231" as compatible string, and update
>> Documentation and Kconfig accordingly.
>>
>> Tested with the Exynos5422-based odroid-xu3 board which has on-board
>> INA231 sensors.
>>
>> Signed-off-by: Kevin Hilman <khilman@linaro.org>
>
> Applied to -next after minor cleanup (see below).
>

Thanks,

Kevin

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

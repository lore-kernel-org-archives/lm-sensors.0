From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 31 Jul 2015 00:58:50 +0000
Subject: Re: [lm-sensors] [PATCH 18/27] hwmon: (g762) Export OF module alias information
Message-Id: <55BAC84A.1010007@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1438273132-20926-1-git-send-email-javier@osg.samsung.com> <1438273132-20926-19-git-send-email-javier@osg.samsung.com>
In-Reply-To: <1438273132-20926-19-git-send-email-javier@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Javier Martinez Canillas <javier@osg.samsung.com>, linux-kernel@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>, lm-sensors@lm-sensors.org

On 07/30/2015 09:18 AM, Javier Martinez Canillas wrote:
> The I2C core always reports the MODALIAS uevent as "i2c:<client name"
> regardless if the driver was matched using the I2C id_table or the
> of_match_table. So technically there's no need for a driver to export
> the OF table since currently it's not used.
>
> In fact, the I2C device ID table is mandatory for I2C drivers since
> a i2c_device_id is passed to the driver's probe function even if the
> I2C core used the OF table to match the driver.
>
> And since the I2C core uses different tables, OF-only drivers needs to
> have duplicated data that has to be kept in sync and also the dev node
> compatible manufacturer prefix is stripped when reporting the MODALIAS.
>
> To avoid the above, the I2C core behavior may be changed in the future
> to not require an I2C device table for OF-only drivers and report the
> OF module alias. So, it's better to also export the OF table to prevent
> breaking module autoloading if that happens.
>
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
>

Applied.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

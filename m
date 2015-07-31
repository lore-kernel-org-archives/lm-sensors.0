From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 31 Jul 2015 00:58:15 +0000
Subject: Re: [lm-sensors] [PATCH 14/27] hwmon: (nct7904) Export I2C module alias information
Message-Id: <55BAC827.2030400@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1438273132-20926-1-git-send-email-javier@osg.samsung.com> <1438273132-20926-15-git-send-email-javier@osg.samsung.com>
In-Reply-To: <1438273132-20926-15-git-send-email-javier@osg.samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Javier Martinez Canillas <javier@osg.samsung.com>, linux-kernel@vger.kernel.org
Cc: Jean Delvare <jdelvare@suse.com>, lm-sensors@lm-sensors.org

On 07/30/2015 09:18 AM, Javier Martinez Canillas wrote:
> The I2C core always reports the MODALIAS uevent as "i2c:<client name"
> regardless if the driver was matched using the I2C id_table or the
> of_match_table. So the driver needs to export the I2C table and this
> be built into the module or udev won't have the necessary information
> to auto load the correct module when the device is added.
>
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Applied.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

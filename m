From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 29 May 2015 20:24:10 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (nct6683) Add missing sysfs attibute initialization
Message-Id: <5568CAEA.7020803@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1432829756-14595-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1432829756-14595-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

On 05/29/2015 01:50 AM, Jean Delvare wrote:

> Reviewed-by: Jean Delvare <jdelvare@suse.de>
>
> Looks like the abituguru and abituguru3 drivers suffer from the same
> bug?
>

Those drivers derive the attr values from a template which is pre-initialized
with SENSOR_ATTR_2. With this, the initialization should be taken care of.
Am I missing something ?

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

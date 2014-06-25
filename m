From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 25 Jun 2014 20:47:45 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (gpio-fan) Change name used in hwmon_device_register_with_groups
Message-Id: <20140625204745.GB14652@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1403726431-18749-1-git-send-email-jdascenzio@yahoo.fr>
In-Reply-To: <1403726431-18749-1-git-send-email-jdascenzio@yahoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Julien D'Ascenzio <jdascenzio@yahoo.fr>
Cc: Jean Delvare <jdelvare@suse.de>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

On Wed, Jun 25, 2014 at 10:00:31PM +0200, Julien D'Ascenzio wrote:
> Since commit 648cd48c9e566f53c5df30d79857e0937ae13b09
> The hwmon name attributes must not include '-' so the name must be
> rename from gpio-fan to gpio_fan
> 
> Signed-off-by: Julien D'Ascenzio <jdascenzio@yahoo.fr>

Good catch. Applied.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

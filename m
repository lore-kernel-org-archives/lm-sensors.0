From: Jean Delvare <jdelvare@suse.de>
Date: Tue, 18 Feb 2014 14:56:17 +0000
Subject: Re: [lm-sensors] [PATCH 2/3] hwmon: (lm90) Create all sysfs groups in one call
Message-Id: <20140218155617.658ce9c5@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392513995-30712-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1392513995-30712-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 15 Feb 2014 17:26:34 -0800, Guenter Roeck wrote:
> Create all sysfs groups in one call by using sysfs_create_groups
> instead of calling sysfs_create_group individually for each group.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/lm90.c |   67 +++++++++++++++++---------------------------------
>  1 file changed, 22 insertions(+), 45 deletions(-)
> (...)

Looks good, except for the "pec" attribute which shouldn't move IMHO.

-- 
Jean Delvare
Suse L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

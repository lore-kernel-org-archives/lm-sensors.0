From: Jean Delvare <jdelvare@suse.de>
Date: Sun, 23 Feb 2014 15:32:52 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] hwmon: (coretemp) Use sysfs_create_group to create sysfs attributes
Message-Id: <20140223163252.41683a64@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392595175-7589-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1392595175-7589-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 16 Feb 2014 15:59:33 -0800, Guenter Roeck wrote:
> Instead of creating each attribute individually, use sysfs_create_group
> to create all attributes for one core with a single call.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/coretemp.c |   20 +++++++-------------
>  1 file changed, 7 insertions(+), 13 deletions(-)
> (...)

Reviewed-by: Jean Delvare <jdelvare@suse.de>
Tested-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
Suse L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

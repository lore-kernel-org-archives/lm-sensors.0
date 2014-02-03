From: Jean Delvare <jdelvare@suse.de>
Date: Mon, 03 Feb 2014 14:57:59 +0000
Subject: Re: [lm-sensors] [PATCH v2 1/4] hwmon: (lm63) Add additional sysfs group for temp2_type attribute
Message-Id: <20140203155759.31f989f3@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1391390510-19238-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1391390510-19238-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun,  2 Feb 2014 17:21:47 -0800, Guenter Roeck wrote:
> With the new hwmon API, we can only add groups of attributes, not individual
> attributes. To prepare for the use of the new API, add an additional sensor
> group for the temp2_type attribute and register it with sysfs_create_group
> instead of device_create_file.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Do not merge temp2_type attribute with extra_lut group but create separate
>     group instead.
> 
>  drivers/hwmon/lm63.c |   16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> (...)

Applied, thanks.

-- 
Jean Delvare
Suse L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

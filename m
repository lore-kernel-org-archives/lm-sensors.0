From: Jean Delvare <jdelvare@suse.de>
Date: Sun, 23 Feb 2014 15:35:58 +0000
Subject: Re: [lm-sensors] [PATCH 2/3] hwmon: (coretemp) Allocate platform data with devm_kzalloc
Message-Id: <20140223163558.08a72ab6@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392595175-7589-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1392595175-7589-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 16 Feb 2014 15:59:34 -0800, Guenter Roeck wrote:
> This simplifies error handling.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/coretemp.c |   12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
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

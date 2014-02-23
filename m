From: Jean Delvare <jdelvare@suse.de>
Date: Sun, 23 Feb 2014 16:16:36 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (max6639) Introduce local dev variable, and reduce noisiness
Message-Id: <20140223171636.2efda1b8@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1393031014-26259-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1393031014-26259-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 21 Feb 2014 17:03:33 -0800, Guenter Roeck wrote:
> Introduce local variable 'dev' in probe function to make code easier
> to read. Also drop dev_info message in probe to reduce noisiness
> during boot.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/max6639.c |   12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> (...)

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
Suse L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

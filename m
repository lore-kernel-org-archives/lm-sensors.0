From: Jean Delvare <jdelvare@suse.de>
Date: Sun, 13 Apr 2014 07:41:18 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (tmp102) Introduce dev variable in probe function
Message-Id: <20140413094118.267a03cf@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1397277376-27502-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1397277376-27502-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 11 Apr 2014 21:36:15 -0700, Guenter Roeck wrote:
> The pointer to client->dev is used several times in the probe function.
> Simplify code by introducing a separate variable for it.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/tmp102.c |   28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> (...)

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

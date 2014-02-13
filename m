From: Jean Delvare <jdelvare@suse.de>
Date: Thu, 13 Feb 2014 09:50:10 +0000
Subject: Re: [lm-sensors] [PATCH 1/4] hwmon: (max6650) Rearrange code to no longer require forward declaratio
Message-Id: <20140213105010.1ea1275f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392226866-25968-2-git-send-email-linux@roeck-us.net>
In-Reply-To: <1392226866-25968-2-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Wed, 12 Feb 2014 09:41:03 -0800, Guenter Roeck wrote:
> Cleanup only; no functional change.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/max6650.c |  228 ++++++++++++++++++++++-------------------------
>  1 file changed, 109 insertions(+), 119 deletions(-)
> (...)

Thanks for doing this.

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
Suse L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

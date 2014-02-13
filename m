From: Jean Delvare <jdelvare@suse.de>
Date: Thu, 13 Feb 2014 10:12:32 +0000
Subject: Re: [lm-sensors] [PATCH 4/4] hwmon: (max6650) Introduce local 'dev' variable
Message-Id: <20140213111232.3e2b748d@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1392226866-25968-5-git-send-email-linux@roeck-us.net>
In-Reply-To: <1392226866-25968-5-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 12 Feb 2014 09:41:06 -0800, Guenter Roeck wrote:
> This makes the code a bit easier to read.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/hwmon/max6650.c |   24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> (...)

Reviewed-by: Jean Delvare <jdelvare@suse.de>

-- 
Jean Delvare
Suse L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

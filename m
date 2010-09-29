From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 29 Sep 2010 16:48:13 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (lm90) Rearrange code to no longer
Message-Id: <20100929184813.40c0e852@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1284780642-7291-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1284780642-7291-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

On Fri, 17 Sep 2010 20:30:42 -0700, Guenter Roeck wrote:
> Signed-off-by: Guenter Roeck <guenter.roeck@ericsson.com>
> ---
>  drivers/hwmon/lm90.c |  523 ++++++++++++++++++++++++-------------------------
>  1 files changed, 256 insertions(+), 267 deletions(-)
> 

Wow. Have you noticed how GNU diff gets this patch completely wrong? I
use quilt and quilt relies in GNU diff, and when refreshing or viewing
the patch, I get an output which is different from what you sent,
larger and less readable. It includes oddities such as:

-	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
-		return -ENODEV;
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		return -ENODEV;

And this isn't a bug in a specific version... Tried it on 4 different
versions of GNU diff on 2 completely different distributions. "diff -d"
gets it right, but the default algorithm does not.

I'll report the bug to the diffutils guys. Meanwhile, your patch is
nice and I'll apply it...

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 26 Apr 2008 13:33:30 +0000
Subject: Re: [lm-sensors] [PATCH] adt7473: Minor documentation update
Message-Id: <20080426153330.273df78f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080328210604.GA7183@tree.beaverton.ibm.com>
In-Reply-To: <20080328210604.GA7183@tree.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

Hi Darrick,

Sorry for the late review.

On Fri, 28 Mar 2008 14:06:04 -0700, Darrick J. Wong wrote:
> Add a sentence about when fan speed increases to maximum.
> 
> Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
> ---
> 
>  Documentation/hwmon/adt7473 |    3 ++-
>  1 files changed, 2 insertions(+), 1 deletions(-)
> 
> diff --git a/Documentation/hwmon/adt7473 b/Documentation/hwmon/adt7473
> index 22d8b19..2126de3 100644
> --- a/Documentation/hwmon/adt7473
> +++ b/Documentation/hwmon/adt7473
> @@ -69,7 +69,8 @@ point2: Set the pwm speed at a higher temperature bound.
>  
>  The ADT7473 will scale the pwm between the lower and higher pwm speed when
>  the temperature is between the two temperature boundaries.  PWM values range
> -from 0 (off) to 255 (full speed).
> +from 0 (off) to 255 (full speed).  Fan speed will be set to maximum when the
> +temperature sensor associated with the PWM control exceeds temp#_max.
>  
>  Notes
>  -----
> 

Obviously correct.

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

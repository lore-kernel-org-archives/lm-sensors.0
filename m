From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 11 Feb 2013 15:15:30 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: (ltc2978) Update datasheet links
Message-Id: <20130211161530.069994d2@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1360079815-15187-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1360079815-15187-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue,  5 Feb 2013 07:56:54 -0800, Guenter Roeck wrote:
> Links to datasheets are no longer valid. Update to current links.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  Documentation/hwmon/ltc2978 |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/hwmon/ltc2978 b/Documentation/hwmon/ltc2978
> index c365f9b..8a5e791 100644
> --- a/Documentation/hwmon/ltc2978
> +++ b/Documentation/hwmon/ltc2978
> @@ -5,11 +5,11 @@ Supported chips:
>    * Linear Technology LTC2978
>      Prefix: 'ltc2978'
>      Addresses scanned: -
> -    Datasheet: http://cds.linear.com/docs/Datasheet/2978fa.pdf
> +    Datasheet: http://cds.linear.com/docs/en/datasheet/2978fc.pdf
>    * Linear Technology LTC3880
>      Prefix: 'ltc3880'
>      Addresses scanned: -
> -    Datasheet: http://cds.linear.com/docs/Datasheet/3880f.pdf
> +    Datasheet: http://cds.linear.com/docs/en/datasheet/3880fa.pdf
>  
>  Author: Guenter Roeck <guenter.roeck@ericsson.com>
>  

Reviewed-by: Jean Delvare <khali@linux-fr.org>

Unfortunately I am afraid that the last letter of the file name is the
revision, so even these links are likely to break in the future. It
might make more sense to provide links to the product pages, which
apparently don't change so often.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

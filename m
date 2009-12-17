From: "Ray Copeland" <ray.copeland@aprius.com>
Date: Thu, 17 Dec 2009 17:37:32 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] Wrong ADT7462_VOLT_COUNT for
Message-Id: <AFEAE911EE22F64BACAB05ED86B4D4FC01C5CF2C@EXVBE012-13.exch012.intermedia.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <AFEAE911EE22F64BACAB05ED86B4D4FC018DA312@EXVBE012-13.exch012.intermedia.net><AFEAE911EE22F64BACAB05ED86B4D4FC018DA31A@EXVBE012-13.exch012.intermedia.net><AFEAE911EE22F64BACAB05ED86B4D4FC018DA328@EXVBE012-13.exch012.intermedia.net> <20091217171445.0bd28259@hyperion.delvare>
In-Reply-To: <20091217171445.0bd28259@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi, Jean, thanks for letting me know.  This is my first time sending a
patch, and I should have sent
it first to Darrick to have him review it before I posted directly to
the group.  He told me how to
rework it properly so that I will do it right next time.

Sorry if this caused any problem for you.

Regards,

Ray Copeland

-----Original Message-----
From: Jean Delvare [mailto:khali@linux-fr.org] 
Sent: Thursday, December 17, 2009 8:15 AM
To: Ray Copeland
Cc: linux-kernel@vger.kernel.org; lm-sensors@lm-sensors.org
Subject: Re: [lm-sensors] [PATCH 1/2] Wrong ADT7462_VOLT_COUNT for
linux-2.6.30 adt7462 hwmon driver

Hi Ray,

On Wed, 16 Dec 2009 17:26:19 -0800, Ray Copeland wrote:
> From: Ray Copeland <ray.copeland@aprius.com>
> Date: Wed, 16 Dec 2009
> Subject: [PATCH 1/2] Wrong ADT7462_VOLT_COUNT for linux-2.6.30 adt7462
hwmon driver 
> 
> Description:
> 
> The #define ADT7462_VOLT_COUNT is wrong, it should be 13 not 12. All
the 
> for loops that use this as a limit count are of the typical form, "for

> (n = 0; n < ADT7462_VOLT_COUNT; n++)", so to loop through all voltages

> w/o missing the last one it is necessary for the count to be one
greater 
> than it is.  (Specifically, you will miss the +1.5V 3GPIO input with
count 
> = 12 vs. 13.)
> 
> Signed-off-by: Ray Copeland <ray.copeland@aprius.com>
> 
> Diff with changes vs. original adt7462.c 2.6.30 version:
> 
> --- adt7462.c.orig      2009-12-15 15:51:05.000000000 -0800
> +++ adt7462.c.volt_count        2009-12-16 14:06:01.000000000 -0800
> @@ -182,7 +182,7 @@
>   *
>   * Some, but not all, of these voltages have low/high limits.
>   */
> -#define ADT7462_VOLT_COUNT     12
> +#define ADT7462_VOLT_COUNT     13
> 
>  #define ADT7462_VENDOR         0x41
>  #define ADT7462_DEVICE         0x62

While the patch looks functionally correct, it is horribly broken in
its format. You sent a HTML mail instead of only plain text. Your
mailer turned the tabs into spaces. And the paths are missing from the
patch header.

Please learn how to send proper patches that kernel maintainers can
apply. Documentation/SubmittingPatches is a good start.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

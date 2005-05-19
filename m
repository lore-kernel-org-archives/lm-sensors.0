From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:42 +0000
Subject: [PATCH 2.6] Trivial: group Intel on I2C Hardware Bus support menu
Message-Id: <UrMWOmfy.1110369137.3109400.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <71ss2156tl8s8mb4afff8511nu3gke4qi8@4ax.com>
In-Reply-To: <71ss2156tl8s8mb4afff8511nu3gke4qi8@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Grant, all,

> From an end-user perspective it is easy to miss the third Intel PIIX
> entry on the menuconfig "I2C Hardware Bus support" screen.
> Also the Intel 801 menu item does not mention ICH.
>
> This trivial patch groups three Intel entries together, adds ICH to
> menu item, and ICH5/ICH5R to the help section.

I'm all for it, as it makes full sense. I would simply suggest the
following variations (I feel like nitpicking today):

>  config I2C_I801
> -	tristate "Intel 801"
> +	tristate "Intel 801/ICH"

I'd rather say "Intel 82801 (ICH)". It's an alternate name for the
same thing, not two separate chips/families.

>@@ -119,7 +119,7 @@
> 	    82801BA
> 	    82801CA/CAM
> 	    82801DB
>-	    82801EB
>+	    82801EB/82801ER (ICH5/ICH5R)

That would be /ER if you follow the example above.

> +config I2C_PIIX4
> +	tristate "Intel PIIX4"
> +	depends on I2C && PCI && EXPERIMENTAL

While you are there, feel free to discard EXPERIMENTAL. The driver exists
for maybe 6 years, if we don't consider it stable now, we never will.

Care to repost a version of your patch including all suggested changes
that you found relevant, it any?

Note that you have to CC: Greg KH when posting such patches if you want
him to include them in his tree and later push them to Andrew Morton.

Thanks for your help,
--
Jean Delvare

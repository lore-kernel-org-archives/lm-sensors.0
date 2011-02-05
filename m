From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 05 Feb 2011 17:38:22 +0000
Subject: Re: [lm-sensors] [PATCH] Update doc/donations
Message-Id: <20110205183822.3bab5997@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110205173233.GA26562@ericsson.com>
In-Reply-To: <20110205173233.GA26562@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 5 Feb 2011 09:32:33 -0800, Guenter Roeck wrote:
> This patch updates the donations file the latest information.
> 
> --
> Index: doc/donations
> =================================> --- doc/donations	(revision 5911)
> +++ doc/donations	(working copy)
> @@ -119,3 +119,8 @@
>  		This board has a Winbond W83795ADG, SMBus is	Jean Delvare
>  		multiplexed with GPIOs.
>  		Drivers developed: w83795
> +
> +lleo19		Intel DH57JG with i3-540 CPU, 4GB RAM, chassis,	2011-01
> +		and power supply.				Guenter Roeck
> +		Used to add support for NCT6775F (W83677HG-I)
> +		to w83627ehf driver.
> 

Feel free to commit changes to this document directly, no need for a
review or approval.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

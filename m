From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 29 Mar 2008 13:56:03 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] Define sysfs interfaces for ibmaem
Message-Id: <20080329145603.7e47418f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080328213646.GC7191@tree.beaverton.ibm.com>
In-Reply-To: <20080328213646.GC7191@tree.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

Hi Darrick,

On Fri, 28 Mar 2008 14:36:46 -0700, Darrick J. Wong wrote:
> Update sysfs interface documentation to include energy meters and power
> meter averaging intervals.
> 
> Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
> ---
> 
>  Documentation/hwmon/sysfs-interface |   12 ++++++++++++
>  1 files changed, 12 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
> index f4a8ebc..85e6654 100644
> --- a/Documentation/hwmon/sysfs-interface
> +++ b/Documentation/hwmon/sysfs-interface
> @@ -328,6 +328,14 @@ curr[1-*]_input	Current input value
>  		Unit: milliampere
>  		RO
>  
> +**********
> +* Energy *
> +**********
> +
> +energy[1-*]_input		Instantaneous energy use

This doesn't make sense to me. Energy is a quantity, it exists
independently of time. An "instantaneous energy use" only makes sense
if you tell in what (presumably very small) amount of time the energy
was used... and then what you are measuring is not an energy but a
power, for which we already have an interface. Please clarify.

> +				Unit: microJoule
> +				RO
> +
>  *********
>  * Power *
>  *********
> @@ -336,6 +344,10 @@ power[1-*]_average		Average power use
>  				Unit: microWatt
>  				RO
>  
> +power[1-*]_interval		Power use averaging interval

Wouldn't power[1-*]_average_interval be clearer?

> +				Unit: milliseconds

Nitpicking for consistency: millisecond (no trailing s).

What values do you expect for this entry? I am wondering if it's safe
to use millisecond as a unit. Is it unlikely that a future chip will
support averaging intervals below the millisecond?

> +				RW
> +
>  power[1-*]_average_highest	Historical average maximum power use
>  				Unit: microWatt
>  				RO


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

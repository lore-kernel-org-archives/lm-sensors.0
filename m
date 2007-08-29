From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 29 Aug 2007 09:10:52 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add power meters to
Message-Id: <20070829111052.503a73a5@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070827211446.GG32667@tree.beaverton.ibm.com>
	<20070828015029.GA10107@khazad-dum.debian.net>
	<20070828131942.18449886@hyperion.delvare>
	<20070828164440.GL32667@tree.beaverton.ibm.com>
In-Reply-To: <20070828164440.GL32667@tree.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: Henrique de Moraes Holschuh <hmh@hmh.eng.br>, "Mark M. Hoffman" <mhoffman@lightlink.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Darrick,

On Tue, 28 Aug 2007 09:44:40 -0700, Darrick J. Wong wrote:
> Update the hwmon sysfs interface documentation to include a specification
> for power meters.
> 
> Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
> ---
> 
>  Documentation/hwmon/sysfs-interface |   15 +++++++++++++++
>  1 files changed, 15 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
> index b3a9e1b..da546ce 100644
> --- a/Documentation/hwmon/sysfs-interface
> +++ b/Documentation/hwmon/sysfs-interface
> @@ -304,6 +304,21 @@ curr[1-*]_input	Current input value
>  		Unit: milliampere
>  		RO
>  
> +*********
> +* Power *
> +*********
> +
> +power[1-*]_input	Current power use
> +			Unit: milliWatt
> +			RO
> +
> +power[1-*]_max_input	Historical maximum power use
> +			Unit: milliWatt
> +			RO
> +
> +power[1-*]_min_input	Historical minimum power use
> +			Unit: milliWatt
> +			RO
>  

I'm not sure if we want these "historical" files. We don't have them for
the other input types, and I believe that it's not the driver's job to
compute and export these values. If anyone cares about the history of
sensed values, that's something for a user-space application to
implement. This will also be much more flexible in user-space, as it
becomes possible to decide the exact time range to consider, to
remember at which time the peak occurred, etc.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

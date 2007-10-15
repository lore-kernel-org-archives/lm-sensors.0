From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 15 Oct 2007 15:10:29 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon: Add power meter spec to
Message-Id: <20071015171029.39ab3fe6@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071009203923.GJ16752@tree.beaverton.ibm.com>
In-Reply-To: <20071009203923.GJ16752@tree.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: "Mark M. Hoffman" <mhoffman@lightlink.com>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

Hi Darrick,

On Tue, 9 Oct 2007 13:39:24 -0700, Darrick J. Wong wrote:
> Update the hwmon sysfs interface documentation to include a specification
> for power meters.
> 
> Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
> ---
> 
>  Documentation/hwmon/sysfs-interface |   31 +++++++++++++++++++++++++++++++
>  1 files changed, 31 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
> index db7bb4a..4e0fb20 100644
> --- a/Documentation/hwmon/sysfs-interface
> +++ b/Documentation/hwmon/sysfs-interface
> @@ -324,6 +324,37 @@ curr[1-*]_input	Current input value
>  		Unit: milliampere
>  		RO
>  
> +*********
> +* Power *
> +*********
> +
> +power[1-*]_average		Average power use
> +				Unit: microWatt
> +				RO
> +
> +power[1-*]_average_highest	Historical average maximum power use
> +				Unit: microWatt
> +				RO
> +
> +power[1-*]_average_lowest	Historical average minimum power use
> +				Unit: microWatt
> +				RO
> +
> +power[1-*]_input		Instantaneous power use
> +				Unit: microWatt
> +				RO
> +
> +power[1-*]_input_highest	Historical maximum power use
> +				Unit: microWatt
> +				RO
> +
> +power[1-*]_input_lowest		Historical minimum power use
> +				Unit: microWatt
> +				RO
> +
> +power[1-*]_reset_history	Reset input_highest, input_lowest,
> +				average_highest and average_lowest.
> +				WO
>  
>  **********
>  * Alarms *

Looks good, thanks for your patience :)

Acked-by: Jean Delvare <khali@linux-fr.org>

Note that lm-sensors 3 still lacks support for power meters, if you
want it you'll have to submit a patch.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

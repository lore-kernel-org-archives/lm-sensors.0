From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 14 Apr 2010 07:37:10 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] hwmon: add description of the
Message-Id: <20100414093710.47583cea@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1270671720-1575-2-git-send-email-iws@ovro.caltech.edu>
In-Reply-To: <1270671720-1575-2-git-send-email-iws@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 13 Apr 2010 15:54:27 -0700, Ira W. Snyder wrote:
> The update_rate attribute can be used by drivers to let userspace choose
> the update rate of the chip, if it is configurable.
> 
> Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
> ---
>  Documentation/hwmon/sysfs-interface |   12 ++++++++++++
>  1 files changed, 12 insertions(+), 0 deletions(-)
> 
> diff --git a/Documentation/hwmon/sysfs-interface b/Documentation/hwmon/sysfs-interface
> index 3de6b0b..39e9844 100644
> --- a/Documentation/hwmon/sysfs-interface
> +++ b/Documentation/hwmon/sysfs-interface
> @@ -92,6 +92,18 @@ name		The chip name.
>  		RO
>  
>  
> +***************
> +* Update Rate *
> +***************
> +
> +update_rate	The rate at which the chip will update readings.
> +		Unit: millisecond
> +		RW
> +		Some devices have a variable update rate. This attribute
> +		can be used to change the update rate to the desired
> +		frequency.
> +
> +

Looks good. But maybe we could merge name and update_rate in a common
"Global attributes" or similar? Looks odd to have separate sections for
single attributes.

>  ************
>  * Voltages *
>  ************


-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

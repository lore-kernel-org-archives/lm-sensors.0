From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 12 Jan 2013 14:35:54 +0000
Subject: Re: [lm-sensors] [PATCH] AMD: Add support to sensors-detect for AMD family 16h power driver
Message-Id: <20130112153554.02a6bd4f@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 12 Dec 2012 14:57:08 -0500, Boris Ostrovsky wrote:
> Load fam15h_power driver on family 16h processors
> 
> Signed-off-by: Boris Ostrovsky <boris.ostrovsky@amd.com>
> ---
>  prog/detect/sensors-detect |    4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/prog/detect/sensors-detect b/prog/detect/sensors-detect
> index 2291534..420ab1a 100755
> --- a/prog/detect/sensors-detect
> +++ b/prog/detect/sensors-detect
> @@ -2349,6 +2349,10 @@ use vars qw(@cpu_ids);
>  		driver => "fam15h_power",
>  		detect => sub { amd_pci_detect('1604') },
>  	}, {
> +		name => "AMD Family 16h power sensors",
> +		driver => "fam15h_power",
> +		detect => sub { amd_pci_detect('1534') },
> +	}, {
>  		name => "Intel digital thermal sensor",
>  		driver => "coretemp",
>  		detect => \&coretemp_detect,

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

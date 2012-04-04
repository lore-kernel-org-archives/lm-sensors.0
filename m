From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 04 Apr 2012 13:54:26 +0000
Subject: Re: [lm-sensors] [PATCH] Don't probe EDID addresses on graphics card adapters
Message-Id: <20120404135426.GB17153@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120404113253.533a4c19@endymion.delvare>
In-Reply-To: <20120404113253.533a4c19@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Apr 04, 2012 at 05:32:53AM -0400, Jean Delvare wrote:
> Avoid probing EDID addresses (0x50-0x57) on graphics card adapters.
> We had one report that it caused trouble:
> http://lists.lm-sensors.org/pipermail/lm-sensors/2012-April/035847.html
> Even though it's not yet clear what happened, let's play it safe.
> 
> This closes ticket #2386.

Agreed, and looks good.

Guenter

> ---
>  prog/detect/sensors-detect |    3 +++
>  1 file changed, 3 insertions(+)
> 
> --- lm-sensors.orig/prog/detect/sensors-detect	2012-03-29 08:33:21.000000000 +0200
> +++ lm-sensors/prog/detect/sensors-detect	2012-04-02 18:37:31.948591233 +0200
> @@ -3660,6 +3660,9 @@ sub scan_i2c_adapter
>  		$input = <STDIN>;
>  		chomp($input);
>  		@not_to_scan = parse_not_to_scan(0x03, 0x77, $input);
> +	} elsif (($class & 0xff00) = 0x0300) {
> +		# Skip EDID addresses by default on graphics adapters
> +		@not_to_scan = parse_not_to_scan(0x03, 0x77, "0x50-0x57");
>  	}
>  
>  	open(local *FILE, "$dev_i2c$adapter_nr") or
> 
> 
> -- 
> Jean Delvare
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

-- 
Guenter Roeck
Distinguished Engineer
PDU IP Systems

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

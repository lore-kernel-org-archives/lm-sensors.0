From: Guenter Roeck <linux@roeck-us.net>
Date: Mon, 22 Oct 2012 13:53:42 +0000
Subject: Re: [lm-sensors] [PATCH 1/2] sensors-detect: Skip graphics cards by default
Message-Id: <20121022135342.GB7375@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20121022141524.1778b4e2@endymion.delvare>
In-Reply-To: <20121022141524.1778b4e2@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Oct 22, 2012 at 02:15:24PM +0200, Jean Delvare wrote:
> Don't probe I2C buses on graphics cards by default. Their drivers will
> typically instantiate the I2C slave devices themselves as needed, and
> such probes have been occasionally reported to cause serious trouble.
> ---
>  prog/detect/sensors-detect |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> --- lm-sensors.orig/prog/detect/sensors-detect	2012-08-27 13:18:01.000000000 +0200
> +++ lm-sensors/prog/detect/sensors-detect	2012-10-06 13:21:05.277537273 +0200
> @@ -3652,8 +3652,8 @@ sub scan_i2c_adapter
>  	my ($funcs, $chip, $addr, $class, $default, $input, @not_to_scan);
>  
>  	$class = get_pci_class($i2c_adapters[$adapter_nr]->{parent});
> -	if (($class & 0xff00) = 0x0400) {
> -		# Do not probe adapters on PCI multimedia cards by default
> +	# Do not probe adapters on multimedia and graphics cards by default
> +	if (($class & 0xff00) = 0x0400 || ($class & 0xff00) = 0x0300) {
>  		$default = 0;
>  	} elsif ($class = 0x0c01 || $class = 0x0c05
>  	      || find_i2c_adapter_driver($i2c_adapters[$adapter_nr]->{name})) {
> 
Excellent idea.

Acked-by: Guenter Roeck <linux@roeck-us.net>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

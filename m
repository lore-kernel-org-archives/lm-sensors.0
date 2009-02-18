From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 18 Feb 2009 16:23:20 +0000
Subject: Re: [lm-sensors] PATCH; sensors-detect: do not crash FSC Syleus IC's
Message-Id: <20090218172320.57e39891@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <499717A0.6070002@redhat.com>
In-Reply-To: <499717A0.6070002@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Sat, 14 Feb 2009 20:12:32 +0100, Hans de Goede wrote:
> As discussed on IRC the Syleus does not like our way of seeing if a device is 
> present at a certain address, this patch implements a workaround consisting of 
> doing a byte data read instead of a quick command or a byte read.
> 
> Once reviewed I can commit this myself.

> Index: prog/detect/sensors-detect
> =================================> --- prog/detect/sensors-detect	(revision 5642)
> +++ prog/detect/sensors-detect	(working copy)
> @@ -2629,7 +2629,14 @@
>  {
>  	my ($file, $addr, $funcs) = @_;
>  
> -	if (($addr >= 0x50 && $addr <= 0x5F)
> +	if ($addr = 0x73) {
> +		# Special case for FSC chips, as at least the Syleus locks
> +		# up with our regular probe code. Note that to our current
> +		# knowledge only FSC chips live on this address, and for them
> +		# this probe method is safe

Missing final dot ;)

> +		return 0 unless ($funcs & I2C_FUNC_SMBUS_READ_BYTE);

Wrong test: you want to check for I2C_FUNC_SMBUS_READ_BYTE_DATA.

> +		return i2c_smbus_access($file, SMBUS_READ, 0, SMBUS_BYTE_DATA, []);
> +	} elsif (($addr >= 0x50 && $addr <= 0x5F)
>  	 || ($addr >= 0x30 && $addr <= 0x37)) {
>  		# This covers all EEPROMs we know of, including page protection
>  		# addresses. Note that some page protection addresses will not

Minor nitpicking: I'd also move the test after the EEPROM test, keeping
the tests in both numeric and historical order.

Other than that, no objection on the principle, I believe it's the
right thing to do.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 24 Jun 2007 11:31:40 +0000
Subject: Re: [lm-sensors] [PATCH] lm-sensors: add detection for non-standard
Message-Id: <20070624133140.3e75a838@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0706200826kc97f051g58873d3c8820cde@mail.gmail.com>
In-Reply-To: <191fb4ca0706200826kc97f051g58873d3c8820cde@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

On Wed, 20 Jun 2007 08:26:54 -0700, Juerg Haefliger wrote:
> This patch adds detection logic for non-standard SMSC Super I/Os.
> These chips have their device ID register at address 0x0d rather than
> 0x20.
> 
> Signed-off-by: Juerg Haefliger <juergh at gmail.com>

I don't know what you and others think, but personally I prefer this
version over the previous one.

Comments:

> --- lm-sensors.orig/prog/detect/sensors-detect	2007-06-13 08:18:39.981298000 -0700
> +++ lm-sensors/prog/detect/sensors-detect	2007-06-20 08:17:26.201043000 -0700
> @@ -1832,6 +1832,38 @@ use vars qw(@chip_kern24_ids @chip_kern2
>  	devid => 0x77,
>        },
>      ],
> +    # Non-standard SMSC detection callback and chip list. These chips differ
> +    # from the standard ones listed above in that the device ID register 
> +    # address is 0x0d instead of 0x20 (as specified by the ISA PNP spec).
> +    ns_detect => \&smsc_ns_detect_superio,
> +    ns_chips =>
> +    [
> +      {
> +	name => "SMSC FDC37C665 Super IO",
> +	driver => "not-a-sensor",
> +	devid => 0x65,
> +      },
> +      {
> +	name => "SMSC FDC37C666 Super IO",
> +	driver => "not-a-sensor",
> +	devid => 0x66,
> +      },
> +      {
> +	name => "SMSC FDC37C669 Super IO",
> +	driver => "not-a-sensor",
> +	devid => 0x03,
> +      },
> +      {
> +	name => "SMSC FDC37N769 Super IO",
> +	driver => "not-a-sensor",
> +	devid => 0x28,
> +      },
> +      {
> +	name => "SMSC LPC47N227 Super IO",
> +	driver => "not-a-sensor",
> +	devid => 0x5a,
> +      },
> +    ],
>    },
>    {
>      family => "VIA/Winbond/Fintek",

Originally I didn't expect this non-standard list to be embedded in the
main list, but after all, maybe it's a good idea to have all the
declarations in the same place.

> @@ -3189,6 +3221,38 @@ sub probe_superio($$$)
>                                          $new_hash;
>  }
>  
> +# Detection routine for non-standard SMSC Super I/O chips
> +# $_[0]: Super I/O LPC address port
> +# $_[1]: Super I/O LPC data port
> +# $_[2]: Reference to chip family hash

Maybe explain the return value convention too.

> +sub smsc_ns_detect_superio
> +{
> +    my ($addrreg, $datareg, $family) = @_;
> +    my ($val, $found);

Unused variable $found.

> +
> +    # read alternate device ID register
> +    outb($addrreg, 0x0d);
> +    $val = inb($datareg);
> +    if ($val = 0x00 || $val = 0xff) {
> +	return 0;
> +    }
> +    # read revision   
> +    outb($addrreg, 0x0e);
> +    $val = ($val << 8) | inb($datareg);

Why do you bother with the revision? You don't even use it for
identification. Remember, we want this non-standard stuff to be as
simple as possible.

> +
> +    print "Yes\n";
> +
> +    foreach my $chip (@{$family->{ns_chips}}) {
> +	if ($chip->{devid} = ($val >> 8)) {
> +	    probe_superio($addrreg, $datareg, $chip);
> +	    return 1;
> +	}
> +    }
> +
> +    printf("Found unknown non-standard chip with ID 0x%04x\n", $val);
> +    return 1;
> +}
> +
>  sub scan_superio
>  {
>    my ($addrreg, $datareg) = @_;
> @@ -3206,6 +3270,12 @@ sub scan_superio
>      foreach $val (@{$family->{enter}->{$addrreg}}) {
>        outb($addrreg, $val);
>      }
> +# call the non-standard detection routine first if it exists
> +    if (defined($family->{ns_detect}) && 
> +	&{$family->{ns_detect}}($addrreg, $datareg, $family)) {

I'd suggest passing $family->{ns_chips} directly as the 3rd parameter.
I can't think of a valid reason why you'd need access to the full
family hash in the ns_detect callback.

> +	exit_superio($addrreg, $datareg);
> +	last FAMILY;
> +    }
>  # did it work?
>      outb($addrreg, $superio{devidreg});
>      $val = inb($datareg);

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

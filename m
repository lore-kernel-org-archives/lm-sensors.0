From: Jean Delvare <jdelvare@suse.de>
Date: Tue, 12 May 2020 09:03:32 +0000
Subject: Re: [PATCH] sensors-detect: Fix the driver for Nuvoton W83677HG-I
Message-Id: <20200512110332.43751a61@endymion>
List-Id: <lm-sensors.vger.kernel.org>
References: <20200507150045.32abbc79@endymion>
In-Reply-To: <20200507150045.32abbc79@endymion>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 7 May 2020 15:00:45 +0200, Jean Delvare wrote:
> Originally, support for the Nuvoton W83677HG-I and derivatives was
> first added to the w83627ehf driver, so that's the driver recommended
> by sensors-detect. Later, support for the same device was added to
> the nct6775 driver. In kernel v5.6, support was removed from the
> w83627ehf driver to get rid of the duplicate code.
> 
> So sensors-detect should now point users of this device to the
> nct6775 driver. We can't do that for very old kernels though, as this
> driver did not exist back then. I chose v3.10 for the cut-over, as
> this is when support for the Nuvoton W83677HG-I was finalized in the
> nct6775 driver, at least according to git log.
> 
> Signed-off-by: Jean Delvare <jdelvare@suse.de>
> ---
>  prog/detect/sensors-detect |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- lm-sensors.orig/prog/detect/sensors-detect	2020-05-07 14:29:34.731733274 +0200
> +++ lm-sensors/prog/detect/sensors-detect	2020-05-07 14:44:55.909135775 +0200
> @@ -2273,7 +2273,7 @@ use constant FEAT_SMBUS	=> (1 << 7);
>  		features => FEAT_IN | FEAT_FAN | FEAT_TEMP,
>  	}, {
>  		name => "Nuvoton W83677HG-I (NCT5572D/NCT6771F/NCT6772F/NCT6775F) Super IO Sensors",
> -		driver => "w83627ehf",
> +		driver => sub { kernel_version_at_least(3, 10, 0) ? "nct6775" : "w83627ehf" },
>  		devid => 0xB470,
>  		devid_mask => 0xFFF0,
>  		logdev => 0x0b,
> 
> 

I got negative feedback from my testing user, there's something wrong
with this patch, please disregard for now, sorry for the noise.

-- 
Jean Delvare
SUSE L3 Support

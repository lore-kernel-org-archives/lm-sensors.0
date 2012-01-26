From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 26 Jan 2012 18:05:57 +0000
Subject: Re: [lm-sensors] [PATCH 2/2] hwmon: (lm87) Get rid of macro-generated functions
Message-Id: <1327601157.2649.222.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20120126154324.1c7d0702@endymion.delvare>
In-Reply-To: <20120126154324.1c7d0702@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 2012-01-26 at 09:43 -0500, Jean Delvare wrote:
> Use SENSORS_DEVICE_ATTR instead of DEVICE_ATTR for most attributes,
> so that the attribute number can be retrieved and it is no longer
> necessary to generate functions using macros.
> 
> This shaves about 2 kB on the binary module size.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
> Tested on an emulated LM87 chip.
> 
>  drivers/hwmon/lm87.c |  350 ++++++++++++++++++++++----------------------------
>  1 file changed, 160 insertions(+), 190 deletions(-)

Nice cleanup. Applied.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

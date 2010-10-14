From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 14 Oct 2010 13:20:39 +0000
Subject: Re: [lm-sensors] Detection of W83L771W/G in lm90
Message-Id: <20101014132039.GA19951@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101014114626.7c4be041@endymion.delvare>
In-Reply-To: <20101014114626.7c4be041@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Oct 14, 2010 at 05:46:26AM -0400, Jean Delvare wrote:
[ ... ]
> +		if ((reg_config1 & 0x2A) = 0x00
> +		 && (reg_config2 & 0xF8) = 0x00) {
> +			if ((chip_id & 0xFE) = 0x10 /* W83L771AWG/ASG */
> +			 && reg_convrate <= 0x08) {
> +				name = "w83l771";
> +			} else
> +			if (chip_id = 0x01 /* W83L771W/G */
> +			 && reg_convrate <= 0x09) {
> +				name = "w83l771";
> +			}

If the chips have a different maximum conversion rate, that should probably be reflected 
in .max_convrate as well. Unless you want to ignore it on purpose for simplicity ...
which is fine with me.

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

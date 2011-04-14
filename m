From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 14 Apr 2011 21:38:36 +0000
Subject: Re: [lm-sensors] [PATCH v2 3/4] hwmon: (sht15) add support for the
Message-Id: <1302817116.26780.580.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1302636879-16615-4-git-send-email-vivien.didelot@savoirfairelinux.com>
In-Reply-To: <1302636879-16615-4-git-send-email-vivien.didelot@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2011-04-12 at 15:34 -0400, Vivien Didelot wrote:
> * Add support for:
>   - Heater.
>   - End of battery notice.
>   - Ability not to reload from OTP.
>   - Low resolution (12bit temp, 8bit humidity).
> * Add an utility function to read individual bytes from the device.
> 
> Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>

Applied to -next.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

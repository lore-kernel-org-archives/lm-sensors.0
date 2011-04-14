From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Thu, 14 Apr 2011 21:39:03 +0000
Subject: Re: [lm-sensors] [PATCH v2 4/4] hwmon: (sht15) add support for CRC
Message-Id: <1302817143.26780.581.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1302636879-16615-5-git-send-email-vivien.didelot@savoirfairelinux.com>
In-Reply-To: <1302636879-16615-5-git-send-email-vivien.didelot@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2011-04-12 at 15:34 -0400, Vivien Didelot wrote:
> From: Jerome Oufella <jerome.oufella@savoirfairelinux.com>
> 
> The sht15 sensor allows validating exchanges to and from the device
> using a crc8 function. An utility function to reverse a byte has also
> been added.
> 
> Signed-off-by: Jerome Oufella <jerome.oufella@savoirfairelinux.com>

Applied to -next.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

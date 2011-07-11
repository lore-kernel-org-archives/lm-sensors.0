From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Mon, 11 Jul 2011 18:44:21 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (it87) Fix label group removal
Message-Id: <1310409861.25412.35.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <20110711193528.25fed27f@endymion.delvare>
In-Reply-To: <20110711193528.25fed27f@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 2011-07-11 at 13:35 -0400, Jean Delvare wrote:
> A copy-and-paste error caused it87_attributes_vid to be referenced
> where it87_attributes_label should be. Thankfully the group is only
> used for attribute removal, not attribute creation, so the effects of
> this bug are limited, but let's fix it still.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: stable@kernel.org

Acked-by: Guenter Roeck <guenter.roeck@ericsson.com>



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

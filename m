From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 09 Nov 2010 02:44:39 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (ad7414) Return proper error code
Message-Id: <20101109024439.GB20251@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1289266834.14461.3.camel@mola>
In-Reply-To: <1289266834.14461.3.camel@mola>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Axel Lin <axel.lin@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, Sean MacLennan <smaclennan@pikatech.com>

On Mon, Nov 08, 2010 at 08:40:34PM -0500, Axel Lin wrote:
> Return proper error if i2c_check_functionality reports
> the adapter does not support the capability we need.
> 
> Also remove unneeded initialization for err variable.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>

Applied.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

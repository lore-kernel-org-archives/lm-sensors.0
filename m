From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 06 Apr 2011 06:50:48 +0000
Subject: Re: [lm-sensors] [PATCH 1/1] [hwmon] nct1008: Initial NCT1008 driver
Message-Id: <20110406065048.GA23290@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1302059183-29631-1-git-send-email-achew@nvidia.com>
 <20110406050929.GA22741@ericsson.com>
In-Reply-To: <20110406050929.GA22741@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "achew@nvidia.com" <achew@nvidia.com>
Cc: "wni@nvidia.com" <wni@nvidia.com>, "w30289@motorola.com" <w30289@motorola.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>, "olofj@chromium.org" <olofj@chromium.org>, "toddpoynor@google.com" <toddpoynor@google.com>

On Wed, Apr 06, 2011 at 01:09:29AM -0400, Guenter Roeck wrote:
> On Tue, Apr 05, 2011 at 11:06:23PM -0400, achew@nvidia.com wrote:
> > From: Andrew Chew <achew@nvidia.com>
> >
> > This is a digital temperature sensor I2C peripheral from ON Semiconductor.
> >
> > Signed-off-by: Andrew Chew <achew@nvidia.com>
> 
> Comments inline. Note that this is not a complete review.
> 
Actually, turns out it would be much simpler to add support for this chip
to the lm90 driver. It is pretty much identical to ADT7461. Even more
interesting is that the chip ID is identical to the ADT7461A chip ID.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

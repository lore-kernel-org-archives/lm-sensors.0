From: "Ira W. Snyder" <iws@ovro.caltech.edu>
Date: Wed, 07 Oct 2009 15:18:48 +0000
Subject: Re: [lm-sensors] [PATCH] ltc4215/ltc4245: Discard obsolete detect
Message-Id: <20091007151847.GA8496@ovro.caltech.edu>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090920151627.76dd424e@hyperion.delvare>
In-Reply-To: <20090920151627.76dd424e@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Linux I2C <linux-i2c@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

On Sun, Sep 20, 2009 at 03:16:27PM +0200, Jean Delvare wrote:
> There is no point in implementing a detect callback for the LTC4215
> and LTC4245, as these devices can't be detected. It was there solely
> to handle "force" module parameters to instantiate devices, but now
> we have a better sysfs interface that can do the same.
> 
> So we can get rid of the ugly module parameters and the detect
> callbacks. This shrinks the binary module sizes by 36% and 46%,
> respectively.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Ira W. Snyder <iws@ovro.caltech.edu>
> ---
> Ira, can you please test and confirm it works OK for you?
> 

I've finally gotten around to testing this. I applied it to 2.6.31.2.
Testing shows no problems at all. The devices are both automatically
bound by the OF device tree, just like before.

You've got my ACK.

Ira

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

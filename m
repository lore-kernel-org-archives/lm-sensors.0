From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Date: Mon, 11 Apr 2011 19:03:25 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] hwmon: (sht15) general code clean-up
Message-Id: <1302547369-sup-2609@sfl>
List-Id: <lm-sensors.vger.kernel.org>
References: <1302198246-22212-2-git-send-email-vivien.didelot@savoirfairelinux.com>
In-Reply-To: <1302198246-22212-2-git-send-email-vivien.didelot@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Excerpts from Jonathan Cameron's message of 2011-04-08 14:17:54 -0400:
> My one question on this is in the header.  Why the extra indent?
> Maybe it looks a smigeon clearer but I'm far from convinced by that
> bit.

The extra indentation in the clean-up patch is made to align the
existing attributes (or macros) with the new ones introduced in the
following patchs, which have longer names (such as
SHT15_STATUS_LOW_BATTERY or last_measurement).

> I agree most of yours are clearer.  Measurements rather than
> measures would be even better. 

ok, I've changed measures for measurements.

> Also, I'd have preferred to see the fixes separated out from the
> purely superficial name changes etc.  They are both worth while, but
> only one changes what actually happens in the driver!

I agree. I've separated the probe function clean-up into a separated
patch.

Vivien.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Tue, 12 Apr 2011 08:02:05 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] hwmon: (sht15) general code clean-up
Message-Id: <4DA406FD.70103@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <1302198246-22212-2-git-send-email-vivien.didelot@savoirfairelinux.com>
In-Reply-To: <1302198246-22212-2-git-send-email-vivien.didelot@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 04/11/11 20:03, Vivien Didelot wrote:
> Excerpts from Jonathan Cameron's message of 2011-04-08 14:17:54 -0400:
>> My one question on this is in the header.  Why the extra indent?
>> Maybe it looks a smigeon clearer but I'm far from convinced by that
>> bit.
> 
> The extra indentation in the clean-up patch is made to align the
> existing attributes (or macros) with the new ones introduced in the
> following patchs, which have longer names (such as
> SHT15_STATUS_LOW_BATTERY or last_measurement).
Fair enough. It might ideally have occurred in that patch as then the
reason would have been obvious!

Still, it's to early in the morning and I'm just being fussy ;)


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

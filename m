From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 18 Jan 2011 16:32:46 +0000
Subject: Re: [lm-sensors] Sandy Bridge support?
Message-Id: <20110118173246.3bf26fbe@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <0022152d6d71d9f528049a109a02@google.com>
In-Reply-To: <0022152d6d71d9f528049a109a02@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Nick,

On Tue, 18 Jan 2011 10:03:23 -0600, Nick Hall wrote:
> Thanks, I checked and my motherboard did indeed have that chip. The only
> difference, if it matters, is that under the "IT8728F" mine had "1039-CXS"
> and "ZC46FBGB".

OK, thanks. If you feel lucky, you may try to load the it87 driver with
parameter force_id, to force the driver to consider your chip as one it
supports. Given the name of your device, the first values to try would
be 0x8721 and 0x8720 (the two most recent chips) or 0x8718 (in case the
IT8728F is an evolution of the IT8718F - I remember the IT8716F and
IT8726F were compatible.) If you give this a try, please let us know
the results.

Or you can wait for us to get a datasheet for the IT8728F. We currently
don't have it. The device isnt' even listed on ITE's website.

> And regarding the sensors-detect script, I understand now. If anyone is
> interested, my Sandy Bridge processor would be model "0x2A" according to how
> that script does things.

This is an option, yes, but it would be better if we could implement
the same detection logic as the coretemp driver has. For one thing, this
would guarantee that the two are always in sync. For another, it would
lower the maintenance effort from our side, as the new detection logic
is universal and doesn't need to be updated with every new CPU model.
I'm looking into it but this is non-trivial.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

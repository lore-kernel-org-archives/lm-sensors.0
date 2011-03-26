From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 26 Mar 2011 21:50:31 +0000
Subject: Re: [lm-sensors] [RFC PATCH 3/3] hwmon: sht15: add support for
Message-Id: <20110326225031.274d9924@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1300301050-15529-4-git-send-email-vivien.didelot@savoirfairelinux.com>
In-Reply-To: <1300301050-15529-4-git-send-email-vivien.didelot@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 21 Mar 2011 20:29:57 -0400, Vivien Didelot wrote:
> On Mon, Mar 21, 2011 at 07:55:20PM +0000, Jonathan Cameron wrote:
> > Hang on, so the original crc patch is broken?  Please rework this series
> > so that patch is valid in the first place!
> The original patch is not broken. The CRC calculation uses the lower nibble
> of the status register, which is 0 by default. This 'fix' comes here
> because this patch allow to change the status register, that is to say the
> lower nibble.
> It does not make sense to fix it in the first patch, before add the support
> to write the status register (even read it). Don't you agree?

I don't. Sure, the hardware default for the low nibble of the "status"
register is 0, and the driver was leaving it untouched so far, but that
doesn't mean that the BIOS or firmware didn't change it before the
sht15 driver got loaded. The patch adding support for checksum
validation should handle this case properly.

> > (...)
> > It's times like this when you wonder who decided to call it status on the
> > datasheet.  Now state would be a reasonable name, but the concept of changing
> > status seems a little odd!

I guess it was difficult to find a suitable name, given that the high
nibble of the register holds status bits and the low nibble holds
configuration bits.

> You're right. Should I rename every sht15_*_status() functions into
> sht15_*_state()?

My opinion on this (which you are free to listen to or ignore): "state"
is hardly better than "status" to describe this register. So I would
either stick to "status" to match the datasheet, or go for "config" to
reflect the nature of the writable bits of the register.

Good night,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Date: Tue, 29 Mar 2011 20:27:12 +0000
Subject: Re: [lm-sensors] [RFC PATCH 3/3] hwmon: sht15: add support for
Message-Id: <1301429985-sup-4779@sfl>
List-Id: <lm-sensors.vger.kernel.org>
References: <1300301050-15529-4-git-send-email-vivien.didelot@savoirfairelinux.com>
In-Reply-To: <1300301050-15529-4-git-send-email-vivien.didelot@savoirfairelinux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Excerpts from Jean Delvare's message of 2011-03-26 17:50:31 -0400:
> I don't. Sure, the hardware default for the low nibble of the "status"
> register is 0, and the driver was leaving it untouched so far, but that
> doesn't mean that the BIOS or firmware didn't change it before the
> sht15 driver got loaded. The patch adding support for checksum
> validation should handle this case properly.
That's right. I'll switch the two patches. Firstly, the status
register support, then the CRC support.
> I guess it was difficult to find a suitable name, given that the high
> nibble of the register holds status bits and the low nibble holds
> configuration bits.
> 
> > You're right. Should I rename every sht15_*_status() functions into
> > sht15_*_state()?
> 
> My opinion on this (which you are free to listen to or ignore): "state"
> is hardly better than "status" to describe this register. So I would
> either stick to "status" to match the datasheet, or go for "config" to
> reflect the nature of the writable bits of the register.
I think I'll keep "status" because it won't make sense to write a
SHT15_CONFIG_BATTERY to match the battery state bit.
> 
> Good night,

Regards,
Vivien.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

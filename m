From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:12 +0000
Subject: Tyan S2882 (ticket #1756)
Message-Id: <20040817154118.M12887@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Alex,

Regarding ticket #1756, I have not much idea what you are supposed to do. Tyan
should know their motherboard and hopefully provide working configuration
files for them. Maybe you could get in touch with them if you can't get it to
work?

I seriously doubt that the same sensor could be used by two chips. For one
thing, it wouldn't be very useful. For another, it would be technically difficult.

The high temperatures you obtain are not impossible if they are reported by
CPU built-in thermal diodes (very near from the CPU core) and the fans are
insufficent. Maybe you should consider that case. After all, this is why
monitoring is important ;)

I remember one post on LKML about the S2882:
http://marc.theaimsgroup.com/?l=linux-kernel&m8237636318994&w=2
You may want to get in touch with that person and share your experience together.

Also, one thing made me curious in your report:

> adm1027-i2c-1-2e
> Adapter: SMBus AMD756 adapter at 50e0
> ERROR: Can?t get alarm mask data!

This isn't supposed to happen. Could you check that the lm85 driver exports an
"alarms" file and that you can read from it using "cat"? I wonder what's going
on. If you can read from the file (meaning that the driver itself is OK),
please strace sensors and report. You may consider unloading other chip
drivers such as w83627hf for a shorter report (or specifically ask sensors for
the adm1027 only).

Let us know if you learn something about the configuration issue, so that I
can update the ticket.

Thanks.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/

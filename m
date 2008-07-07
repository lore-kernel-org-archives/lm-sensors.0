From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 07 Jul 2008 07:14:04 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: it87 support for 16-bit fan reading
Message-Id: <20080707091404.2d5309d2@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <76366b180802102232o60442894gfca038eb4b6f181d@mail.gmail.com>
In-Reply-To: <76366b180802102232o60442894gfca038eb4b6f181d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Andrew,

On Sun, 6 Jul 2008 20:52:40 -0400, Andrew Paprocki wrote:
> On Sun, Jul 6, 2008 at 7:16 AM, Jean Delvare <khali@linux-fr.org> wrote:
> 
> > can't test. Someone with such a chip (you?) could attempt to reset it
> > (write 1 to bit 7 of register 00h) and check what the default value
> > of register 0Bh actually is.
> 
> I tested this, and the value is in fact 09h. I did this as the first
> thing in it87_init_device():
> 
> it87_write_value(data, 0x00, 1<<7);
> tmp = it87_read_value(data, IT87_REG_FAN_DIV);
> 
> As you said, it doesn't really matter, because the chips that support
> 16-bit will use it now.
> 
> > So maybe we should simply always enable all of fan1, fan2 and fan3,
> > regardless of what the BIOS did. That's a one-line change as far as I
> > can see, fairly simple.
> 
> I'm in favor of that. It can't do any harm, really, as everyone
> controls what inputs/temps/fans are ignored via sensors.conf anyway.

My hope was to make the configuration a bit easier by not presenting to
the users fan inputs which were not used on their systems. But this
only works if the BIOS plays the game, and experience has shown that it
does not always do.

> Should I submit a separate patch for that?

Yes please.

> > revisions >= J as far as I can see. This makes me wonder why your patch
> > doesn't also cover revision I, as it already had 16-bit fan speed
> > registers and the 2 extra fans as well.
> 
> I updated the documentation in the patch I'll post next. I went back
> and looked at the I datasheet, and you are correct. It (rev 07h)
> supports both 8-bit and 16-bit modes, and the fan divisors were simply
> dropped in rev 08h. I modified the patch to check for rev >= 07h.

Good.

> I also noticed the documentation mentioned that later IT8705F
> revisions also support 16-bit fans. I looked at the only datasheet
> currently online (Version G) and it does indeed support the same
> registers. I will submit a patch to enable 16-bit on this chip as
> well. Do you happen to have any older datasheets for this chip? I'll
> enable 16-bit for >= rev 05h (G), but if you have data showing it
> exists in an earlier revision than that, please let me know. Also, is
> Version G actually rev 05h? The G datasheet says the default value for
> the 22h register is 03h and does not enumerate the version values like
> the IT8712F datasheet. What revision does your chip report?

My IT8705F chip reports:
it87: Found IT8705F chip at 0x290, revision 2

That would correspond to "rev. F" in the datasheets. My personal notes
on the IT8705F revisions are:

IT8705F rev. F: 0x02
IT8705F rev. G: 0x03 (datasheet v0.4.1)

My rev. F chip has no register 0Ch, so it definitely doesn't support
16-bit mode. So you would test for revision code >= 0x03 for the
IT8705F. Should be fairly easy after the patch you've just written.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

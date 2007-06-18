From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 18 Jun 2007 08:29:00 +0000
Subject: Re: [lm-sensors] sensor-detect and non-compliant SMSC Super I/Os
Message-Id: <20070618102900.6d036951@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0706111131w61cc4abfo31ba33bba90a3314@mail.gmail.com>
In-Reply-To: <191fb4ca0706111131w61cc4abfo31ba33bba90a3314@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

On Sun, 17 Jun 2007 20:59:18 -0700, Juerg Haefliger wrote:
> On 6/16/07, Jean Delvare <khali@linux-fr.org> wrote:
> > OTOH, standard LPC chips don't have anything at 0x0d (a read will
> > return 0xff, or possibly 0x00?) so you should be able to tell standard
> > chips from non-standard ones that way.
> 
> Is that true for all standard LPC chips? The ISA PNP spec just list
> this address as part of a reserved card-level address range.

This is my experience at least, and "reserved for future use" in a 1994
specification pretty much means "unused forever", don't you think? ;)

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

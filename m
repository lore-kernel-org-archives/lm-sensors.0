From: RusH <citizenr@gmail.com>
Date: Mon, 02 Apr 2007 17:26:20 +0000
Subject: Re: [lm-sensors] Asus smbus mux
Message-Id: <3df49b7b0704021026u71c2e2f1j20fd9e31116f9ba2@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3df49b7b0704011722q1201063eh37253910ddb1e004@mail.gmail.com>
In-Reply-To: <3df49b7b0704011722q1201063eh37253910ddb1e004@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 4/2/07, Jean Delvare <khali@linux-fr.org> wrote:
> Please reply to the list, rather than to me only. The whole point is to
> get the information archived for later use.

sorry, Im learning to use gmail with lists (and forgot the 'reply all')

> > Well, it is now since I got the code :) (clean with no disclaimers/nda crap).
> > I can strip it further to bare specs and post it here.
>
> Yes, please do so.

ok

> > > We don't yet support I2C/SMBus multiplexing, but when we do
> >
> > well, actually I saw some tyan code supporting it allready, plus
> > i2c-virtual from 2002
>
> Except that i2c-virtual is a Linux 2.4 driver and does not even work.
> It would need changes to i2c-core which will never happen in Linux 2.4,
> but will be considered for 2.6 someday.
>
> As for the "tyan code", I guess you refer to my i2c-amd756-s4882 driver?
> This is a dedicated driver for only one board, not a generic solution.

I know, that was also the plan for my board (A7V133)

> We cannot do that for all motherboards out there, in particular we
> don't want to do that just to give access to some SPD EEPROMs, the cost
> is too high for the thin benefit.

I understand. Arent clock generators on the smbus too? Not that acces
to them is important or particularly safe.

-- 
Who logs in to gdm? Not I, said the duck.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

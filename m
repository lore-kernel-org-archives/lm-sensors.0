From: "David Hubbard" <david.c.hubbard@gmail.com>
Date: Wed, 28 Mar 2007 17:20:47 +0000
Subject: Re: [lm-sensors] get rid of i2c-isa - h now - fixes of w82627ehf
Message-Id: <4dfa50520703281020n2ee11acdg84b9812105ac4b78@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <45F47B44.8010108@assembler.cz>
In-Reply-To: <45F47B44.8010108@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

I'm going to put in an hour or so and incorporate the changes Jean suggests:

On 3/12/07, Jean Delvare <khali@linux-fr.org> wrote:
> I would have prefered a separate patch for that, now it makes you patch
> even larger (39 kB). Same goes for the help text updates in Kconfig.

(snip)

> What you are doing here is pretty much the opposite of the fix Petr
> committed over a year ago. So I think you should back up this change.

(snip)

> > +enum kinds { w83627ehf, w83627ehg, w83627dhg };
>
> Why define a separate kind for w83627ehg given that you treat it
> everywhere as a w83627ehf? I think it's convenient that the enum matches
> the prefixes used in every driver.

(things I'll work on in here, but snipped)

> I suggest adding warning messages when the base I/O isn't set and when
> we need to forcibly enable the device, as I did in the w83627hf driver.
> This will make support easier.

I'll still need review of the patch when I've done this, so I'll post back then.

David

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

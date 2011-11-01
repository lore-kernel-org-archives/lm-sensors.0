From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 01 Nov 2011 09:35:59 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] hwmon: (w83627ehf) Add support for the
Message-Id: <20111101103559.4d482d96@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20111031152342.15f99729@endymion.delvare>
In-Reply-To: <20111031152342.15f99729@endymion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Mon, 31 Oct 2011 14:27:31 -0700, Guenter Roeck wrote:
> On Mon, 2011-10-31 at 17:03 -0400, Jean Delvare wrote:
> > The W83627UHG is clearly on the side of the W83627DHG. The decision of
> > splitting NCT677[56] support to a separate driver is unrelated IMHO.
> > The rationale is that the w83627ehf driver code has become quite
> > complex (it's the 3rd hwmon driver by size out of 117!) and a lot of the
> > code recently added only applies to the NCT677[56]. If future devices
> > are almost compatible with the NCT677[56] but not quite, things will
> > only become worse.
>
> There is at least one new Nuvoton chip which is completely microcode
> programmed (NCT6681D). Nuvoton advertises it as "the first IC of
> Nuvoton`s new product line, or eSIO". Not entirely sure what that means,
> but it almost looks like we may have reached the end of the hard-core
> LPC devices.

Abit has been using a similar Winbond chip in the past (W83L950D) for
its =B5Guru line of hardware monitoring chips. They have since then
reverted to more conventional Super-I/O chips.

From our perspective, programmable chips are likely to be a problem, as
getting specifications for these will be even harder than getting
datasheets for traditional chips. As a matter of fact, =B5Guru support
was made by reverse engineering and trial and error. Pretty painful.

But anyway I wouldn't jump to a conclusion too quickly, let's see what
happens in the months to come first.

> Two other currently not supported chips are NCT5577D, which seems to be
> a variant of NCT677[56]F, and W83527HG, which seems to be somewhere in
> between NCT6775F and earlier chips.

I'm a little skeptical about the W83527HG, according to its datasheet
it has the same device ID as the W83627DHG-P. I'll ask Nuvoton.

Anyway, even adding support for one or two additional chips to the
w83627ehf driver as it exists today could be challenging, if they are
somewhat significantly different from what we support today.

> > With separate drivers, the code would become easier to read IMHO.
> > Obviously this implies some code duplication but I believe we reached
> > the point where this should be considered. Another benefit is that we
> > could then have separate maintainers for the two drivers, so better
> > load balancing.
>
> Agreed.

--=20
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

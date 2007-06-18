From: "Juerg Haefliger" <juergh@gmail.com>
Date: Mon, 18 Jun 2007 03:59:18 +0000
Subject: Re: [lm-sensors] sensor-detect and non-compliant SMSC Super I/Os
Message-Id: <191fb4ca0706172059g66b07607sf10b7c64ffa064ff@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0706111131w61cc4abfo31ba33bba90a3314@mail.gmail.com>
In-Reply-To: <191fb4ca0706111131w61cc4abfo31ba33bba90a3314@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 6/16/07, Jean Delvare <khali@linux-fr.org> wrote:
> Hi Juerg,
>
> On Thu, 14 Jun 2007 12:26:25 -0700, Juerg Haefliger wrote:
> > On 6/12/07, Jean Delvare <khali@linux-fr.org> wrote:
> > > Same for me, it depends on how the code looks like. If it's clean and
> > > safe, no objection.
> > >
> > > I am curious how you can tell between the two types of register
> > > mappings? Is there a perfect solution, or do you have some heuristic?
> >
> > I can't tell. It's arbitrary. Some of these chips have the LPC base
> > address (0x2e/0x4e) in register 0x12 but not all of them of course.
> > SMSC doesn't make it easy for us...
>
> OTOH, standard LPC chips don't have anything at 0x0d (a read will
> return 0xff, or possibly 0x00?) so you should be able to tell standard
> chips from non-standard ones that way.

Is that true for all standard LPC chips? The ISA PNP spec just list
this address as part of a reserved card-level address range.


> > Anyways, below is a first shot. Let me know what you think, I'm sure
> > it has room for improvements :-)
>
> First of all, an improvement would be if your e-mail client didn't fold
> long lines...

Ah ja, sorry. Will attach patches in the future...


> For the code, it's way more complex than I hoped it would be. You went
> for a generic solution, which I agree is a good idea in general, but
> maybe not in this case. We don't know if other chip manufacturers will
> diverge from the standard, nor how they will diverge if they do. And we
> don't know if any of these non-SMSC chips has sensors. So I think I
> would prefer less intrusive SMSC-specific code as long as we don't need
> more.
>
> More specifically, we could add an optional callback function for each
> family, which would be called before the standard detection for this
> family. Depending on the return value of this callback, the standard
> processing would be applied or skipped for this family. So, in the case
> of these SMSC chips, the callback would read from 0x0d, and if the
> value is neither 0xff nor 0x00, a separate list of known non-standard
> SMSC chips would be processed, and standard processing would be skipped.
>
> What do you think?

Sounds fine. I don't care too much even though I wouldn't call the
changes complex. I'll give it a try and we'll see how complicated
it'll be.

...juerg


> --
> Jean Delvare
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: bezaur@gmail.com (Charles Spirakis)
Date: Thu, 03 Aug 2006 07:55:50 +0000
Subject: [lm-sensors] Patch to fully support W81791D
Message-Id: <5bfe43f80608030055n77c1384al887bf0b87f440a1b@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <5bfe43f80607101040q5fe64dfdi4e7e2ce349407d62@mail.gmail.com>
In-Reply-To: <5bfe43f80607101040q5fe64dfdi4e7e2ce349407d62@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean --

I can't speak for the 2.4 driver, but the testing that I did for the
2.6 driver was based on the values in /sys. The biggest changes Sven
found were that the user-mode sensors tool wasn't showing all the
values from the w83791d that it could. Sven provided a patch for this
which will be submitted in a separate email.

As for driver bugs, Sven did find one of those too - the beep enable
and the realtime status bits don't completely match the documentation
and one of the beep enable bits needs to be swapped. A second patch
will be submitted for this.

-- charles


On 7/28/06, Charles Spirakis <bezaur at gmail.com> wrote:
> I'll give it a try.
>
> Sven and I were also talking about a patch to the w83791d driver to
> fix some of the beep/realtime status bits as the documentation doesn't
> seem to match the hardware. I'll try to get that to the lmsensors
> mailing list over the weekend.
>
> -- charles
>
>
> On 7/28/06, Jean Delvare <khali at linux-fr.org> wrote:
> > > -----BEGIN PGP SIGNED MESSAGE-----
> > > Hash: SHA1
> > >
> > > Jean Delvare schrieb:
> > > > Charles, Sven,
> > > >
> > > >>> I've attached a patch to fully support the W81791D chip, which is part of the
> > > >>> coming kernel 2.1.18.
> > > >>>
> > > >>> Partial support was alredy implemented, but it was missing IN9/FAN4/FAN5 output.
> > > >>>
> > > >>> Please add it to the SVN.
> > > >
> > > > Where is this patch, please?
> > >
> > > It was attatched - I checked it...
> >
> > I guess you had only sent it to Charles, who has no write access to the
> > repository. At least I did not receive your original post and I can't
> > see it in the mailing list archive either.
> >
> > > But in case, something went wrong - here it comes again...
> >
> > Great, thanks. Charles, can you please review and test the patch? Then
> > I'll apply it if it has no problem.
> >
> > I'm very surprised that this support was missing since the W83791D
> > support was added. This means that parts of the drivers (w83781d in 2.4
> > and w83791d in 2.6) were never actually exercised.
> >
> > Thanks,
> > --
> > Jean Delvare
> >
>


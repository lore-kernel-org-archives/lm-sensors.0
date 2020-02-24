From: Sandeep <sandy.8925@gmail.com>
Date: Mon, 24 Feb 2020 16:54:28 +0000
Subject: Re: ignore setting in sensors.conf only works with lowercase arguments
Message-Id: <CAGPDPzAwTXksS+sgHmCY3t3Tm7FN8T8oEJKsj5ZuORFY-Stbvw@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAGPDPzCctbDzVm1WsiZeN-ObkMUt76hJSbC3EnQ5nadnZTTjzw@mail.gmail.com>
In-Reply-To: <CAGPDPzCctbDzVm1WsiZeN-ObkMUt76hJSbC3EnQ5nadnZTTjzw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Thank you, that solved my problem!

Yours sincerely,
Sandeep

On Mon, 24 Feb 2020 at 14:32, Ondřej Lysoněk <olysonek@redhat.com> wrote:
>
> Hi,
>
> Sandeep <sandy.8925@gmail.com> writes:
>
> > Hello,
> >
> > There are some sensor inputs such as "CPUTIN" for my motherboard's
> > sensor chip, which have a default bogus value. I attempted to use an
> > ignore line in sensors.conf to block this entry, but noticed that it
> > didn't work.
> >
> > I tried using ignore for a different lowercase label (e.g "fan1" ) and
> > it was ignored as expected.
> >
> > It seems that ignore assumes that the argument will be lowercase only,
> > and refuses to work otherwise. Even if I use "ignore cputin" it
> > doesn't work.
> >
> > Can you please fix this?
>
> I think there's nothing to fix. You just need to use the real name of
> the input (such as 'temp2') in the 'ignore' statement. What you're using
> ('CPUTIN') is the label of the input. You can use 'sensors -u' to find
> out the real name.
>
> Ondra
>
> >
> > Yours sincerely,
> > Sandeep
>

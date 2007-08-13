From: "dave jones" <s.dave.jones@gmail.com>
Date: Mon, 13 Aug 2007 06:18:26 +0000
Subject: Re: [lm-sensors] How to define IN_TO_REG and IN_FROM_REG in
Message-Id: <5628d8010708122318v4dddea51r2f9a5e50afd506db@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <5628d8010708090151y3f14d2edh783cf86429e01259@mail.gmail.com>
In-Reply-To: <5628d8010708090151y3f14d2edh783cf86429e01259@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 8/10/07, Juerg Haefliger wrote:
> Hi Dave,,

Hi Juerg,

> > > Hi Dave,
> >
> > Hi Jeurg,
> >
> > > > Hello,
> > > >
> > > > I don't understand why the IN_TO_REG(val) is defined by
> > > > (SENSORS_LIMIT((((val) + 8)/16),0,255))
> > >
> > > (val+8)/16 is equal to val/16 with rounding, i.e. round(val/16), and
> > > then the result is clipped to stay within the range 0-255.
> >
> > Thanks. But I just don't understand why the variable val plus 8? How
> > do you know?
>
> The kernel can't do floating point arithmetic, it truncates the
> results. So we have to add (divisor/2) before doing the division to
> achieve rounding. For example if val=8, (8/16) would result in 0 (in
> the kernel). But round(8/16) is actually 1, which is what we want. We
> achieve this by adding 8 (which is 16/2) before dividing by 16.
>
> Bottom line, you have to add (divisor/2) before dividing to get
> correct rounding of the result.
>
>
> > Another example I see is IN_TO_REG(val) defined:
> >
> >  (SENSORS_LIMIT((((val)  + 4 / 8),0,255)), why is val plus 4? why not 8? Thanks.
>
> Same here 4 is divisor/2 (8/2).

Thank you for your clear explanation. Now I completely understand,
thank you very much!
I'd really appreciate!
>
> ...juerg
>
>
> > >
> > > Hope this helps
> > > ...juerg
> > >
> > >
> > > > and IN_FROM_REG(val) is
> > > > defined by ((val) * 16)
> > > >
> > > > Would you teach me? Thank you.
> > > >
> > > > BR,
> > > > Dave.
> > > >
> >
> > BR,Dave.
> >
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

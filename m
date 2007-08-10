From: "dave jones" <s.dave.jones@gmail.com>
Date: Fri, 10 Aug 2007 14:10:57 +0000
Subject: Re: [lm-sensors] How to define IN_TO_REG and IN_FROM_REG in
Message-Id: <5628d8010708100710m3c26c76chddfdef4b42b35b39@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <5628d8010708090151y3f14d2edh783cf86429e01259@mail.gmail.com>
In-Reply-To: <5628d8010708090151y3f14d2edh783cf86429e01259@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 8/9/07, Juerg Haefliger wrote:
> Hi Dave,

Hi Jeurg,

> > Hello,
> >
> > I don't understand why the IN_TO_REG(val) is defined by
> > (SENSORS_LIMIT((((val) + 8)/16),0,255))
>
> (val+8)/16 is equal to val/16 with rounding, i.e. round(val/16), and
> then the result is clipped to stay within the range 0-255.

Thanks. But I just don't understand why the variable val plus 8? How
do you know?
Another example I see is IN_TO_REG(val) defined:

 (SENSORS_LIMIT((((val)  + 4 / 8),0,255)), why is val plus 4? why not 8? Thanks.
>
> Hope this helps
> ...juerg
>
>
> > and IN_FROM_REG(val) is
> > defined by ((val) * 16)
> >
> > Would you teach me? Thank you.
> >
> > BR,
> > Dave.
> >

BR,Dave.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

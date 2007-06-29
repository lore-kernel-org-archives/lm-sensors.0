From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 29 Jun 2007 21:10:01 +0000
Subject: Re: [lm-sensors] dme1737 / sch311x hybrid driver
Message-Id: <20070629231001.59677256@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0706281128l75612b36t7da3a07b4a5b73e8@mail.gmail.com>
In-Reply-To: <191fb4ca0706281128l75612b36t7da3a07b4a5b73e8@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 29 Jun 2007 13:25:56 -0700, Juerg Haefliger wrote:
> On 6/29/07, Jean Delvare <khali@linux-fr.org> wrote:
> > On Thu, 28 Jun 2007 11:28:18 -0700, Juerg Haefliger wrote:
> > > Not sure if option 3) is feasible. Sounds a little bit hacky and I
> > > don't know if it's even possible to register a 'bogus' i2c client or
> > > if it would break something somewhere that I'm not aware of.
> >
> > Option 3) has a name: i2c-isa. It took me years to get rid of it, and
> > I'm just there now. If you implement something similar again, I'll hate
> > you forever ;) So just forget about it, it's not going to happen.
> 
> :-) I knew about i2c-isa and its status. I was not planing on using
> it. I don't know, I thought it might be possible to just register the
> i2c client somehow without having an actual device behind it.

Possible, certainly. Acceptable, no ;-)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

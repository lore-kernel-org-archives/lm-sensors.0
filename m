From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 14 Aug 2007 19:26:06 +0000
Subject: Re: [lm-sensors] #2179: Treat strange fan speed (like 675 000 rpm)
Message-Id: <20070814212606.23d94610@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <2ecba3930708141118t4486af7bo425e1f89a7a1f72e@mail.gmail.com>
In-Reply-To: <2ecba3930708141118t4486af7bo425e1f89a7a1f72e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Piotr,

On Tue, 14 Aug 2007 20:18:23 +0200, Piotr Czepek wrote:
> 2007/8/13, lm-sensors <lm-sensors-notify@lm-sensors.org>:
> > #2179: Treat strange fan speed (like 675 000 rpm) as "0"
> > -------------------------------------+--------------------------------------
> >   Reporter:  piotr.czepek@gmail.com  |       Owner:  khali
> >       Type:  enhancement             |      Status:  assigned
> >   Priority:  minor                   |   Milestone:
> >  Component:  fancontrol              |     Version:
> > Resolution:                          |    Keywords:
> 
> > -------------------------------------+--------------------------------------
> > Changes (by khali):
> >
> >   * status:  new => assigned
> >   * reporter:  ticket => piotr.czepek@gmail.com
> >  * cc: piotr.czepek@gmail.com (removed)
> >   * component:  misc => fancontrol
> >   * priority:  trivial => minor
> >   * owner:  somebody => khali
> >   * keywords:  fan speed  driver =>
> >
> > Comment:
> >
> >  What driver are you using? I can't remember seeing a driver report high
> >  speeds for stopped fans.
> >
> >  I don't much like the idea of arbitrarily discarding some reported fan
> >  speed values. You should probably simply avoid using low duty cycle PWM if
> >  it results in bad speed readings. You may get better results by using a
> >  lower base frequency for the PWM.
> >
> > --
> > Ticket URL: <http://lm-sensors.org/ticket/2179#comment:1>
> > lm-sensors <http://lm-sensors.org/>
> > Linux hardware monitoring
> 
> Hi,
> 
> I use w83627hf driver.
> (...)

Please follow up in the ticket system (trac), not on the mailing list.
I'll reply there.

Axel, is it possible to remove the Reply-To header from the mails sent
by the trac ticket system? It is almost an invitation to do the wrong
thing, and that has happened a number of times already.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

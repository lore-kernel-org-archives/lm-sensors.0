From: Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Date: Sat, 23 Jun 2007 14:05:59 +0000
Subject: Re: [lm-sensors] Quick Question about latest IBM thinkpads!
Message-Id: <20070623140559.GB29917@khazad-dum.debian.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <524002.68161.qm@web82504.mail.mud.yahoo.com>
In-Reply-To: <524002.68161.qm@web82504.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 23 Jun 2007, Jean Delvare wrote:
> On Mon, 18 Jun 2007 21:24:04 -0300, Henrique de Moraes Holschuh wrote:
> > On Mon, 18 Jun 2007, Jean Delvare wrote:
> > > For the stable branch of lm-sensors, explicit support will be needed. If
> > > you plan to merge support in the 2.6.23 kernel, it would probably be a
> > > good thing to merge the user-space support now, so that it makes it into
> > > the next release (2.10.4) and is available when kernel 2.6.23-rc1 is
> > > released.
> > 
> > What needs to be done so that lm-sensors userspace will grok thinkpad-acpi
> > sensors?  Is there a howto somewhere?
> 
> If you followed the standard sysfs interface (and you really want to),

I did.  To the letter.  I even checked with you guys to make sure it was
100% correct on the PWM stuff :-)

> We don't have a HOWTO, but using a similar change as an example should
> make the job easy:
>   http://www.lm-sensors.org/changeset/4355

I will try. Thanks!

> If you have specific questions on the way, just ask and we'll try to
> help. I'll be happy to review (and test) your code when you're done.

I have one.  What is NOSYSCTL and VALUE()? (or where are them documented)?

-- 
  "One disk to rule them all, One disk to find them. One disk to bring
  them all and in the darkness grind them. In the Land of Redmond
  where the shadows lie." -- The Silicon Valley Tarot
  Henrique Holschuh

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

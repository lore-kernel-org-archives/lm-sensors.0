From: =?iso-8859-1?q?Hans-J=FCrgen_Koch?= <hjk@linutronix.de>
Date: Sun, 08 Apr 2007 19:18:15 +0000
Subject: Re: [lm-sensors] Proposal
Message-Id: <200704082118.15854.hjk@linutronix.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200704081630.17151.hjk@linutronix.de>
In-Reply-To: <200704081630.17151.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Am Sonntag 08 April 2007 20:56 schrieb Hans de Goede:

> >
> > Good point. Anyway, most sensor drivers have no way of knowing which of
> > their inputs are actually used. The LM93 driver I'm currently working on
> > is a monster that creates about 160 (!) sysfs files. I don't find it easy
> > to judge what's worse, having a few unused sysfs files or a large table
> > in kernel space.
>
> Only 160? My abituguru 1/2 driver creates 177 for my motherboard and even
> more on some others (it can detect used versus unused inputs). And the
> abituguru3 driver can create 230 with known motherboards, and if i wouldn't
> use the table approach it would create 384 entries. Sorry I'm bragging here
> I couldn't help myself, and hopefully this also makes it even clearer why I
> went with the table approach.
>
> Also notice that the table (except for the used entry) could be made so
> that it is freed after module initialisation (currently it isn't).
>

That's not bragging... I thank you for your explanations!

Cheers,
Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: "Juerg Haefliger" <juergh@gmail.com>
Date: Thu, 26 Jul 2007 15:08:09 +0000
Subject: Re: [lm-sensors] [PATCH] adt7470: Update sensors periodically via
Message-Id: <191fb4ca0707260808n5af0c37bmc1cf8e095ea5cf71@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070726010421.GM19586@tree.beaverton.ibm.com>
In-Reply-To: <20070726010421.GM19586@tree.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Darrick,

I guess I'm not seeing the big picture :-) The problem you're trying
to solve is that the reading of the registers takes a long time and
needs to be able to sleep?

> > Hi Darrick,
> >
> > Why using a workqueue at all? Can't you just run a timer and do the
> > update when it expires and restart the timer?
>
> Currently, I use mutexes (and msleep) which require the ability to
> sleep.  Timers can't sleep because they are implemented as a softirq.

True.


> That said, I think the solution is to have two workqueue items--one to
> start the read and another to run after the temperature sensors have
> been read.  The delays for both can be handled via schedule_delayed_work().
> It could be done with two timers and spinlocks, but ... yuck.

Hmm... Sounds rather complicated. Is there a problem with blocking
apps for that long?
How about forking off a kernel thread instead of using workqueues?

...juerg


> New patch forthcoming.
>
> --D
>
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.6 (GNU/Linux)
>
> iD8DBQFGqE2ga6vRYYgWQuURApRaAKCAKsf8b2EQWGDJ3TSFT4dDY5cNsACdFzlI
> yvfRi5A+xgLK8bJ7ea7oVZA> =8vm8
> -----END PGP SIGNATURE-----
>
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

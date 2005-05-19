From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:13 +0000
Subject: [PATCH] i2c driver changes 2.6.0-test3
Message-Id: <20030823212712.7b9e8357.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1060972405413@kroah.com>
In-Reply-To: <1060972405413@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> agreed. it causes lots of problems, e.g. "I loaded your driver and my
> PC beeped like crazy and then shut down".

Yes, I remember these ones.

> should we do this for 2.8.1?

It's not required. To me, 2.8.1 has to be released right after Linux
2.4.22 so that we can have our i2c subsystem go into Linux 2.4. The rest
if far less important. 




> Jean Delvare wrote:
> >>Why don't we just make it policy that now and in the future we don't
> >
> >>initialize the limits on the sensors?
> >>(...)
> > 
> > 
> > I think I agree. As long as it doesn't cause extra problems, I
> > believe the drivers should be kept as simple and "neutral" as
> > possible. If certain drivers really have to intialize limits for any
> > reason, it's OK, but I don't object against the default policy being
> > to not initialize.
> > 
> > (Which doesn't mean I'll rush to remove initializations in "my"
> > drivers".)
> > 
> > 
> >>We don't know in what crazy way a motherboard manufacturer may have
> >>wired or scaled the inputs and with the newer sensors, it's leading
> >to>shutdowns and fan spinup behavior that is "less than optimal".
> > 
> > 
> > In this precise case, the reason is not initializing, but
> > initializing with awful values. That's different.
> > 
> 


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

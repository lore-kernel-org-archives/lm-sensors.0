From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:05 +0000
Subject: SAA1064 sensors chip driver
Message-Id: <20030715204037.422a63e5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307131153.24333.sascha@akv-soft.de>
In-Reply-To: <200307131153.24333.sascha@akv-soft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > > Another small thing (@all *g*):
> > > Most of your modules lack the #ifdef MODULE...#endif construct
> > > usually embracing init_module and cleanup_module. That prevents
> > > most of these to run smoothly compiled into the kernel. Is this a
> > > bug or a feature?
> > 
> > Bug, definitely. I noticed this too, because I didn't do so in my
> > own driver... I'll check every driver tomorrow. Anyway, drivers that
> > get mkpatched must be OK, or I guess someone would have noticed, by
> > the time...
> 
> No, this isn't a bug.  The #ifdef MODULE is not needed anymore.  Just
> use:
> 	module_init(foo_init());
> 	module_exit(foo_exit());
> 
> and everything will work just fine for when the code is build as a
> module or within the kernel.

OK, thanks for the clarification :)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

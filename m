From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:17 +0000
Subject: problem with it87.o
Message-Id: <20030920190359.5693d31b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200308161353.53028.j.ellerbroek@student.tudelft.nl>
In-Reply-To: <200308161353.53028.j.ellerbroek@student.tudelft.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Thanks for replying, and don't worry about how long it took you, I'm
> in no hurry. In fact, I've replaced the case fan with a very silent
> 220V fan, which means I haven't got a problem with the sensors driver
> anymore. Should you want the information anyway to improve the modules
> or something like that just let me know, i'd gladly test it for you
> since you've been so helpful.

Yes, I'd appreciate if you could test. Maybe we could tweak our
initialization procedure, or provide an additional module parameter, in
order to prevent the problem you encountered.

> On Saturday 20 September 2003 10:56, you wrote:
> > > I still haven't been able to resolve my problem with the fan
> > > spinup, you asked for the value in 'alarms':
> > >
> > > cat /proc/sys/dev/sensors/it87-i2c-1-2d/alarms returns:
> > > 26130
> > >
> > > Do you think this problem can be resolved by means of a specific
> > > config, or is it really a driver problem?
> >
> > First, I'd like to apologize for the slow answer. I've been very
> > busy these days (moved in to a new place for a new job). If you're
> > still interested in solving your fan problem, here we go.
> >
> > It looks like one of the steps taken by the it87 module while
> > initializing your chipset doesnt please it. We simply have to find
> > out which one. For that, we'd need to see the configuration
> > register(s) state(s) before the module is loaded (which means the
> > module should not be loaded automatically at boot time).
> >
> > Run the following command (as root) before loading the module:
> > i2cdump 1 0x2d b > ~/it87-before-init.out
> >
> > Then, load the module, then unload it, and run the command again:
> > i2cdump 1 0x2d b > ~/it87-after-init.out
> >
> > And send us the two files so that we can analyze them.


-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

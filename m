From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Thu, 08 Sep 2005 16:25:15 +0000
Subject: [lm-sensors] i801_smbus 0000:00:1f.3: Bus collision!
Message-Id: <2538186705090806563ce902fd@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050907213603.GW8392@levanta.com>
In-Reply-To: <20050907213603.GW8392@levanta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 9/8/05, Richard Hirst <rhirst@levanta.com> wrote:

> > > The board has an mBMC which is basically working in that I can read
> > > the sensors either by 'ipmitool' or 'sensors'.
> > >
> > > However, round about every 10 reboots or so, I get the Bus collision
> > > message and the system locks up solid during boot after outputting a
> > > few messages such as
> > >
> > > i801_smbus 0000:00:1f.3: Bus collision!
> > > i801_smbus 0000:00:1f.3: Reset failed! (01)
> > > i801_smbus 0000:00:1f.3: Reset failed! (01)
> > > i801_smbus 0000:00:1f.3: Reset failed! (01)
> > > bmcsensors.o: Error 0xff on cmd 0xa/0x23; state = 2; probably fatal.
> > > i801_smbus 0000:00:1f.3: Reset failed! (01)
> > > i801_smbus 0000:00:1f.3: Reset failed! (01)
> > > i801_smbus 0000:00:1f.3: Reset failed! (01)

The bus collisions are expected - both the IPMI BMC (not bmcsensors
directly) and the i2c modules you have loaded are competing for the
smbus. However although I've done this (loaded both bmcsensors and i2c
modules and got bus collisions) its never resulted in a lockup.

> > > I'm assuming this indicates that two things have tried to use the
> > > i2c bus at the same time, and I guess one of them is the bmcsensors
> > > code.
No, not directly. bmcsensors uses the IPMI messaging interface to send
out queries to the IPMI BMC which then reads the sensors readings over
the i2c/smbus (which is sometimes shared with the system).

> > > I also tried adding code to check 'd->in_use' at the beginning of
> > > i801_start() because it looked to me like in_use should perhaps
> > > normally be zero at that point.  Don't know if that is valid, but
> > > I did get a few indications of i801_start() getting called with
> > > d->in_use non-zero.

The IPMI BMC won't be using the i801 interface driver...its basically
another computer on your motherboard :), I'd suspect the i2c drivers
or i801 are causing the system lockup, as Mark says though you
shouldn't be using both (but it shouldn't lockup IHMO).
 
> OK; at the point where it dies I certianly havn't used ipmitool.
> Not sure if startup scripts have used sensors or not.

You will encounter the same problems if you use ipmitool as frequently
while using sensors.

> > > c) could it be a bug triggered by the SMP kernel?
All my IPMI machines (and I venture to guess the vast majority of IPMI
boxes) are SMP so I doubt its an SMP problem.

> > >
> > > d) any suggestions as to where I go from here ;-)


> > Have you tried the openipmi mailing list?
> > http://lists.sourceforge.net/lists/listinfo/openipmi-developer
> 
> Yeah, that might be a good place to ask, thanks!

I don't think your problem has anything to do with the IPMI subsystem,
so that isn't a good place to ask.

Yani

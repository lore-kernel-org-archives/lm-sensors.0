From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:37 +0000
Subject: Regarding ticket #955
Message-Id: <3D5542C9.E7FFF276@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020728090837.QAYT12689.mf2@there>
In-Reply-To: <20020728090837.QAYT12689.mf2@there>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Great.
I'll fix up the makefile.

If it says i801smbus is already active, then you didn't need p4b_smbus
at all.
You should be able to modprobe i2c-i801.
If it fails, you probably need the parameter force=1 or the
force_addr=xxx parameter.

It looks like the driver could use a little fixing up to make this
easier
and automatically enable without force=1 like we do with
other drivers. I'll work on it.

mds


Pontus Edvardsson wrote:
> 
> Hi,
> I have successfully compiled p4b_smbus.o thanks to your mail. Insmod fails
> however, something about the i801smbus already active??
> 
> Thanks, Pontus
> 
> On Monday 29 July 2002 01.09, Mark D. Studebaker wrote:
> > Ticket #958 tells us that it's related to SMP.
> > With SMP off it will compile.
> >
> > Can you add -D__SMP__ to the compile line and see if that works?
> >
> > Pontus Edvardsson wrote:
> > > Hi,
> > >
> > > I've been trying to figure out what makes the difference between your and
> > > mine configuration, since you were able to compile the p4b_smbus.o
> > >
> > > I tried to compile on a 2.4.18 Debian system which failed, I also tried
> > > compiling on a 2.4.18 Mandrake system, which failed as well.
> > >
> > > Could you maybe send me your .config file for me to examine if you think
> > > it could have anything to do with my problem. If I could compile with
> > > yours unmodified .config it would be easier to isolate the problem,
> > > right? I have a PCI Promise TX2-133 IDE controller, for which I must at
> > > the moment patch my kernel to 2.4.19-rc3 to get working.
> > >
> > > Thanks, Pontus

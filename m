From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:25 +0000
Subject: Request for CVS access
Message-Id: <20011031100945.S5150@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20011030092230.V5150@Stimpy.netroedge.com>
In-Reply-To: <20011030092230.V5150@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


OK, no problem.  I'll check the logs.  BTW- check your CVS/Root file.
It should say:

:pserver:knobi@cvs.lm-sensors.nu:/home/cvs

Assuming that is correct, I'll double-check the config to make sure
things are right.


Phil

On Wed, Oct 31, 2001 at 07:04:37PM +0100, Martin Knoblauch wrote:
> phil@netroedge.com wrote:
> > 
> > If there isn't one yet for you, take the next free one in i2c-id.h.  I
> > don't see a reason why not.
> > 
> > Phil
> > 
> Phil,
> 
>  thanks. I tried to commit the change to the i2c-id.h file and got
> refused. And yes,
> I logged in using my private login :-( So, something seems wrong. Do I
> have to do something special at cvs-login? Sorry, I am not that familiar
> with CVS. At least it seems to protect the repository from th stupid 
> :-)
> 
> Martin
> 
> lx/i2c> cd kernel/
> Directory: /lhome/martink/lx/i2c/kernel
> i2c/kernel> cvs diff
> cvs server: Diffing .
> Index: i2c-id.h
> =================================> RCS file: /home/cvs/i2c/kernel/i2c-id.h,v
> retrieving revision 1.37
> diff -r1.37 i2c-id.h
> 130a131
> > #define I2C_DRIVERID_FSCSCY 1029
> i2c/kernel> cvs commit i2c-id.h
> cvs [server aborted]: "commit" requires write access to the repository
> cvs commit: saving log message in /tmp/cvsUaXtzZ
> i2c/kernel> more  /tmp/cvsUaXtzZ
> Add Id 1029 for Fujitsu Siemns Scylla Chip (MKN)
> 
> 
> > On Wed, Oct 31, 2001 at 08:42:31AM +0100, Martin Knoblauch wrote:
> > > phil@netroedge.com wrote:
> > > >
> > > > OK, done.  Let me know if you have any troubles.
> > > >
> > > > Phil
> > > >
> > > Phil,
> > >
> > >  thanks. One short question - how to obtain an "official" module-id. For
> > > my initial implementation I have just used 1029, which seemed to be the
> > > next free one.
> > >
> > > i2c-id.h:#define I2C_DRIVERID_FSCSCY 1029
> > >
> > > Martin
> > >
> > > > On Tue, Oct 30, 2001 at 02:44:29PM +0100, Martin Knoblauch wrote:
> > > > > Phil,
> > > > >
> > > > >  could you please grant me access to the CVS archive? I am working on a
> > > > > driver for the Fujitsu-Siemens "Scylla" Chip (a relative to the Poseidon
> > > > > :-) and would need access to both trees. I would prefer the login name
> > > > > "knobi". Here is my CVS Password String:
> > > > >
> > > > > [removed]
> > > > >
> > > > > Thanks in Advance
> > > > > Martin
> > > > > --
> > > > > ------------------------------------------------------------------
> > > > > Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
> > > > > TeraPort GmbH            |    Phone:  +49-89-510857-309
> > > > > C+ITS                    |    Fax:    +49-89-510857-111
> > > > > http://www.teraport.de   |    Mobile: +49-170-4904759
> > > >
> > > > --
> > > > Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
> > > >    phil@netroedge.com -- http://www.netroedge.com/~phil
> > > >  PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
> > >
> > > --
> > > ------------------------------------------------------------------
> > > Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
> > > TeraPort GmbH            |    Phone:  +49-89-510857-309
> > > C+ITS                    |    Fax:    +49-89-510857-111
> > > http://www.teraport.de   |    Mobile: +49-170-4904759
> > 
> > --
> > Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
> >    phil@netroedge.com -- http://www.netroedge.com/~phil
> >  PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
> 
> -- 
> ------------------------------------------------------------------
> Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
> TeraPort GmbH            |    Phone:  +49-89-510857-309
> C+ITS                    |    Fax:    +49-89-510857-111
> http://www.teraport.de   |    Mobile: +49-170-4904759

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A

From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:25 +0000
Subject: Request for CVS access
Message-Id: <20011031094952.N5150@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20011030092230.V5150@Stimpy.netroedge.com>
In-Reply-To: <20011030092230.V5150@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


If there isn't one yet for you, take the next free one in i2c-id.h.  I
don't see a reason why not.


Phil


On Wed, Oct 31, 2001 at 08:42:31AM +0100, Martin Knoblauch wrote:
> phil@netroedge.com wrote:
> > 
> > OK, done.  Let me know if you have any troubles.
> > 
> > Phil
> >
> Phil,
> 
>  thanks. One short question - how to obtain an "official" module-id. For
> my initial implementation I have just used 1029, which seemed to be the
> next free one.
> 
> i2c-id.h:#define I2C_DRIVERID_FSCSCY 1029
> 
> Martin
>  
> > On Tue, Oct 30, 2001 at 02:44:29PM +0100, Martin Knoblauch wrote:
> > > Phil,
> > >
> > >  could you please grant me access to the CVS archive? I am working on a
> > > driver for the Fujitsu-Siemens "Scylla" Chip (a relative to the Poseidon
> > > :-) and would need access to both trees. I would prefer the login name
> > > "knobi". Here is my CVS Password String:
> > >
> > > [removed]
> > >
> > > Thanks in Advance
> > > Martin
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

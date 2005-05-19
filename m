From: bob_gobeille@hp.com (GOBEILLE,BOB (HP-FtCollins,ex1))
Date: Thu, 19 May 2005 06:23:37 +0000
Subject: IPMI (BMC) lm-sensors
Message-Id: <F341E03C8ED6D311805E00902761278C116B8BB3@xfc04.fc.hp.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020808145503.T10637@Stimpy.netroedge.com>
In-Reply-To: <20020808145503.T10637@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks.  Were still making up our mind on this but will let you know if we
decide to do it.  Right now, we have to figure out get familiar with the
lm-sensors code and figure out if this is the best way to get BMC/IPMI
support into things like ganglia and other monitoring tools we are
interested in (since the BMC can do so much more than monitor).

Thanks again,
Bob Gobeille


> -----Original Message-----
> From: Mark D. Studebaker [mailto:mds@paradyne.com]
> Sent: Friday, August 09, 2002 5:55 PM
> To: sensors@Stimpy.netroedge.com
> Cc: GOBEILLEBOB (HP-FtCollinsex1)
> Subject: Re: IPMI (BMC) lm-sensors
> 
> 
> Agreed. That's why I put IPMI-BMC detection in sensors-detect 
> in 2.6.3;
> once people knew they had IPMI-BMC, maybe someone would write 
> a driver.
> We've had maybe 1 or 2 people ask about it in the 4 1/2 months since
> 2.6.3 was released. And no volunteers.
> 
> If you start the work, let us know, and we will add the information
> to our 'new drivers' page.
> 
> One complication - IPMI defines both an SMBus and sensors.
> So the development may involve both 'bus' and 'chip' drivers.
> 
> mds
> 
> 
> phil@netroedge.com wrote:
> > 
> > Mostly it's because there hasn't been the effort/time/interest.
> > There are also some mild arguments against depending on platform
> > specific features, like IPMI, instead of driving the 
> hardware directly
> > (a POSIX thing), but we'd like to see an IPMI driver.
> > 
> > The implementation would be pretty basic, I would think.  
> It would be
> > like a chip driver (see chips/lm75.c) which doesn't depend on a bus
> > driver.  Since this could migrate into the mainstream 
> kernel, it would
> > need to support, or at least cleanly stub out, on unsupport
> > architectures instead of causing compiling nightmares.
> > 
> > Mark, any comments on this?
> > 
> > Phil
> > 
> > On Thu, Aug 08, 2002 at 05:24:34PM -0400, GOBEILLE,BOB 
> (HP-FtCollins,ex1) wrote:
> > > Phil,
> > > I see from the lm-sensors newdrivers web page that there 
> is no support
> > > planned for IPMI (BMC).  Is this because the lm-sensors 
> developers don't
> > > think that IPMI support belongs in lm-sensors or because 
> no one has had the
> > > time to do it or because no one has hardware with a BMC?
> > >
> > > I work in the Hewlett Packard Linux R&D lab and I would 
> sure like lm-sensors
> > > to talk IPMI so that existing tools that use lm-sensors 
> will work with the
> > > BMC machines that we have.  We don't have anyone in the 
> lab who is very
> > > familiar with lm-sensors so if we tried to contribute 
> this we would be
> > > starting from scratch.  This is still a possibility but I 
> wanted to get an
> > > idea if there was a philisophical argument against 
> putting IPMI into
> > > lm-sensors.
> > >
> > > Thanks,
> > > Bob Gobeille
> > > Hewlett Packard Corporation
> > > Bob.Gobeille@hp.com
> > 
> > --
> > Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
> >    phil@netroedge.com -- http://www.netroedge.com/~phil
> >  PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
> 

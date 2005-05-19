From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:31 +0000
Subject: Netserver 1000r and Serverworks OSB4 specs
Message-Id: <3CC0E888.9F12D309@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1016214655.1576.23.camel@mattb.fc.hp.com>
In-Reply-To: <1016214655.1576.23.camel@mattb.fc.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

any update for us?


Matthew Brichacek wrote:
> 
> Ok, sounds good to me.  ServerWorks said they had no problem with having
> an open source driver developed, as long as the specs weren't
> published.  I signed the NDA and agreed that they wouldn't be released
> so we just won't be able to publish the specs.  As long as that is ok,
> we should be able to move forward.
> So, I will finish pushing this through the right channels and later this
> week I can tell you when the hardware will be available.
> Thanks for making this easy, let me know if you need anything else from
> me, or if you have any questions.
> 
> Thanks
> 
> Matt Brichacek
> 970-898-7346
> 
> On Fri, 2002-03-22 at 08:25, Mark Studebaker wrote:
> > Well obviously the most important thing is to find out what chip is the sensor
> > chip, and get the docs for that chip. If you can legitimately give us
> > a board and the docs (and the pizza and the beer) - without us having to sign NDA's - then
> > we should be able to develop a driver.
> >
> > Matthew Brichacek wrote:
> > >
> > > On Fri, 2002-03-15 at 14:59, Mark Studebaker wrote:
> > > > As far as we know the OSB4 support works fine, so the problem is presumably
> > > > with chips on the SMBus that we don't support?
> > > As far as I can tell, yes.
> > >
> > > > It's not something on the ISA/PCI bus?
> > > >
> > > I wish I knew.
> > > When I run sensors-detect, the i2c-piix4 driver works fine, loads and
> > > seems very content.  This is the driver for the communications bus
> > > correct?
> > > Next as the program continues, it fails on the drivers for the different
> > > chips.  I have tried both ISA and SMBus multiple times.  I have also
> > > tried to manually insert the modules myself with no luck there either.
> > > I have gone over the manuals and I believe I have tried most everything
> > > mentioned.
> > >
> > > > Them telling you what the chips are shouldn't require an NDA...
> > > > or you can look at the board...
> > > > Or do you already know it is some proprietary sensor chip?
> > > >
> > > I am almost 100% sure that they are proprietary chips.  The reason for
> > > the NDA I believe is because the documents I received have the specs for
> > > everything on the motherboard, including all the proprietary stuff.
> > >
> > > > Of course we would welcome a donation...
> > > >
> > > I have already been told I can send hardware if that will help get the
> > > issue resolved.  I might be able to get some pizza and beer involved
> > > too.
> > >
> > > I appreciate your help on this matter.  I wish I had more information to
> > > give you, this SMBus stuff is pretty new to me.
> > >
> > > Thanks again,
> > >
> > > Matthew
> > >
> > > >
> > > >
> > > > Matthew Brichacek wrote:
> > > > >
> > > > > Hello,
> > > > >         I have recently tried to get my serverworks osb4 mb to register your
> > > > > drivers.  I was able to get the PIIx4 driver to load and recognize the
> > > > > SMBus, however no chips are recognized.  I was able to get ServerWorks
> > > > > to release the specs to me for their I2C and SMBus stuff.  I am working
> > > > > out the details of the confidentiality agreement with them right now.
> > > > > If I was able to provide you with the specs and some hardware could you
> > > > > make use of this to complete support for this MB and the chips on it?
> > > > >
> > > > > Thanks
> > > > >
> > > > > Matthew
> > > > >
> > > > > --
> > > > > Matthew M. Brichacek
> > > > > Linux Development Lab R&D Engineer
> > > > > Hewlett Packard Company
> > > > > 3404 Harmony Road
> > > > > Ft. Collins, Colorado 80528-9599
> > > > > Phone: (970) 898-7346
> > > > > email: mmbrich@ldl.fc.hp.com
> > > > >               __
> > > > >              / /\
> > > > >             / /  \
> > > > >     __     /_/ /\ \
> > > > >    /_/\  __\ \ \_\ \
> > > > >    \ \ \/ /\\ \ \/ /
> > > > >     \ \ \/  \\ \  /
> > > > >      \ \  /\ \\ \ \
> > > > >       \ \ \ \ \\ \ \
> > > > >        \ \ \_\/ \ \ \
> > > > >         \ \ \    \_\/
> > > > >          \_\/
> > > > >         i n v e n t
> > > >
> >

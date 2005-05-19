From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:40 +0000
Subject: SiS
Message-Id: <3DA76355.557F5CF5@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <FJEPJHGHDGKMMPFFGCLOOEOEDLAA.a.vankaam@chello.nl>
In-Reply-To: <FJEPJHGHDGKMMPFFGCLOOEOEDLAA.a.vankaam@chello.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Alex,
catching up on email after vacation.
Nice to hear from you.
Mark Hoffman told us he was investigating the 8707, as we have
posted on our new drivers page
http://secure.netroedge.com/~lm78/newdrivers.html

But haven't heard of any progress from him.

mds


Alexander van Kaam wrote:
> 
> Mark
> 
> since we are on about SiS chipsets and boards, you ever heard about the
> ITE8707F ? I can't find any info on it although a user has send me a picture
> of it in his pc.
> 
> it's not on the normal ISA and am waiting results from going via $2E to see
> if I can enabled it via that way.
> 
> Regards, Alex
> 
> - Please always attach all previous mails !
> ----------------------------------------------------------------------
> The Motherboard Monitor:
> http://mbm.livewiredev.com/
> ----------------------------------------------------------------------
> To Subscribe to the MBM update list, go to
> http://mbm.livewiredev.com/join.html
> ----------------------------------------------------------------------
> For long you live and high you fly,
> And smiles you'll give and tears you'll cry,
> And all you touch and all you see,
> Is all your life will ever be.
> ----------------------------------------------------------------------
> 
> -----Original Message-----
> From: Mark M. Hoffman [mailto:mhoffman@lightlink.com]
> Sent: Saturday,28 September, 2002 23:14
> To: Alexander van Kaam
> Cc: Mark D. Studebaker; Sensors
> Subject: Re: SiS
> 
> Hi Alex:
> 
> (cc'ed to MDS because for some reason, I'm having trouble w/ the list)
> 
> * Alexander van Kaam <a.vankaam@chello.nl> [2002-09-27 19:55:12 +0200]:
> 
> > the 0008 can be set to appear as 0018, it's in the datasheets (search for
> > 0018 and you will find "Note: Write a 1 to Reg40 bit 6 will change the
> > Device ID to 0018h.")
> >
> > Now please don't ask my why SiS will allow you to rename the 0008 to 0018,
> I
> > dunno, maybe board makers whan it that way ?  Asus A7S333 has the 0018 if
> > case you need to find a board that has it.
> 
> Ok thanks... I haven't found anyone with SiS745 chipset yet; it's on the
> "looking for testers" list though.
> 
> > the 0963 you can handle exactly as the 0961 smbus wise that is.  I have
> not
> > had a 0962 tester as of yet, if I do will let you know the board and stuff
> 
> Yes I suspect as much... but I won't add code until I find someone to step
> up and test it.
> 
> > for that mather I handle the 0008, 0018, 0961 and 0963 the same way right
> > now, enable the 0016 via reg 77.  To avoid giving the smbus the wrong name
> > this way I just call it  SiS0016 via 0961 or however I got it.
> 
> Right now, our driver is called i2c-sis645... I would like to change the
> name to i2c-sis0016 at some point.  I need some guidance from the project
> maintainers for how to do that without messing up all our users.
> 
> > I would asume that the 0962 is identical in the above way but have not yet
> > encountered it.
> >
> > I see how you determine the SiS smbus driver, as you said not a perfect
> way
> > and will to keep updated, shame SiS does not do a better job of Device
> ID's
> > or at least Revisions.
> >
> > a final question, on the intel,via,adm, after setting the start bit I
> always
> > check to see if the smbus starts/is working, on intel for example if bit 0
> > of INTEL_SMBHSTSTS is high, however I have not find such a way on the SiS
> so
> > for now I just do a simple 1ms wait and then go into the check if ready
> > loop..... have you found such a bit or are you also just putting a little
> > rest and then go on ?
> 
> Can you not use SMB_CNT[HOST_BUSY] for this purpose?  In our case we just
> sleep and then test SMB_STS against 0x0e in a loop.
> 
> > Thanks for the complimetens on MBM, sadly I never tried lm_sensors as I
> > don't have linux, sorry :)
> 
> Yes, I do feel sad for you in that regard. ;)
> 
> Regards,
> 
> Mark
> 
> > -----Original Message-----
> > From: Mark M. Hoffman [mailto:mhoffman@lightlink.com]
> > Sent: Friday,27 September, 2002 18:27
> > To: Alexander van Kaam
> > Cc: sensors@stimpy.netroedge.com
> > Subject: Re: SiS
> >
> >
> > Hi Alex:
> >
> > * Alexander van Kaam <a.vankaam@chello.nl> [2002-09-27 10:32:36 +0200]:
> >
> > > I was wondering, I just started support for the SiS Smbus -yes yes way
> to
> > > late- and for now got a running smbus driver for Device 0016
> > > detected/enabled via either the 0008, 0018, 0961 or 0963.
> >
> > What chipset claims 0018?  I haven't seen that before.  Right now we're
> > working with 0008 and 0961.  We're looking for testers for 0962 and 0963.
> >
> > > how I was wondering, the 0008 has been around a long time and I am
> pretty
> > > sure the older versions do not support the same smbus. Have you found a
> > way
> > > to determin if the 0008 is a new or old one ?  So far I have not, I have
> > > seen revision ID's of 00, 10 and 0F that all appear to be new.
> >
> > Agreed; their PCI IDs are nearly random.  We've been using a list of north
> > bridge IDs to determine whether to proceed when loading a driver.  It's
> > far from ideal.  The driver I wrote (for newer dev 0016) does this:
> >
> > if (0961)
> >       continue...
> >
> > else if (0008)
> >       if ((0645) || (0646) || (0650) || (etc...))
> >               continue...
> >
> > else
> >       give up...
> >
> > I haven't added any device ID to that list without at least one person
> > testing it.  Benefit of open source: people sometimes add their own IDs
> > to the list and send me a patch. ;)
> >
> > > any insight would be appreciated, btw if you don't yet have support for
> > any
> > > of the above mentioned for let me know.
> >
> > As I said, we haven't seen 0018 before and we're looking for testers for
> > the rest.
> >
> > Also coincidence: I fired up MBM 5.2 just last night on my P4S333 - it
> > looks great Alex.
> >
> > Regards,
> >
> > --
> > Mark M. Hoffman
> > mhoffman@lightlink.com
> >
> >
> 
> --
> Mark M. Hoffman
> mhoffman@lightlink.com

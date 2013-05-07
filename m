From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 07 May 2013 15:07:31 +0000
Subject: Re: [lm-sensors] Gigabyte GA-Z77N-ITX Motherboard it87 sensors module (SuperIO chip ITE 8728)
Message-Id: <20130507150731.GA1853@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAPweEDz7mv+eouxQeNxL=bxEafZwFgG3BsMW+shK9bhapjVeeA@mail.gmail.com>
In-Reply-To: <CAPweEDz7mv+eouxQeNxL=bxEafZwFgG3BsMW+shK9bhapjVeeA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, May 07, 2013 at 03:17:05PM +0100, luke.leighton wrote:
> On Tue, May 7, 2013 at 2:43 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> > On Tue, May 07, 2013 at 08:38:04AM +0100, luke.leighton wrote:
> >> On Tue, May 7, 2013 at 8:03 AM, Jean Delvare <khali@linux-fr.org> wrote:
> >>
> >> >>     modprobe it87 force_id=0x8720
> >> >
> >> > Thanks for sharing your findings. Obviously I already knew about it
> >> > all, but your post might help others in similar situations.
> >>
> >>  with the right keywords, aaanything is possible :)
> >>
> >> >> also, the following page http://www.lm-sensors.org/wiki/Devices was
> >> >> also quite terse and not immediately very helpful.  if the advice
> >> >> about force_id had been on the wiki page, i would have saved about 2
> >> >> hours of searching.
> >> >
> >> > Good point. However I'm not sure where I would add the information and
> >> > in what form. The force_id parameter isn't it87-specific, it is
> >> > supported by 11 different hwmon drivers, covering something 20 or 30
> >> > different devices. In general it is also better if users can build a
> >> > standalone driver because this gives them the right device name
> >> > matching the configuration file for their board (if one exists.)
> >>
> >>  in debian this is generally discouraged.  in the work environment in
> >> which i find myself it is a *definite* no.  we have enough to deal
> >> with in the fact that this is only available for 3.2.0 rather than
> >> 2.6.32.  we will need to do at least 2 to 3 months of testing before
> >> 3.2.0 can be *considered* to be put into production.
> >>
> > And we are up to 3.9 already, and 2.6.32 was already dropped from the longterm
> > supported kernel list. You are really running old kernels - by the time you
> > start running 3.2, it may be getting close to EOL.
> 
>  doesn't matter: it's what debian/stable (or ubuntu) are using.
> that's what's important here.  live stable production systems cannot
> use stuff that's not been fully tested.  i once worked for an
> organisation that was still using python 2.1... in 2007!
> 
> >>  and we would need to either create a debian package for the
> >> stand-alone driver or compile ... no, we would not be able to compile
> >> on the box because that would mean that the 800 machines in the field
> >> would need to have gcc installed, that would mean 100% CPU for short
> >> durations which would disrupt the customer, so no, definitely a debian
> >> package, and that's a lot of work.
> >>
> >>  basically it is often completely impractical to use the standalone
> >> driver, or quite a lot of work.
> >>
> >>
> >> > That being said, I agree that not all users can build the standalone
> >> > driver.
> >>
> >>  ... or it's a significant burden to do so, as well as requiring
> >> months of testing before going live.
> >>
> > I think Jean referred more to individual users and did not really have
> > distributions or large scale deployments in mind.
> 
>  indeed.  we're looking to buy 100 a month of these motherboards once
> we have done the required 2-3 months of testing. as a free software
> developer i don't mind discussing these things: many corporations
> would not even remotely have permission to do so, so unfortunately you
> would normally not get to hear about the ways in which the software
> you've written is being deployed, large-scale.
> 
> >> > Also the cases where passing the force_id parameter works
> >> > perfectly are rather rare. So I decided to add a note about force_id in
> >> > the IT8728F entry only.
> >>
> >>  that works.  that works very well.  H77N could do with being added to
> >> the list of gigabyte motherboards in that entry, it only lists 67 so
> >> far.
> >>
> > Might be better to remove all of them. The driver is, after all, for a SuperIO
> > chipset, not for specific Intel boards, and the chip is used quite widely
> > on many boards nowadays.
> 
>  well... it kinda helps to identify it.  i did a search "H77N" - i did
> *not* do a search by "SuperIO" or even "it87" - it was only after
> spotting that text "unrecognised SuperIO chip" did i begin to track
> things down.
> 
Maybe, but H77 vs. it87 is really completely unrelated. Other H77 boards
will support different SuperIO chips. Presumably you don't look up the
manufacturer of your car radio to find the correct tire size either ...

>  if i had had a page which had come up with "Gigabyte H77N" i would
> have had a chance to find the information.
> 
The information should really be in the Gigabyte manual. Now, turns out that
a Google search for "gigabyte h77n superio" returns the SuperIO chip as first
response. Not really sure how we could do better than that.

What may make sense is a note telling people to look for the SuperIO
chip on their board, not for any of the Intel chips. A database with
motherboards and matching SuperIO chips might make sense too, though
I am relatively sure that something like this already exists. If not,
you are of course welcome to create such a database and maintain it.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

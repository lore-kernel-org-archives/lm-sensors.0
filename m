From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sat, 16 Jun 2007 19:52:01 +0000
Subject: Re: [lm-sensors] Proposal
Message-Id: <20070616195201.GD3292@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <200704081630.17151.hjk@linutronix.de>
In-Reply-To: <200704081630.17151.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans:

* Hans de Goede <j.w.r.degoede@hhs.nl> [2007-06-16 21:50:20 +0200]:
> Mark M. Hoffman wrote:
> >Hi everyone:
> >
> >Finally, back to the thread that resulted in change of maintainers, but not
> >yet any merged code. ;)
> >
> >* Hans de Goede <j.w.r.degoede@hhs.nl> [2007-04-11 15:49:08 +0200]:
> >>Jean Delvare wrote:
> >>>Hans,
> >>>
> >>>On Mon, 09 Apr 2007 14:26:06 +0200, Hans de Goede wrote:
> >>>>Jean Delvare wrote:
> >>>>>This is absolutely not different from all other hardware monitoring
> >>>>>drivers. And all other drivers handle it in user-space, because that's
> >>>>>the right design. I see no valid reason why it would be different for
> >>>>>your abituguru3 driver. All you need is one configuration file per
> >>>>>motherboard.
> >>>>Actually it is _very_ different. The uguru is not a chip, its more a 
> >>>>piece of software (looking from the driver POV) then a chip, thus 
> >>>>sensors which aren't there really aren't there, they are not just 
> >>>>unconnected pins, they _really_ aren't there.
> >
> >There is another way to look at it: the uguru3 is not a single chip, it is 
> >a
> >*family* of chips.  With that model, we would end up with a compromise 
> >between
> >your positions that has precedent in other drivers.
> >
> >I.e. Append the motherboard ID to the chip name, and also use that to 
> >create
> >the needed sysfs files.  Voila, you don't need "label" sysfs files anymore
> >because you can put a section in sensors.conf for each variant of uguru3.
> >
> >It's not that I'm against the label files per se.  But IMHO this suggestion
> >is the closest fit to the existing model of operation.
> >
> 
> I could do that, actually making the ID available in some way to userspace 
> is a good idea, however I'm still in favor of the fooX_label approach 
> because:
> 
> 1) The driver will need the table it currently has no matter what, to 
> determine
>    which inputs the model / this specific member of the family has, and at
>    which addresses these inputs reside and what type they have.
> 
>    Since the table is already there, I might as well at the labels there and
>    have all info in a single place = less maintainance / no sync problems

I anticipated that argument, and I can't disagree.  I only wanted to propose
something that was perhaps less controversial.

> 2) With dyn chip support in place (soon hopefully) a newer kernel with 
> support
>    for new motherboards added to the table, will just work without requiring
>    userspace updates. When the labels are in sensors.conf userspace will 
>    need
>    updating too, and if sensors.conf has been edited, it will require manual
>    intervention / editing  even.
> 
>    More in general if other drivers, for example CPU / chipset internal
>    sensor temp drivers get added, they can have foo#_label sysfs entries 
>    too,
>    and the new dyn chip support libsensors will do the right thing.
> 
>    Atleast Fedora, and probably other distro's update the kernel way more 
>    often
>    then userspace tools.
> 
> >>So is this one, its reading the configuration register which tells the 
> >>driver which model/stepping we are running on.
> >
> >Yep, this leads directly to my suggestion above.  Guys, is that acceptable?
> >(/me is out, but leaving the rest uncut since it's such an old thread)
> >
> 
> If the above solution is what it takes to gets the driver integrated, then 
> maybe I can agree, but I see big pain (mainly for me) in having to maintain 
> the needed table partly in the driver and partly in sensors.conf, since the 
> driver will need a table anyways, why not put all the info in one place?
> 
> ---
> 
> I've feeling we're arguing about 2 different things at once here, so here 
> is a try to split them:
> 
> 1) do we want foo#_label sysfs entries for devices were we can give a 
> sensible
>    label to userspace, like cpu temp drivers
> 2) if we agree that we want / will allow 1), is it ok for the uguru3 driver 
> to
>    generate foo#_label sysfs entries using the contents of an uguru3 
>    register
>    which addresses a lookup table with the actual info.

Without allowing #2, I would say #1 is pointless...

But I've heard enough: IMHO the answers are yes and yes.  Would you please
respin your patch against v2.6.22-rc4 and I'll look at it as soon as I can.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

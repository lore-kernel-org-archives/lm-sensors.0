From: coop@axian.com (Jerry Cooperstein)
Date: Thu, 19 May 2005 06:23:36 +0000
Subject: lm_sensors and thinkpad
Message-Id: <20020719174202.A7471@p3.attbi.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3D38A745.6A1F696C@bellsouth.net>
In-Reply-To: <3D38A745.6A1F696C@bellsouth.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Mark and Albert:

Thanks to both of you for your quick response.

I was sort of aware that the problem was on the user-side, not the
kernel patch, but let me tell you of the following scenario which
really DID happen.

I got asked to develop a utility which ran on a customer's Linux
laptops, polling performance statistics periodically, including power
state, disk I/O, CPU usage, thermal state, etc.  They already had
something like this for Windoze and wanted a Linux utility so they
could see what their employees were actually doing out in the field,
and it would be emailed back from time to time to a server.  (very big
brother IMHO, but I guess it would be voluntary)

It was in the course of working on this (pretty easy) task that I
fried my 600X.  I then discovered that most of the laptops the
customer had were Thinkpads of the 600 series.  I had nightmares about
how some of the users (even just one) would be
technologically-inhibited enough to ignore all warnings and run
'sensors-detect' and no matter how much I told them to RTFM on it I
would get blamed for the damage.  The business type who was
negotiating the whole thing was not a good enough engineer to
appreciate the whole thing properly and so the project got pushed
aside.  no big loss, as it was just a small amount of work -- but so
it goes.

So a warning on the kernel configuration seems like a good idea (who
knows maybe it will bring more attention to the problem and get IBM to
cooperate) and I hope some future version of the user-space utility
screams about Thinkpads:)

Merci again

coop

===================================
 Jerry Cooperstein, PhD        <coop@axian.com>
 Senior Consultant
                                            ____       _
 Axian, Inc.   <info@axian.com>              // |_  __(_) ___  _ __
 4800 SW Griffith Dr., Ste. 202             //| |\\/ /| |/ _ \| '_ \
 Beaverton, OR  97005 USA             _____//_| | / / | | |_| | | | |
 Voice: (541)758-8020                ((   //  |_|/_/\\|_|\_/|_|_| |_|
                                      ``-''          ``-''
 http://www.axian.com/               Software Consulting and Training
===================================




On Fri, Jul 19, 2002 at 08:22:23PM -0400, Mark Studebaker wrote:
> Here's the latest.
> The issue is not resolved. We stopped getting help from IBM
> several months ago.
> The kernel patches (and kernels like Red Hat that have had sensors
> included for quite a while now) only contain individual modules.
> They don't 'sense' any particular model of board - they look for
> a device they support, and either do nothing or exit if they
> don't find it.
> 
> The tool that's been the problem for IBM users is sensors-detect,
> our hardware detection script. It is a userspace tool and is not
> part of the kernel patches.
> 
> Unless a kernel user (whether 2.5, redhat, whatever) starts
> modprobing sensors modules he can't get hurt.
> We haven't heard any complaints from IBM users in quite a while -
> and as I said Red Hat has been shipping our package for over a year, IIRC.
> 
> Sorry you toasted your thinkpad. Believe me if we had the info
> from IBM we needed we would try to fix it.
> 
> mds
> 
> 
> 
> Albert Cranford wrote:
> > I understand and fully appreciate your comments.
> > I'm sure that this is not resolved in our current 2.6.3
> > version that I'm currently integrating into linux-2.5.26.
> > 
> > Today we released i2c&lm_sensors 2.6.4 with new IBM drivers
> > but this is for PPC and considered Beta testing at the
> > moment.
> > 
> > I will make a change in the Config.in to warn 600x laptop
> > users to stay away.
> > 
> > Thanks alot,
> > Albert
> > 
> > Jerry Cooperstein wrote:
> > 
> >>Hi:
> >>
> >>Having fried one motherboard on my 600x Thinkpad by use of
> >>sensor-detect (I'm not blaming anyone but myself for reading
> >>documentation a little too late--and I got it replaced on
> >>warranty) I'm kind of nervous about whether the lm_sensors
> >>patches going into the kernel are sensitive to the Thinkpad
> >>issue, either by resolving it, or sensing it is a Thinkpad
> >>and staying away from it.
> >>
> >>I haven't been able to find any recent documentation on this,
> >>so I'd appreciate it if you could bring me up to date.  Besides
> >>my own fears, I have nightmares about distributions using
> >>such kernels and frying up laptops on unsuspecting users.  I
> >>know from checking things out in the past the blame belonged
> >>to IBM and/or Intel, not Linux, but I'm not sure everyone
> >>would see it that way :<
> >>
> >>Thanks,
> >>
> >>coop
> >>
> >>===================================
> >> Jerry Cooperstein, PhD        <coop@axian.com>
> >> Senior Consultant
> >>                                            ____       _
> >> Axian, Inc.   <info@axian.com>              // |_  __(_) ___  _ __
> >> 4800 SW Griffith Dr., Ste. 202             //| |\\/ /| |/ _ \| '_ \
> >> Beaverton, OR  97005 USA             _____//_| | / / | | |_| | | | |
> >> Voice: (541)758-8020                ((   //  |_|/_/\\|_|\_/|_|_| |_|
> >>                                      ``-''          ``-''
> >> http://www.axian.com/               Software Consulting and Training
> >>===================================
> > 
> > 
> 

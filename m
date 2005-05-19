From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:36 +0000
Subject: major lm_sensors problem
Message-Id: <20020730142411.F9662@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200207301755.g6UHtga04064@shire.frodo.local>
In-Reply-To: <200207301755.g6UHtga04064@shire.frodo.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


OK, well this is beginning to sound different than the Thinkpad 
issue... How can you re-install w/o being able to boot?  Can you boot 
to CD but not HD or something?

On Thinkpads, it's been reported that you can hit 'ESC' to break out 
of the hanging error screen when booting, you could try that.  On 
Thinkpads, the ESC gets out of the error condition and the error 
message goes away after you shutdown and restart again (so I've 
heard).

Do you know that it was lm-sensors which did this, or was it just one
of the things you've done lately which may be suspect?

If you can boot to CD and your CD can see the harddrive, then it's 
likely that it is a boot loader problem.  Hard to say how lm-sensors 
could effect your boot loader?


Phil

On Tue, Jul 30, 2002 at 02:07:04PM -0700, Minesh Khatri wrote:
> nothing happens after the IBM logo comes up. i can still go to the BIOS setup,
> but that's about it. after the logo, there is just a cursor in the top right
> corner and the system is hosed. i am reinstalling linux right now and hopefully
> it will reboot correctly. do you know what the problem might be?
> 
> thanks,
> minesh
> 
> --- phil@netroedge.com wrote:
> > 
> > Hi, what happens when you try to boot?  Do you get a CRC error or 
> > something like that?  It's possible that you are experiencing the 
> > 'Thinkpad' problem, although I don't want to jump to conclusions at 
> > this point.
> > 
> > 
> > Phil
> > 
> > On Tue, Jul 30, 2002 at 10:40:35AM -0700, Minesh Khatri wrote:
> > > Hi,
> > > 
> > > I ran your program, sensors-detect, on Red Hat 7.3, and now it has screwed up
> > my
> > > computer (IBM Intellistation). Linux will no longer boot. I was wondering if
> > you
> > > had any solutions or reasons as to why this is happening? 
> > > 
> > > Thanks,
> > > Minesh
> > > 
> > > __________________________________________________
> > > Do You Yahoo!?
> > > Yahoo! Health - Feel better, live better
> > > http://health.yahoo.com
> > 
> > -- 
> > Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
> >    phil@netroedge.com -- http://www.netroedge.com/~phil
> >  PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A
> 
> 
> __________________________________________________
> Do You Yahoo!?
> Yahoo! Health - Feel better, live better
> http://health.yahoo.com

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A

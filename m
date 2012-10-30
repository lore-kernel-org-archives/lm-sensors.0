From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 30 Oct 2012 17:27:28 +0000
Subject: Re: [lm-sensors] sensors-detect changes monitor settings on hp pavilion dv7
Message-Id: <20121030182728.6be5703a@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAAq1RJmLU+cyc59=3fnm-ZNZckk0t-qkcE=2rWNHMfj0HedKSQ@mail.gmail.com>
In-Reply-To: <CAAq1RJmLU+cyc59=3fnm-ZNZckk0t-qkcE=2rWNHMfj0HedKSQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 4 Oct 2012 18:30:11 +0200, Jean Delvare wrote:
> Hi Andrew,
> 
> On Thu, 4 Oct 2012 11:30:45 -0400, Andrew Potter wrote:
> > Hi, I wasn't quite sure from the information on lm-sensors.org how to open
> > an official ticket, but the details of my problem are here:
> > 
> > https://bbs.archlinux.org/viewtopic.php?pid70583
> > 
> > Basically, when I probe i915 gmbus panel (i2c-2) with sensors-detect, when
> > it probes address 0x4f my monitor settings (I think the sharpness mostly)
> > are changed drastically.  This is persistent over any operating system and
> > reboot, leading me to believe a) its a hardware issue, or b) nothing
> > usually touches whatever values were changed.  Any help would be greatly
> > appreciated, in the forum post I've also included some experimentation with
> > i2c-tools.  The problem originally occured on an Arch Linux system.  Let me
> > know if you need anything else!
> 
> Thanks for reporting. We have had that kind of problem popping up every
> other year or so, and take such reports very seriously. We've done our
> best to make sensors-detect as safe as possible, but the fact is, the
> I2C and SMBus protocols do not support device probing in general, so
> the whole thing is a hack, and hacks can turn bad sometimes.
> 
> Please keep in mind that everything you will do to investigate and
> solve this issue (including things I or others may suggest you do) may
> make things even worse than they are today. So it's all up to you what
> you want to do and when you prefer to stop and stick with what you have.
> 
> First thing I would like to know is the version of lm-sensors (or
> sensors-detect) you have been running.
> 
> Second thing I would like to know is the exact revision of your laptop
> HP Pavillon DV7. If possible, provide the dmidecode output. We want to
> document the problem and prevent it from happening to other users with
> the same hardware, using a blacklist if needed.
> 
> One thing I don't quite understand is how there can be two different
> graphics chips (one Intel, one Nvidia) in a laptop. What sense does it
> make, and which one are you using? If the Intel is an integrated thing
> and the Nvidia chip was added and is supposed to be better, then I
> would suppose that's what you're using, but then I do not understand
> how messing up with the Intel I2C buses can have any adverse effect.
> 
> It might be a good idea to prevent scanning of I2C buses on graphics
> cards by default, as we do for multimedia (TV) cards already. These
> days drm drivers should take care of instantiating the hardware
> monitoring devices present without user-space probing, so it's probably
> doing more harm than good.
> 
> You said you ran i2cdump on the chip, did you save the output? I'd like
> to take a look.
> 
> The only chance to get your system back to its original state by
> software is to know what chips exactly are on the I2C bus of your Intel
> graphics chip and in particular at I2C address 0x4a. Unfortunately this
> information is usually very hard to get.
> 
> Another thing you should try is:
> * Power down the machine.
> * Remove the battery, unplug the AC adapter.
> * Wait 1 minute at least, 10 minutes if you have time.
> * Put the battery and AC adapter back in place.
> * Power up the machine again.
> 
> With some luck this will restore the original state. It has worked for
> others in the past.

Andrew, were you able to solve the problem somehow, using my suggestion
or otherwise?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

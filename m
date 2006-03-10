From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Fri, 10 Mar 2006 02:44:46 +0000
Subject: [lm-sensors] Proposal to individual alarm/beep sysfs files
Message-Id: <20060310024446.GA4922@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060305231105.97f9085a.khali@linux-fr.org>
In-Reply-To: <20060305231105.97f9085a.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean, Hans, et. al.:

I've been following this thread and the later, related thread very closely
(although I've been quiet until now.)

* Jean Delvare <khali at linux-fr.org> [2006-03-05 23:11:05 +0100]:
> Last week, in the course of writing a hardware monitoring driver for the
> SMSC LPC47M192 chip, Hartmut Rick and I discussed how alarms could be
> represented under sysfs in a standard way, so that no knowledge of the
> chip is needed for userspace libraries and tools. I'll try to summarize
> our conclusion here, and also add a few thoughts I had since. Hopefully
> this can lead us to a fully standard solution; this is the last step I
> am aware of before a chip-independant library can be written.

> The original discussion was between per-type files versus per-channel
> files. I think we agreed that individual files were better, allowing a
> much cleaner implementation. Per-type files would require us to reorder
> all bits when the chip has them in a random order (which is most often
> the case, unfortunately). With per-channel files, we just have to
> extract the correct bit, which is easy. We can even use the same
> callback for all alarms, as demonstrated at the end of this post.

I like one file per alarm as a standard.  No alternative (short of dropping
the sysfs filesystem altogether) is better.  But I have a suggestion...

> Now, some chips offer more than one alarm for a given channel. For
> example the LM90/ADM1032 has a separate alarm for low limit crossed,
> high limit crossed and critical limit crossed. It was suggested that we
> could have non-boolean alarm files, and it makes some sense. However,
> on second though, it means that we would have to define a standard bit
> order inside such alarm files, and we'll have to build the contents
> from the registers. This won't be easier than having per-type files,
> which we said we did not want to do.
> 
> So my new suggestion is to have per-limit alarm files for chips which
> implement things that way. This makes every alarm file a boolean. The
> only drawback I can think of is that we'll end up with many more sysfs
> files defined in each driver. However, the size increase seems to be
> acceptable, thanks to the dynamic sysfs callbacks and the array of
> attributes which we can use now.
> 
> Fault conditions and beep masks can be handled exactly the same way.
> 
> Here is a proposed patch to sysfs-interface which summarizes my views.
> It's only a draft for now, comments are welcome.

<snip>

> +Old drivers provided a different, non-standard interface to alarms and
> +beeps. These interface files are deprecated, but will be kept around
> +for compatibility reasons:
>  
>  alarms		Alarm bitmask.
>  		Read only.

Why deprecate these?  It is easy enough to leave the few extra files
there.  Then, if some embedded app really needs that last 1-2k, they
can chop out (by way of CONFIG_ option) all of the individual alarm
files and save the space.  At any rate, it is useful to 'cat .../alarms'
at a glance to see if it's nonzero.  Not every user needs the full
sensors(1) & libsensors.

Also BTW... in the related thread, Hans wrote:
> (I've learned programming on a 8051, so 9k additional data is _huge_ to me).

I hear that, Hans.  Linux is the most scalable software I've ever seen, but
it can't (and AFAICT, won't ever) scale down to the level of the stuff I (we?)
work on at the day job.  Suffice to say, if you need hwmon in a Linux box
and you can't afford 1-2k more, you're going to be patching quite a lot of
stuff already anyway.  E.g. have you noticed this one?

>    text    data     bss     dec     hex filename
>    8095      31      24    8150    1fd6 drivers/pci/quirks.o

Guaranteed most of that doesn't apply to any given machine, and (almost) none
of it can be CONFIG'ed away.  (I know it's all marked __init or __devinit,
but it's still in the kernel image.)

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com



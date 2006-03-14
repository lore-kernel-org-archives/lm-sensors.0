From: greg@kroah.com (Greg KH)
Date: Tue, 14 Mar 2006 06:32:48 +0000
Subject: [lm-sensors] Proposal to individual alarm/beep sysfs files
Message-Id: <20060314063248.GA6777@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060305231105.97f9085a.khali@linux-fr.org>
In-Reply-To: <20060305231105.97f9085a.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Mar 06, 2006 at 08:30:11AM +0100, Hans de Goede wrote:
> Jean Delvare wrote:
> 
> >The original discussion was between per-type files versus per-channel
> >files. I think we agreed that individual files were better, allowing a
> >much cleaner implementation. Per-type files would require us to reorder
> >all bits when the chip has them in a random order (which is most often
> >the case, unfortunately). With per-channel files, we just have to
> >extract the correct bit, which is easy. We can even use the same
> >callback for all alarms, as demonstrated at the end of this post.
> >
> >Now, some chips offer more than one alarm for a given channel. For
> >example the LM90/ADM1032 has a separate alarm for low limit crossed,
> >high limit crossed and critical limit crossed. It was suggested that we
> >could have non-boolean alarm files, and it makes some sense. However,
> >on second though, it means that we would have to define a standard bit
> >order inside such alarm files, and we'll have to build the contents
> >from the registers. This won't be easier than having per-type files,
> >which we said we did not want to do.
> >
> >So my new suggestion is to have per-limit alarm files for chips which
> >implement things that way. This makes every alarm file a boolean. The
> >only drawback I can think of is that we'll end up with many more sysfs
> >files defined in each driver. However, the size increase seems to be
> >acceptable, thanks to the dynamic sysfs callbacks and the array of
> >attributes which we can use now.
> >
> >Fault conditions and beep masks can be handled exactly the same way.
> >  
> >
> 
> I still vote for having one file per type of alarm. All you need is an 
> array which contains the correct masks per sensor type for the alarm reg 
> and then a loop which contructs a new virtual alarm reg , by masking the 
> real alarm reg with the values in the array and storing the true/false 
> results linear in a new mask.
> 
> I think having a zillion files in sysfs is a bad idea, besides the 
> obvious driver size this also requires a kobject per file, which is a 
> refcount ed object and thus not so light.

No, a zillion files in sysfs is a fine idea.  One value per file is the
rule here for sysfs, and having binary alarm masks that must be decoded
is a mess.  It's also fixing your api into stone for pretty much
forever.

However if you have one file per alarm type, you can add new alarm types
in the future and not support older ones just fine, the file just will
not be there.

Also, sysfs does (well, will, in 2.6.17, and -mm right now) support
polling sysfs files to allow userspace to wake up when something has
happened.  With this interface, the files do not needed to be read from
all the time to see if something happened, just make a poll() call, and
when woken up, go read the file that changed.  This makes userspace much
simpler and lighter-weight on the whole system.  It also allows your
userspace program to easily handle many multiple different alarms at the
same time (when woken up, you know which file descriptor has changed so
you go read only that one.)

So, in short, lots of sysfs files are not something to be scared about,
they are a good thing.

thanks,

greg k-h


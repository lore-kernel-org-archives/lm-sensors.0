From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 04 Oct 2007 13:42:07 +0000
Subject: Re: [lm-sensors] lm-sensors 3.0.0-rc1 has been released!
Message-Id: <20071004154207.672bb388@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070925233316.7afaa297@hyperion.delvare>
In-Reply-To: <20070925233316.7afaa297@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Henrique,

On Thu, 4 Oct 2007 09:49:30 -0300, Henrique de Moraes Holschuh wrote:
> On Thu, 04 Oct 2007, Jean Delvare wrote:
> > Stuck in D state? I don't understand. Won't the signal simply be
> > delayed until the lock is released?
> 
> The point is, what if the lock is NOT released (for a long time/at all)?
> There would be no need for mutex_lock_interruptible to exist if that was not
> an issue.  The real question is, could this happen in thinkpad-acpi or other
> hwmon chip drivers?
> 
> Of course, locks not being released are the sign of huge bugs on most of
> hwmon that do operations that are bounded and fast in the first place, but
> for complex drivers that call into the ACPI interpretor, that is not so
> clear.

It really depends on what you consider a "long" time. Some hwmon
drivers can take the lock for one second (reading all the register
values at once), which qualifies as long in some contexts, sure. But
for a hardware monitoring applet, this seems reasonably short to me.

And yes, never-returning locks would be bugs, so we don't have to
consider this case.

> (...)
> I'd send the patches, yes.  But so far, I could not make heads-and-tails of
> the libsensors code.  I am studying it.  I will have more time after the
> merge window for 2.6.24 closes.

You're looking at the lm-sensors-3.0.0 branch, right? The library code
there is rather sane IMHO, in comparison to trunk ;) There's not much
you have to look at: sensors_read_sysfs_attr() and
sensors_write_sysfs_attr() in lib/sysfs.c, and sensors_get_value() and
sensors_set_value() in lib/access.c. And then error.h and error.c if
you need to add error codes. And that's about it, I think.

> As for proving to you that this complexity is needed, well, I don't have any
> latency-sensitive loads here, nor do I play with real-time audio.  But I
> will be sure to tell you if I meet an easily reproducible scenario involving
> libsensors.  I *know* first hand of such scenarios when dealing, e.g., with
> /dev/hwrandom, which stalls for long times on slow hardware rngs.  But even
> ACPI EC access is not supposed to stall for that long unless it is broken...

Maybe it's just me missing the point, but I don't really see how
real-time audio fits in the picture. Non-interruptible locks don't
block your entire system, just the process in question, i.e. in our
case the application which is using libsensors. So my impression is
that having hwmon drivers return -EINTR rather than delaying signals
only matters if the same application that is using libsensors also
needs to do low-latency work. I don't know of any such application,
which is why I think we don't care.

Also worth reminding is the fact that a non-waiting call to
sensors_get_value() may take 1 second for some drivers. So if you are
worried about latency for the waiting case, you are most probably as
much worried about the non-waiting case. This pretty much forbids
mixing time-critical tasks with libsensors as far as I can see.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

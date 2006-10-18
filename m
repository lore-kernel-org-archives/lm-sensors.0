From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 18 Oct 2006 15:13:25 +0000
Subject: [lm-sensors] generic chip support in libsensors
Message-Id: <20061018171325.3125efc8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44C78622.8060808@hhs.nl>
In-Reply-To: <44C78622.8060808@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Bob,

Sorry for being so quiet, that's because I am very busy, not because
I'm not interested. I _am_ very interested by your work.

I am worried about how you are currently keeping your changes? At some
point we'll have to merge your changes upstream, and we are not going
to take one big patch with all changes. We need incremental changes so
that we can review and test them properly.

It might make sense to open a branch for you in our Subversion
repository so that you can do these incremental commits right now, and
we can comment and review and test as you progress.

On Tue, 17 Oct 2006 00:02:57 +0200, Bob Schl?rmann wrote:
> We are currently almost done with modifying the library so that it
> detects the chip's features from the sysfs entries, it now needs
> some testing. One problem we had was finding a way to add the new
> sensors_chip_features entry to the global list of known chips. This is
> currently handled by making the last places of the global array empty
> placeholders.

This means you put an arbitrary limit to the number of entries which
can be created dynamically. This is certainly OK if this limit is large
enough, as a first approximation. But dynamic entries are supposed to
become the one and only way in the future, so it'd be better if we
could handle them cleanly. This might come naturally when we drop
support for static entries anyway.

> For step 2/3 (modify the sensors tool so the per chip print routines are
> replaced by generic ones) we had some ideas. 
> 
> The first idea was to create a sort of object oriented approach by using
> structs and function pointers, kind of how Gtk works. In the
> OO-model a Sensor class/struct would be the root class and cpu,
> voltage, etc. sensors would be implemented as subclasses. This has the
> advantage (in our opinion) of a clear API and makes adding new sensor
> types easier.
> 
> A simpler approach would be to just create a function that returns the
> correct sensor type given a sensor_chip_feature struct. The sensors app
> can then be restructured around this.

This was my original intent, yes. Just add this function to the
libsensors API and you're done.

> We have currently chosen to first implement the the last approach,
> because this seems more 'incremental', and when there is enough time
> left (there probably will be) implement the oo-model as an extra layer.

I prefer the last approach too. No need to make things more complex
than is required. "sensors" is written in C, not an OO language.
And we haven't been adding a new sensor type in the past 6 years, I
pretty much doubt we'll have to add any in a near future, so no need to
optimize for this unlikely event.

> A patch will be available soon, to show our current progress and
> hopefully to get some feedback whether we took the right path with step
> 1,

Great, looking forward :)

-- 
Jean Delvare


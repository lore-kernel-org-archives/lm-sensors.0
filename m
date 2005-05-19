From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:25 +0000
Subject: libsensors for linux 2.6
Message-Id: <3FB7B9C4.A4D14C1E@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031116144447.6ac271ca.khali@linux-fr.org>
In-Reply-To: <20031116144447.6ac271ca.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I think I'll stay on this thread.

I heavily modified and checked in Danny's patch, with the following
features:
	- Supports both sysfs and /proc (#ifdef SYSFS removed)
	- Requires two additions to struct sensors_chip_feature: 
	  sysfs file name and sysfs magnitude
	  This is the struct in the massive lib/chips.c file.
	  I've only updated w83781d for now for my testing.
	- version advanced to 3.0.0

I did it this way to minimize typing. The sysfs name and magnitude are
optional;
it will use the old name and magnitude if they aren't present.

It's been a long time and nobody had stepped up to even doing this much.
Some simpler libsensors or none at all may be a good long-term goal.
If gkrellm is using sysfs values directly with some sort of
configuration file
perhaps we should look at that as a good example of how to do things.

But I think this approach is good for now. Another hour of modifying
lib/chips.c
and it will be done. But if you're getting ready to change the standard
names
and/or magnitudes I better hold off...
Helpful hint: the more names stay the same as they were before the less
typing there will be (inx, inx_min, inx_max....). Unfortunately
pretty much everything is different now. The reason it's called
"in_input1"
instead of "in1" escapes me.

On the larger point, don't think I'm disagreeing with you.
None of this changes my opinion that libsensors sucks.

One problem I ran into:

For temp_xxx, sysfs_interface says divide by 1000 but actually it's 100
(for w83781d anyway)


mds



Jean Delvare wrote:
> 
> > I broke down and started integrating Danny's patch.
> > stay tuned for progress...
> 
> Just one or two questions, since I haven't been watching the thread very
> carefully - no time for this, sorry.
> 
> You might have seen my recent post about sysfs file naming conventions,
> with questions about how to handle values that relate to more than one
> sensor, relative hysteresis values and the such. The goal of this naming
> convention is to have a common, standardized interface with libs and/or
> user-space programs. The fact that libsensors has specific code for each
> and every chipset is a problem. With a sysfs interface where each file
> name can only represent one thing, this shouldn't be needed anymore.
> This basically means that libsensors as we know it should *not* be
> needed for Linux 2.6.
> 
> Of course, we would still need a way to tweak values, set limits, set
> labels and ignore values. The source for this is in our sensors.conf
> file. That should almost be the only common part between the old and the
> new library. This make me wonder if this is a good idea to try having
> only one library for both kernel branches. Why don't we start a 2.6
> dedicated library? This would be libsensors.so.3.
> 
> That said, this would be better if we could all agree of the sysfs file
> naming convention first. Please post your comments on the other thread.
> Greg KH and Mark Hoffman already have clarified a number of things and
> some points look OK now, but there are still some problems left.
> 
> --
> Jean Delvare
> http://www.ensicaen.ismra.fr/~delvare/

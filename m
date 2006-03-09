From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 09 Mar 2006 21:05:30 +0000
Subject: [lm-sensors] Memory usage of sysfs files
Message-Id: <20060309220530.0c68c600.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.63.0603082311220.3051@Laila>
In-Reply-To: <Pine.LNX.4.63.0603082311220.3051@Laila>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

> AFAIK each sysfs file has a inode behind it which has been fixated in 
> the inode-cache. This is also one of the more worry some parts IMHO, if 
> we completly fill the inode-cache (which can be configured to be quite 
> small on embedded systems) this will cause a performace impact. This is 
> all AFAIK / IMHO.

Well, if a given embedded system wants to support hardware monitoring,
it gets to be configured with such an inode-cache size that it'll work
properly. If not this is a configuration issue, and I don't think we
can take this into account in our design decision.

> > Also note that the number of individual
> > alarm files depends on the number of channels and/or limits the device
> > has, so this approach won't suddenly turn a small driver into a large
> > one. The size increment had to be somehow proportional to the original
> > driver size.
> 
> Well, the uguru driver would have 100 alarm (mask/beep/shutdown) files 
> on my mb instead of the current 14!
> (this number could vary depending on the exact config of the uguru on a mb)

Ah, I guess this explains your reluctance to individual files ;) But the
uguru really is more of an exception than the rule here. For the other
drivers, I'd expect no more than 50 files for the largest ones, and
rather half that value for the vast majority of our "complete hardware
monitoring" drivers. Temperature-only drivers have even less, of course.

How many sysfs files does the uguru driver have, not counting the
alarm/beep/shutdown entries?

> To get an idea of the extra code size for the mask creation I've removed 
> the loops doing the masking in the uguru driver and replaced them with a 
> simple function which gets/sets values directly from the data using 
> attr->nr and/or attr->index .
> 
> Results:
> With loops:
> [hans at shalem uguru]$ ls -l abituguru.o abituguru.ko
> -rw-rw-r-- 1 hans hans 232871 Mar  8 15:14 abituguru.ko
> -rw-rw-r-- 1 hans hans 154472 Mar  8 15:14 abituguru.o
> 
> Without loops:
> [hans at shalem uguru]$ ls -l abituguru.o abituguru.ko
> -rw-rw-r-- 1 hans hans 231191 Mar  9 21:12 abituguru.ko
> -rw-rw-r-- 1 hans hans 152816 Mar  9 21:11 abituguru.o

These numbers are really too high, you must have some debugging option
enabled. Please provide the same numbers without debugging so that the
comparisons make more sense.

> This would also spare one array with the sensor masks in show to user 
> order a 16 bytes which is malloced.

Hm?

> So this saves around 1.8k code and would cost around 9k malloced (+ 
> possible fragmented page size loss) data.

Nothing to be afraid of, if you want my opinion.

> Also think about the number of extra file handles and / or open/closes a 
> userspace program would need to have / do with this interface.

That's right, this is an interesting point, maybe the more serious in
your series of objections. That being said, I wouldn't expect a
user-space program to use several file handles, that's really the kind
of process where you serialize the reads. I'm also not sure how costly
an open/close on a ram-based fs is. Given that there is no seek time
involved, I'd expect it to be quite fast. But if you have some figures
to throw in the battle, they'll be welcome.

I'd really like to see other numbers for your propsal on a driver
different from the uguru, as this one really isn't representative of
the rest of the drivers. If you could pick one (or more) on which I did
my own tests, even better (these are f71805f, lm63, lm90, w83627hf).

Lastly, I have been thinking of another advantage of my proposal over
yours: it makes it possible for user-space to know exactly which
features a given chip has. With your proposal, there is no way for the
user-space to know if a given channel supports alarm or beep until this
alarm or beep is activated; it basically assumes that all channels
support alarm or beep, or none does.

A concrete example can be found in the new smsc47m192 driver: temp2 and
temp3 have a diode fault bit, but temp1 doesn't. Same for temp1 vs
temp2 in the lm63 and lm90 drivers. I guess we can find similar
examples in other drivers. But I would agree that this probably is a
rare case, so it doesn't justify my proposal on its own - it's just
another item on the scales.

Thanks,
-- 
Jean Delvare


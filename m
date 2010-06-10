From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 10 Jun 2010 07:09:05 +0000
Subject: Re: [lm-sensors] [PATCH] fix hwmon/i5k_amb.c sysfs attribute for
Message-Id: <20100610090905.458b3fb9@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20100609140000.60975b2f.kamezawa.hiroyu@jp.fujitsu.com>
 <20100609110719.270634a9@hyperion.delvare>
 <m14ohcyoa5.fsf@fess.ebiederm.org>
In-Reply-To: <m14ohcyoa5.fsf@fess.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org, mingo@redhat.com, "akpm@linux-foundation.org" <akpm@linux-foundation.org>, Jiri Kosina <jkosina@suse.cz>

Hi Eric,

On Wed, 09 Jun 2010 12:54:58 -0700, Eric W. Biederman wrote:
> I would love to see all of the sysfs attributes be declared
> statically which is overwhelming the common practice for sysfs
> attributes.

I fear this isn't going to happen. If you look at the hwmon drivers
which create their attributes dynamically, you'll see that at least
some of them really have to: themselves receive the list of attributes
dynamically from the firmware or hardware. Switching to static
attributes would mean setting arbitrary limits and wasting a lot of
memory.

> And that 46 approaching 50 call sites just barely exceeds the number
> of call sites who have had lockdep problems fixed.
> 
> Furthermore it does make sense to have a special initialization helper
> for dynamically allocated sysfs attributes.

Sure it does make sense, we have the same mechanism for many other
structures. But when the initialization is only needed when debugging,
it becomes somewhat questionable.

> It doesn't really make sense to add sysfs_attr_init into
> device_create_file.  The vast majority of sysfs attributes are
> declared statically and thus get a very fine grained locking analysis,
> by virtue of each one having their very own lock_class_key.
> device_create_file is by and large used on those static files.  So
> we would likely reduce the quality of the lockdep coverage if we folded
> sysfs_attr_init into device_create_file.

What's wrong with calling sysfs_attr_init() automatically in
device_create_file() if and only if it has not been called explicitly
before? This would avoid all these per-driver patches. I understand
that this means that all dynamic attributes would share the same
lock_class_key, but I suspect this shouldn't be a problem in practice.
And this would avoid having to add calls to sysfs_attr_init() in many
drivers. Only drivers which need finer-grained classes AND use dynamic
attributes would have had to be touched. This might as well be 0 driver
in the end.

> Right now the burden of sysfs_attr_init is placed on drivers that do
> strange things with their sysfs files, and need to dynamically
> allocate them, which is maybe 5% of the sysfs files, that are not
> automatically generated.  Apparently the hwmon drivers seem to
> standout in that regard.  With two different drivers needing this
> treatment.

Five, actually... Three more need fixing (asc7621, abituguru and
abituguru3). Yes, hwmon drivers are a big consumer of sysfs attribute
files.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

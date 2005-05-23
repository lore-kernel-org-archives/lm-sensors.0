From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Mon, 23 May 2005 04:01:47 +0000
Subject: [lm-sensors] Re: [RFC PATCH 2.6.12-rc3-mm2 1/2] i2c: new sysfs
Message-Id: <20050523020106.GA26080@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050503034928.GC4977@jupiter.solarsys.private>
In-Reply-To: <20050503034928.GC4977@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello Yani:

* Yani Ioannou <yani.ioannou@gmail.com> [2005-05-21 07:19:45 -0400]:
> What's the status on the hwmon patch? I'm looking at updating
> bmcsensors now and Jean suggested bmcsensors should be modified to get
> rid of any i2c references before submitting it (since it has
> absolutely nothing to do with i2c), but from what I can tell this was
> the last message about it. I'd really like to see something like this
> get accepted soon.

I thought I would finish the userspace/libsensors modifications first,
then I could shake out any interface problems.  As I wrote earlier:

>> There is still the question of what to use for class device ID string.
>> We could resurrect each chip's ID number (that was incremented but never
>> used) to make names like lm78-0, lm78-1, etc.  But, the uniqueness
>> requirement isn't completely guaranteed that way.  E.g. two different
>> modules might name a class device w83627hf-0.  Suggestions?

I was thinking of passing the class device ID string as a parameter to 
hwmon_device_register() instead of pulling it out of dev->bus_id.  If I
were to re-submit the patch for inclusion (w/ the changes suggested by
Greg)... what would you use for the class device ID string for bmcsensors?

If we can have such a patch included on the condition that it may still
change (due to interface / naming conventions) then I will rework it 
and submit it on Wed or Thu.  Maybe we can keep it in -mm for an extended
period until I finish the libsensors stuff.  Would that work for you?

Regards,

-- 
Mark (hacking on his house instead of his computer) Hoffman
mhoffman@lightlink.com


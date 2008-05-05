From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 05 May 2008 21:22:45 +0000
Subject: Re: [lm-sensors] [PATCH] i5k_amb: Support Intel 5400 chipset
Message-Id: <20080505232245.6003ac8a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080503045558.GJ16078@tree.beaverton.ibm.com>
	<20080505135621.66809b0e.akpm@linux-foundation.org>
In-Reply-To: <20080505135621.66809b0e.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: djwong@us.ibm.com, mhoffman@lightlink.com, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Andrew,

On Mon, 5 May 2008 13:56:21 -0700, Andrew Morton wrote:
> On Fri, 2 May 2008 21:55:59 -0700
> "Darrick J. Wong" <djwong@us.ibm.com> wrote:
> 
> > Minor rework to support the Intel 5400 chipset.
> 
> Thanks, I added this to the for-git-hwmon part of the -mm queue.
> 
> I haven't heard from Mark for quite some time so soon I might declare him
> absent and I'll go through my hwmon patches with a view to merging them into
> 2.6.26 directly.

For Mark's status see:
http://lists.lm-sensors.org/pipermail/lm-sensors/2008-May/023006.html

I guess he'll be happy if you merge a couple patches for him.

> 
> That queue currently consists of:
> 
> hdaps-invert-the-axes-for-hdaps-on-lenovo-r61i-thinkpads.patch
> adt746x-logical-bitwise-confusion-in-set_max_duty_at_crit.patch

The adt7473:set_max_duty_at_crit() code was originally confusing but
correct. After this patch the code is clear but broken. Is it
considered an improvement?

(I would have told you before if that patch had been submitted to the
lm-sensors list as it should have, given that it modifies a hardware
monitoring driver... Not to mention that the patch file name doesn't
match the driver file name, just to add to the confusion.)

> adt7473-minor-documentation-update.patch

I reviewed and acked that one, it's ready to go.

> i5k_amb-support-intel-5400-chipset.patch

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

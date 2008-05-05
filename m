From: Andrew Morton <akpm@linux-foundation.org>
Date: Mon, 05 May 2008 20:56:21 +0000
Subject: Re: [lm-sensors] [PATCH] i5k_amb: Support Intel 5400 chipset
Message-Id: <20080505135621.66809b0e.akpm@linux-foundation.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080503045558.GJ16078@tree.beaverton.ibm.com>
In-Reply-To: <20080503045558.GJ16078@tree.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: djwong@us.ibm.com
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org, mhoffman@lightlink.com

On Fri, 2 May 2008 21:55:59 -0700
"Darrick J. Wong" <djwong@us.ibm.com> wrote:

> Minor rework to support the Intel 5400 chipset.

Thanks, I added this to the for-git-hwmon part of the -mm queue.

I haven't heard from Mark for quite some time so soon I might declare him
absent and I'll go through my hwmon patches with a view to merging them into
2.6.26 directly.

That queue currently consists of:

hdaps-invert-the-axes-for-hdaps-on-lenovo-r61i-thinkpads.patch
adt746x-logical-bitwise-confusion-in-set_max_duty_at_crit.patch
adt7473-minor-documentation-update.patch
i5k_amb-support-intel-5400-chipset.patch


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

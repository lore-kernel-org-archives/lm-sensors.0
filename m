From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 16 Dec 2007 19:41:50 +0000
Subject: Re: [lm-sensors] [PATCH] libsensors: No longer depend on libsysfs
Message-Id: <20071216194150.GD30454@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071129120153.26879145@hyperion.delvare>
In-Reply-To: <20071129120153.26879145@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

> On Sun, 16 Dec 2007 13:59:02 -0500, Mark M. Hoffman wrote:
> > I've finally finished reviewing this.  I only have one minor change to
> > suggest, which IMHO makes the code a little more readable at very little
> > expense in cycles and no expense in size.

* Jean Delvare <khali@linux-fr.org> [2007-12-16 20:25:26 +0100]:
> I'm totally fine with this patch, I agree that it's somewhat cleaner
> and the additional cost is negligible. Feel free to apply it to SVN.
> 
> Thanks for the review,

You're welcome; committed.

And BTW thanks for doing the work to get rid of libsysfs.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Mon, 18 Feb 2008 21:32:34 +0000
Subject: Re: [lm-sensors] [PATCH] adt7473: New driver for Analog
Message-Id: <20080218213234.GC5784@tree.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071219034116.GM6870@tree.beaverton.ibm.com> <20071219154759.7be5025c@hyperion.delvare> <20071219231437.GR6870@tree.beaverton.ibm.com> <20080217200250.GD2916@jupiter.solarsys.private>
In-Reply-To: <20080217200250.GD2916@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Mark M. Hoffman" <mhoffman@lightlink.com>
Cc: Jean Delvare <khali@linux-fr.org>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

On Sun, Feb 17, 2008 at 03:02:50PM -0500, Mark M. Hoffman wrote:

> Documentation/hwmon/adt7473 would be nice.

Ok, I'll generate one.

> That should be const.

Applied.

> > +	BUG();
> 
> Given ADT7473_PWM_BHVR_SHIFT is 5, this BUG() is obviously impossible.
> But I guess it's not obvious to GCC.

I'll put in a comment to explain that.

> NACK on that comment and associated code:  Jean Delvare submitted a
> patch to NVIDIA over two years ago to fix their bug.  Apparently some
> distros even carry his patch.  So, I don't want to encourage such a
> hack to persist.  Please just do the standard check here.

Ok.  I wonder if the nouveau people have any intention to
reverse-engineer the i2c controller?

Updated patch to follow soon.

--D

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

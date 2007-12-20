From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 20 Dec 2007 09:58:08 +0000
Subject: Re: [lm-sensors] [PATCH] adt7470: Support per-sensor alarm files
Message-Id: <20071220105808.1d9a044b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071219040123.GN6870@tree.beaverton.ibm.com>
	<20071219154012.18302de5@hyperion.delvare>
	<20071219221124.GP6870@tree.beaverton.ibm.com>
In-Reply-To: <20071219221124.GP6870@tree.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: lm-sensors <lm-sensors@lm-sensors.org>, "Mark M. Hoffman" <mhoffman@lightlink.com>, linux-kernel <linux-kernel@vger.kernel.org>

Hi Darrick,

On Wed, 19 Dec 2007 14:11:25 -0800, Darrick J. Wong wrote:
> On Wed, Dec 19, 2007 at 03:40:12PM +0100, Jean Delvare wrote:
> > In general we keep the all-in-one alarms file for compatibility, but
> > given that this driver is fairly new and libsensors never had specific
> > support for it anyway, it's probably OK to drop it this time.
> 
> Thanks for the code review.  I've made the changes you asked for and
> here's a new patch to supersede yesterday's.
> ---
> Remove the old alarms hack and replace it with per-sensor alarm files.
> 
> Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>

Looks alright to me this time.

Acked-by: Jean Delvare <khali@linux-fr.org>

BTW, did you try your driver with lm-sensors 3.0.0?

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

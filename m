From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 07 Nov 2008 20:35:13 +0000
Subject: Re: [lm-sensors] [PATCH 4/5] adt7473: Check inputs from sysfs writes
Message-Id: <20081107213513.2f347fca@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081107185621.13022.61885.stgit@elm3a70.beaverton.ibm.com>
	<20081107185641.13022.70557.stgit@elm3a70.beaverton.ibm.com>
	<20081107112040.0154e093.akpm@linux-foundation.org>
In-Reply-To: <20081107112040.0154e093.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Darrick J. Wong" <djwong@us.ibm.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Fri, 7 Nov 2008 11:20:40 -0800, Andrew Morton wrote:
> On Fri, 07 Nov 2008 10:56:41 -0800
> "Darrick J. Wong" <djwong@us.ibm.com> wrote:
> 
> > +#define ROUND_DIV(x, divisor)	(((x) + ((divisor) / 2)) / (divisor))
> 
> It might make sense to rename this to ROUND_CLOSEST, fix the
> double-evaluation and whap it into kernel.h?

To be consistent with DIV_ROUND_UP, I'd rather name the new function
DIV_ROUND_CLOSEST. But other than that, yes I agree that making this an
inline function and moving it to kernel.h would be a good idea. Many
many hwmon drivers use this and people keep asking about this construct.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

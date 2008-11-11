From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Tue, 11 Nov 2008 00:49:28 +0000
Subject: Re: [lm-sensors] [PATCH 3/5] adt7470: Check input range when sysfs
Message-Id: <20081111004927.GO8668@plum>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081107185621.13022.61885.stgit@elm3a70.beaverton.ibm.com> <20081107185636.13022.54109.stgit@elm3a70.beaverton.ibm.com> <20081110162214.b8202b60.akpm@linux-foundation.org>
In-Reply-To: <20081110162214.b8202b60.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@linux-foundation.org>
Cc: khali@linux-fr.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Mon, Nov 10, 2008 at 04:22:14PM -0800, Andrew Morton wrote:

> When writing changelogs, please explain _why_ a change was made, as
> well as what the change does.

Sorry about that.  Here's a revision:

Implement correct range checking for adt7470 to prevent userland from
writing impossible values into the chip, and cap out-of-range values per
standard hwmon conventions.

Implement correct rounding of input values per standard hwmon
conventions.

Is that better?

(Same goes for the adt7473 patch.)

> Looking at it, I guess it does change the userspace interface in minor
> ways, so we should merge it into 2.6.28.  Ditto
> adt7473-check-inputs-from-sysfs-writes.patch.  Agree?

Yes.

--D

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

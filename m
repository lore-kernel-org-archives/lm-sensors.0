From: Andrew Morton <akpm@linux-foundation.org>
Date: Tue, 11 Nov 2008 00:22:14 +0000
Subject: Re: [lm-sensors] [PATCH 3/5] adt7470: Check input range when sysfs
Message-Id: <20081110162214.b8202b60.akpm@linux-foundation.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081107185621.13022.61885.stgit@elm3a70.beaverton.ibm.com>
	<20081107185636.13022.54109.stgit@elm3a70.beaverton.ibm.com>
In-Reply-To: <20081107185636.13022.54109.stgit@elm3a70.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: djwong@us.ibm.com, khali@linux-fr.org, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

On Fri, 07 Nov 2008 10:56:36 -0800
"Darrick J. Wong" <djwong@us.ibm.com> wrote:

> Subject: [PATCH 3/5] adt7470: Check input range when sysfs files are written
> 
> Implement correct rounding and range checking for adt7470.
> 
> Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>

When writing changelogs, please explain _why_ a change was made, as
well as what the change does.

Coz I'm sitting here wondering if we need this in 2.6.28 and I don't
have all the information.

Looking at it, I guess it does change the userspace interface in minor
ways, so we should merge it into 2.6.28.  Ditto
adt7473-check-inputs-from-sysfs-writes.patch.  Agree?


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

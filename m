From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 28 Oct 2007 17:48:20 +0000
Subject: Re: [lm-sensors] [PATCH] i5k_amb: Convert macros to C functions
Message-Id: <20071028174820.GO30546@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070730033840.GG31314@jupiter.solarsys.private> <20070730192606.GD2795@tree.beaverton.ibm.com> <200707302141.l6ULfAnT021069@e1.ny.us.ibm.com> <20070731183706.GG2795@tree.beaverton.ibm.com> <20071016125429.GG3731@jupiter.solarsys.private> <20071016230657.GA6408@tree.beaverton.ibm.com> <20071018131550.GA3526@jupiter.solarsys.private> <20071018202243.GF31309@tree.beaverton.ibm.com> <20071025161912.9e4ef550.akpm@linux-foundation.org> <20071026185511.GB7333@tree.beaverton.ibm.com>
In-Reply-To: <20071026185511.GB7333@tree.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel <linux-kernel@vger.kernel.org>, lm-sensors <lm-sensors@lm-sensors.org>

Hi:

* Darrick J. Wong <djwong@us.ibm.com> [2007-10-26 11:55:11 -0700]:
> akpm objected to some of the macros, so convert them into functions.
> 
> Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
> ---
> 
>  drivers/hwmon/i5k_amb.c |   65 +++++++++++++++++++++++++++++++----------------
>  1 files changed, 43 insertions(+), 22 deletions(-)

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

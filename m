From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Mon, 26 May 2008 15:55:53 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (adt7473) Remove unused defines
Message-Id: <20080526155552.GH16874@mars.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080426162827.5694c65a@hyperion.delvare>
In-Reply-To: <20080426162827.5694c65a@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

* Darrick J. Wong <djwong@us.ibm.com> [2008-04-28 10:25:58 -0700]:
> On Sat, Apr 26, 2008 at 04:28:27PM +0200, Jean Delvare wrote:
> > All the *_MAX_ADDR defines are never used, so remove them. The number
> > of registers of each type is already expressed by the *_COUNT defines.
> > 
> > Signed-off-by: Jean Delvare <khali@linux-fr.org>
> > Cc: Darrick J. Wong <djwong@us.ibm.com>
> 
> Looks/compiles ok, so
> 
> Acked-by: Darrick J. Wong <djwong@us.ibm.com>

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Thu, 06 Mar 2008 19:49:50 +0000
Subject: Re: [lm-sensors] [RFC/PATCH] hwmon: fix common race conditions,
Message-Id: <20080306194950.GU7500@tree.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080304145440.GE2892@jupiter.solarsys.private>
In-Reply-To: <20080304145440.GE2892@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Mar 06, 2008 at 09:06:09AM -0500, Mark M. Hoffman wrote:
> Hi Darrick:
> Notice how encode_temp() above is outside of the locked section.  It is
> instructive for potential reviewers of this patch series to see just how easy
> it is to miss these.

Yep...

> REG_CFG5 (from which temp_twos_complement is updated) is never written.  Do you
> really need to read that during every update?  If you move that one read into
> the init routine, that will instantly kill all the race conditions associated
> with temp_twos_complement (assuming the hardware does not modify this register
> behind our backs).  What do you think?

Correct, the hardware doesn't modify that register at all.  I see your
patch, so I'll have a look through that.

--D

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

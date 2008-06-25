From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Wed, 25 Jun 2008 13:20:03 +0000
Subject: Re: [lm-sensors] [PATCH 03/10] hwmon: (lm85) Drop dead code
Message-Id: <20080625132003.GB23797@mars.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080412195552.421b4a28@hyperion.delvare>
In-Reply-To: <20080412195552.421b4a28@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2008-05-01 08:47:33 +0200]:
> Hi Juerg,
> 
> On Wed, 30 Apr 2008 21:52:45 -0700, Juerg Haefliger wrote:
> > Wow, sure a lot of unused junk. The patch looks good but doesn't apply 
> > cleanly over the revised patch 02/10. Could you please refresh and 
> > resend it?
> 
> Sure, here you go:
> 
> Drop a lot of useless register defines, conversion macros, data structure
> members and update code. All these register values were read from the
> device but nothing is done out of them, so this is all dead code in
> practice.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
> Refreshed to apply cleanly on top of the updated patch 2/10.
> 
>  Documentation/hwmon/lm85 |   11 ++----
>  drivers/hwmon/lm85.c     |   82 +---------------------------------------------
>  2 files changed, 6 insertions(+), 87 deletions(-)

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

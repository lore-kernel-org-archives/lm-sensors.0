From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 08 Jun 2008 15:36:26 +0000
Subject: Re: [lm-sensors] [patch 2.6.26-rc1] lm75: sensor reading bugfix
Message-Id: <20080608153626.GA7246@mars.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <200805031919.17110.david-b@pacbell.net>
In-Reply-To: <200805031919.17110.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David:

* David Brownell <david-b@pacbell.net> [2008-05-03 19:19:16 -0700]:
> LM75 sensor reading bugfix: never save error status as valid
> sensor output.  This could be improved, but at least this
> prevents certain rude failure modes.
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> ---
> Goes on top of the previously submitted lm75 cleanup patch:
> 
> 	http://marc.info/?l=lm-sensors&m0880547009929&w=2
> 
>  drivers/hwmon/lm75.c |   20 +++++++++++++++-----
>  1 file changed, 15 insertions(+), 5 deletions(-)


Applied to hwmon-2.6.git/testing, thanks.

Hrm, I missed this one on the first pass through my queue when I picked
up your other lm75 patches.  Looks like it's severe enough to warrant
sending to Linus before 2.6.26 (along with the prerequisite cleanup patch).

Any objections?

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

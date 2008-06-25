From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Wed, 25 Jun 2008 13:21:09 +0000
Subject: Re: [lm-sensors] [PATCH 05/10] hwmon: (lm85) Misc cleanups
Message-Id: <20080625132109.GD23797@mars.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2008-04-12 19:57:11 +0200]:
> Misc cleanups to the lm85 hardware monitoring driver:
> * Mark constant arrays as const.
> * Remove useless masks.
> * Have lm85_write_value return void - nobody is checking the returned
>   value anyway and in some cases it was plain wrong.
> * Remove useless initializations.
> * Rename new_client to client in lm85_detect.
> * Replace cascaded if/else with a switch/case in lm85_detect.
> * Group similar loops in lm85_update_device.
> * Remove legacy comments.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
>  drivers/hwmon/lm85.c |  151 ++++++++++++++++++++++----------------------------
>  1 file changed, 67 insertions(+), 84 deletions(-)

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

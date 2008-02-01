From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Fri, 01 Feb 2008 03:07:08 +0000
Subject: Re: [lm-sensors] [PATCH 1/3] hwmon: (lm80) Various cleanups
Message-Id: <20080201030708.GQ8290@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2008-01-05 15:35:09 +0100]:
> * Drop trailing whitespace
> * Fold a long line
> * Rename new_client to client
> * Drop redundant initializations to 0
> * Drop bogus comment
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
> Tested using i2c-stub.
> 
>  drivers/hwmon/lm80.c |   49 ++++++++++++++++++++++++-------------------------
>  1 file changed, 24 insertions(+), 25 deletions(-)
> 

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

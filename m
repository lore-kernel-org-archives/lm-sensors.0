From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 25 Nov 2007 01:53:30 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (gl518sm) Various cleanups
Message-Id: <20071125015330.GG13717@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2007-10-22 17:45:08 +0200]:
> * Drop history, it doesn't belong there
> * Drop unused struct member
> * Drop bogus struct member comment
> * Drop unused driver ID
> * Rename new_client to client
> * Drop redundant initializations to 0
> * Drop useless cast
> * Drop trailing space
> * Fix comment
> * Drop duplicate comment
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
>  drivers/hwmon/gl518sm.c |   49 ++++++++++++++++++-----------------------------
>  include/linux/i2c-id.h  |    1 
>  2 files changed, 19 insertions(+), 31 deletions(-)

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

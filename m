From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 25 Nov 2007 01:54:02 +0000
Subject: Re: [lm-sensors] [PATCH 1/4] hwmon: (gl520sm) Various cleanups
Message-Id: <20071125015402.GN13717@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071104234423.1e67928e@hyperion.delvare>
In-Reply-To: <20071104234423.1e67928e@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2007-11-04 23:44:23 +0100]:
> * Drop trailing spaces
> * Drop unused driver ID
> * Drop stray backslashes in macros
> * Rename new_client to client
> * Drop redundant initializations to 0
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
>  drivers/hwmon/gl520sm.c |   63 ++++++++++++++++++++++-------------------------
>  include/linux/i2c-id.h  |    1 
>  2 files changed, 30 insertions(+), 34 deletions(-)

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

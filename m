From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 25 Nov 2007 01:53:18 +0000
Subject: Re: [lm-sensors] [PATCH 3/3] hwmon: (adm1025) Various cleanups
Message-Id: <20071125015318.GE13717@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2007-10-10 21:14:11 +0200]:
> * Whitespace cleanups
> * Constify scaling constants
> * Fold long lines
> * Drop redundant initializations to 0
> * Rename new_client to just client
> * Use sysfs_create_group()
> * Drop a useless comment
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
>  drivers/hwmon/adm1025.c |   80 +++++++++++++++++++++--------------------------
>  1 file changed, 36 insertions(+), 44 deletions(-)

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

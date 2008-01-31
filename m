From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Thu, 31 Jan 2008 13:56:34 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (asb100) Various cleanups
Message-Id: <20080131135634.GJ8290@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080103231549.3cb00f27@hyperion.delvare>
In-Reply-To: <20080103231549.3cb00f27@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2008-01-03 23:15:49 +0100]:
> * Drop history, it's incomplete and doesn't belong there
> * Drop unused version number
> * Drop trailing spaces
> * Coding style fixes
> * Fold long lines
> * Rename new_client to client
> * Drop redundant initializations to 0
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Mark M. Hoffman <mhoffman@lightlink.com>
> ---
>  drivers/hwmon/asb100.c |  124 +++++++++++++++++++++++-------------------------
>  1 file changed, 60 insertions(+), 64 deletions(-)

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Thu, 31 Jan 2008 13:57:00 +0000
Subject: Re: [lm-sensors] [PATCH 2/3] hwmon: (asb100) De-macro the sysfs
Message-Id: <20080131135700.GK8290@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080103232107.0045f327@hyperion.delvare>
In-Reply-To: <20080103232107.0045f327@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean:

* Jean Delvare <khali@linux-fr.org> [2008-01-03 23:21:07 +0100]:
> Use standard dynamic sysfs callbacks instead of macro-generated
> wrappers. This makes the code more readable, and the binary smaller
> (by about 12%).
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Mark M. Hoffman <mhoffman@lightlink.com>
> ---
> The previous patch was supposed to be numbered "1/3" but I hit "Send"
> too fast, sorry for the confusion.
> 
>  drivers/hwmon/asb100.c |  233 +++++++++++++++++++-----------------------------
>  1 file changed, 90 insertions(+), 143 deletions(-)

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

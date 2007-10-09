From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Tue, 09 Oct 2007 01:24:38 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/lm87: Disable VID when it should be
Message-Id: <20071009012438.GN3835@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071008224810.4e80536d@hyperion.delvare>
In-Reply-To: <20071008224810.4e80536d@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

* Jean Delvare <khali@linux-fr.org> [2007-10-08 22:48:10 +0200]:
> A stupid bit shifting bug caused the VID value to be always exported
> even when the hardware is configured for something different.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
>  drivers/hwmon/lm87.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

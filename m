From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 03 May 2007 16:58:50 +0000
Subject: Re: [lm-sensors] [PATCH 08/36] Use menuconfig objects II - hwmon
Message-Id: <20070503185850.5db788e4@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.61.0704301225060.29151@yvahk01.tjqt.qr>
	<Pine.LNX.4.61.0704301327500.29151@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0704301327500.29151@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, lm-sensors@lm-sensors.org

Hi Jan,

On Mon, 30 Apr 2007 13:28:29 +0200 (MEST), Jan Engelhardt wrote:
> 
> Change Kconfig objects from "menu, config" into "menuconfig" so
> that the user can disable the whole feature without having to
> enter the menu first.
> 
> Signed-off-by: Jan Engelhardt <jengelh@gmx.de>
> 
> ---
>  drivers/hwmon/Kconfig |  109 ++++++++++++++++++++++++--------------------------
>  1 file changed, 53 insertions(+), 56 deletions(-)

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 08 Apr 2009 08:26:32 +0000
Subject: Re: [lm-sensors] [PATCH] ibmaem: Automatically load on HC10 blade
Message-Id: <20090408102632.1a85a151@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20090407205153.GA8311@plum>
In-Reply-To: <20090407205153.GA8311@plum>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: djwong@us.ibm.com
Cc: Andrew Morton <akpm@linux-foundation.org>, lm-sensors <lm-sensors@lm-sensors.org>, linux-kernel <linux-kernel@vger.kernel.org>

Hi Darrick,

On Tue, 7 Apr 2009 13:51:54 -0700, Darrick J. Wong wrote:
> Enable auto-probing for the HC10 blade and amend the supported system list.
> 
> Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
> ---
> 
>  Documentation/hwmon/ibmaem |    2 +-
>  drivers/hwmon/Kconfig      |    2 +-
>  drivers/hwmon/ibmaem.c     |    1 +
>  3 files changed, 3 insertions(+), 2 deletions(-)

Applied, thanks.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

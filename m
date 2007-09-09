From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Sun, 09 Sep 2007 16:08:17 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/it87: Add support for fan4 and fan5
Message-Id: <20070909160817.GG31992@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070706175505.33f91d9f@hyperion.delvare>
In-Reply-To: <20070706175505.33f91d9f@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

* Jean Delvare <khali@linux-fr.org> [2007-09-03 17:11:46 +0200]:
> Add support for the IT8716F and IT8718F fan4 and fan5. The late
> revisions of the IT8712F have these too but support is harder to add
> and nobody asked for it yet, so I didn't include it.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> ---
> This is the same patch I sent on July 6th, updated to apply on top of
> Mark's hwmon-testing tree. Any kind soul to review it? It's relatively
> simple.
> 
>  Documentation/hwmon/it87 |    3 +-
>  drivers/hwmon/it87.c     |   54 +++++++++++++++++++++++++++++++++-------------
>  2 files changed, 41 insertions(+), 16 deletions(-)

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Tue, 11 Sep 2007 11:26:29 +0000
Subject: Re: [lm-sensors] [PATCH] thmc50: fixed alarms clearing
Message-Id: <20070911112629.GI31992@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070909173534.844e24c7.krzysztof.h1@wp.pl>
In-Reply-To: <20070909173534.844e24c7.krzysztof.h1@wp.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi:

* Krzysztof Helt <krzysztof.h1@wp.pl> [2007-09-09 17:35:34 +0200]:
> From: Krzysztof Helt <krzysztof.h1@wp.pl>
> 
> This patch make use the interrupt status register instead
> of the interrupt status mirror register. Reading of the mirror
> register does not clear alarms.
> 
> Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

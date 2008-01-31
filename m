From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Thu, 31 Jan 2008 13:36:05 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/dme1737: fix Super-IO device
Message-Id: <20080131133605.GG8290@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0801240942h64bd96c1j67554c131c32c01e@mail.gmail.com>
In-Reply-To: <191fb4ca0801240942h64bd96c1j67554c131c32c01e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg:

* Juerg Haefliger <juergh@gmail.com> [2008-01-26 08:54:24 -0800]:
> Shoot, sorry about that. Attached  is the correct patch.
> 
> ------
> The dme1737 has a second place where the Super-IO device ID is
> checked. This has been missed by Jean's initial patch that adds
> support for user-controlled Super-IO device ID override. This patch
> fixes this issue.
> 
> Signed-off-by: Juerg Haefliger <juergh at gmail.com>

Applied to hwmon-2.6.git/testing, thanks.

-- 
Mark M. Hoffman
mhoffman@lightlink.com


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

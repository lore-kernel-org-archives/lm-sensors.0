From: Clemens Ladisch <clemens@ladisch.de>
Date: Fri, 23 Aug 2013 18:25:15 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: (k10temp) Add support for Fam16h (Kabini)
Message-Id: <5217A90B.5050902@ladisch.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1377279498-2868-1-git-send-email-wei@aristanetworks.com>
In-Reply-To: <1377279498-2868-1-git-send-email-wei@aristanetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@lm-sensors.org
Cc: Wei Hu <wei@aristanetworks.com>, linux-kernel@vger.kernel.org

Wei Hu wrote:
> The temperature reporting interface stays the same, so we just
> add the PCI-ID to the list.
>
> Verified on AMD Olive Hill.
> ---
>  Documentation/hwmon/k10temp |    1 +
>  drivers/hwmon/Kconfig       |    4 ++--
>  drivers/hwmon/k10temp.c     |    3 ++-
>  3 files changed, 5 insertions(+), 3 deletions(-)

Acked-by: Clemens Ladisch <clemens@ladisch.de>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Clemens Ladisch <clemens@ladisch.de>
Date: Wed, 06 Apr 2011 10:21:22 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/k10temp: add support for Fam15h
Message-Id: <4D9C3EA2.50605@ladisch.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1302079081-22572-1-git-send-email-andre.przywara@amd.com>
In-Reply-To: <1302079081-22572-1-git-send-email-andre.przywara@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Andre Przywara wrote:
> AMDs upcoming CPUs use the same mechanism for the internal
> temperature reporting as the Fam10h CPUs, so we just needed to add
> the appropriate PCI-ID to the list.
> This allows to use the k10temp driver on those CPUs.
> While at it change the Kconfig entry to be more generic.

Please also update the other places where these numbers are mentioned,
like here: <http://git.kernel.org/linus/aa4790a62878>.


Regards,
Clemens

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Clemens Ladisch <clemens@ladisch.de>
Date: Fri, 30 Mar 2012 12:20:43 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: k10temp: Add support for AMD Trinity CPUs
Message-Id: <4F75A51B.9090503@ladisch.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1333108649-22338-1-git-send-email-andre.przywara@amd.com>
In-Reply-To: <1333108649-22338-1-git-send-email-andre.przywara@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Andre Przywara wrote:
> The on-chip northbridge's temperature sensor of the upcoming
> AMD Trinity CPUs works the same as for the previous CPUs.
> Since it has a different PCI-ID, we just add the new one to the list
> supported by k10temp.
> This allows us to use the k10temp driver on those CPUs.

Acked-by: Clemens Ladisch <clemens@ladisch.de>

> On that way move the PCI-ID definition for the Llano and Brazos
> northbridges from pci_ids.h into this driver, since it's the only
> user and the header of pci_ids.h tell us to do so.

The reason for that is to avoid needless churn.
This move of the ID _is_ needless churn, and is change independent
of the Trinity ID.


Regards,
Clemens

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

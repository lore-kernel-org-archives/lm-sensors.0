From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:38 +0000
Subject: adt7463 on asus w1n laptop
Message-Id: <mHzvd0ty.1108559679.6709120.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <200502141545.03330.christophe.dr@free.fr>
In-Reply-To: <200502141545.03330.christophe.dr@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Christophe,

> OK, so which module in
> the /lib/modules/<kernelversion>/kernel/drivers/pci/hotplug/ directory are
> we supposed to load and with which parameters ?

I don't think you are supposed to load these. The main flag should be
sufficient.

--
Jean Delvare

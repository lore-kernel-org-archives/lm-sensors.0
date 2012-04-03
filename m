From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 03 Apr 2012 03:57:16 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: use module_pci_driver
Message-Id: <20120403035716.GA8682@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1333416346.18133.4.camel@phoenix>
In-Reply-To: <1333416346.18133.4.camel@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Axel Lin <axel.lin@gmail.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andreas Herrmann <andreas.herrmann3@amd.com>, Clemens Ladisch <clemens@ladisch.de>, Rudolf Marek <r.marek@assembler.cz>, Jean Delvare <khali@linux-fr.org>, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Mon, Apr 02, 2012 at 09:25:46PM -0400, Axel Lin wrote:
> This patch converts the drivers in drivers/hwmon/* to use module_pci_driver()
> macro which makes the code smaller and a bit simpler.
> 
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> Cc: Andreas Herrmann <andreas.herrmann3@amd.com>
> Cc: Clemens Ladisch <clemens@ladisch.de>
> Cc: Rudolf Marek <r.marek@assembler.cz>
> ---
>  drivers/hwmon/fam15h_power.c |   13 +------------
>  drivers/hwmon/k10temp.c      |   13 +------------
>  drivers/hwmon/k8temp.c       |   13 +------------
>  3 files changed, 3 insertions(+), 36 deletions(-)
> 
Applied.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

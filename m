From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 06 Jun 2006 06:33:18 +0000
Subject: [lm-sensors] [PATCH 1/3] pci: i2c scx200_acb avoid
Message-Id: <20060606083318.8c69a0ff.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jiri,

> i2c scx200_acb avoid pci_find_device
> 
> i2c scx200_acb bus driver pci_find_device -> pci_get_device conversion.

The use of pci_find_device in scx200_acb was added by a patch from
Jordan Crouse which is not yet finished and applied, so I asked Jordan
to fix it in the next iteration of his patch directly. As a result,
your patch will no more be necessary. Thanks for pointing out the use
of a deprecated function though.

As a side note, I'd suggest that you stop sending patches to three
mailing lists at once, as this generates lot of traffic and makes
discussions difficult. Please pick the best list for your patches and
send to only this list.

Thanks,
-- 
Jean Delvare


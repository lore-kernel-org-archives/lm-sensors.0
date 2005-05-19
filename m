From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:07 +0000
Subject: Ticket about sis630
Message-Id: <20040731174207.192b0ca8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040731162716.042cf6a8.khali@linux-fr.org>
In-Reply-To: <20040731162716.042cf6a8.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Hi Jean & Greg,
> 
> oops, forgot to push patch...
> please apply attached patch.
> 
> Patch description:
> this patch adds SiS 1039:0018 to PCI device list of sis630.c. This is
> needed, due to changes in pci quirks that cause sis630/sis730 LPC to
> change id from 008 -> 0018. This patch doesn't have any side effects,
> because i2c-sis630 checks for supported devices.

Oh yeah, now I remember. This went through the list once already. I've
pointed the ticket owner to this patch, hopefully it'll solve his/her
problem.

Thanks.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/

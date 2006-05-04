From: brix@gentoo.org (Henrik Brix Andersen)
Date: Thu, 04 May 2006 08:11:54 +0000
Subject: [lm-sensors] unique names for module parameters
Message-Id: <20060504081154.GB2459@osgiliath>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060504080231.GH19375@grok.co.za>
In-Reply-To: <20060504080231.GH19375@grok.co.za>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, May 04, 2006 at 10:02:31AM +0200, Thomas Andrews wrote:
> Would it not make more sense to prefix all module parameters in a more
> consistent manner eg:
> 
>     scx200_acb_base=0x810,0x820,0x830,0x840
>     scx200_acb_sioaddr=0x2e,0x4e,0x15c
>     scx200_acb_irq=5

No. With the current implementation, you have to specify
scx200_acb.base=0x810,0x820,0x830,0x840 to pass the 'base' parameter
to the scx200_acb module.

See linux/Documentation/kernel-parameters.txt for more information.

Regards,
Brix
-- 
Henrik Brix Andersen <brix at gentoo.org>
Gentoo Metadistribution | Mobile computing herd
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 213 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060504/99a40928/attachment.bin

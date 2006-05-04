From: tandrews@grok.co.za (Thomas Andrews)
Date: Thu, 04 May 2006 08:02:31 +0000
Subject: [lm-sensors] unique names for module parameters
Message-Id: <20060504080231.GH19375@grok.co.za>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

If a module has a parameter like "base", and you want to build a
monolithic kernel, as I understand it, you must put into your lilo/grub
kenel command-line. Is that correct?

If that is the case, then surely it is a bit short-sighted to use module
parameter names like "base" and "irq", etc because there is a very good
chance of modules using the same parameter names, and hence causing a
kind of name-space pollution?

Would it not make more sense to prefix all module parameters in a more
consistent manner eg:

    scx200_acb_base=0x810,0x820,0x830,0x840
    scx200_acb_sioaddr=0x2e,0x4e,0x15c
    scx200_acb_irq=5

Regards,
Thomas


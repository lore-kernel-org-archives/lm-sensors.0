From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sat, 01 Apr 2006 22:37:44 +0000
Subject: [lm-sensors] [PATCH] remove the fix_hstcfg from i2c-piix4
Message-Id: <442F00B8.6010507@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

This patch removes the fix_hstcfg option from the driver and related SMBus Interrupt Select register
magic because now we know what are valid values for this register. This patch updates the documentation
and adds new IRQ mode check so we are sure not to miss any new "unusual" value.

The PCI quirk for users of fix_hstcfg was not developed because the chipset lacks of subsystem ID registers
and DMI is stated "To be filled". Impact to existing systems is minimal because the problem showed up
on motherboards like 10 years back. On the other hand users of newer Serverworks and HT1000 systems won't
be misleaded by the message suggesting to try the fix_hstcfg any more.

Signed-off-by: Rudolf Marek <r.marek at sh.cvut.cz>

Regards
Rudolf


-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: patch_remove_fixhstcfg
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060402/9d3d753a/patch_remove_fixhstcfg.pl

From: jomick@rcn.com (Jeff Omick)
Date: Thu, 19 May 2005 06:23:40 +0000
Subject: asus 7v 333 sensors.
Message-Id: <3D9F9FA3.B92E379A@rcn.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi,


I saw you post that you got sensors to work with the asus a7v333 motherboard

i've been trying but have been unsuccessful.

i got all but 12c-viaproc modules to load i get 

[root@molokai proc]# modprobe i2c-viapro 
/lib/modules/2.4.18-3/kernel/drivers/i2c/i2c-viapro.o: init_module: No such
device
Hint: insmod errors can be caused by incorrect module parameters, including
invalid IO or IRQ parameters
/lib/modules/2.4.18-3/kernel/drivers/i2c/i2c-viapro.o: insmod
/lib/modules/2.4.18-3/kernel/drivers/i2c/i2c-viapro.o failed
/lib/modules/2.4.18-3/kernel/drivers/i2c/i2c-viapro.o: insmod i2c-viapro failed


here a lsmod

[root@molokai proc]# lsmod
Module                  Size  Used by    Not tainted
w83781d                18592   0  (unused)
i2c-proc                8160   0  [w83781d]
i2c-core               18720   0  [w83781d i2c-proc]
cmpci                  32756   0  (autoclean)
soundcore               6692   4  (autoclean) [cmpci]
ipt_state               1536   4  (autoclean)
ipt_LOG                 4736  10  (autoclean)
ipt_limit               1952   9  (autoclean)
iptable_filter          2752   1  (autoclean)
ipt_MASQUERADE          2464   1  (autoclean)
ip_conntrack_ftp        5056   0  (unused)
ip_nat_ftp              4320   0  (unused)
iptable_nat            20980   2  [ipt_MASQUERADE ip_nat_ftp]
ip_tables              13952   8  [ipt_state ipt_LOG ipt_limit iptable_filter
ipt_MASQUERADE iptable_nat]
ip_conntrack           21132   3  [ipt_state ipt_MASQUERADE ip_conntrack_ftp
ip_nat_ftp iptable_nat]
binfmt_misc             7556   1 
autofs                 12132   0  (autoclean) (unused)
tulip                  43104   2 
ide-cd                 30272   0  (autoclean)
cdrom                  32224   0  (autoclean) [ide-cd]
ehci-hcd               19520   0  (unused)
usb-uhci               24452   0  (unused)
usbcore                73216   1  [ehci-hcd usb-uhci]


if you could help out i would really appriciate it.

thanks
Jeff Omick

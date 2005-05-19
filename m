From: t7thguest@gmx.de (schiebe)
Date: Thu, 19 May 2005 06:24:12 +0000
Subject: ticket 1372 (A7V333)
Message-Id: <1061027552.6648.11.camel@campgrounds>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

with reference to my ticket 1372 i provide my dmesg and lsmod output.

dmesg:
i2c-core.o: i2c core module
i2c-viapro.o version 2.6.5 (20020915)
i2c-viapro.o: Can't detect vt82c596 or compatible device, module not
inserted.

[root@campgrounds root]# lsmod
Module                  Size  Used by    Tainted: P
sd_mod                 13388   0  (autoclean) (unused)
emu10k1                68136   0  (autoclean)
ac97_codec             13544   0  (autoclean) [emu10k1]
sound                  73108   0  (autoclean) [emu10k1]
soundcore               6276   7  (autoclean) [emu10k1 sound]
sr_mod                 17912   0  (autoclean)
agpgart                46752   3  (autoclean)
nvidia               1766848  11  (autoclean)
parport_pc             18756   1  (autoclean)
lp                      8868   1  (autoclean)
parport                36480   1  (autoclean) [parport_pc lp]
nfsd                   79024   8  (autoclean)
lockd                  57680   1  (autoclean) [nfsd]
sunrpc                 80412   1  (autoclean) [nfsd lockd]
autofs                 12948   0  (autoclean) (unused)
dmfe                   16705   0  (unused)
hisax                 541988   1
isdn                  136288   2  [hisax]
slhc                    6644   0  [isdn]
ipt_REJECT              3896   2  (autoclean)
iptable_filter          2380   1  (autoclean)
ip_tables              14648   2  [ipt_REJECT iptable_filter]
ide-scsi               11984   0
scsi_mod              106200   3  [sd_mod sr_mod ide-scsi]
ide-cd                 35196   0
cdrom                  33472   0  [sr_mod ide-cd]
nls_iso8859-1           3484   2  (autoclean)
nls_cp437               5116   2  (autoclean)
vfat                   12844   2  (autoclean)
fat                    38328   0  (autoclean) [vfat]
keybdev                 2880   0  (unused)
mousedev                5428   1
hid                    21700   0  (unused)
input                   5792   0  [keybdev mousedev hid]
usb-uhci               25868   0  (unused)
ehci-hcd               19592   0  (unused)
usbcore                77696   1  [hid usb-uhci ehci-hcd]
ext3                   69984   2
jbd                    51220   2  [ext3]
[root@campgrounds root]#

The other moduls (i2c-proc, i2c-dev, etc) can i load. Iam using Redhat
9. On my A7V133 (with RH9) everything works fine.

greetings
Tobias


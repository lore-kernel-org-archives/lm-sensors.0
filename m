From: Hubert.Li@Resilience.com (Hubert Li)
Date: Fri, 07 Jul 2006 07:47:07 +0000
Subject: [lm-sensors] Unresolved symbols in i2c-ipmi
Message-Id: <1152258427.2658.21.camel@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

When I do `depmod -a` after i2c and lm_sensors are installed, I got
error like this:

Unresolved symbols
in /lib/modules/2.4.21-40.EL.rftsmp/kernel/drivers/i2c/busses/i2c-ipmi.o

Then I run `depmod -a -e` to find detail information:
# depmod -a -e
depmod: *** Unresolved symbols
in /lib/modules/2.4.21-40.EL.rftsmp/kernel/drivers/i2c/busses/i2c-ipmi.o
depmod:         ipmi_smi_watcher_unregister_Rsmp_87e068b3
depmod:         ipmi_request_Rsmp_5ed81731
depmod:         ipmi_get_version_Rsmp_8bb4af12
depmod:         ipmi_create_user_Rsmp_e10206b5
depmod:         ipmi_smi_watcher_register_Rsmp_18f0b1ff
depmod:         ipmi_destroy_user_Rsmp_74848fb7

I use i2c-2.10.0 and lm_sensors-2.10.0 tarball to build on Red Hat
Enterprise Linux AS release 3(kernel version: 2.4.21-27). In order to
run it on Red Hat Enterprise Linux AS release 3(kernel version:
2.4.21-40), I set parameter `LINUX` of Makefile to 2.4.21-40 source
directory. Attached please find the diff files of i2c and lm_sensors'
spec files for fit my environment. The RFT_KERNEL in these two spec
files are refer to the 2.4.21-40 source.

Could you please help with the problem? Thank you.

Br,
Hubert




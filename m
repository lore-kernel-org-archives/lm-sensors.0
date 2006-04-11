From: fredantispam@free.fr (fred)
Date: Tue, 11 Apr 2006 17:07:42 +0000
Subject: [lm-sensors] nvidia GPU & i2c...
Message-Id: <443BE25E.5010703@free.fr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

In recent driver (1.0-8756), nvidia claims that it can now uses i2c busses.

Paste from README :
The NVIDIA Linux kernel module now includes i2c (also called I-squared-c,
Inter-IC Communications, or IIC) functionality that allows the NVIDIA Linux
kernel module to export i2c ports found on board NVIDIA cards to the Linux
kernel. This allows i2c devices on-board the NVIDIA graphics card, as
well as
devices connected to the VGA and/or DVI ports, to be accessed from kernel
modules or userspace programs in a manner consistent with other i2c ports
exported by the Linux kernel through the i2c framework.

You must have i2c support compiled into the kernel, or as a module, and
X must
be running. The i2c framework is available for both 2.4 and 2.6 series
kernels. Linux kernel documentation covers the kernel and userspace /dev
APIs,
which you must use to access NVIDIA i2c ports.

NVIDIA has noted that in some distibutions, i2c support is enabled. However,
the Linux kernel module i2c-core.o (2.4) or i2c-core.ko (2.6), which
provides
the export infrastructure, was not shipped. In this case, you will need to
build the i2c support module. For directions on how to build and install
your
kernel's i2c support, please refer to your distribution's documentation for
configuring, building, and installing the kernel and associated modules.

For further information regarding the Linux kernel i2c framework, please
refer
to the documentation for your kernel, located at .../Documentation/i2c/
within
the kernel source tree.

Ok.

I have nf4 chipset and nvidia cards, ok, but I have in my log messages :
NVRM: loading NVIDIA Linux x86 Kernel Module  1.0-8756  Wed Mar 29
14:26:26 PST 2006
i2c_adapter i2c-0: SMBus Quick command not supported, can't probe for chips
i2c_adapter i2c-1: SMBus Quick command not supported, can't probe for chips
i2c_adapter i2c-2: SMBus Quick command not supported, can't probe for chips
i2c_adapter i2c-3: SMBus Quick command not supported, can't probe for chips
i2c_adapter i2c-4: SMBus Quick command not supported, can't probe for chips
i2c_adapter i2c-5: SMBus Quick command not supported, can't probe for chips

What does it means ?

Thanks in advance.

-- 
Fred.


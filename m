From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 08 Feb 2011 16:42:48 +0000
Subject: [lm-sensors] Intel boards utilizing QST for fan control
Message-Id: <20110208164248.GC13717@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

there are a number of Intel boards using Intel's "Quiet System Technology"
or QST for temperature monitoring and fan control.

This functionality is currently not supported by Linux. If your board uses QST,
you will not be able to see the temperature readings used to determine fan speeds, 
and you will not be able to display fan speeds.

Background:

Intel provides an open source SDK which can be used to access QST information.
You can get this SDK from 
	http://software.intel.com/en-us/articles/Intel_Quiet_System_Technology_Software_Development_Kit/

This SDK depends on a Linux driver named heci. This driver was made available by Intel 
at http://sourceforge.net/projects/openamt/. The driver was included in the Linux kernel
staging tree for a period of time. Unfortunately, Intel abandoned the project and requested
the driver to be removed from the kernel, which happened with 2.6.32. See "Linux support" at
	http://www.thinkwiki.org/wiki/Intel_Active_Management_Technology_%28AMT%29
for details. Too bad, since the driver seemed to be in pretty good shape.

In summary, if you want to buy an Intel board and want to see voltage and fan monitoring 
data in Linux, check the board specification if it utilizes QST for fan control. If it does,
the board may not be optimal for your purpose, and you might want to look for another board
instead.

If you do have such a board and want its fan control to be supported by the Linux kernel,
I would suggest to get in touch with Intel and request such support. Maybe they reconsider
their position if enough people request it.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

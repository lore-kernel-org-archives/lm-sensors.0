From: akuster@mvista.com (Armin Kuster)
Date: Thu, 19 May 2005 06:23:31 +0000
Subject: Update to 405 i2c drivers
Message-Id: <3CA4D78A.342BC9F5@mvista.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Here in an update to the 405 i2c drivers,  They have been altered to
support the on-chip driver standard now being used in the ppc 4xx
kernel.  So one driver can support the 405gp, np405l , np405H , stb03xxx
and stb04xxx.


IMPORTANT_CHANGES	<- added note on name change
doc/summary		<- minor name change
kernel/i2c-adap-ibm_ocp.c	<- renamed, updated to be able to upport
multi-i2c ports on any 405 cpu
kernel/i2c-algo-ibm_ocp.c	<- renamed, updated with some fixes 
kernel/i2c-algo-ibm_ocp.h	<- renamed
kernel/i2c-algo-ppc405.c	<- removed
kernel/i2c-algo-ppc405.h	<- removed
kernel/i2c-id.h	
kernel/i2c-ppc405.c	<- removed 
kernel/i2c-ppc405.h	<- removed 
kernel/i2c-ppc405adap.h	 <- removed 
mkpatch/Config.in	<- name change
mkpatch/FILES	<- added ocp drivers to list so it can be installed



TIA

Armin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 405_update.patch.gz
Type: application/octet-stream
Size: 22525 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20020329/a4b219fb/405_update.patch.obj

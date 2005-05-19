From: alex@alexdalton.org (Alexandre d'Alton)
Date: Thu, 19 May 2005 06:24:56 +0000
Subject: ADM1031 / ADM1030 Driver
Message-Id: <1083877103.1250.6.camel@megapc>
List-Id: <lm-sensors.vger.kernel.org>
References: <1083188185.5337.5.camel@megapc>
In-Reply-To: <1083188185.5337.5.camel@megapc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Again a new version of adm1031 driver attached.

That version adds:

	- add alarms file
	- corrected bug on reading fan2 pwm
	- setting either fan1_auto_channel or fan2_auto_channel to zero will
disable auto fan control
	- disable sampling on update in order to have consistant values for
temp readings and their extended resolution bits.

Thanks,

-- 
Alexandre d'Alton <alex@alexdalton.org>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: adm1031-linux-2.6.6-rc3.diff
Type: text/x-patch
Size: 34873 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040506/c6a8ec25/adm1031-linux-2.6.6-rc3.bin

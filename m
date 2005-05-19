From: bjorn@mork.no (=?iso-8859-1?q?Bj=F8rn_Mork?=)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: "probe" module param broken for it87 in Linux 2.6.6
Message-Id: <hvwu3gux0k.fsf@rasputin.ws.nextra.no>
List-Id: <lm-sensors.vger.kernel.org>
References: <hvk6zhzp6c.fsf@rasputin.ws.nextra.no>
In-Reply-To: <hvk6zhzp6c.fsf@rasputin.ws.nextra.no>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare <khali@linux-fr.org> writes:

> So I'd suggest that you simply use the standard exit sequence in the
> it87 driver (the second one in your current patch). A patch for the 2.4
> driver would be appreciated as well.

Here is a patch against current lm_sensors cvs using just the
standard, documented exit sequence.  

Removing code is my speciality :-)


Bj?rn

-------------- next part --------------
A non-text attachment was scrubbed...
Name: it87-lm_sensors-cvs2004-05-13.patch
Type: text/x-patch
Size: 559 bytes
Desc: against lm_sensors cvs removing extra exit command
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040513/6384a60c/it87-lm_sensors-cvs2004-05-13.bin

From: RaphaelD@tyan.com (Raphael Deng)
Date: Wed, 22 Feb 2006 03:01:33 +0000
Subject: [lm-sensors] Broadcom HT1000 support request
Message-Id: <3174569B9743D511922F00A0C94314230E8709F3@TYANWEB>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On you website, I found lm-sensors didn't have any plan to support HT1000.
But as I know, it's very easy to support it.

 

HT1000 still use the PIIX4 SMBus controller, and current i2c-piix4.c file
can support it by adding new chip Device ID 0x0205.

The vendor id is still formal Serverworks ID(0x1166).

 

Raphael Deng

Tyan Computer Corp

-------------- next part --------------
An HTML attachment was scrubbed...
URL: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20060222/3077d244/attachment.html

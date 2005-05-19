From: rnissl@gmx.de (Reinhard Nissl)
Date: Thu, 19 May 2005 06:24:40 +0000
Subject: Fujitsu Siemens sensor HERMES
Message-Id: <4024136B.7010005@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F70765D.5060209@gmx.de>
In-Reply-To: <3F70765D.5060209@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Jean Delvare wrote:

> All you have to do is split pwm into a different file in the 2.4 driver,
> and update the rest of the driver accordingly. This will require changes
> to be made to libsensors, and possibly sensors too, and I'll do them.

Attached you'll find the changes for kernel 2.4.x. Updated documentation will 
follow later.

Bye.
-- 
Dipl.-Inform. (FH) Reinhard Nissl
mailto:rnissl@gmx.de
-------------- next part --------------
A non-text attachment was scrubbed...
Name: lm_sensors2.diff.gz
Type: application/x-gzip
Size: 2558 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040206/f44e835d/lm_sensors2.diff.gz

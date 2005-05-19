From: lists@edeca.net (David Cannings)
Date: Thu, 19 May 2005 06:25:27 +0000
Subject: Sensors without module support
Message-Id: <41C96B89.7050208@edeca.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Is it possible to use lm-sensors without module support in the kernel?
sensors-detect exits immediately with "couldn't open /proc/modules".  I
am using 2.6.7 and have compiled i2c and the relevant code for my
sensors (an SiS 961 and Winbond chip) into the kernel.

I don't wish to enable module support on the machine as it's a server
and I'd like to keep that extra hole closed up.

Thanks,

David

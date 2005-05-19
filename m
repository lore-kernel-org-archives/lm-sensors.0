From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:52 +0000
Subject: Winbond W83792D driver
Message-Id: <425F8DB8.5020303@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <42461044.3080406@mds.gotdns.com>
In-Reply-To: <42461044.3080406@mds.gotdns.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all.

We just tried and all three bits can be used despite the fact datasheet proposes
on page 37 that bit2 should be 0 and bit6 1

We tried to write 0x76 and subclients moved to 0x4e and 0x4f.

Maybe the datasheet should be clearified that values on bit2 and bit6
are power on defaults but all three bits can be altered.

Regards

Rudolf

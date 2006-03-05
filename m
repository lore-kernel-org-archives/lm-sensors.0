From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sun, 05 Mar 2006 20:54:55 +0000
Subject: [lm-sensors] Broadcom HT1000 support request
Message-Id: <440B501F.9030709@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <3174569B9743D511922F00A0C94314230E8709F3@TYANWEB>
In-Reply-To: <3174569B9743D511922F00A0C94314230E8709F3@TYANWEB>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

> HT1000 still use the PIIX4 SMBus controller, and current i2c-piix4.c
> file can support it by adding new chip Device ID 0x0205.

I would like to ask if you can take a look to the datasheet and check the
HOST configutration bits, because it seems this chip and other serverworks defines
bits different way.

Thanks,

Regards
Rudolf


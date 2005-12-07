From: gardner.ben@gmail.com (Ben Gardner)
Date: Wed, 07 Dec 2005 17:28:30 +0000
Subject: [lm-sensors] [PATCH 0/3] i386: CS5535 chip support (Geode companion
Message-Id: <808c8e9d0512070928y6f50be0arcba9404de2f68f78@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Andrew Morton <akpm@osdl.org>
Cc: lm-sensors <lm-sensors@lm-sensors.org>, linux-kernel@vger.kernel.org

This patch series adds support for the AMD CS5535, which is the Geode
companion chip.  It targets the DIVIL (Diverse Integrated Logic)
components.

Patch 1 does the following:
 - verifies the existence of the CS5535 by checking the DIVIL signature
 - configures UART1 as a NS16550A
 - (optionally) enables UART2 and configures it as a NS16550A
 - (optionally) enables the SMBus/I2C interface

Patch 2 provides a simple GPIO char driver, modeled after the
scx200_gpio driver.

Patch 3 provides a SMBus/I2C driver, modeled after the scx200_acb driver.

Signed-off-by: Ben Gardner <bgardner at wabtec.com>


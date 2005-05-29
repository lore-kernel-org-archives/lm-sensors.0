From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Sun, 29 May 2005 12:40:10 +0000
Subject: [lm-sensors] future feature request - detection issue
Message-Id: <42999BFA.9010700@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

We are lm_sensors group that develops drivers for Winbond chip in Linux environment.
Our drivers are "motherboard indepent" so we have to implement very sophisticated chip detection methods.

Your chips like w83781d and compatible and also your new one w83792d have chip ID and manufacturer ID in bank0 register.
What if bios left the bank switched to other one? Then it is not possible to detect your chips.

Please can you consider to place the ID registers outside the BANKed register space? It will assure that the detection of
chips will be fine.

Thank you,

Regards

Rudolf


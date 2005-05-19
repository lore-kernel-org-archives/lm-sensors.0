From: marius.reiner@hdev.de (Marius Reiner)
Date: Thu, 19 May 2005 06:24:58 +0000
Subject: lm-sensors debian specific daemon installation
Message-Id: <20040518203500.525581a3.marius.reiner@hdev.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Aurelien,

lm-sensors contains a shellscript which adjusts fanspeeds corresponding
to temperature changes on sensors. This script runs like a daemon and
already gets installed with the current lm-sensors package in sid.
Now my question is: Do you want to include an init script in the debian
package and let the user decide whether to install it and run
update-rc.d automatically or should it just go to the examples directory
in the lm-sensors documentation?
Currently I know of two unstable-users (including me ;)), so I can send
you a working init script.

Please let me know how we should handle this.

Best regards,

Marius

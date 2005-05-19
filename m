From: marius.reiner@hdev.de (Marius Reiner)
Date: Thu, 19 May 2005 06:24:06 +0000
Subject: pwmconfig
Message-Id: <20030721143500.16b7195b.marius.reiner@hdev.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030721115123.11b859d1.khali@linux-fr.org>
In-Reply-To: <20030721115123.11b859d1.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

thanks for testing and patching pwmconfig.
Regarding the tempsensor issue, does the same thing happen if you change PWM values manually?

> Additionally, pwmconfig does not work for me, but maybe that's just my
> system not supporting it.

You mean your fans don't respond to PWM changes? There's a high chance your mainboard has no support, maybe this page has some info on it: http://www.almico.com/forumindex.php

If you're a bit crazy, you could add the fan control circuit yourself, then my homepage may be of use for you: http://www.hdev.de

Regards,
  Marius

From: hwang@circadiant.com (Howard Wang)
Date: Tue, 08 Nov 2005 00:55:40 +0000
Subject: [lm-sensors] i2c -dev and i2c bus driver
Message-Id: <24EB6743805F45478251E18DEBF3F6BE8133F0@csserver.circadiant.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <24EB6743805F45478251E18DEBF3F6BE8133DD@csserver.circadiant.com>
In-Reply-To: <24EB6743805F45478251E18DEBF3F6BE8133DD@csserver.circadiant.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org




-----Original Message-----
From:	Howard Wang
Sent:	Mon 11/7/2005 12:31 PM
To:	lm-sensors@lm-sensors.org
Cc:	
Subject:	RE: [lm-sensors] i2c -dev and i2c bus driver
Hi,

Well I dont know the architecture (and today have no time to look deeper) but I can see (in kernel 2.6.14) second i2c driver:

 scx200_acb.c
 scx200_i2c.c

Maybe it is what you want?

yes, that's what I loaded after booing and using i2c-dev driver to talk to
our i2c device, for the devices connnected to the ACB 2 of superIO from the
microporcessor, every thing works. however, for the device, connected to
ACB 1 of superIO, I won't be able to talk to them.

any suggestions.

really appreciate your help.

howard


Regards
Rudolf





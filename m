From: hwang@circadiant.com (Howard Wang)
Date: Mon, 07 Nov 2005 17:49:18 +0000
Subject: [lm-sensors] i2c -dev and i2c bus driver
Message-Id: <24EB6743805F45478251E18DEBF3F6BE8133EA@csserver.circadiant.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <24EB6743805F45478251E18DEBF3F6BE8133DD@csserver.circadiant.com>
In-Reply-To: <24EB6743805F45478251E18DEBF3F6BE8133DD@csserver.circadiant.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

appreciate your help. the i2c bus driver of my system is sc1200 from AMD, 
there is i2c bus driver scx200_i2c, I just wonder whether this driver supports
two buses, currently it only talks to one bus on my system. I dont know how 
I can make it to talk to the second bus.

regards

howard



-----Original Message-----
From:	Rudolf Marek [mailto:r.marek@sh.cvut.cz]
Sent:	Fri 11/4/2005 5:55 PM
To:	Howard Wang
Cc:	lm-sensors@lm-sensors.org
Subject:	Re: [lm-sensors] i2c -dev and i2c bus driver

> Yes, all you need to register it to the subsystem. (They can share common functions). Please have a look to i2c-nvidia.c
> If you have more questions, just write.
I mean i2c-nforce2.c
Sorry,
Rudolf



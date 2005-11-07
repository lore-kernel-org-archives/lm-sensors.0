From: r.marek@sh.cvut.cz (Rudolf Marek)
Date: Mon, 07 Nov 2005 18:00:32 +0000
Subject: [lm-sensors] i2c -dev and i2c bus driver
Message-Id: <436F8828.5010005@sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <24EB6743805F45478251E18DEBF3F6BE8133DD@csserver.circadiant.com>
In-Reply-To: <24EB6743805F45478251E18DEBF3F6BE8133DD@csserver.circadiant.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Howard Wang wrote:
> appreciate your help. the i2c bus driver of my system is sc1200 from AMD, 
> there is i2c bus driver scx200_i2c, I just wonder whether this driver supports
> two buses, currently it only talks to one bus on my system. I dont know how 
> I can make it to talk to the second bus.

Well I dont know the architecture (and today have no time to look deeper) but I can see (in kernel 2.6.14) second i2c driver:

 scx200_acb.c
 scx200_i2c.c

Maybe it is what you want?

Regards
Rudolf

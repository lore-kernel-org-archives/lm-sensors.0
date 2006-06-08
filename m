From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 08 Jun 2006 15:33:31 +0000
Subject: [lm-sensors] [PATCH] i2c: fix scx200_acb functionalities
Message-Id: <20060608173331.e5af158c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060607222407.6dc85114.khali@linux-fr.org>
In-Reply-To: <20060607222407.6dc85114.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greg,

Quoting myself:
> Can you please push this to Linus as soon as possible? It would be nice
> to have this fix in 2.6.17 (and -stable too.)
> 
> 
> The scx200_acb advertises SMBus block transactions as supported. In
> fact, it supports SMBus block writes, but not SMBus block reads which
> are more complex to implement.
> 
> This fixes an oops reported by Alexander Atanasov:
> http://marc.theaimsgroup.com/?l=linux-kernel&m4970382125094

Huh, please hold on, my fix seems to be incomplete.

-- 
Jean Delvare


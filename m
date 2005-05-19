From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:02 +0000
Subject: Fancontrol (perl) patch
Message-Id: <20040619235550.261e1229.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <637C4FE1-BEA4-11D8-8C9C-000A95AF6760@hawaii.rr.com>
In-Reply-To: <637C4FE1-BEA4-11D8-8C9C-000A95AF6760@hawaii.rr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Dean,

> Add END {} block to restore fans on many kinds of errors/interrupts.
> Remove arugment from restorefans

Two questions:

1* What cases are you trying to catch? You already seem to be catching
all possible signals.

2* I suspect that the restorefans() function will be called twice more
often than not. Since the END block is executed on exit, and
restorefans() exits, won't it call itself each time?

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/

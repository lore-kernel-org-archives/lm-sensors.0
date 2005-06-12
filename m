From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 12 Jun 2005 10:39:32 +0000
Subject: [lm-sensors] Patch to check return values in i2c-algo-bit.c
Message-Id: <20050612103905.279c71ce.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050611110823.GA21311@kestrel>
In-Reply-To: <20050611110823.GA21311@kestrel>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Karel,

> > Although I agree on the problem, I think we can solve it with less
> > changes than you did. You are basically checking the return value of
> 
> OK - no problem. Is it necessary for me to resend the patch with the
> superfluous changes removed?

Yes please. Please also make sure the patch will apply properly using
patch -p1 (that's not the case of your original patch), and include a
Signed-off-by line at the top.

And please reply to the list, NOT to me.

Thanks,
-- 
Jean Delvare

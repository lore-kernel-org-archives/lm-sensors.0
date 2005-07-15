From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 15 Jul 2005 20:25:28 +0000
Subject: [lm-sensors] Patches Doubt
Message-Id: <20050715202454.4a572346.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <42D2FDEF.6020504@feitoza.com.br>
In-Reply-To: <42D2FDEF.6020504@feitoza.com.br>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Marcelo,

> Someone has told me:
> Well, as long as last_updated is set to jiffies + something at some
> point, then using time_after() only is the correct solution.
> 
> That's why the patches are correct?

Yes, assuming "something" can be 0.

The primary reason why I say these patches are good is because all other
hardware monitoring drivers were recently modified the exact same way.

I have queued your patches locally and will send them up to Greg KH once
other pending patches have reached him.

Thanks,
-- 
Jean Delvare

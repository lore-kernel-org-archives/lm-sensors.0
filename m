From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 18 Aug 2006 09:18:06 +0000
Subject: [lm-sensors] [RFC PATCH 2.6.18-rc4-mm1] hwmon: unchecked return
Message-Id: <20060818111806.abab2f06.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060814020407.GA3327@jupiter.solarsys.private>
In-Reply-To: <20060814020407.GA3327@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

> > That's not enough, unfortunately. In case of error you must unregister
> > the driver before returning. I also think we should print some message
> > on error. Care to send an updated patch?
> 
> Updated patch attached. I have tested it on my machine and everything
> is working, but if other hwmon drivers use this, can they apply the
> patch on their machine and see if the modules fail to load?

Thanks for the update. I tested this with the it87 driver and it worked
as designed, preventing the driver to load if an error occurs.

Unfortunately you forgot to sign your patch. Can you please resend the
patch with the proper Signed-off-by line? While you're there please
also fix the indentation of the "return" line, which isn't correct.

-- 
Jean Delvare


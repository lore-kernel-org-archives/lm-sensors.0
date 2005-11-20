From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 20 Nov 2005 23:26:42 +0000
Subject: [lm-sensors] VT8231 patch for review
Message-Id: <20051120232719.0a7a9102.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051116150825.2410D12E9E@bluewhale.planbit.co.uk>
In-Reply-To: <20051116150825.2410D12E9E@bluewhale.planbit.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Roger,

> Please can you send me a copy of the changed file that you have, then we are
> in sync.

See my other post on the list. The patch is here:
http://khali.linux-fr.org/devel/i2c/linux-2.6/hwmon-vt8231-new-driver.patch

I'll updated it in-place if needed, until it gets merged.

> I am happy to take a look at the latest 2.9.2 sensors library and user space
> utility to bring it in line with the current numbering scheme - these should
> be minor changes.  I don't have a 2.4-based system here, however, so it
> won't be easy for me to update the 2.4 version of the VT8231 kernel module
> unless I reinstall a system here, which I am not really too keen to do.  Is
> there anyone who is responsible for the 2.4 version of the module who can
> take on that work?

That would be Mark D. Studebaker, but as you can see it doesn't look
like he will help us, at least not now.

Anyway, I've done all the necessary changes in lm_sensors CVS already.
Please confirm that it works for you at least. I've taken my chance
with the 2.4 driver as well, but I have no chip so I definitely cannot
test anything myself. I hope my call for testers, both on our site and
on the list, will have some effect.

Thanks,
-- 
Jean Delvare

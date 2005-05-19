From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:56 +0000
Subject: lm-sensors install goes fine, but I only get status of EEPROMs
Message-Id: <20040508141134.563f82de.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <409C6578.2040008@knology.net>
In-Reply-To: <409C6578.2040008@knology.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> OK, my problem:  the install of lm_sensors seems to go fine. 
> Everything gets detected like it should, but when I run 'sensors', all
> I see are the EEPROMs.  I've check the FAQ entry for this and think
> I've done what it says to do--still no luck.  This is an Intel
> D865PERL board.  I don't know the specific sesnor ID , but they are
> detected as an SMSC EMC6D100 chipset...technical information is at 
> http://www.smsc.com/main/catalog/emc6d100.html#Additional%20Information.
>  
> If the lm85 driver isn't right for this chipset, and there isn't one 
> that is, I'd be glad to try to build a driver...I will probably need 
> some help on that.

The lm85 driver should support it. We have to find out why it didn't.

Please recompile with I2C chip debug turned on (it's an option in the
Linux configuration menu), then reload the lm85 driver and watch the
logs for hints.

You could also try using the force parameter of the lm85 module to force
it to accept your chip, and see how it goes:
  modprobe lm85 force=0,0x2e
Again, watch the logs for hints.

-- 
Jean Delvare
http://khali.linux-fr.org/

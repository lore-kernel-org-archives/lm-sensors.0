From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 28 Oct 2007 19:20:54 +0000
Subject: Re: [lm-sensors] What to use as prefix for TI TMP401 IC,
Message-Id: <20071028202054.4bd13dc2@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4722FB3C.9010402@hhs.nl>
In-Reply-To: <4722FB3C.9010402@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 28 Oct 2007 13:55:45 +0100, Hans de Goede wrote:
> Jean Delvare wrote:
> > Did you check first if the TMP401 was compatible with another device we
> > already support? After a quick look, the register map reminds me those
> > of the LM90/ADM1032 a lot. It would be worth checking that the TMP401
> > device couldn't be supported by the lm90 driver by just adding the
> > device and manufacturer ID...
> 
> I did, its indeed like the lm90, except that the local (on chip) temp sensor 
> registers all are 16 bits (split in a low and high reg) insetad of the 8 bits 
> of the lm90, which esp with all the special cases already in lm90.c seems like 
> enough of a divergence to me to warrant a new driver.

Good point, I agree that a separate driver is fine in this case. You
might still be able to copy-n-paste a good load of code from the lm90
driver, as it is state-of-the-art when it comes to dynamic sysfs
callbacks, individual alarm files, etc.

> > Also, I suggest that you add detection for the TMP401 to sensors-detect
> > right away. That's the best way to find early testers for your work.
> 
> Will do.

Thank you. Other than a misplaced parenthesis in a comment, it looks OK
to me. Can you please also add an entry in the Devices table on the
wiki, so that everybody can follow your progress?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

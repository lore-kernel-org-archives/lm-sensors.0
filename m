From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:21 +0000
Subject: I2C crash - ADM1021
Message-Id: <20031010222426.57b7ee46.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1063901946.2937.27.camel@localhost>
In-Reply-To: <1063901946.2937.27.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> Just a quick FYI update.

Nice to you to keep us informed :)

> Today, I updated all source for I2C and lmsensors from CVS.

Which basically means you have 2.8.1 - since almost no changes have been
made since we released it.

> When running sensors-detect, it had slightly different settings
> for the OPTIONS line in modules.conf for the adm1021 driver.
> 
> Previously, the line read
> options adm1021 ignore=0,0x18,0,0x4c
> 
> Now, the instructions correctly show
> options adm1021 ignore=0,0x4c,0,0x4e

In your original mail, you said the line was:
options adm1021 ignore=0,0x18,0,0x4c,0,0x4e
That is, all potential addresses disabled.

Now, if 0x4e wasn't actually disabled, it explains how your system could
possibly crash. (Not that we undestand why it did, but at least it had a
"chance" to.)

> The difference being that the driver was polling a port it had no
> business doing and I believe this is what caused my system to crash!

Makes sense.

> Now, the irony is that the information from port 0x18 is totally
> useless as it shows system and cpu temperature at -41C!
> 
> /sbin/modprobe adm1021 ignore=0,0x4c,0,0x4e
> 
> sensors
> ----------------
> lm84-i2c-0-18
> Adapter: SMBus Via Pro adapter at 5000
> Algorithm: Non-I2C SMBus adapte
> Board:       -41?C  (low =   -1?C, high =  -17?C)
> CPU:         -41?C  (low =  +60?C, high =   -1?C)

The LM84 has a somewhat weak identification method, and is often
misdetected. There's not much we can do about it. Maybe we could decide
that the following conditions make us drop it:
* Board or CPU temp below 0.
* low limit > high limit
* high limits below 0
In your example, the 6 conditions are met, so we could reasonably decide
not to detect it. Even with, say, 3 or 4 conditions, I guess we could
drop it.

I just made these changes to sensors-detect, would you be kind enough,
give it a try and confirm that it now doesn't tell you to load adm1021
anymore? Thanks.

> But thank you anyway for making that minor correction!  I hope it was
> only me that had the disk trashing trouble!

We had no other reports, hopefully because nobody experienced the same.

> One interesting note is that when rebooting, I had to completely do a
> cold start.

The chip as 0x18 is not a LM84. Maybe it is some other chip that did not
like what the adm1021 driver did to him, and had its revendge at
shutdown time ;)

> Let me know if I can provide you with any additional detail.

Great that the changes I made to sensors-detect prevent your system from
crashing.

Thanks for the update :)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

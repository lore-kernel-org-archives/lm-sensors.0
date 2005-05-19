From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:52 +0000
Subject: Winbond W83792D driver
Message-Id: <20050415184945.30be8ead.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <42461044.3080406@mds.gotdns.com>
In-Reply-To: <42461044.3080406@mds.gotdns.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

> We just tried and all three bits can be used despite the fact
> datasheet proposes on page 37 that bit2 should be 0 and bit6 1
> 
> We tried to write 0x76 and subclients moved to 0x4e and 0x4f.
> 
> Maybe the datasheet should be clearified that values on bit2 and bit6
> are power on defaults but all three bits can be altered.

The datasheet looks already very clear to me (although it seems that it
confused several persons already). The bit definitions for CR4A clearly
state that all 3 low address bits can be changed for both subclients. I
don't think that the datasheet can be more clear about this. Insead, we
should simply pay more attention to what is written ;)

We already discussed this subclient address issue a few days ago, and I
fixed a problem related to this in the CVS right before the 2.9.1
release.

Whether or not we allow the user to force arbitrary subclient addresses
or force each in a separate range doesn't make much difference IMHO. The
chip has no limitation, but adding at the driver level is unlikely to
cause problems. Forcing subclient addresses is a feature only a few
users need.

Just remember that if we do *not* force subaddresses to different ranges,
then the driver has to handle the duplicate address case when the user
forces the addresses.

Thanks,
-- 
Jean Delvare

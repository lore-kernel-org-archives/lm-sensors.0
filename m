From: torvalds@osdl.org (Linus Torvalds)
Date: Wed, 19 Apr 2006 16:19:22 +0000
Subject: [lm-sensors] [PATCH] i2c-i801: Fix resume when PEC is used
Message-Id: <Pine.LNX.4.64.0604190918210.3701@g5.osdl.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060418140629.7cb21736.khali@linux-fr.org>
 <20060418170331.GA3915@jupiter.solarsys.private> <20060418211546.fa5a76df.khali@linux-fr.org>
 <20060419130857.7f2db2d4.khali@linux-fr.org>
In-Reply-To: <20060419130857.7f2db2d4.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Greg KH <greg@kroah.com>, "Mark M. Hoffman" <mhoffman@lightlink.com>, linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org



On Wed, 19 Apr 2006, Jean Delvare wrote:
> 
> The BIOS of the Tecra M2 doesn't like it when it has to reboot or
> resume after the i2c-i801 driver has left the SMBus in PEC mode. The
> most simple fix is to clear the PEC bit after after every transaction.

Just wondering.. Wouldn't it make more sense to clear it when closing the 
device or when shutting down, rather than after each transaction?

		Linus


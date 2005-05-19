From: kraxel@bytesex.org (Gerd Knorr)
Date: Thu, 19 May 2005 06:24:53 +0000
Subject: i2c address probing and AT24RF08 corruption
Message-Id: <20040419191304.GA16954@bytesex.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1082123259.407fe3fb3d41c@imp.gcu.info>
In-Reply-To: <1082123259.407fe3fb3d41c@imp.gcu.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> My proposal of address ranges is admitedly a trick, just meant to
> prevent about any form of eeprom corruption (although I of course put
> the stress on the AT24RF08 because we know how bad it is). It is not
> meant as a solution to prevent any kind of bus or video chips hangs. For
> this, the .class selection mechanism is what we want. Also note that the
> .class thing alone would not solve the eeprom corruption issues, since
> they usually live on the same bus as the hardware monitoring chips.

Yup, .class can not fully replace the address range lists, but it should
reduce the number of cases where the address lists are needed and thus
simplify maintaining them ;)

Analog TV cards usually have a have eeprom at 0xa0, with PCI Subsystem
ID and sometimes config info, serial number and such stuff ...
Everything else isn't critical, at least I'm not aware of any touble
cases in the analog TV world.

  Gerd

-- 
http://bigendian.bytesex.org

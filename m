From: mds@mds.gotdns.com (Mark Studebaker)
Date: Fri, 23 Dec 2005 23:19:04 +0000
Subject: [lm-sensors] cp6000 smbus driver
Message-Id: <43AC85E8.40807@mds.gotdns.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <24EB6743805F45478251E18DEBF3F6BE813467@csserver.circadiant.com>
In-Reply-To: <24EB6743805F45478251E18DEBF3F6BE813467@csserver.circadiant.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

IPMB is not supported.
There's the beginnings of a driver for 2.4 in the lm_sensors tree
but I never got it to work because my BMC didn't support it.

Howard Wang wrote:
> HI All,
> 
> I have a question: 
> 
> my machine is cp6000 from kontron, the system has pentium M + 6300 ESB hub.
> there is an smbus and an ipmb bus, I have no trouble talking to the smbus,
> but I have no way to talk to the ipmb bus, which is also supposed to use 
> smbus protocol.
> 
> my question is: to talk to the ipmb bus using pure i2c access,
> which one is the bus driver, the i801 or 6300 ESB
> and which driver is needed to talk the device on that ipmb bus ?
> 
> your help is greatly appreciated.
> 
> howard
> 
> 
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors at lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors


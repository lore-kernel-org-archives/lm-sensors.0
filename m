From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: Two Masters on one Bus?
Message-Id: <20030724014237.GD13286@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <200307231641.23416.sascha@akv-soft.de>
In-Reply-To: <200307231641.23416.sascha@akv-soft.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Sascha Volkenandt <sascha@akv-soft.de> [2003-07-23 16:41:23 +0200]:
> 
> I'm currently wondering if it is possible to have two master devices 
> connected to one I2C-Bus. I will also look into the I2C-Specifications, but 
> I guess most of you would know the answer on-the-fly. I have a book (about 
> a Motorola Microcontroller), where it is described to use the MC as an 
> I2C-Master. It sais there, that it is "sometimes" possible to drive two 
> masters on one bus, but not how specifically.

Yes it's possible.  The arbitration scheme is simple and very efficient.
But if you have to implement it by "bit-banging", I don't think that's 
any easier than just implementing a slave.

> The intention is to build a small Home-Controller connected to the server, 
> and I've thought about connecting them using I2C (easiest, only two/four 
> wires needed). The "plain" way would be to implement the I2C-Slave Protocol 
> on the MC, but that seems somewhat hard to accomplish, since it is a rather 
> slow processor doing quite some other things (such as driving an LCD, where 

Have you looked at PIC microcontrollers?  Cheap, decent docs, very easy
to learn assembly language, many free (beer and freedom) tools, and
some models have built-in I2C controllers.

http://www.microchip.com/

(Who cares about the desktop?  Interesting things are still happening
in the 8-bit world thanks to the combination of *very* small and *very*
cheap.  Hardware hackers wake up!)

> a refresh already takes ~10ms). So I thought about using both server and 
> controller as a Master Device, sharing an EEPROM where they can exchange 
> data.

Watch the write-cycle limits on the EEPROM if you plan to use it like a 
ring buffer - you will eventually wear it out.  OTOH many I2C peripheral
chips have some amount of otherwise unused parameter RAM; that would be
better.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

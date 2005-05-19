From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:17 +0000
Subject: False detection of sensors on MSI K7N2 Delta-L (NForce2)!
Message-Id: <20040930101038.M9671@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <415BD873.8010303@gmx.de>
In-Reply-To: <415BD873.8010303@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 30 Sep 2004 11:57:07 +0200, Jan Schiefer wrote
> I've been trying to get lm_sensors working on my lovely MSI K7N2 
> Delta-L NForce2 mainboard since I switched to kernel 2.6.x. When I 
> choose ISA or SMBUS it makes no difference. I tried every version... 
> It never worked...
> 
> Now I discovered the problem: False chip detection by sensors-detect.
> I finally got it working (manually) with kernel 2.6.9-rc2 and lm_sensors
> CVS.
> Just because I was lucky I tried the right module.
> 
> sensors-detect (even in latest CVS) makes following module suggestions:
> i2c-nforce2, i2c-isa, eeprom, w83627hf
> Only the eeprom reader will be detected then.
> 
> The correct modules are: i2c-isa, eeprom, w83781d
> Only these modules make it work. So you don't need i2c-nforce2 (I don't
> know why on a NForce2-Board...) and w83781d instead of w83627hf.

It's not exactly a false detection. Your motherboard has a W83627HF chip which
happens to be supported by both the w83781d and the w83627hf drivers. The
latter is prefered, so sensors-detect does the correct thing.

Now, if the w83627hf driver doesn't see your chip, that's the real problem and
we have to correct that.

We would need:
1* The full output of sensors-detect. Make sure to unload all chip drivers
(eeprom, w83781d, w83627hf) before running the script.
2* A dump of your chip contents. You should obtain it with "isadump 0x295 0x296".

Also note that if you only load i2c-isa, eeprom and w83781d, the eeprom module
will not actually be used, since it needs i2c-nforce2 (on your system).

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/

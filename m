From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:51 +0000
Subject: asb100 question
Message-Id: <20040411045155.GD17920@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <200404111158.58208.gar@reapl.net>
In-Reply-To: <200404111158.58208.gar@reapl.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Luke <gar@reapl.net> [2004-04-11 11:58:58 +1000]:
> Hi,
> 
> 	I have been trying to get sensors to work ASUS A7N8X-E Deluxe with the 
> love-sources-2.6.5-r3 and lm-sensors-2.8.6, I am using gentoo.
> 
> So anyways, I use the modules i2c-nforce2, asb100 and eeprom - and when I 
> emerge gkrellm, the sensors work! But when I run sensors I get:
> 
> galadriel root # sensors
> eeprom-i2c-1-52
> Adapter: SMBus nForce2 adapter at 5000
> Memory type:            DDR SDRAM DIMM
> Memory size (MB):       512
> 
> eeprom-i2c-1-50
> Adapter: SMBus nForce2 adapter at 5000
> Memory type:            DDR SDRAM DIMM
> Memory size (MB):       512
> 
> asb100-i2c-2-48
> Adapter: SMBus nForce2 adapter at 5500
> ERROR: Can't get alarm data!
> ERROR: Can't get IN data! (0x0001)
> ERROR: Can't get IN data! (0x0002)
> ERROR: Can't get IN data! (0x0003)

<etc>

Hmmm, looks to me like you have an old libsensors somewhere which is
getting in the way.  See also FAQ 4.27 here:

http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/doc/lm_sensors-FAQ.html#Section%204.27

> So aside from getting "sensors" to work, I have another question, I belive 
> temp1=CPU temp, temp2=MB temp (from looking at the BIOS), there are 2 other 
> temps detected apparently, temp35, and temp4% (Celcius) - is one a temp 
> for my nvidia graphics card, or the HDD?  I'd just like to label them 
> properly :)

It may be that both temp1 AND temp4 are CPU.  This is not uncommon for ASB100
with an Athlon.  But definitely temp3 is bogus and *none* of these are graphics
or HD temps.

BTW if you want HD temps look here:

http://smartmontools.sourceforge.net/

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:30 +0000
Subject: I2C device identification
Message-Id: <20020306155923.A11458@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <AFF2EB205B84D011ADB200805FFE6E010BE14F51@txexmta2.amd.com>
In-Reply-To: <AFF2EB205B84D011ADB200805FFE6E010BE14F51@txexmta2.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


If you see a device at, say, 0x31 and 0x51 which both seem to be
eeproms, then they are most likely the same device responding to
either address.  Don't count on most eeproms to show up twice like
this, though.  It is possible to have devices in the 0x30-0x3f and
0x50-0x5f be independant, unqiue devices.  It appears to be rare (at
least on motherboards). 

I hope this helps.


Phil

On Wed, Mar 06, 2002 at 10:44:15AM -0600, leo.duran@amd.com wrote:
> Hello,
> 
> In the "I2C Tools Page": http://www2.lm-sensors.nu/~lm78/i2ctools.html
> there is chart listing general devices addresses.
> 
> The range 0x30 thru 0x37 is listed as "eeprom shadow", whereas the range
> 0x50 thru 0x57 is listed as "eeprom".  Does this mean that the same (eeprom)
> device will respond to both addresses?  Or are these two distint devices?
> 
> Thanks for the clarification,
> Leo Duran.
> 

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A

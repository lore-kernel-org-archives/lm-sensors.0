From: phil@netroedge.com (phil@netroedge.com)
Date: Thu, 19 May 2005 06:23:36 +0000
Subject: More flash eeprom fun on a Thinkpad
Message-Id: <20020722124426.F28532@Stimpy.netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020721144141.C11600@Stimpy.netroedge.com>
In-Reply-To: <20020721144141.C11600@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


I think DIMM eeproms with SPD data can be anywhere from 0x50-0x57
(allowing for up to 8 DIMM slots per I2C/SMBus).  The addresses are
set by hardwiring certain pins on the DIMM slots which are in turn
connected to the address pins on the eeprom.  Some CPU's, like Xeons
have eeproms on them which show up at higher addresses.  For example,
it's not uncommon to see a Xeon box with only 4 DIMM slots, but have
eeproms showing up at 0x50, 0x51, and 0x57.

BTW-Did you try dumping the contents of the 0x57 to see what was in
it?


Phil


On Mon, Jul 22, 2002 at 08:59:51PM +0200, Jean Delvare wrote:
> 
> > Could we simply blacklist the 0x54-0x57 area unless the user 
> > explicitly 'forces' regular usage of that area?
> 
> Just for information, it seems that recent Sony Vaio laptops (at least
> mine) have an information eeprom at 0x57.
> 
> -- 
> Jean "Khali" Delvare
> http://www.ensicaen.ismra.fr/~delvare/

-- 
Philip Edelbrock -- IS Manager -- Edge Design, Corvallis, OR
   phil@netroedge.com -- http://www.netroedge.com/~phil
 PGP F16: 01 D2 FD 01 B5 46 F4 F0  3A 8B 9D 7E 14 7F FB 7A

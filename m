From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:36 +0000
Subject: More flash eeprom fun on a Thinkpad
Message-Id: <3D40A0C6.14FF6598@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20020721144141.C11600@Stimpy.netroedge.com>
In-Reply-To: <20020721144141.C11600@Stimpy.netroedge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I'm hoping that the corruption is only in the
24RF08 "access protection page" which is at 0x5C.
That's what Australia Joe thinks and I'm inclined to agree.
Since the portion of the chip at 0x54-57 is just a regular-old
24C08, it stands to reason that the problem is in the other part.
Stay tuned...


phil@netroedge.com wrote:
> 
> I think DIMM eeproms with SPD data can be anywhere from 0x50-0x57
> (allowing for up to 8 DIMM slots per I2C/SMBus).  The addresses are
> set by hardwiring certain pins on the DIMM slots which are in turn
> connected to the address pins on the eeprom.  Some CPU's, like Xeons
> have eeproms on them which show up at higher addresses.  For example,
> it's not uncommon to see a Xeon box with only 4 DIMM slots, but have
> eeproms showing up at 0x50, 0x51, and 0x57.
> 
> BTW-Did you try dumping the contents of the 0x57 to see what was in
> it?
> 
> Phil
> 
> On Mon, Jul 22, 2002 at 08:59:51PM +0200, Jean Delvare wrote:
> >
> > > Could we simply blacklist the 0x54-0x57 area unless the user
> > > explicitly 'forces' regular usage of that area?
> >
> > Just for information, it seems that recent Sony Vaio laptops (at least
> > mine) have an information eeprom at 0x57.

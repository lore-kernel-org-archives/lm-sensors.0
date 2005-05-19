From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:35 +0000
Subject: Ticket #920
Message-Id: <3D286EA3.3396D377@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200206221117.33609.veso_vdd@mail.orbitel.bg>
In-Reply-To: <200206221117.33609.veso_vdd@mail.orbitel.bg>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

i2c-voodoo3 had a bug in it where it wasn't flushing PCI posted writes.
This may or may not be the problem.
Can you get it from CVS
and try it?


Vesselin Dimitrov wrote:
> 
> On Monday 01 July 2002 01:10, you wrote:
> > I'm stumped.
> > If i2cdump works then i2c-voodoo3 is working fine.
> > Don't know what the scanline problem is either.
> > If you load eeprom instead of ddcmon, then look in
> > /proc/sys/dev/sensors/eeprom-i2c-2-50,
> > do you see the same data you saw in i2cdump?
> 
> No, all the entries in /proc/sys/dev/sensors/eeprom-i2c-2-50
> (from 00 to f0) contain zeros.

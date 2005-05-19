From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:28 +0000
Subject: Complete dead system
Message-Id: <3C3FB02B.9400DFE6@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Translation anybody?
Sounds like his system dies when i2c-i801 is loaded...
What were the other sensors modules loaded?

Rainer Zocholl wrote:
> 
> linux-i2c@pelican.tk.uni-linz.ac.at steht im
> "readme". Hoffentlich ist das keine groessere Mailingliste ;-)
> 
> Problem:
> 
> Hardware: MSI MS-6215 MoBo, DVB-s Karten.
> 
> Hat im BIOS (V.1.7 )eine Option "Thermal check".
> Wenn ich das aktiviere h?ngt die Kiste komplett(!) beim hochfahren
> und laden des Treibers:
> 
>   51:58 msi kernel: i2c-core.o: i2c core module
>   51:58 msi kernel: i2c-i801.o version 2.6.2 (20011118)
>   51:58 msi kernel: i2c-core.o: adapter SMBus I801 adapter at 0540 registered as adapter 0.
> <power off, da nix anderes mehr geht.>
>   54:26 msi syslogd 1.3-3#33.1: restart.
> 
> noch ein Versuch:
> 
>   54:37 msi kernel: i2c-core.o: i2c core module
>   54:37 msi kernel: i2c-i801.o version 2.6.2 (20011118)
>   54:37 msi kernel: i2c-core.o: adapter SMBus I801 adapter at 0540 registered as adapter 0.
> <power off, da nix anderes mehr geht.>
>   57:06 msi syslogd 1.3-3#33.1: restart.
> 
> Erst das deaktivieren verhinderte den H?nger.
> 
> Was ist das?
> 
> Rainer
> Rainer---<===>                         Vertraulich
>              //
>            //
>          <===>--------------ocholl, Kiel, Germany ------------

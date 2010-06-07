From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 07 Jun 2010 18:38:36 +0000
Subject: Re: [lm-sensors] Gigabyte MA785GMT-UD2H
Message-Id: <20100607203836.2be5a503@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <E1OI4SR-000499-9R@mendel.bio.caltech.edu>
In-Reply-To: <E1OI4SR-000499-9R@mendel.bio.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi David,

On Mon, 07 Jun 2010 09:45:58 -0700, David Mathog wrote:
> > > lm90-i2c-2-4c
> > > Adapter: NVIDIA i2c adapter 
> > > temp1:       +29.0Â°C  (low  =  +0.0Â°C, high = +105.0Â°C)  
> > >                       (crit = +127.0Â°C, hyst = +117.0Â°C)  
> > > temp2:       +19.6Â°C  (low  = -11.0Â°C, high = +94.0Â°C)  
> > >                       (crit = +127.0Â°C, hyst = +117.0Â°C)  
> > > 
> > > 
> > > Verified that these go up when the graphics card is busy.
> > 
> > The values are surprising. temp1 is on the sensor chip itself, so it's
> > the graphics adapter's temperature. Sounds reasonable. temp2 OTOH is a
> > remote sensors, which typically monitors the GPU. It should be much
> > hotter, and can anyway not be cooler than the board.
> > 
> > Are you sure sensors-detect found an LM90 chip and not an LM99? The
> > LM99 has a 16 degrees offset on temp2, 35Â°C would see more reasonable.
> 
> Ran sensors-detect again and it was LM99.  So tried this instead:
> 
> echo lm99 0x4c > /sys/bus/i2c/devices/i2c-2/new_device
> sensors
> lm99-i2c-2-4c
> Adapter: NVIDIA i2c adapter 
> temp1:       +27.0°C  (low  =  +0.0°C, high = +105.0°C)  
>                       (crit = +127.0°C, hyst = +117.0°C)  
> temp2:       +34.9°C  (low  =  +5.0°C, high = +110.0°C)  
>                       (crit = +143.0°C, hyst = +133.0°C)  
> 
> but that doesn't agree with the nvidia tools either:
> 
> nvidia-smi --query-gpu-info -a
> 
> GPU 0:
>         Product Name            : Quadro FX 1400
>         PCI ID                  : ce10de

6-digit PCI IDs? Wow.

>         Temperature             : 38 C

The problem is that we don't know where nvidia gets the value. Maybe
from the same sensor and they add an offset, or from another (internal)
sensor, which could explain the difference.

> Ran a graphics intensive program and did this again and both went up 5C,
> so it looks like lm99 reads 3C below the actual temp fairly
> consistently.  For whatever it is worth speedfan showed 40C when "idle",
> but idle on W7 is probably not the same as idle on linux.  Is there a
> way to add 3C to the lm99 reading in the sensors.conf file?

Yes there is:

chip "lm99-i2c-2-4c"

   compute temp2  @+3, @-3

> <SNIP>
> 
> > This is expected. As I understand it, the K8 sensor was per-core (or
> > even 2 sensors per core) while the K10 sensor is per CPU package.
> 
> I thought these CPUs had both per core sensors and a package sensor. 
> Why report only the last one?  Maybe because some of Brisbane chips had
> broken core sensors?  This is Regor though, hopefully with working core
> sensors.

I just don't know, sorry. Adding Andreas and Clemens to Cc, they may
know.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

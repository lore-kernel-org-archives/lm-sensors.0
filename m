From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:44 +0000
Subject: I2C DDC display
Message-Id: <20040228185408.33003b2f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040228001023.4653.qmail@web14901.mail.yahoo.com>
In-Reply-To: <20040228001023.4653.qmail@web14901.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Kronos,

> Hum, I can rewrite it using sda/scl operation, it's quite simple. But
> I don't think that the code is generic. When I wrote the adapter I
> decided to leave that stuff around just to be sure, but it does work
> without that black magic (ie. with only radeon_do_probe_i2c_edid), al
> least on my setup (R300 + analog LCD).

According to Jon, it's required only for some old monitors. BTW, Jon,
where did you get this information from?

I too have been having success with reading DDC information on various
graphics adapters (Matrox and nVidia) on recent enough monitors.

Frankly, I don't see the point in handling these old monitors. At least,
I wouldn't support them unless someone specifically asks for it and
provides enough information for us to do the right thing.

As for where the code should be, I still think it is *not* possible to
put it in the chip driver. If I understand it correctly, before the
special sequence is send on the bus, the EDID does *not* respond to any
I2C address. This means that the ddcmon driver will *never* be called.

> Also, I don't think that is safe to attach a client to radeon DDC
> busses (yet). During probe I fiddle directly with the adapter (without
> any locking), if another client kicks in I fear that it will blow up.
> radeonfb should register its own clients for probing EDID, it's in my
> TODO list.

I have been trying it :) And it worked correctly. Anyway, the radeonfb
driver only probes the EDID at startup, right? So accessing it later
sounds safe.

Thanks Kronos for entering the thread. I hadn't even realized you were
subscribed to the list.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

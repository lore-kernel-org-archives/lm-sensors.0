From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:32 +0000
Subject: lm_sensors && bt869
Message-Id: <20040101131938.2ae3b5ac.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031228153744.49065c91.khali@linux-fr.org>
In-Reply-To: <20031228153744.49065c91.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Well...actually I think we need the following new names:
> 1. switch_ntsc : To tell the bt869 to output either ntsc or pal
> (1=NTSC, 0=PAL)

I'd call the file "output_norm".

> 2. switch_colorbars : 1 to turn on colorbars calibration screen and 0
> to turn it off

Not sure about this one, I think I'd simply call it "colorbars".

> 3. change_colordepth : To change the color depth (for Voodoo3 there's
> only 16 and 24bit for TV-Out-Mode, other would have 32bit here, too)

This is "colordepth".

> 4. change_resolution[1-2] : 1 for the width(x) and 2 for the height(y)

I would say "output_width" and "output_height".

> 5. switch_half_resolution : Switch to turn on the Half-Resolution-Mode
> (this is a special mode which can't be merged with switch_resolution!)

"half_resolution" ?

> 6. switch_output_format : 2=RGB, 1=SVIDEO, 0=Composite

Using "format" is a bit confusing IMHO. What about "output_source"? (Oh
well this is maybe even more confusing...)

As a general rule, you don't want to prepend the action to the file
names.

> There's also a status[0-2] in there (read-only), but I couldn't figure
> out what exactly this is for. It is used but as it seems it's only for
> driver-internal things and not really for the end-user...Perhaps you
> could take a look over it!

Well, without the hardware I probably won't help much - and I don't
really plan to read the full data sheet ;) Don't know what to do with
these. If it's not a "public" think, we don't care much, except that it
might conflict with something else someday... Do as you want. If it's
not widely used, this also mean we can change it later if needed.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

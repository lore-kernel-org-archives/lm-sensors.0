From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 03 Dec 2009 13:15:11 +0000
Subject: Re: [lm-sensors] Zotac itx-f sensor i2cdump
Message-Id: <20091203141511.7f2d6b5a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <45354d3e0912020755s5c8f2c00rc9c5611c204ae719@mail.gmail.com>
In-Reply-To: <45354d3e0912020755s5c8f2c00rc9c5611c204ae719@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 2 Dec 2009 18:15:59 +0100, MC Matti wrote:
> >  http://dl.lm-sensors.org/lm-sensors/files/sensors-detect
> >
> donwloaded:
> [...]
> Probing for `Winbond W83L771AWG/ASG'...                     Success!
>    (confidence 6, driver `to-be-written')
> [...]

OK, that's a good start.

> > We do not have support for this chip yet.
>
> Is there a documentation?

There is, but I'm not quite sure what I can share. I have a document
for the old incarnation of these chips (W and G variants) from Winbond.
I don't think there is any restriction on it so I could give it to you,
however I don't know how much of it applies to your chip. The new
document for the AWG and ASG incarnations is not publicly available,
you have to request it by mail from Nuvoton:
http://www.nuvoton.com/hq/enu/ProductAndSales/ProductLines/ComputerIC/HardwareMonitor/HWMonitorforGraphicCardNBAndIA/W83L771AWG_W83L771ASG.htm

Feel free to give it a try if you are interested.

> Is anyone already working on it?

Not yet.

> Which driver would be the best to start with (if theres a doc)?

2 years ago I wrote down that the lm90 driver would be a good candidate
and that the W83L771W/G may be compatible with the Nat. Semi. LM86.
Honestly I can't remember what made me think this, but I'd trust me ;)
I don't know if it still applies to the AWG/ASG variant that you have.

You might as well take your chance and force the lm90 driver to treat
your chip as a lm86:

modprobe lm90 force_lm86=0,0x4c.

Now if your house burn, I'm not responsible, OK? ;)

For now I've added your request to the wiki.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

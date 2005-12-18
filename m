From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 18 Dec 2005 16:43:59 +0000
Subject: [lm-sensors] revisiting __SENSOR_DEVICE_ATTR() and array
Message-Id: <20051218174359.14e7d5d6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <439A7911.5020904@gmail.com>
In-Reply-To: <439A7911.5020904@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

> I too am partial to this way, less work for me ;-)
> Patch attached, done against 14.3 + your SENSOR_ATTR patch.

Are you certain this was the last version of your patch? I'm asking
because of the name: pc87360-use-sensor-attr-arrays~. Trailing tilde
usually means backup copy...

> > Lastly, would you want/accept to become the pc87360 driver maintainer?
> > If you do, just provide a patch to MAINTAINERS. You can look at other
> > hardware monitoring drivers entries for inspiration.
>
> thanks for that vote of confidence.  I guess I'd have the
> original author available for consult  ;-)

It took me several seconds to figure out that was me ;) You probably
know the device as least as good as I do by now, and you have one
physical device to test on, while I don't. I'm awaiting for your
MAINTAINERS patch :) But of course you are right, I'm still available
for advice if needed.

Thanks,
-- 
Jean Delvare


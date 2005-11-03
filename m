From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 03 Nov 2005 23:14:00 +0000
Subject: [lm-sensors] lm-sensors install changed/corrupted
Message-Id: <20051103231340.07cdf70d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <43699477.5000809@earthlink.net>
In-Reply-To: <43699477.5000809@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

> > How come that you use the lm90 driver while sensors-detect did not
> > suggest you should do so?
> 
> sensors-detect >> did << suggest that I use lm90 on the first run.
> On the second run it apparently did not (possibly because the lm90
> module was already loaded from the first run?)  I did not notice
> the inconsistancy in the sensors-detect output from the first and
> second runs until you pointed it out here.

This is really strange. Not only it did not suggest that you load the
lm90 driver (which would be expected as the driver was already loaded)
but it did not even see a device at a supported address on the SMBus.

> I then ran "lsmod | grep it87" to see if they had been loaded.
> Evidently not, since lsmod did not know of them.  So that's
> when I rebooted ... to give everything a chance to get
> settled down and loaded.

Actually you could have loaded them manually at this point. But on
second thought it's great you didn't, because it seems to demonstrate
that the problem was caused by sensors-detect itself rather than any
hardware monitoring drivers.

The lm90 and it87 drivers are fairly reliable by now, so I would have
been surprised that they could trigger the problem you described by
just loading them. Please let us know if they will now work properly.

That being said, I also don't quite see how sensors-detect could have
done that either. You don't seem to have any exotic hardware in there.

-- 
Jean Delvare

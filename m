From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 26 Mar 2008 11:28:19 +0000
Subject: Re: [lm-sensors] lm_sensors v2 asc7621 support
Message-Id: <20080326122819.26604f0d@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <47C9A8B9.20501@kenm.demon.co.uk>
In-Reply-To: <47C9A8B9.20501@kenm.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ken,

On Sat, 01 Mar 2008 19:04:25 +0000, Ken Milmore wrote:
> I've had a go at implementing support for George Joseph's experimental 
> Adigilog asc7621 driver in lm_sensors 2.10.5.  Find patch attached.
> 
> I've been running this for a while with the asc76xx driver on an Intel 
> D975XBX2 board.  It works just fine for reading the sensors, although 
> writing the alarm limits and such doesn't seem to work quite right.
> 
> Hopefully this might be a starting point for someone else to add 
> official support for these chips to lm_sensors.

For new drivers, we don't really want to add support to lm-sensors
2.10.x. Just use lm-sensors 3.0.x, which supports all hwmon drivers by
design.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

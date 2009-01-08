From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 08 Jan 2009 12:44:04 +0000
Subject: Re: [lm-sensors] Support for Intel DG33FB main board?
Message-Id: <20090108134404.7a698684@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <495C30EF.3090708@earthlink.net>
In-Reply-To: <495C30EF.3090708@earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Steve,

On Wed, 31 Dec 2008 21:56:47 -0500, Stephen Clark wrote:
> I have a new intel DG33FB mainboard when I run sensors-detect I get the following:
> ...
> Trying family `SMSC'...                                     Yes
> Found `SMSC LPC47M182 Super IO Fan Sensors'
>      (but not activated)
> ...
> Intel Core family thermal sensor...                         Success!
>      (driver `coretemp')
> 
> This lets me see the temps of the cores on my q6600 but not
> voltages or fan speeds. Are there any plans to support this
> main boards further?
> 
> sensors version 3.0.2 with libsensors version 3.0.2

The hardware monitoring features of the LPC47M182 are very often
nut used (and thus disabled), we don't even have a driver for them.

This means that hardware monitoring is done by either a chip on the
SMBus (Did sensors-detect find an SMBus to scan? Did it find any
unknown chip there maybe? Including the full output of sensors-detect
helps) or, if the board is based on an ICH8 or later Intel south
bridge, by the south bridge itself. We don't yet support the ICH8
integrated sensors, unfortunately [1].

[1] http://lists.lm-sensors.org/pipermail/lm-sensors/2009-January/025045.html

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

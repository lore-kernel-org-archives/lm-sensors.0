From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 09 Oct 2006 09:23:23 +0000
Subject: [lm-sensors] Supermicro X6DH8-G2+ / sensors not working
Message-Id: <20061009112323.0da9d46f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <451FF905.60001@hal.saar.de>
In-Reply-To: <451FF905.60001@hal.saar.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Michael,

> Jean Delvare wrote:
> > OK, now that it works, I will have to clean up the driver to make it
> > suitable for upstream submission. In particular this implies converting
> > the driver from an i2c-isa driver to a platform driver. Will you be
> > able to test this second variant of the driver?
>
> Sure, if it's not too much work. :)

Well hopefully this new version of the driver will just work. However,
be aware that, contrary to the previous version, I couldn't give a try
to this one, so you're the first tester. This means there could be a
couple sharp edges left, please let me know if you notice anything
wrong.

The changes are essentially in the way the driver is registered, so
basically, if you are able to load, unload and reload the driver, and
everything still works, it's a good sign that the conversion is a
success. You should also see the reserved I/O region in /proc/ioports
as "pc87427 FMC".

Please give it a try and report!

Thanks,
-- 
Jean Delvare
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: pc87427.c
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061009/fdef6935/attachment.c 

From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 09 Oct 2007 18:29:26 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon/lm78 and w83781d: Probe fewer I2C
Message-Id: <20071009202926.609b987a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071007122546.3f8b4d18@hyperion.delvare>
In-Reply-To: <20071007122546.3f8b4d18@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Uwe,

On Tue, 9 Oct 2007 16:59:10 +0200, Uwe Hermann wrote:
> On Sun, Oct 07, 2007 at 12:25:46PM +0200, Jean Delvare wrote:
> > We've never seen any device supported by the lm78 or w83781d driver
> > at addresses 0x20-0x27, so let's stop probing these addresses. Extra
> > probes cost time, and have potential for confusing or misdetecting
> > other I2C devices.
> 
> If the addresses are _theoretically_ possible (as per datasheet)
> wouldn't it be good to have an option to override this?

Virtually _all_ addresses are possible, as the I2C address can be
changed just by writing the new address to a register. So we don't want
to probe all possible addresses.

> Something like scanall=1 or similar? Or maybe that option already exists?

We already have the "probe" parameter, through which a user can ask the
driver to probe additional arbitrary addresses.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

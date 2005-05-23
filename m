From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Mon, 23 May 2005 16:28:20 +0000
Subject: [lm-sensors] Re: [RFC PATCH 2.6.12-rc3-mm2 1/2] i2c: new sysfs
Message-Id: <2538186705052307271fafb63d@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050503034928.GC4977@jupiter.solarsys.private>
In-Reply-To: <20050503034928.GC4977@jupiter.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 5/23/05, Jean Delvare <khali@linux-fr.org> wrote:
> No, not all i2c chip drivers are hardware monitoring monitors. At least
> the following should stay in drivers/i2c/chips:
> * ds1337
> * eeprom
> * isp1301_omap (what is this BTW?)
> * m41t00
> * pcf8574
> * pcf8591
> * rtc8564
Ah, yes you are right of course. I have no idea what isp1301_omap is
:), but I'd have to say that about the majority of stuff in i2c.

> > (...) and perhaps
> > drivers/i2c/bus to drivers/i2c (although the latter isn't necessary,
> > it just makes sense to me).
> 
> I don't this it is a good idea. The current scheme makes it clear which
> drivers create i2c busses, which are i2c chip drivers, which are
> algorithms and which are core drivers. I wouldn't change that.

My thought was more a removal of a redundancy, but since there will
still be some i2c/chips as you point out it doesn't make much sense.

I guess I'll have a little look into things myself, see how I'd go
about making bmcsensors independent from i2c on its own for now.

Thanks,
Yani

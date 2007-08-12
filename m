From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 12 Aug 2007 11:13:52 +0000
Subject: Re: [lm-sensors]
Message-Id: <20070812131352.6f6bec51@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <87ekb9s3tn.wl%info@wore.ma.cx>
In-Reply-To: <87ekb9s3tn.wl%info@wore.ma.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Christian,

On Tue, 24 Jul 2007 15:43:28 +0200, Christian Hohnstaedt wrote:
> On Tue, Jul 24, 2007 at 03:09:57PM +0200, Jean Delvare wrote:
> > Good point. But what this means then is that LM75_TEMP_TO_REG() should
> > take a long as a parameter rather than an int.
> 
> Sounds reasonable.
> 
> Then LM75_TEMP_FROM_REG() should also return a long instead of an int.

This doesn't really matter. A long is needed for LM75_TEMP_TO_REG()
because that's what simple_strtol() gives, but in the other direction,
we use sprintf, which can handle both an int or a long.

> Other drivers using LM75_TEMP_TO_REG:
> 
> driver          temp.type   func
> ------------------------------------
> asb100.c        long        strtoul
> ds1621.c        direct      strtoul
> w83627e?hf.c    u32         strtoul
> w83781d.c       s32         strtol
> 
> Looks like there is some kind of general inconsistency :-)

Indeed. Can you please send a patch fixing all the affected drivers?

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

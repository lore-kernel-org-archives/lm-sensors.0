From: Wu Zhangjin <wuzhangjin@gmail.com>
Date: Tue, 01 Dec 2009 02:06:03 +0000
Subject: Re: [lm-sensors] [PATCH v5 5/8] Loongson: YeeLoong: add hwmon driver
Message-Id: <1259633163.1894.24.camel@falcon>
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1259414649.git.wuzhangjin@gmail.com>
         <ed9926f7d6acbf2abd2eb172ec5147e578dc8fb7.1259414649.git.wuzhangjin@gmail.com>
         <1259558432.5516.8.camel@falcon.domain.org>
         <1259562294.5516.16.camel@falcon.domain.org>
         <20091201014819.GA29728@linux-mips.org>
In-Reply-To: <20091201014819.GA29728@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-mips@linux-mips.org, zhangfx@lemote.com, yanh@lemote.com, huhb@lemote.com, lm-sensors@lm-sensors.org

On Tue, 2009-12-01 at 01:48 +0000, Ralf Baechle wrote:
> On Mon, Nov 30, 2009 at 02:24:54PM +0800, Wu Zhangjin wrote:
> 
> > > > +config YEELOONG_HWMON
> > > > +	tristate "Hardware Monitor Driver"
> > > > +	select HWMON
> > > 
> > > Will use depend in the next version.
> > > 
> > 
> > Sorry, This must be select, there is no other way to select this stuff.
> 
> Why that?

Hmm, sorry, my old explanation is totally Wrong, it's better to select
it for us, just as the x86 platform drivers did:

$ cat drivers/platform/x86/Kconfig | grep " HWMON"
	select HWMON
	select HWMON

Because the HWMON stuff is put in the device drivers as a menuconfig,
but our platform driver is put in its own directory. it will not be
convenient for the users to select it themselves, and also, this select
have no side effect.

Best Regards,
	Wu Zhangjin


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

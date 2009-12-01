From: Ralf Baechle <ralf@linux-mips.org>
Date: Tue, 01 Dec 2009 01:48:19 +0000
Subject: Re: [lm-sensors] [PATCH v5 5/8] Loongson: YeeLoong: add hwmon driver
Message-Id: <20091201014819.GA29728@linux-mips.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1259414649.git.wuzhangjin@gmail.com>
 <ed9926f7d6acbf2abd2eb172ec5147e578dc8fb7.1259414649.git.wuzhangjin@gmail.com>
 <1259558432.5516.8.camel@falcon.domain.org>
 <1259562294.5516.16.camel@falcon.domain.org>
In-Reply-To: <1259562294.5516.16.camel@falcon.domain.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wu Zhangjin <wuzhangjin@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-mips@linux-mips.org, zhangfx@lemote.com, yanh@lemote.com, huhb@lemote.com, lm-sensors@lm-sensors.org

On Mon, Nov 30, 2009 at 02:24:54PM +0800, Wu Zhangjin wrote:

> > > +config YEELOONG_HWMON
> > > +	tristate "Hardware Monitor Driver"
> > > +	select HWMON
> > 
> > Will use depend in the next version.
> > 
> 
> Sorry, This must be select, there is no other way to select this stuff.

Why that?

  Ralf

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

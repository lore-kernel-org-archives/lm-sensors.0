From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 13 Apr 2011 20:34:49 +0000
Subject: Re: [lm-sensors] [PATCH v5 1/2] Use "request_muxed_region" in it87
Message-Id: <20110413223449.1ddf7bc8@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1302641290-30212-1-git-send-email-natg@google.com>
	<1302641387-30264-1-git-send-email-natg@google.com>
	<4DA547CD.60406@redhat.com>
	<BANLkTikfuvvujTi6i2MUGOHgNLZCqcouJQ@mail.gmail.com>
	<20110413103409.47638b72@endymion.delvare>
	<BANLkTimhUd9+QmLh-fSjwDO5c_vRH+kktA@mail.gmail.com>
In-Reply-To: <BANLkTimhUd9+QmLh-fSjwDO5c_vRH+kktA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Natarajan Gurumoorthy <natg@google.com>
Cc: Hans de Goede <hdegoede@redhat.com>, Guenter Roeck <guenter.roeck@ericsson.com>, Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Mike Waychison <mikew@google.com>

Hi Nat,

Please don't top-post.

On Wed, 13 Apr 2011 10:59:45 -0700, Natarajan Gurumoorthy wrote:
> John,
>       Unfortunately you are right. After grepping though drivers/hwmon
> and drivers/watchdog I realize the ugliness is fairly deep rooted. All
> of the following drivers need to be cleaned up as far as the
> "superio_enter" "superio_exit" operation is concerned if we want this
> stuff to be SMP clean and allow multiple drivers to coexist.
> 
> drivers/watchdog
> f71808e_wdt.c
> it8712f_wdt.c
> it87_wdt.c
> sch311x_wdt.c
> iTCO_vendor_support.c
> ibmasr.c
> w83697hf_wdt.c
> w83697ug_wdt.c:
> 
> 
> drivers/hwmon
> dme1737.c:1935:static inline void dme1737_sio_enter(int sio_cip)
> f71805f.c:100:superio_enter(int base)
> f71882fg.c:196:static inline int superio_enter(int base);
> it87.c:112:superio_enter(void)
> pc87360.c:1009:	/* No superio_enter */
> sch5627.c:118:static inline int superio_enter(int base)
> smsc47b397.c:75:static inline void superio_enter(void)
> smsc47m1.c:77:superio_enter(void)
> vt1211.c:223:static inline void superio_enter(int sio_cip)
> w83627ehf.c:135:superio_enter(int ioreg)
> w83627hf.c:134:superio_enter(struct w83627hf_sio_data *sio)
> 
> Have I missed any other drivers that also need to be cleaned.

f71882fg and sch5627 already call request_muxed_region() so I think
these are safe. OTOH you missed pc87427 at least. And there are
probably a few non-watchdog, non-hwmon drivers which need the same fix
(for example drivers/parport/parport_pc.c and
drivers/net/irda/via-ircc.h are suspect.)

> Even if
> I got my boss to sign up to clean this I can only test the it8712f
> drivers and thats it.

For one thing, you don't have to. Converting just a subset is already a
welcomed step in the right direction. But anyway the changes should be
fairly easy and not too risky so I wouldn't mind you doing them without
testing them all. And we can find testers for most hwmon drivers, I'm
sure (I can personally test f71805f and w83627ehf, maybe w83627hf).

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

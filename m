From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 06 Oct 2009 16:00:27 +0000
Subject: Re: [lm-sensors] it87 sensors need an ACPI driver (2.6.31)
Message-Id: <20091006180027.4b1666cf@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <c43b2e150909200120kf87cdc2oabafea8abbf01227@mail.gmail.com>
	<68676e00909200520s7730b516v4e0d6c17d529d0a7@mail.gmail.com>
	<4AC939BB.8090600@wasp.net.au>
	<68676e00910050837g2006bfb8j349891504e474a95@mail.gmail.com>
	<4ACA21E8.6080501@msgid.tls.msk.ru>
	<68676e00910060800h4cb84dcl9f610f6b23a88e5c@mail.gmail.com>
	<4ACB60A7.307@msgid.tls.msk.ru>
	<68676e00910060834p338c77c8kae8156a1f8dc68a9@mail.gmail.com>
	<4ACB653B.9090707@msgid.tls.msk.ru>
In-Reply-To: <4ACB653B.9090707@msgid.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Luca Tettamanti <kronos.it@gmail.com>, Brad Campbell <brad@wasp.net.au>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, lm-sensors@lm-sensors.org

On Tue, 06 Oct 2009 19:41:47 +0400, Michael Tokarev wrote:
> Luca Tettamanti wrote:
> > In term of Q-FAN profiles: yes, but I still haven't managed to make it
> > work (the interface is there though).
> 
> Oh, so it's basically boils down to Silent/Optimal/Normal choices
> as in the BIOS settings, right?  I mean, still no pwm_* controls
> as it87 offers?..

Probably not. But feel free to bother Asus about it. If they don't
provide the level of control you want, they should know about it, and
make it better in future products. Or even in current products through
BIOS upgrades.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

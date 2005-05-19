From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:22 +0000
Subject: [BK PATCH] I2C update for 2.6.10-rc1
Message-Id: <vYBFH9gE.1099992539.9943000.khali@gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
In-Reply-To: <20041109052229.GA5117@kroah.com>
References: <20041109052229.GA5117@kroah.com>
In-Reply-To: <20041109052229.GA5117@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: greg@kroah.com, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, sensors@Stimpy.netroedge.com


Hi Greg,

>Greg Kroah-Hartman:
>  o I2C: delete normal_i2c_range logic from sensors as there are no more
>         users
>  o I2C: moved from all sensor drivers from normal_i2c_range to normal_i2c
>  o I2C: fix i2c_detect to allow NULL fields in adapter address structure
>  o I2C: remove normal_isa_range from I2C sensor drivers, as it's not used
>  o I2C: remove ignore_range from I2C sensor drivers, as it's not used
>  o I2C: remove probe_range from I2C sensor drivers, as it's not used

I'm very happy with that :) A documentation update will be needed though.

Also, while we're at it, is there any reason why I2C_CLIENT_END and
I2C_CLIENT_ISA_END are two different constants? We could probably go
with 0xffff (or 0xfffd if you don't like 0xffff) for both. We never saw
a non-even-aligned ISA address anyway, did we? Just a though anyway, I
agree it doesn't matter much.

As a side note, I could never understand why the I2C-ISA kind of
emulation was implemented the way it is. It could make sense if the
clients really didn't know that they are accessing the ISA bus. It's
not the case though, clients are accessing the ISA I/O space directly.
The i2c-isa driver is almost empty. Client drivers with both I2C and ISA
bus accesses (lm78, w83781d, it87) are a mess. I understand that the
original idea was to avoid code duplication for chips supporting both
bus interfaces, but in the end the benefit is questionable. In
particular, people only using ISA chips have to bear the overhead of the
whole I2C subsystem with little benefit. There must be a better way.
Greg, do you have plans to clean it up? I can think of two completely
different approaches, either a true i2c-isa emulation, or a complete
separation of the ISA stuff. We may consider different approaches for
I2C+ISA chips and ISA only chips, by the way.

Thanks,
Jean

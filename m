From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Fri, 12 Aug 2011 14:29:51 +0000
Subject: Re: [lm-sensors] How can I use two command bytes for a block read?
Message-Id: <20110812142951.GA23938@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAN=k24me3-OrpzHBww2J2_x62+iDtSRBTHwGH7pZ4RMqxSgpFA@mail.gmail.com>
In-Reply-To: <CAN=k24me3-OrpzHBww2J2_x62+iDtSRBTHwGH7pZ4RMqxSgpFA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Wayne Tams <wayne.tams@gmail.com>
Cc: linux-i2c@vger.kernel.org, "lm-sensors@lm-sensors.org" <lm-sensors@lm-sensors.org>

On Fri, Aug 12, 2011 at 05:21:15AM -0400, Wayne Tams wrote:
> Hi,
> 
> I am having a little bother interfacing with a device that requires two command
> bytes for both reads and writes. I can perform a successful write using I2C
> writes but I would rather use the user-space i2c_smbus_ functions from
> i2c-dev.h. In the i2c-dev documentation (http://lxr.free-electrons.com/source/
> Documentation/i2c/smbus-protocol?v=2.6.35;a=arm#L225) there is a mention of a
> two byte command block read but there does not appear to be any supporting
> function in i2c-dev.h. Is there a patch available to add this functionality or
> could there be another approach?
> 
> Just to clarify I need my smbus read transaction to look like this:
> 
> 
> 
>  S Addr Wr [A] Comm1 [A] Comm2 [A] S Addr Rd [A] [Data] A [Data] A ... A [Data] NA P
> 
> Thanks
> 
> Wayne

Wrong mailing list. Try linux-i2c@vger.kernel.org (copied).

As a general hint, eeprom drivers such as drivers/misc/eeprom/at24.c do this;
you might want to have a look.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

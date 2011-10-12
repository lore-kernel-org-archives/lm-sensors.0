From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 12 Oct 2011 16:02:34 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon:lm75 add ADT75 support - requires
Message-Id: <1318435354.2454.33.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <1318412218-4237-1-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1318412218-4237-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 2011-10-12 at 11:47 -0400, Jean Delvare wrote:
> On Wed, 12 Oct 2011 11:36:58 +0200, michael.hennerich@analog.com wrote:
> > From: Michael Hennerich <michael.hennerich@analog.com>
> > 
> > The Analog Devices ADT75 has an additional register at 0x04
> > for initiating oneshot captures. It is not actively used in
> > this driver but we must avoid assuming it will behave as
> > 0x05-0x07 do and return the last read value. In fact register 0x04
> > reads the same as register 0x00. And all registers are repetitive
> > mirrored around register 0x04. This fact is used to detect the ADT75.
> 
> I object. The detection of the original LM75 is there for historical
> reasons (that chip was very popular on PC motherboards at the end of
> the 90's. Other compatible chips were never so popular on PC
> motherboards and this is the reason why they are _not_ detected by the
> lm75 driver. If you have any of these chips, you have to instantiate
> them explicitly.
> 
> Same goes for the ADT75. I don't expect it on PC boards, but rather on
> embedded designs where it should simply be instantiated, rather than
> detected.
> 
> It's still fine to document the ADT75 as being supported by the driver,
> and adding an lm75_type enum value for it. But no detection, please.
> 
Good point. I am fine with that.

Turns out the chip I referred to in my other e-mail is a TI TMP75. It
won't be detected either, but works fine in our design because I
instantiate it with i2c_register_board_info() during board
initialization. Which is why I never noticed that auto-detection does
not work for it.

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

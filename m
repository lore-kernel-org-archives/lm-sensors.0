From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 16 Aug 2007 07:40:51 +0000
Subject: Re: [lm-sensors] [PATCH 3/6] libsensors4: Don't substitute the isa
Message-Id: <20070816094051.3106db21@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070815174020.055f6ea3@hyperion>
In-Reply-To: <20070815174020.055f6ea3@hyperion>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Wed, 15 Aug 2007 18:56:36 +0200, Hans de Goede wrote:
> Jean Delvare wrote:
> > Don't handle the isa bus in sensors_parse_i2cbus_name(). We really
> > don't need to, as there is a single ISA bus, there's no need for
> > substituting anything.
> 
> This one requires deeper knowledge of libsensors then I have.

Bus substitution is how we addressed the fact that i2c bus numbers can
change across reboots. With bus statements in sensors.conf, you can
give an arbitrary (and persistent) bus number to an i2c bus based on
it's name. After that, whenever you refer to that bus number in the
configuration file (in a chip statement), it will mean that bus, even if
the current bus numbering is different. This mechanism is very useful
when you have similar I2C hardware monitoring chips on different buses
and each needs a specific configuration.

This bus substitution mechanism would also presumably be useful for
other bus types where several buses can exist on the system (w1, spi),
but for ISA, there can really be only one isa bus, so there's no risk
of bus number changing across reboot.

Not too sure about the PCI bus. So far I assumed that there was only
one, but it seems that on big systems there can be several.

As a side note, the i2c bus number substitution is only done for the
configuration file at the moment. If you want to specify a chip name on
sensors' command line, you still must use the bus numbers of the
running system. This should probably be changed. I'll create a ticket
for this.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

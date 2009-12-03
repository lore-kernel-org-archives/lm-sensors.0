From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 03 Dec 2009 13:06:42 +0000
Subject: Re: [lm-sensors] lm_sensors problems with nVidia 9300-d-e and ION
Message-Id: <20091203140642.1502edf7@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rusty,

Apparently your request / proposal felt through the cracks.

On Wed, 4 Nov 2009 15:13:17 -0800 (PST), Rusty Waters wrote:
> We are trying to validate a few new boards, that all have nVidia chipsets
> on them. I am totally frustrated and would like to see if anybody else
> can tell me how to go about getting sensors to work. The I2C chipsets on
> these boards are MCP79, which means they use i2c-nforce2 drivers.

MCP79 or MCP7A? The difference may be relevant.

> These boards come from Zotac, and Pegatron in particular.
> I have used Ubuntu Jaunty 9.04, Ubuntu 9.10 Karmic Koala, and also Fedora
> Core 11, none work out of the box.
> In each of these version I then downloaded the lm-sensors 3.1.1, made it,
> installed it and followed it to the best of my current abilities.
> Also used the newest version of sensors-detect.

Could you please post the full output of sensors-detect? This would be
a good start. It would also be interesting to know what kind of hardware
monitoring data, if any, is displayed by the BIOS.

Last but not least, do the specifications of the system mention
hardware monitoring capabilities of any kind?

> The only sensors I get working are the 2 CPU temps, in all cases.

Please provide the output of "sensors".

> Why cannot it sense the i2c MCP79, and get me fan speeds, for example?

Very hard to tell without additional data. Could be that the SMBus
channels themselves are not accessible for some reason. Or they are,
but the hardware monitoring chip isn't connected to the SMBus. Or it is
but we don't support it yet.

> If need be, I'd be glad to get your group a board to use.

This would be very helpful, yes, in particular if you need support
fast. Shall I provide a shipping address in private?

> I apologize if this is not the right mailing list, but if so, could you
> point me to the lm-sensors-users, or whatever it may be?

You hit the right list :)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

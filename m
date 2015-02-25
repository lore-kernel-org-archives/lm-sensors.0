From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 25 Feb 2015 16:27:46 +0000
Subject: Re: [lm-sensors] [PATCH] ARM: Kirkwood: enable GPIO fan alarm support for 2Big Network v2
Message-Id: <20150225162746.GB25241@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1424696523-14855-1-git-send-email-simon.guinot@sequanux.org>
 <54EB34F3.4000500@roeck-us.net>
 <20150223144049.GU1509@kw.sim.vm.gnt>
 <54EB3E0E.7070503@roeck-us.net>
 <20150225123632.GW1509@kw.sim.vm.gnt>
 <54EDDCAD.9070703@roeck-us.net>
 <20150225150126.GY1509@kw.sim.vm.gnt>
In-Reply-To: <20150225150126.GY1509@kw.sim.vm.gnt>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Wed, Feb 25, 2015 at 04:01:26PM +0100, Simon Guinot wrote:
> On Wed, Feb 25, 2015 at 06:31:09AM -0800, Guenter Roeck wrote:
> > On 02/25/2015 04:36 AM, Simon Guinot wrote:
> > >On Mon, Feb 23, 2015 at 06:49:50AM -0800, Guenter Roeck wrote:
> > >>On 02/23/2015 06:40 AM, Simon Guinot wrote:
> > >>>On Mon, Feb 23, 2015 at 06:10:59AM -0800, Guenter Roeck wrote:
> > >>>>On 02/23/2015 05:02 AM, Simon Guinot wrote:
> > >>>>>On the LaCie 2Big Network v2 (net2big_v2) board, the fan alarm is not
> > >>>>>wired to the I2C fan controller but to a separe GPIO. This GPIO can be
> > >>>>>controlled by using the gpio-fan driver.
> > >>>>>
> > >>>>>This patch adds the gpio-fan alarm description in the net2big_v2 DTS.
> > >>>>>
> > >>>>>Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
> > >>>>>---
> > >>>>>  arch/arm/boot/dts/kirkwood-net2big.dts | 5 +++++
> > >>>>>  1 file changed, 5 insertions(+)
> > >>>>>
> > >>>>>diff --git a/arch/arm/boot/dts/kirkwood-net2big.dts b/arch/arm/boot/dts/kirkwood-net2big.dts
> > >>>>>index 53dc37a3b687..e4f7e497379f 100644
> > >>>>>--- a/arch/arm/boot/dts/kirkwood-net2big.dts
> > >>>>>+++ b/arch/arm/boot/dts/kirkwood-net2big.dts
> > >>>>>@@ -27,6 +27,11 @@
> > >>>>>  		device_type = "memory";
> > >>>>>  		reg = <0x00000000 0x10000000>;
> > >>>>>  	};
> > >>>>>+
> > >>>>>+	gpio_fan {
> > >>>>>+		compatible = "gpio-fan";
> > >>>>>+		alarm-gpios = <&gpio0 25 GPIO_ACTIVE_LOW>;
> > >>>>>+	};
> > >>>>>  };
> > >>>>>
> > >>>>>  &regulators {
> > >>>>>
> > >>>>Again, wrong solution, and conceptually wrong as well from a dt perspective.
> > >>>>
> > >>>>The alarm signal should be handled by the g762 driver, and the alarm-gpios
> > >>>>property should be added to the g762 description.
> > >>>
> > >>>OK. Then you think it would be better to add support for alarm GPIOs
> > >>>support in the g762. The problem is that we should have to find a
> > >>>generic way to do that. After all, we could want the very same
> > >>>modification for a bunch of fan drivers.
> > >>>
> > >>Can't help it. After all, the interrupt handling logic is different for each chip,
> > >>and there are non-DT systems out there.
> > >>
> > >>The g762 property should probably be something like
> > >>
> > >>	g762@3e {
> > >>                 compatible = "gmt,g762";
> > >>                 reg = <0x3e>;
> > >>                 clocks = <&g762_clk>;
> > >>		interrupt-parent = <&gpio0>;
> > >>		interrupts = <25 GPIO_ACTIVE_LOW>;
> > >>         };
> > >>
> > >>struct i2c_client has an irq field, and as far as I can see it is filled in
> > >>automatically from the dt node. So all the driver should have to do is to
> > >>implement an interrupt handler.
> > >
> > >Is that OK to pass a GPIO line through the "interrupts" property ?
> > 
> > Why not ? That is how it is supposed to be used. The driver neither needs
> > to know nor should know that its interrupt line is connected to a gpio pin.
> 
> Well, I think we are interested in both the interrupt signal _and_ the
> GPIO value. We need to display the later through the sysfs fan1_alarm
> file.
> 
> Using the irq field from struct i2c_client is quite handy but the GPIO
> polarity information is lost...
> 
> That's why I think we should probably use a dedicated property.
> 
> > 
> > >Moreover it seems to me that g763 controller (compatible) supports
> > >alert interrupts through SMBus. Then maybe we should save the
> > >"interrupts" property for this signal ?
> > >
> > You lost me there. The SMBus alert signal is shared among multiple chips.
> > If a system supports it, it should be connected to the alert interrupt handler
> > (in i2c-smbus.c), which would handle it and pass it to a driver's alert function.
> 
> It was a question. I was not knowing the proper way for a driver to
> connect with this interrupt. Thanks for the explanation.
> 
> > 
> > >Don't you think it would be more explicit to have a separate DT
> > >property (such as "gpio-alarm") and also a dedicated field in the
> > >g762 platform data structure ?
> > >
> > 
> > No. It would add an unnecessary dependency on gpio (or, rather, gpio
> > driven interrupts) to the g762 driver, and it would limit its usability.
> 
> Considering we will have to read this GPIO, then we will have this
> dependency.
> 
You are right, in the sense that the alarm isn't really generated
by the fan controller, while I assumed that it was. Given that,
I am ok with the implementation in the gpio-fan driver.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

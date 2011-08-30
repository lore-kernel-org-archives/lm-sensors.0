From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 30 Aug 2011 17:05:50 +0000
Subject: Re: [lm-sensors] [RESEND] LM73 hwmon driver i2c auto-detection
Message-Id: <20110830170550.GA27122@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAOYRzauHk1j8ThGc8Cq32Jb21LS2iqtAnyD=H=9ZpVmk3RVw-Q@mail.gmail.com>
In-Reply-To: <CAOYRzauHk1j8ThGc8Cq32Jb21LS2iqtAnyD=H=9ZpVmk3RVw-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Aug 30, 2011 at 11:25:42AM -0400, Robert Casanova wrote:
> We are trying to use the hwmon framework to read the temperature values out of
> a LM73 device we have in our i2c bus on the OMAPL-138. It's current address is
> 0x49.
> The actual behavior for the LM73 driver seems to be to try to autodetect if
> there are any other devices of that same type on the i2c bus by looking at the
> std addresses where it could find one:
> 0x48, 0x49, 0x4a, 0x4c, 0x4d, 0x4e
> 
> What happens is that we have a different device with completely different
> registers at @0x48 so when the autodetection method gets called it tries to
> read 2bytes out of the register 0x07 and this other device has only 1byte of
> data at that register, then the whole bus times out.
> 
> We have tried declaring the devices we have during our board setup statically,
> for instance:
> static const struct i2c_board_info __initconst i2c_devices[] = {
> {
> I2C_BOARD_INFO("lm73", 0x49),
> },
> };
> 
> static __init void board_init(void) {
> ...
> i2c_register_board_info(1/* i2c-0 above was registered i2c_davinci.1*/,
> i2c_devices,
> ARRAY_SIZE(i2c_devices));
> ...
> }
> 
> But even when the driver gets instantiated at the proper address 0x49 the
> sensors_lm73_init gets called making the detect method to get called and
> testing an address that could be an LM73 but is not and hanging the bus.
> 
> Has anyone found some of the same problems? Is there any way to avoid
> completely the autodetection for the hwmon framework? Should the i2c
> implementation be able to handle this situation gracefully?
> 
Did you try to instantiate the _other_ device ? That should take care of the problem.

Instantiating the LM73 at address 0x49 won't help, since the i2c core code will still
attempt to auto-detect the chip at address 0x48.

Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

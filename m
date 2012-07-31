From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 31 Jul 2012 23:24:02 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Driver for ADT7410
Message-Id: <20120731232402.GA7666@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <50183D4E.5040708@gmx.de>
In-Reply-To: <50183D4E.5040708@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Tue, Jul 31, 2012 at 10:17:18PM +0200, Hartmut Knaack wrote:
> Hi,
> this patch brings basic support for the Analog Devices ADT7410 temperatur=
e sensor, based on the lm75 hwmon driver and the adt7410 iio driver. The fo=
llowing functionality has been implemented:
>=20
>   * get current temperature
>   * get/set minimum, maximum and critical temperature
>   * get/set hysteresis
>   * get alarm events for minimum, maximum and critical temperature
>=20
> The ADT7410 provides some more configuration options, but would need non-=
standard sysfs symbols, so I prefer to get some feedback before implementin=
g any:
>=20
>   * get/set resolution (13/16 bits): temp#_resolution (13/16)?
>   * get/set event mode (comparator/interrupt): temp#_eventmode (0/1)?
>   * get/set polarity of INT pin (active-high/active-low): temp#_INT (0/1)?
>   * get/set polarity of CT pin (active-high/active-low): temp#_CT (0/1)?
>   * get/set sampling mode (continous/one sample per second/one-shot/power=
-down): temp#_mode (0/1/2/3)?
>   * get/set fault queue (1 to 4 faults to trigger event): temp#_faultqueu=
e (1/2/3/4)?
>   * get device id: temp#_id?
>=20
> Besides, I saw that there are several sensors (including the ADT7410) whi=
ch have just one hysteresis register, that stores a delta value that applie=
s to min, max and critical temperature. How are the chances to create a sta=
ndard symbol "temp#_hyst"?
>=20
> All implemented sysfs-symbols have been sucessfully tested at temperature=
s of 15=B0C to 40=B0C.
>=20
> Signed-off-by: Hartmut Knaack <knaack.h <at> gmx.de>

Hi,

your mailer replaced all tabs with spaces, making a real review quite diffi=
cult.
Please fix that.

Couple of comments (not a complete review):

- For configuration, we commonly assume it is taken care of by the BIOS. Ot=
her
  that that, if you think anything needs to be configurable, use platform d=
ata
  and/or device tree information. No sysfs attributes, please.
- Hysteresis is an absolute temperature, not a relative one. So the questio=
n for
  a generis attribute would be what it applies to. The current approach doe=
s not
  have that problem.
- Please use devm_ functions to allocate resources.
- The wrappers for adt7410_i2c_write_byte and adt7410_i2c_read_byte are rea=
lly
  unnecessary. Please drop. You don't need error messages here, hopefully.
- Use i2c_smbus_read_word_swapped and i2c_smbus_write_word_swapped for the =
16
  bit functions instead of the local wrapper functions.
- Using "char" for "valid" makes the code more complex for most platforms.
  Consider bool instead.
- Your code hides error returns from i2c access functions by returning EIO
  instead of the actual error. Please don't do that.
- The access retry code in adt7410_update_device is really quite complex.
  Is this really needed ? In general, the sensor should be configured for
  continuous conversion, and it should not be necessary to wait for a conve=
rsion
  to complete. besides, we can not afford an active 240 ms wait loop, so if=
 the
  loop should _really_ be needed, you would have to add a sleep function ca=
ll.
- The detect function is quite weak. you should definitely also check bits =
0..3
  of the status register (must be 0), and consider checking against known c=
hip
  revision numbers. Question is also if the chip is expected to show up
  in a PC type system; if not, it might make sense to drop the detect funct=
ion
  entirely, given its weakness.
- Use SENSOR_DEVICE_ATTR_2 to encode secondary index values (instead of mul=
tiple
  show_xxx_alarm functions).
- Don't initialize variables unnecessarily.
- set_mask and clr_mask in the probe function are really not necessary.
- Please align function parameters to the opening (.
- No unnecessary ( ), please [no, it does not make the code easier to read,
  it just hides the really important ( )s].
- Please run the patch through checkpatch.pl. I can not really say for sure
  due to the tab problem how many issues there  are, but I see at least one
  checkpatch error.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

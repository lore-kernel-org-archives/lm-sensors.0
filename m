From: arno@natisbad.org (Arnaud Ebalard)
Date: Sat, 01 Jun 2013 17:26:54 +0000
Subject: Re: [lm-sensors] [PATCHv2 1/3] Add support for GMT G762/G763 PWM fan controller
Message-Id: <87fvx1pwrl.fsf@natisbad.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <cover.1369687670.git.arno@natisbad.org>
	<b44f55c4194f6cd8c94f8a3d63ad5c8bd1d1cfe0.1369687670.git.arno@natisbad.org>
	<20130531221616.GG7626@kw.sim.vm.gnt>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Simon Guinot <simon.guinot@sequanux.org>, Guenter Roeck <linux@roeck-us.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Russell King - ARM Linux <linux@arm.linux.org.uk>, Jason Cooper <jason@lakedaemon.net>, linux-doc@vger.kernel.org, devicetree-discuss@lists.ozlabs.org, Olivier Mouchet <olivier.mouchet@gmail.com>, Rob Herring <rob.herring@calxeda.com>, lm-sensors@lm-sensors.org, Grant Likely <grant.likely@secretlab.ca>, Rob Landley <rob@landley.net>, Jean Delvare <khali@linux-fr.org>, Linux ARM Kernel Mailing List <linux-arm-kernel@lists.infradead.org>

Hi Simon and Guenter,

Simon Guinot <simon.guinot@sequanux.org> writes:

> On Tue, May 28, 2013 at 12:03:14AM +0200, Arnaud Ebalard wrote:
>> 
>> Signed-off-by: Arnaud Ebalard <arno@natisbad.org>
>> ---
>>  drivers/hwmon/Kconfig              |   10 +
>>  drivers/hwmon/Makefile             |    1 +
>>  drivers/hwmon/g762.c               | 1012 ++++++++++++++++++++++++++++++++++++
>>  include/linux/platform_data/g762.h |   54 ++
>>  4 files changed, 1077 insertions(+)
>>  create mode 100644 drivers/hwmon/g762.c
>>  create mode 100644 include/linux/platform_data/g762.h
>
> Hi Arnaud,
>
> After more tests on my 2Big Network v2 board, it appears that the fan
> doesn't rotate when PWM mode (the preferred operating mode for this
> board) is selected. Nevertheless, DC mode is usable (even if not ideal
> given the hardware). After some investigations I noticed that an extra
> initialization is needed to enable PWM mode on my board: the set_cnt
> register must be set to 0 while the default value is 0xff. Is that
> specific to my hardware ? Is PWM mode working on your ReadyNAS with
> the default set_cnt value ?

First, thanks for testing this!

Regarding your problem, I first started by booting current version of my
driver on the Duo v2 w/o touching chip registers (only clock reference
value). This way, I inherit the values installed by (NETGEAR's) u-boot:

$ for k in fan* pwm* ; do echo -n "$k:" ; echo `cat $k `; done
fan1_alarm:0
fan1_div:2
fan1_fault:0
fan1_input:1807
fan1_target:1807
pwm1:221
pwm1_enable:2        /* closed-loop, i.e. config is done via set_cnt */
pwm1_mode:1          /* PWM mode */ 

If G762 datasheet is correct, NETGEAR's u-boot alters fan divisor ('01'
i.e. 2 instead of '00' i.e. 1). It also changes the default mode from
linear to pwm and sets set_cnt to 34 (255-221). 

Then, I grabbed the GPL sources (5.3.7) of NETGEAR's u-boot and found
the following in a boot function:

 /* Turn G76x(FAN controller, i2c address 0x3e) on.
  * The FAN_SET_CNT register's offset is 0x0.
  * Set [1300(rpm) = 65% = 5a(FAN_SET_CNT)] as default.
  */
 unsigned char byte=0x5a;
 if(i2c_write(0, 0x3e, 0x0, 1, &byte, 1) != 0) 
   puts ("Error writing the i2c chip : G76x(Fan controller).\n");

AFAICT, this is the only location in the whole source tarball where 0x3e
reg is modified in an i2c function. 


Then, I grabbed the u-boot source code from NETGEAR for ReadyNAS 102
(Armada-370 based NAS, also using a G762) and it has the following:

 /* Turn G76x(FAN controller, i2c address 0x3e) on.
  * The FAN_SET_CNT register's offset is 0x0.
  * Set [1300(rpm) = 65% = 5a(FAN_SET_CNT)] as default.
  */
 MV_U8 byte=0x5a;
 if(i2c_write(0x3e, 0x0, 1, &byte, 1) != 0)
 	puts ("Error writing the i2c chip : G76x(Fan controller).\n");
 /* Tune the FAN_STARTV */
 if (i2c_read(0x3e, 0x5, 1, &byte, 1) != 0)
 	puts ("Error reading the i2c chip : G76x(Fan controller).\n");
 byte |= 0x3;
 if(i2c_write(0x3e, 0x5, 1, &byte, 1) != 0)
 	puts ("Error writing the i2c chip : G76x(Fan controller).\n");
 
In the end, it does not seem NETGEAR's u-boot does some specific things
except setting a non-zero value to SET_CNT register for the fan to start
rotating.

BTW, if you wonder why some attributes reported at the beginning have
different values than the ones in the datasheet (0x5a set in u-boot,
reading 0x22) although NETGEAR's u-boot code does not seem to tamper
those, I don't have the answer. 


> I haven't noticed this issue while testing your v1 patch series because
> at the time I was using a board with an U-Boot modified by LaCie. This
> last sets the set_cnt register to 0 while U-Boot mainline don't.
> Actually, the 2Big fan is not configured nor even started by U-Boot
> mainline. I have to fix this but maybe that something can be done in
> the g762 Linux driver too ?

You mean like reading set_cnt, setting it to 0 and then setting it back
to previous value? I guess it would be good to confirm that the G762
needs that to start operating on all platforms. The datasheet does not
provide info and I cannot confirm/infirm that on ReadyNAS Duo v2 and
102 platforms.


>> +/* When filling a g762_platform_data structure to be passed during platform
>> + * init to the driver, it needs to be initialized to the following default
>> + * value before changing specific fields. This is needed to avoid a sparse
>> + * initialization to have current values replaced by 0 */
>
> In other places, you use this multi-line comment format:
>
> /*
>  * ...
>  * ...
>  */

I missed than one, thanks.


>> +static const struct g762_platform_data G762_DEFAULT_PDATA = {
>> +	.fan_startv = G762_DEFAULT_NO_OVERLOAD,
>> +	.fan_gear_mode = G762_DEFAULT_NO_OVERLOAD,
>> +	.fan_div = G762_DEFAULT_NO_OVERLOAD,
>> +	.fan_pulses = G762_DEFAULT_NO_OVERLOAD,
>> +	.fan_target = G762_DEFAULT_NO_OVERLOAD,
>> +	.pwm_polarity = G762_DEFAULT_NO_OVERLOAD,
>> +	.pwm_enable = G762_DEFAULT_NO_OVERLOAD,
>> +	.pwm_freq = G762_DEFAULT_NO_OVERLOAD,
>> +	.pwm_mode = G762_DEFAULT_NO_OVERLOAD,
>> +};
>
> Are you sure that all this settings are needed ? IMHO the g762 platform
> data should only holds the platform specific configuration: fan_startv,
> fan_gear_mode, fan_div and fan_pulses. The other settings are not really
> related with the platform but more with the operating fan configuration.
> For my part, I am happy enough with the sysfs hwmon interface.
>
> The same comment applies to the g762 DT binding properties.

Reading Guenter's mail, it seems he has the same opinion. He also agrees
with you that the array is not a good idea in a header.

Regarding the former, I will comply to what Guenter decides but here are
the reasons why I wanted to expose all those attributes. 

I think choosing PWM mode and closed-loop is also platform related. For
instance, on my ReadyNAS Duo v2, the fan is a 3 wire one with a
tachometer and it makes sense to set the chip in closed-loop
mode using previous knobs. Setting a minimal fan_target is also
useful to prevent someone booting a kernel to just have no cooling. One
could argue that the u-boot provided by the manufacturer has already
taken care of those but:

 - the user may install a stock u-boot
 - the manufacturer may have performed this config in the kernel and not
   using u-boot

Regarding the latter, I will try and come with an other approach,
probably using a function instead of an array if it is
acceptable. My initial idea was that the platform maintainer would be
able to to do sth like:  

  struct g762_platform_data pdata = G762_DEFAULT_PDATA;
  pdata.pwm_freq = 8192;

and then pass the structure to the i2c init routine if he only wants to
give a reference clock frequency. Other attributes would not be modified.

Additionally, the problem with using 0 as a "use default value" is that
0 is used for linear mode (sysfs interface for pwm_mode), 0 is also a
valid value for fan_startv. Same for pwm_polarity and fan_gear_mode.
Hence my decision to use something else.  


Guenter, I will work on a v3 this evening based on your comments.

Cheers,

a+

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

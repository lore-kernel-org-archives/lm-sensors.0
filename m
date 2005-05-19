From: rnissl@gmx.de (Reinhard Nissl)
Date: Thu, 19 May 2005 06:24:37 +0000
Subject: Fujitsu Siemens sensor HERMES
Message-Id: <401820C0.3020905@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <3F70765D.5060209@gmx.de>
In-Reply-To: <3F70765D.5060209@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

Jean Delvare wrote:

>>video:/soft/src/lm_sensors2/kernel/chips # cat \
>>	/sys/bus/i2c/devices/0-0073/fan_div1
>>2
>>video:/soft/src/lm_sensors2/kernel/chips # echo 1 > \
>>	/sys/bus/i2c/devices/0-0073/fan_div1
>>video:/soft/src/lm_sensors2/kernel/chips # cat \
>>	/sys/bus/i2c/devices/0-0073/fan_div1
>>2
>>video:/soft/src/lm_sensors2/kernel/chips #
>>
>>Nothing special. The invalid value is simply ignored. Although
>>set_fan_div()  returns -1 in that case, echo doesn't show any error.
> 
> Could you please check the value returned by echo? (i.e. "echo 1 >
> fan_div1 ; echo $?"). I don't really think it can show the error, but
> who knows... But why would we be allowed to return errors in these
> functions if we cannot catch them later?

Surprize! The driver's return value has an influence on echo's return value  :-))

In the case, where my driver returns -1, echo returns 1, otherwise 0.

>>How about adding a printk() for that case?
> 
> Sound like a good idea (although I think you have to use dev_info() or
> something similar, not printk(), in Linux 2.6).

I see, dev_info() will always print a message, while dev_dbg() print them only 
only when debug messages are requested.

So, although an application, that is writing the sysfs fan_div file, has a 
chance to detect, whether it worked or not, it might still be a good idea in 
this special case to show a message with acceptable values.

The attached version now outputs a message like below:

i2c_adapter i2c-0: fan_div value 3 not supported. Choose one of 2, 4 or 8!

Bye.
-- 
Dipl.-Inform. (FH) Reinhard Nissl
mailto:rnissl@gmx.de
-------------- next part --------------
A non-text attachment was scrubbed...
Name: fscher.c.gz
Type: application/x-gzip
Size: 5037 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040128/fef3c67e/fscher.c.gz

From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sun, 08 Apr 2007 18:49:41 +0000
Subject: Re: [lm-sensors] asb_100 sensor location in /sys heirarchy changes
Message-Id: <46193945.80002@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <4615F494.6070403@hhs.nl>
In-Reply-To: <4615F494.6070403@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Hans,
> 
> On Fri, 06 Apr 2007 09:19:48 +0200, Hans de Goede wrote:
>> Here is what I have on my system:
>> /sys/bus/i2c/devices/0-0050
>> /sys/bus/i2c/devices/0-0051
>>
>> And here is what I would like to have:
>> /sys/bus/i2c/devices/viapro-0-0050
>> /sys/bus/i2c/devices/viapro-0-0051
>>
>> The idea here is that the 0 added here is in case one can have multiple 
>> instances of the same i2c master driver
> 
> Which directly points to a weakness in your proposal: if you have two
> adapters of the same type, they'll get named foo-0 and foo-1. How do
> you know which is which? You don't, so you only moved the problem one
> step further, you didn't solve it.
> 

I agree, but still I think there is some worth in my proposal. For one it makes 
the problem smaller, for example in case of the poster of the asb_100 problem, 
it will make the problem go away.

Also say I have a system with multiple identical masters, for example 2 nvidea 
cards in SDI. Last time I looked at the device model code (2 years ago) when 
you would register a new driver, the bus code would do a linear pass along all 
the devices on the bus (and sub-busses) and see if the driver matched a device, 
device by device, then upon a match the bus code will call the driver_detect 
method, and once that has returned, it will go look at the next device on the 
bus, etc. Thus AFAIK assuming for example PCI masters, foo-0 and foo-1 will 
always get enumerated in fixed order.

> My understanding is that this is a problem for user-space to solve, it
> should not assume stable device numbering accross reboots. But it used
> to be the case and many user-space tools still rely on this.
> 

After writing my initial mail about this, I've done some more thinking about 
this and I agree, this should be solved at the userspace level.

So in our case in libsensors, thus I would like to propose to change the 
libsensors name format for i2c from chipname-i2c-busnumber-address to
chipname-i2cmastername-masternumber-address

So for example. the SPD eeprom at i2c address 50 of my via smbus master would 
be: "eeprom-i2c_viapro-0-50", Yes i know libsensors doesn't handle eeproms, 
this is just an example.

I have also been thinking about ways to give the masters even uniquer names 
then just numbering indentical masters, but anything I came up with was full of 
holes.

The whole idea behind this "exercise" is to be able to make the dmi autoloaded 
configs more explicit on which chip is located on which bus, and thus not 
loading any drivers on i2c busses where they might do harm.

Which brings me to the question, when insmodding an i2c-client driver, is it 
possible to tell it which masters to scan?

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

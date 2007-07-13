From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Fri, 13 Jul 2007 12:49:12 +0000
Subject: Re: [lm-sensors] [PATCH] v3 of a adt7470 driver\
Message-Id: <469774C8.8010905@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070713002836.GR3435@tree.beaverton.ibm.com>
In-Reply-To: <20070713002836.GR3435@tree.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Darrick J. Wong wrote:
> On Thu, Jul 12, 2007 at 11:42:43AM +0200, Hans de Goede wrote:
>> Darrick J. Wong wrote:
>>> Resend with correct title and patch included just once.
>>> ---
>>> adt7470: new hwmon driver for adt7470 chip.
>>>
>>> Signed-off-by: Darrick J. Wong <djwong@us.ibm.com>
>> Looks good now, as far I'm concerned this is ready to get merged.
>> Acked-by: Hans de Goede <j.w.r.degoede@hhs.nl>
>>
>> Mark, any chance you can pick this up soonish, maybe it can make 2.6.23 
>> then.
>>
>> Darrick, have you already written support for this driver for libsensors 
>> and sensors? If not could you please do that ASAP? Then I'll review it and 
>> with some luck and Jean's permission we can still get support for this chip 
>> included into lm_sensors 2.10.4
> 
> I ... can't say that I have a working config.  I've added this into /etc/sensors.conf:
> chip "adt7470-*"
>         label fan1 "CPU0 Fan"
>         label fan2 "CPU1 Fan"
>         label temp1 "CPU0 Temp"
>         label temp3 "CPU1 temp"
>         label pwm1 "CPU0 Fan Control"
>         label pwm2 "CPU1 Fan Control"
> 
> (There are more pwm/fan/temp widgets but on the Z30 they're not
> connected to anything.)
> 
> But every time I run sensors (from svn) I see only this:
> root@elm3a181:/usr/local/src/lm_sensors/prog# sensors/sensors -c
> /tmp/sensors.conf 
> adt7470-i2c-0-2f
> Can't get adapter name for bus 0
> 

While the "Can't get adapter name for bus 0" message is strange, its also 
harmless. Its normal for sensors to not print anything for chips libsensors 
doesn't know, thats why I asked you to write libsensors support. See 
lib/chips.{c,h} for many many examples, just add an entry at the end for the 
adt7470. If you then recompile and install libsensors, sensors should give you 
some (ugly) output.

In order to get better output for sensors, you must also add support to sensors 
itself see prog/sensors/chips.{c,h} and don't forget to also add the printing 
routine to the table in prog/sensors/main.c once you are done writing it.

I assume this means sofar you've only been testing by catting sysfs files? In 
that case it is a good idea to test with the 3.0.0 branch of lm_sensors, which 
on longer needs support code for each chip, instead it "queries" sysfs to find 
out what features a chip has.

To try it do:
svn checkout http://lm-sensors.org/svn/lm-sensors/branches/lm-sensors-3.0.0
cd lm-sensors-3.0.0
make
sudo make install                          # will put it in /usr/local
sensors3

Notice that you can install and use sensors3 and the 2.10.x brnch in parallel.

Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Thu, 05 Jul 2007 14:26:02 +0000
Subject: Re: [lm-sensors] Howto handle alarms which need to be reset?
Message-Id: <468CFF7A.3030603@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <468B4474.5070309@hhs.nl>
In-Reply-To: <468B4474.5070309@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Hans,
> 
> On Wed, 04 Jul 2007 11:03:31 +0200, Hans de Goede wrote:
>> Anonymous has been so kind as to send me a datasheet for the fscpos sensor.
>> Because of this I'm working on improved individual alarm file patches for the
>> fscher (which is documented in Documentation/hwmon/fscher) and the fscpos as I
>> now have a better understanding of these 2 chips.
>>
>> Once an alarm condition has been signaled, it needs to be reset by software
>> otherwise the alarm will stay present even if there no longer is a cause.
>>
>> I see 2 solutions for this:
>> 1) clear an alarm when it gets read by userspace, assuming the chip will set it
>>     again if the condition prevails (I need to test if this is true)
>> 2) make the fooX_alarm file rw and make a write of 0 from userspace clear it
>>
>> I prefer 1), asumming my assumption is true.
>>
>> Suggestions, comments, advice?
>> (...)
>> It looks like its going to be 2) as the hardware only raises the alarm once 
>> when an alarm condition occurs, it will only raise it again when the condition 
>> has been cleared and the reoccurs.
> 
> In other words, we are abusing interrupt flags as if they were
> real-time alarm flags. Frankly, the proper fix would probably be to not
> export alarms flags at all.
> 
> I don't like your option 2 at all. Alarm files are specified as being
> read only and reflecting the alarm state in the chip. If some drivers
> make them read only and require a write from user-space to clear them,
> how are you going to handle this in libsensors? Check the attribute
> file permissions, if it's writable, compare the reading to the limits
> (and which limits?) to decide whether you need to clear it? This is
> adding complexity to the library, just to handle a couple of unpopular
> drivers. I'd rather have the workaround in the drivers themselves, it's
> much more efficient.
> 

I agree its not pretty, better solutions are much welcome. I'm not sure not 
supporting the alarm flags at all is the answer though. On my fsc pc, when I 
cause an alarm an annoying led starts blinking at the front of the PC and it 
won't stop until cleared by software.

> We have another example of the behavior you describe with the DS1621
> chip. Here is how the alarm handling is implemented in the ds1621
> driver, maybe you can just do the same in the fscher driver?
> 
> 		/* reset alarms if necessary */
> 		new_conf = data->conf;
> 		if (data->temp[0] > data->temp[1])	/* input > min */
> 			new_conf &= ~DS1621_ALARM_TEMP_LOW;
> 		if (data->temp[0] < data->temp[2])	/* input < max */
> 			new_conf &= ~DS1621_ALARM_TEMP_HIGH;
> 		if (data->conf != new_conf)
> 			ds1621_write_value(client, DS1621_REG_CONF,
> 					   new_conf);
> 

Unfortunately the limits for temperature are hardwired into the fscher / fscpos 
chip and not specified, so although the above sounds feasible, I don't know 
when to clear the alarm. For the fans this is feasible, and it is already 
implemented in the fscpos driver, but not in the fscher driver.

Notice that the fscpos driver also already has a mechanism to reset the temp 
alarms, using an tempX_reset file, which is identical to making the alarm files 
rw if you ask me, except that it adds yet another sysfs attribute.

So summarising, I can make the fan alarms auto-reset, but temperature is a 
problem. Suggestions ? Once we have a solution for this I'll write a third 
revision of the fscher / fscpos patches as time permits.

Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

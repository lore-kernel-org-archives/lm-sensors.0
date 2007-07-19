From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Thu, 19 Jul 2007 17:11:04 +0000
Subject: Re: [lm-sensors] [PATCH] First cut of a adt7470 driver
Message-Id: <469F9B28.4040106@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070706211144.GI3435@tree.beaverton.ibm.com>
In-Reply-To: <20070706211144.GI3435@tree.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Hans,
> 
> Sorry for the late answer, I'm swamped :(
> 

No problem, I'm very happy that you've found the time eventually, thanks!

> On Sat, 14 Jul 2007 22:17:34 +0200, Hans de Goede wrote:
>> Jean Delvare wrote:
>>> On Fri, 13 Jul 2007 14:08:53 +0200, Hans de Goede wrote:
>>>> I know it looks strange to store the return value in an int then, but in some 
>>>> of the other store methods I need val to be signed, and for consistency I've 
>>>> thus stored it into an int everywhere.
>>> But wouldn't then a large input value (fitting in a long but not in an
>>> int) be silently turned into a negative value, possibly doing crazy
>>> things in the rest of the code?
>> That could happen, but then people are _really_ asking for it. Notice that most 
>> hwmon drivers store functions do even less checking then this. We really need 
>> to discuss this and make a decision on it for all hwmon drivers, starting with 
>> the question wether or not to check if the user input actually is a number?
>>
>> Currently a user can do:
>> echo -n foo > /sys/class/hwmon/hwmon0/in0_max
>> and not get an error (instead in0_max typically gets set to 0
> 
> I am totally fine handling really invalid values as 0. As you said,
> people doing that are asking for trouble, and handling this case would
> slow down and/or enlarge our drivers quite a bit.
> 
> OTOH, the reason why I think that numbers should always be treated
> correctly, even if out of bounds, is that they may be written by
> libsensors rather than directly by a human. And libsensors may have
> done some arithmetic operations on the values based
> on /etc/sensors.conf, in particular for voltages. This can easily
> result in a negative value being written to a voltage sysfs file. This
> is really important that we correctly trim the negative value to 0 mV
> and not to 4080 mV, otherwise we trigger an unwanted alarm. This is
> only an example but it shows why we have to be careful.
> 

I agree that we should do some sanity checking, but not too much as to not 
clutter the drivers. However, I think we first need to define some kind of 
standard as to what sanity checking we will do, and what not, and how to handle 
out of range values (clamp versus EINVAL), actually I've written and send a 
proposal for this to the list already as our discussion got me thinking about this.

> That being said, this is kind of low priority and I am fine fixing the
> drivers when people report such problems. I really don't have the time
> to go thought all drivers to make sure that they are always correct
> (but wouldn't mind if someone else does, of course.)
> 

I agree that this is somewhat of a minor issue, and I do not advocate to go in 
and fix everything immediately once my proposal is accepted, one of the main 
purposes of my proposal is to have some guidelines / rules for input checking 
when reviewing patches. If we find the time and energy for it we could also fix 
existing drivers, but thats not high priority.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

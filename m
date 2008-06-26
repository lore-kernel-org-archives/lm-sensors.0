From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Thu, 26 Jun 2008 08:35:43 +0000
Subject: Re: [lm-sensors] fscpos and fscher drivers
Message-Id: <486354DF.80101@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080626090548.3024bab0@hyperion.delvare>
In-Reply-To: <20080626090548.3024bab0@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> On Thu, 26 Jun 2008 09:09:34 +0200, Hans de Goede wrote:
>> Jean Delvare wrote:
>>> Hi Hans,
>>>
>>> Do you have a plan to phase out the fscpos and fscher drivers? Now that
>>> your fschmd driver supports all known FSC hardware monitoring chips, it
>>> would be great if we could get rid of the legacy fscpos and fscher
>>> drivers to make the configuration, maintenance and support easier.
>>>
>> Agreed, the reason this hasn't been done until now is because the fscpos and 
>> fscher drivers support the watchdog function of the fscXXX family whereas my 
>> fschmd driver doesn't (note the fscpos and fscher drivers do not support the 
>> watchdog driver through the standard watchdog interface, instead they use 
>> custom sysfs attr under the hwmon class).
> 
> Ah, I had forgotten about this watchdog issue. This makes the situation
> a bit more complex of course.
> 

Actually this has sparked me into looking into the watchdog stuff. So I'm 
working on adding (proper) watchdog support right now.

Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

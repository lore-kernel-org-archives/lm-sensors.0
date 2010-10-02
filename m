From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Sat, 02 Oct 2010 13:08:42 +0000
Subject: Re: [lm-sensors] Sysfs attribute to specify device range
Message-Id: <20101002130842.GA27524@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4CA71DF0.5000309@cam.ac.uk>
In-Reply-To: <4CA71DF0.5000309@cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jonathan,

On Sat, Oct 02, 2010 at 07:56:32AM -0400, Jonathan Cameron wrote:
> Hi All,
> 
> This question is actually motivated by a light sensor driver
> proposed for IIO, but given we don't have an answer in our
> current abi and the problem seems a common one I thought
> I would ask you guys.  Firstly I'm not sure if you already
> have an interface for this!
> 
Not that I know of.

> We have a multi range sensor, to simplify the discussion, let us
> call it an adc.  So it's range can be configured to say 0-1V, 0-2V, 0-4V.
> We would like to be able to control this via a sysfs attribute and
> have been trying to work out what to call it.
> 
Would that be a dynamic or a static parameter ? Or, in other words, 
would the setting depend on the specific board or on some runtime consideration ?

If it is static, a sysfs attribute would really be the wrong way to go. 
The best option in that case would be to use platform data.
In all instances I can think of, that would be the most appropriate, since 
such settings are typically board dependent.

max6650 uses a "prescale" module parameter. Not really a good solution to use
a module parameter, though, since it applies to all instances of the driver.

> in1_max is out because I believe that is used for alarms (whilst we have
> different, more general, naming for those, we don't want to muddy the
> waters by reusing the name).
> 
> in1_range is a bit non specific as it isn't clear how to specify future
> devices that support say 1-2V range.  We could allow a pair of values
> to specify the range (fine as single conceptual entity).  If only one
> is present then assume the minimum is 0? 
> 
Wonder if inX_anything really applies in the first place. After all, you are 
talking about light, not voltage. Sure, it is measured in volt, but so is current
and pretty much everything else. And it isn't really hw monitoring in the first 
place, so I doubt if the driver should be in hwmon - probaby not.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

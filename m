From: "Ivo Manca" <pinkel@gmail.com>
Date: Tue, 21 Aug 2007 09:40:52 +0000
Subject: Re: [lm-sensors] Misc API changes for libsensors4
Message-Id: <004d01c7e3d7$5eb1c190$0a01a8c0@pinkeltje>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070817225454.2e3bc43d@hyperion.delvare>
In-Reply-To: <20070817225454.2e3bc43d@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hey Jean,

As we saw with my struggle for supporting the PCChips motherboard with 
the sis5595 chip, we had a problem with a voltage channel which was 
connected to a temperature sensors. However, there was no way to let 
sensors know that the in4 was actually temperature instead of voltage. 
I've added the related mail below (14/06/2007). Is this something for 
libsensors4?

Ivo


----- Original Message ----- 
From: "Jean Delvare" <khali@linux-fr.org>
To: "Hans de Goede" <j.w.r.degoede@hhs.nl>
Cc: "Ivo Manca" <pinkel@gmail.com>; <lm-sensors@lm-sensors.org>
Sent: Thursday 14 June 2007 21:13
Subject: Re: [lm-sensors] sis5595


> Hans,
>
> On Tue, 12 Jun 2007 19:42:29 +0200, Hans de Goede wrote:
>> Jean Delvare wrote:
>> > If you can't get additional information, you can label in4 "CPU 
>> > Temp",
>> > observe the reading over a period of time, and set arbitrary limits
>> > accordingly. Unfortunately we have no way to tell "sensors" that a
>> > voltage input is actually a temperature value.
>>
>> Is it possible other motherboards manufacturers have done something 
>> similar?
>
> Well, it is possible to do this with virtually any voltage input of 
> all
> driver. But maybe this is more likely for the in4 of the sis5595
> because it can already be used for temperature monitoring (although in
> a technically different way.)
>
>> Ifso would it be an idea to add a driver flag to rename all the in4 
>> sysfs attr
>> to tempX sysfs attr, without changing the way how things are read?
>
> Yes, this could be done, shouldn't be too expensive.
>
> A more generic solution would be to implement this in libsensors. For
> that we'd need a new sensors.conf directive to change the type of a
> given sensor (from voltage to temp in this case). After all, the only
> difference is the unit displayed after the value. There are a few
> driver which could use this: pc87360, vt8231... which currently export
> voltage value as temp* files for thermistor-based measurements.
>
> -- 
> Jean Delvare



----- Original Message ----- 
From: "Jean Delvare" <khali@linux-fr.org>
To: "LM Sensors" <lm-sensors@lm-sensors.org>
Sent: Friday 17 August 2007 22:54
Subject: [lm-sensors] Misc API changes for libsensors4


> Hi all,
>
> As libsensors4 won't be compatible with libsensors3 (thus the major
> version number change) it's the right time for small adjustments to 
> the
> API, which we won't be allowed to do later. After reviewing the 
> current
> API, I have the following proposals, and I would like to know if there
> are objections to me doing these changes.
>
> * Drop support for reloading the configuration from sensors_init().
> Instead, the application will have to call sensors_exit() explicitly
> before calling sensors_init() again. Rationale: most applications 
> don't
> offer any way to reload the configuration file, so better optimize for
> the initial load.
>
> * Change the prototype of sensors_get_label() from
> int sensors_get_label(const sensors_chip_name *name, int feature, char 
> **result)
> to
> char *sensors_get_label(const sensors_chip_name *name, int feature)
>
> Errors can be reported with a NULL pointer.
>
> * Rename sensors_get_feature() and sensors_set_feature() to
> sensors_get_value() and sensors_set_value(), respectively. Rationale:
> the new names better reflect what the functions do.
>
> * Change the prototype of sensors_get_detected_chips from
> const sensors_chip_name *sensors_get_detected_chips(int *nr)
> to
> const sensors_chip_name *sensors_get_detected_chips(const 
> sensors_chip_name *name, int *nr)
>
> The application would pass a chip name possibly containing wildcards,
> so sensors_get_detected_chips() could check for matches itself (using
> sensors_match_chip). Passing an all-wildcard chip name (or NULL?) 
> would
> restore the old behavior. This makes it easier to let the user chose a
> subset of chips to print (as can be done with sensors' command line) 
> by
> moving the code into the library. We may then be able to make
> sensors_match_chip private, as this is the last use in sensors and
> sensord.
>
> * Drop SENSORS_MODE_NO_RW and SENSORS_MODE_RW. The mode is a bitfield,
> we typically set, or test for, a specific bit. As a matter of fact,
> these two symbols aren't used anywhere in libsensors, sensors, 
> sensord,
> ksensors nor xsensors.
>
> If anyone has objections or comments, please let me know.
>
> Thanks,
> -- 
> Jean Delvare
>
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors 


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

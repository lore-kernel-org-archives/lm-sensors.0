From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Wed, 24 Oct 2007 11:18:05 +0000
Subject: Re: [lm-sensors] lm-sensors-3.0.0 and /etc/sensors.conf [was:
Message-Id: <471F29ED.8020705@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <471F1302.7030302@hhs.nl>
In-Reply-To: <471F1302.7030302@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Hans,
> 
> On Wed, 24 Oct 2007 11:40:18 +0200, Hans de Goede wrote:
>> Hi All,
>>
>> In another thread Jean Delvare wrote:
>>
>> ---
>>
>>  > However I have a remark to ease the transition from version 2.x.x to
>>  > version 3.0.0: it is currently possible to have the two libraries
>>  > installed, but they both use the same configuration file. What about
>>  > having different config files for the two versions (e.g. sensors.conf
>>  > and sensors3.conf) ?
>>
>> Technically speaking, the libraries themselves don't have default
>> configuration files. Applications do. That makes the matter only worse.
>>
>> For openSuse, my plan was to get plain rid of lm-sensors 2 and all
>> applications using it as soon as possible, so that no such conflict
>> happens. I don't think we'll package libsensors v2.10.x in the next
>> release. I don't know what Hans' plans are for Fedora. Of course, if
>> you intend to guarantee backwards compatibility by shipping the old
>> libsensors for a longer time in Debian, then indeed you have a problem.
>>
>> The fact that applications, rather than the library, set the default
>> configuration file name, means that it's essentially out of our control.
>> We could change sensors and sensord in lm-sensors 3.0.0 to use a
>> different default, but that won't solve the problem for all the 3rd
>> party applications out there. You'd need to change them all. Either the
>> authors do, or the packagers will have to.
>>
>> If you want to use /etc/sensors3.conf as the default for applications
>> using lm-sensors 3 in Debian, there's nothing preventing you from doing
>> that. This doesn't really have to be done upstream. That being said, I
>> agree that it would become confusing if different distributions come up
>> with different naming schemes.
>>
>> Coming to think about it, I think it's silly to have the default
>> configuration file name in applications. There's really no reason why
>> an application would want to use a different default, is there? So it
>> might be the right time to change this and put the default
>> configuration file name in libsensors. Calling sensors_init(NULL) would
>> use that default. It would make it easier to change the default if a
>> distribution wants to, and it would enforce a common default for
>> applications using the new library. Opinions?
>>
>> I don't much like the idea of using /etc/sensors3.conf for lm-sensors
>> 3. Soon enough, lm-sensors 2 will be history, sensors.conf will no
>> longer exist, and we'll be stuck with /etc/sensors3.conf. That's a bit
>> unaesthetic, isn't it? A slightly different approach would be to
>> use /etc/sensors3.conf if it exists, and /etc/sensors.conf otherwise
>> (as was done for the XFree86 configuration file from version 3.x to
>> version 4.x; remember?) This approach preserves compatibility with
>> existing installations and offers a nice upgrade path. But of course
>> this can only be (easily) implemented if the default is handled in
>> libsensors rather than in the applications themselves, as I proposed
>> above.
>>
>> ---
>>
>> My vote goes to removing the configfile argument to sensors_init, and hardcode
>> /etc/sensors.conf in libsensors.
> 
> I don't like this. While I do agree that most applications shouldn't
> use this parameter, it is still very convenient to be able to do
> "sensors -c <something>" as a user to test a custom configuration file
> before you copy that file to /etc/sensors.conf (or whatever it will
> be.) Also, being able to ask the users to report the output of sensors
> with no configuration file interfering (sensors -c /dev/null) is very
> valuable for debugging and investigating, and I wouldn't want to lose
> this ability.
> 
> There seems to be a consensus on the fact that the default should be in
> libsensors and not in the applications though, so I can implement this
> now.
> 
>>                                  Then we can make this /etc/sensors3.conf for
>> lm-sensors-3.x.x so that the 2 libs can be installed in parallel for distro's
>> who want to have a compatibility lib for the old 2.x version.
>>
>> I agree that having /etc/sensors3.conf isn't pretty, but it isn't horrible 
>> either, so I think its a good compromise.
> 
> My proposal to use /etc/sensors3.conf if present and fall back
> to /etc/sensors.conf if not, achieves this as well. Do you see any
> reason not to do this?
> 

No not all, I should have more verbose on that, checking for /etc/sensors3.conf 
first and then /etc/sensors.conf, when the sensors_init argument is NULL, 
sounds like a good plan to me.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

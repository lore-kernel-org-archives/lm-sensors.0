From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sat, 20 Oct 2007 22:41:59 +0000
Subject: Re: [lm-sensors] lm-sensors 3.0.0-rc1 has been released!
Message-Id: <471A8437.40208@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070925233316.7afaa297@hyperion.delvare>
In-Reply-To: <20070925233316.7afaa297@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Hans,
> 
> On Fri, 19 Oct 2007 22:18:02 +0200, Hans de Goede wrote:
>> Jean Delvare wrote:
>>> On Wed, 26 Sep 2007 23:02:31 +0200, Hans de Goede wrote:
>>>> Excellent work Jean! I've given this a test run on all my systems / test rigs 
>>>> and it works great everywhere. I'll create patches for ksensors, gkrellm, and 
>>>> gome's sensors-applet as time permits. I'm afraid this will take a while as 
>>>> currently I'm very busy with stuff regarding the upcoming Fedora 8.
>>> Any news on this? I am more or less waiting for this to happen before
>>> we can release lm-sensors 3.0.0 final.
>> I've ported my first application over: gkrellm. gkrellm only uses the main 
>> featuree (_input values) so I instinctively wrote this:
>>
>> 	while ((feature = sensors_get_features(name, &nr1))) {
>> 		/* ..... */
>> 		result = sensors_get_value(name, feature->number, &val);
>>
>> Which to my surprise doesn't work I now know this should be:
>> 	while ((feature = sensors_get_features(name, &nr1))) {
>> 		/* ..... */
>> 		result = sensors_get_value(name,
>> 			sensors_get_subfeature(name, feature, SENSORS_SUBFEATURE_IN_INPUT),
>> 			feature->number, &val);
>>
>> Which must be put in a switch statement on feature->type to put in 
>> SENSORS_SUBFEATURE_IN_INPUT / SENSORS_SUBFEATURE_FAN_INPUT / 
>> SENSORS_SUBFEATURE_TEMP_INPUT
>>
>> Ideally my first naive code should just work for simple applications which only 
>> want to read the main / _input feature, I haven't checked yet, but I think 
>> making my initial code work, doesn't match well with the current libsensors 
>> structure, 
> 
> Indeed. Features and subfeatures are now separate entities. When I
> proposed to do that change a few months ago, nobody objected.
> 

I didn't understand back then that foo#_input would become a subfeature too, I 
thought that would be part of the main feature.

>>            so how about adding an "int input_subfeature_number" to the
>> sensors_feature struct, so that my original code will work like this:
>>
>> 	while ((feature = sensors_get_features(name, &nr1))) {
>> 		/* ..... */
>> 		result = sensors_get_value(name,
>> 		 	feature->input_subfeature_number, &val);
>>
>>
>> Or alternatively a sensors_get_main_value(name, feature, &val) function?
> 
> First of all, please note that the main value in question may not
> exist. Your code should be ready for it to happen.
> 

Do features that do have tresholds / other settings but no reading of the 
actual input exist?

> My guess was that applications would need to switch on the feature type
> anyway, as different types are usually displayed differently, so I
> never considered this to be a problem. All of sensors, sensord and
> xsensors do, I'm surprised that gkrellm doesn't. How does it display
> the proper unit? How does it adjust the number of decimal places?
> 

This is correct, there indeed is such a switch present, the code I postred was 
simplified for the discussion. Still needing to make an additional function 
call to get to the _input subfeature feels like a detour.

> I am also surprised that you call sensors_get_value() directly in the
> loop that discovers the features. Applications which display values
> continuously (as opposed to sensors' one-shot) tend to store the
> feature numbers at initialization time, and then call
> sensors_get_value() on them directly without looping over
> sensors_get_features() again.
> 

Actually you are right, the feature number gets remembered. (again I simplified 
the code).

> Adding input_subfeature to struct sensors_subfeature is possible if it
> helps you. It should be fairly easy. I'd just like to understand why
> gkrellm's needs differ from the 3 applications I've ported myself.
> 

Well it doesn't need it, but having it would make the code cleaner.

>> Besides that adding a define to sensors.h which can be tested to find out 
>> against which libsensors version code is compiling would be a good idea too.
> 
> As the underlying build system needs to know what library will be used
> (for proper linkage),

No it doesn't -lsensors will work for both linsensors3 and libsensors4 actually 
the ./configure check for libsensors in gkrellm works with both without 
modification (it checks for sensors/sensors.h && sensors_init()).

> I expected applications to deal with the
> different versions on their own. But if you think that a #define in
> sensors.h would help, just go ahead, that's fine with me.
> 

Well as explained above ./configure and the Makefiles don't need to know about 
the different versions, So only some code changes are needed, for which it 
would be nice if a #define is present to test for.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

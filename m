From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Fri, 19 Oct 2007 20:18:02 +0000
Subject: Re: [lm-sensors] lm-sensors 3.0.0-rc1 has been released!
Message-Id: <471910FA.4030802@hhs.nl>
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
> On Wed, 26 Sep 2007 23:02:31 +0200, Hans de Goede wrote:
>> Excellent work Jean! I've given this a test run on all my systems / test rigs 
>> and it works great everywhere. I'll create patches for ksensors, gkrellm, and 
>> gome's sensors-applet as time permits. I'm afraid this will take a while as 
>> currently I'm very busy with stuff regarding the upcoming Fedora 8.
> 
> Any news on this? I am more or less waiting for this to happen before
> we can release lm-sensors 3.0.0 final.
> 

Okay,

I've ported my first application over: gkrellm. gkrellm only uses the main 
featuree (_input values) so I instinctively wrote this:

	while ((feature = sensors_get_features(name, &nr1))) {
		/* ..... */
		result = sensors_get_value(name, feature->number, &val);

Which to my surprise doesn't work I now know this should be:
	while ((feature = sensors_get_features(name, &nr1))) {
		/* ..... */
		result = sensors_get_value(name,
			sensors_get_subfeature(name,                             				feature, 
SENSORS_SUBFEATURE_IN_INPUT),
			feature->number, &val);

Which must be put in a switch statement on feature->type to put in 
SENSORS_SUBFEATURE_IN_INPUT / SENSORS_SUBFEATURE_FAN_INPUT / 
SENSORS_SUBFEATURE_TEMP_INPUT

Ideally my first naive code should just work for simple applications which only 
want to read the main / _input feature, I haven't checked yet, but I think 
making my initial code work, doesn't match well with the current libsensors 
structure, so how about adding an "int input_subfeature_number" to the
sensors_feature struct, so that my original code will work like this:

	while ((feature = sensors_get_features(name, &nr1))) {
		/* ..... */
		result = sensors_get_value(name,
		 	feature->input_subfeature_number, &val);


Or alternatively a sensors_get_main_value(name, feature, &val) function?

Besides that adding a define to sensors.h which can be tested to find out 
against which libsensors version code is compiling would be a good idea too.

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

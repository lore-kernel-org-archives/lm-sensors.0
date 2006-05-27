From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 27 May 2006 07:16:16 +0000
Subject: [lm-sensors] PATCH: abituguru driver
Message-Id: <20060527091616.acd12638.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4470B10F.7070502@hhs.nl>
In-Reply-To: <4470B10F.7070502@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

> > Now, before I push this upwards, there's at least one thing which I
> > would like you change/fix: the sysfs interface files handling. I see
> > that you are creating the sysfs file attributes dynamically, and store
> > the names in a large array in the device private data structure:
> > 
> > > struct abituguru_data {
> > > (...)
> > > 	/* The sysfs attr and their names are generated automatically, for bank1
> > > 	   we cannot use a predefined array because we don't know beforehand
> > > 	   of a sensor is a volt or a temp sensor, for bank2 and the pwms its
> > > 	   easier todo things the same way.  For in sensors we have 9 (temp 7)
> > > 	   sysfs entries per sensor, for bank2 and pwms 6. */
> > > 	struct sensor_device_attribute_2 sysfs_attr[16 * 9 +
> > > 		ABIT_UGURU_MAX_BANK2_SENSORS * 6 + ABIT_UGURU_MAX_PWMS * 6];
> > > 	/* Buffer to store the dynamically generated sysfs names, we need 2120
> > > 	   bytes for bank1 (worst case scenario of 16 in sensors), 444 bytes
> > > 	   for fan1-6 and 738 bytes for pwm1-6 + some room to spare in case I
> > > 	   miscounted :) */
> > > 	char bank1_names[3400];
> > 
> > Why do you want to do this in the first place? All other hardware
> > monitoring drivers use static attributes. Within a given driver, not
> > all supported chips use all attributes, but that's OK. What makes the
> > uGuru different?
> 
> That in bank1 a certain sensor address within the bank sometimes is a 
> temp sensor and sometimes an in sensor, hence the 2 different sysfs attr 
> "templates" for bank1 sensors. In my previous version I already had 
> dynamicly generated sysfs attr because of this, but I used a large const 
> array with all the names to assign the names. However with the new per 
> sensor alarm files, this array became huge (9 entries per sensor * 16 
> sensors!) and the array became a maintainance problem, having to 
> manually type in 144 names in an array is no fun!

We have other drivers where channels can be of different nature
(vt8231, vt1211), this is nothing new. I didn't suggest that you
manually type the names, you could use macros. Not that I particularly
like macros, but this is an alternative.

> This change has actually reduced the size of the driver by 150 lines or 
> so compared to the old one file for all alarms version, I don't want to 
> know how much the line increase would have been if I had kept static 
> sysfs attr arrays.
> 
> The uguru is a special beast, currently it has 134 sysfs entries on my 
> system, but the theoretical maximum is:
> 9x16 (16 in sensors) + 6x6 (6 fan sensors) + 6x5 (5 pwm outputs) = 210 
> entries.
> 
> Since I don't know beforehand wether a sensor is a temp or in sensor, I 
> would need an additional 7x16 (16 temp sensors) sysfs attr in the 
> driver, for a grand total of 322 sysfs attr! I've always learned that 
> computers are good at repetetive jobs and that you shouldn't have 
> repetitive patterns in your code but instead let the computer do the 
> repetitions which is what I've done.

Cut'n'paste is a third way to let your computer do the repetitive job ;)

> > Your dynamic implementation has "overflow" written on it in big block
> > letters. What will happen when we later need to add files? Or if we
> > change the names and the new ones are longer? I'd need to be convinced
> > that everything is safe and under control. "3400" hardcoded doesn't
> > qualify, let alone the comment itself ;) At the very least, you should
> > express the array size from clearly defined constants. And you should
> > use snprintf, not sprintf, when filling the array.
> 
> Ok, I'll add a bunch of defines, is 1 define for the total names length 
> (including \0) per sensor type acceptable so say (numbers are fiction):
> ABITUGURU_IN_NAMES_LENGTH   150
> ABITUGURU_TEMP_NAMES_LENGTH 120
> ABITUGURU_FAN_NAMES_LENGTH   80
> ABITUGURU_PWM_NAMES_LENGTH  100
> 
> And I'll switch to snprintf

No, actually I think you should define a maximum length per file name
first. Then multiply by the number of files per input, then by the max
number of inputs, and finally add everything to get the total array
size. It doesn't matter if it makes you define a dozen constants, as
long as the final result can be easily verified by the reviewer. Feel
free to make the define names a bit shorter if it makes the expressions
more readable.

Of course, the size parameter you pass to snprintf will need to be
expressed in terms of these constants.

> > But before that you really need to convince me that this is needed at
> > all, because the code complexity must be justified by a significant
> > benefit, else it's just not worth it.
> 
> I call not having to have an array with 322 entries + const 
> initialization for 322 entries a significant benefit.
> 
> If you agree please let me know then I'll add the defines and switch to 
> snprintf.

I would have done it differently, but this is your driver ;) If you can
guarantee that the arrays containing the attributes and names won't
overflow, I'm fine with your approach.

> > I won't push the driver upwards until this is sorted out.
> > 
> > Other cleanups I'd like you to consider:
> > 
> > * Use the ARRAY_SIZE macro instead of hardcoded values wherever
> >   possible.
> > * In abituguru_probe(), refactor the error path so that you have a
> >   single call to kfree().
> 
> I'll take a look at these when I'm fixing the showstopper.

Thanks,
-- 
Jean Delvare


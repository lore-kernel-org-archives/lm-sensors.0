From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:36 +0000
Subject: Error messages on ignored values
Message-Id: <eLuDL1GS.1107516883.4906290.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050204053725.34834.qmail@web60504.mail.yahoo.com>
In-Reply-To: <20050204053725.34834.qmail@web60504.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Michael,

> I am running Debian sarge, with a 2.6.10 kernel that I have built, the
> user programs of lm_sensors-2.9.0, and the 2.6.10 kernel patch.

Which patch are you talking about?

> I am able to run sensors, and get valid output, but the values that are
> marked ignore in the sensors.conf are reported as unreadable. I changed a
> label value in the conf file and saw the output of sensors change, so I
> know I am looking at the correct configuration file.
>
> I have added a debug message to progs/sensors/chips.c to print out the
> result of sensors_get_ignored, and see that the config file is being used
> to determine that the values should be ignored.
>
> mcarland@myth:~/lm_sensors-2.9.0/prog/sensors$ lsmod
> Module                  Size  Used by
> vt1211                 16692  0
> i2c_sensor              2784  1 vt1211
> i2c_isa                 1600  0
> lirc_serial            11328  0
> lirc_dev               11404  1 lirc_serial
> mcarland@myth:~/lm_sensors-2.9.0/prog/sensors$ uname -a
> Linux myth 2.6.10myth-via #5 Thu Feb 3 21:24:11 UTC 2005 i686 GNU/Linux

FWIW, the 2.6.10 linux kernel doesn't have a vt1211 driver, so we can
hardly support this.

> I see that the logic to print out the values checks the ignored status,
> but doesn't use it until after an attempt to read the values:
>
>  if (!sensors_get_label_and_valid(*name,SENSORS_VT1211_IN0,&label,&valid) &&
>      !sensors_get_feature(*name,SENSORS_VT1211_IN0,&cur) &&
>      !sensors_get_feature(*name,SENSORS_VT1211_IN0_MIN,&min) &&
>      !sensors_get_feature(*name,SENSORS_VT1211_IN0_MAX,&max)) {
>    if (valid) {
>      print_label(label,10);
>      printf("%+6.2f V  (min = %+6.2f V, max = %+6.2f V)   %s\n",
>             cur,min,max,alarms&VT1211_ALARM_IN0?"ALARM":"");
>    }
>  } else
>    printf("ERROR: Can't get IN0 data!\n");
>  free_the_label(&label);

I agree with your analysis of the code. Looks suboptimal, since we do
read values even when we already know we'll ignore them.

> Shouldn't either sensors_get_feature(...) not do the read if the feature
> is not valid (only that function would have to be changed),

Bad idea, sensors_get_feature is part of libsensors, on which several
other monitoring tools are based. We better don't change the interface
without a solid reasons - and this one isn't.

> or more
> appropriately change the logic for each section like the one above to
> break if !valid, before sensors_get_feature(...) is called? Something like
>
>  if (sensors_get_label_and_valid(*name,SENSORS_VT1211_IN0,&label,&valid)) {
>    printf("ERROR: Can't get IN0 data!\n");
>  } else if (valid) {
>    if (!sensors_get_feature(*name,SENSORS_VT1211_IN0,&cur) &&
>        !sensors_get_feature(*name,SENSORS_VT1211_IN0_MIN,&min) &&
>        !sensors_get_feature(*name,SENSORS_VT1211_IN0_MAX,&max)) {
>        print_label(label,10);
>        printf("%+6.2f V  (min = %+6.2f V, max = %+6.2f V)   %s\n",
>               cur,min,max,alarms&VT1211_ALARM_IN0?"ALARM":"");
>    } else
>    printf("ERROR: Can't get IN0 data!\n");
>  }
>  free_the_label(&label);

Agreed, that would be better.

Now you might wonder why the problem was never noticed and fixed, since
it seems to spread across all chips print functions. The reason is
rather simple. In the times of Linux 2.4, hardware monitoring drivers
would use procfs as the user-space/kernel interface. With procfs, it was
difficult to add or remove individual interface files depending on a
given chip configuration, thus it wasn't done. As a result, "sensors"
could safely read any value, even if that value wouldn't make any
sense, and it was left to the user to add the proper "ignore" lines in
the configuration files.

When we started porting drivers to Linux 2.6 and sysfs, we found it was
now easy to disable specific interface files when they wouldn't mean a
thing for a specific chip configuration. That sounded like a sane thing
to do (let's not waste resources) but sensors started complaining in
this case. The solution that was used so far was to discard the
complaint itself, because a missing interface file was now considered
possible and no more necessarily an error.

The approach you propose is slightly different, since the user would have
to put "ignore" lines in his/her configuration file in order to
dismiss the error message. So, while it looks cleaner, I am not sure it
is the way to go. If we do what you propose, we are likely to get many
reports about the errors, which aren't really errors.

The idea of not reading values for ignored channels still makes sense
though, as it improves performance, and isn't incompatible with hiding
errors on missing interface files.

Feel tree to propose a patch for print_vt1211 that will remove the error
message for the files that now can possibly not be there, and would also
skip reads on ignored channels if you want. We'd apply such a patch.

Thanks,
--
Jean Delvare

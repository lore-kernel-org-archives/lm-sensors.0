From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 07 Oct 2007 14:59:34 +0000
Subject: Re: [lm-sensors] Call for 2.10.5
Message-Id: <20071007165934.4974da0a@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20071007114017.27909e43@hyperion.delvare>
In-Reply-To: <20071007114017.27909e43@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Sun, 07 Oct 2007 14:08:46 +0200, Hans de Goede wrote:
> Jean Delvare wrote:
> > Hi all,
> > 
> > lm-sensors 2.10.4 is 3 months old now, so we should think about
> > releasing 2.10.5. There are no big changes, as expected in a stable
> > branch, but a good load of bugfixes. Proposed schedule:
> > 
> > * October 10th: SVN freeze
> > * October 11th-14th: testing
> > * October 15th: release
> 
> <ugh> thats awefully short notice.

The release date of 2.10.5 has been set to October 16th long ago:
http://www.lm-sensors.org/milestone/2.10.5

>                                    I would really like to add support for the 
> new FSC driver, and fix things so that they will work with both the old and the 
> new drivers, but I don't think I'll get around to doing that before the 10th.
> 
> Any chance we could slip a couple of days if I don't get around to doing this 
> before the 10th?

Sure, no problem. As long as it doesn't shift too much, that's fine
with me.

> While I'm talking about the FSC, currently the temp code for both the fscpos 
> and the fscher looks like this:
> 
>    if (!sensors_get_label_and_valid(*name,SENSORS_FSCPOS_TEMP1,&label,&valid) &&
>        !sensors_get_feature(*name,SENSORS_FSCPOS_TEMP1,&temp) &&
>        !sensors_get_feature(*name,SENSORS_FSCPOS_TEMP1_STATE,&state)) {
>      if (valid) {
>        print_label(label,10);
>          if((int) state & 0x01)
>            printf("\t%+6.2f C\n", temp);
>          else
>            printf("\tfailed\n");
>      }
>    } else
>      printf("ERROR: Can't get TEMP1 data!\n");
>    free(label);
> 
> Notice the SENSORS_FSCPOS_TEMP1_STATE, which is a sysfs attr file containing a 
> copy of the status register, the new driver doesn't have this. It has a 
> tempX_fault instead and adds a tempX_alarm.
> 
> So I'm thinking to just go the common denominater way here and only read and 
> display the temp (thus displaying something like 0 or 255 for not connected 
> sensors), does this sound ok?

Your change should not cause a regression. This means that you should
keep using the value read from the state file where available, and only
if not, display whatever bogus value the driver returned.

Alternatively, you could add new symbols for the fault files in
libsensors, so that you always have a way to get the information.
Whether it's worth doing when lm-sensors 3 offers full support out of
the box, is up to you.

> For fans it reads:
>    if (!sensors_get_label_and_valid(*name,SENSORS_FSCPOS_FAN1,&label,&valid) &&
>        !sensors_get_feature(*name,SENSORS_FSCPOS_FAN1,&fan) &&
>        !sensors_get_feature(*name,SENSORS_FSCPOS_FAN1_STATE,&state)) {
>      if (valid) {
>        print_label(label,10);
>          if((int) state & 0x04)
>            printf("\tfaulty\n");
>          else
>            printf("\t%6.0f RPM\n", fan);
>      }
>    } else
>      printf("ERROR: Can't get FAN1 data!\n");
>    free(label);
> 
> Again using a raw dump of the status register and dead wrong actually as 0x04 
> is not a fault bit but an alarm bit (rather major difference if you ask me).

Please fix this bug.

> Again I'm thinking to just go the common denominater way here and only read and 
> display the rpms (displaying 0 for a not connected fan) does this sound ok?

As above for temperatures, you shouldn't introduce a regression.

> For the fscscy the temp code looks like this:
>    if (!sensors_get_label_and_valid(*name,SENSORS_FSCSCY_TEMP1,&label,&valid) &&
>        !sensors_get_feature(*name,SENSORS_FSCSCY_TEMP1,&temp) &&
>        !sensors_get_feature(*name,SENSORS_FSCSCY_TEMP1_LIM,&templim) &&
>        !sensors_get_feature(*name,SENSORS_FSCSCY_TEMP1_MIN,&tempmin) &&
>        !sensors_get_feature(*name,SENSORS_FSCSCY_TEMP1_MAX,&tempmax) &&
>        !sensors_get_feature(*name,SENSORS_FSCSCY_TEMP1_STATE,&state)) {
>      if (valid) {
>        print_label(label,10);
>          if((int) state & 0x01)
>            printf("\t%+6.2f C (Min = %+6.2f C, Max = %+6.2f C, Lim = %+6.2f C)\n
>                  temp,tempmin,tempmax,templim);
>          else
>            printf("\tfailed\n");
>      }
>    } else
>      printf("ERROR: Can't get TEMP1 data!\n");
>    free(label);
> 
> Again using a raw dump of the status register, and even worse using software 
> maintained min and max values, which are not limits, but the lowest / highest 
> value measured since the driver was loaded <ugh>.

This is confusing and should be removed.

> Proposed solution once again: display only the temp and no other info, it would 
> be nice to preserve the display of the limit, but thats called temp#_lim, where 
> as in the new driver it is called temp#_max, which in the old driver was not a 
> limit as described above, so just displaying only the temp seems for the best.

You can translate temp#_lim to temp#_max in lib/chips.c.

> Alternatively I could test for the readability of SENSORS_FSC***_TEMP1_STATE 
> and switch between the code for the old driver and new to be written code for 
> the new driver, that might be better as it will also reduce the chance of 
> regressions.

My point exactly :)

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

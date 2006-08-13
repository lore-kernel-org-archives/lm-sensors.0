From: bezaur@gmail.com (Charles Spirakis)
Date: Sun, 13 Aug 2006 07:34:04 +0000
Subject: [lm-sensors] [PATCH] Update lm_sensors to handle more of the
Message-Id: <5bfe43f80608130034l2a9a75cbj913d41cf5b2c655d@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <5bfe43f80608030056t16679db3ub2bc7fa0efa59ed1@mail.gmail.com>
In-Reply-To: <5bfe43f80608030056t16679db3ub2bc7fa0efa59ed1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean --

I will try to get an update to you in the next few days. However,
there is some ambiguity in the documentation which is causing some of
the confusion...

If you look at the 791d beep enable register (0xa3) and compare those
bits to the alarm status register (0xab) you will see a discrepancy in
the bit ordering.

Sven and I tried to figure out if the documentation was correct or if
one of the bit orderings provided were correct and it was hard to
tell. It seemed like the bits for the enable did correspond to the
bits for the alarm and we had reason to believe the enable bits were
correct (which puts in7 and in8 at 0x10000 and 0x20000 respectively -
the same as the w83782d). In a side note, if you look at the interrupt
mask bits (0x9d) they seem to follow the alarm status bit pattern and
not the enable bit pattern but since the driver isn't using that
register it's not overly significant other than interesting
information.

I will go back and test this again just to verify what we think we saw
is what we actually saw (or heard as the case may be).

If anyone from winbond is reading this, would it be possible to get a
definitive answer as to whether the documentation is right and (if
not), to let us know what the correct bit patterns are for the alarm
vs. the enable?

Along these same lines, the bit position for bit 1 and bit 13 are also
swapped between what is shown for the enable vs. alarm. In that case,
the documentation seems to be correct and the patch for the 2.6 driver
is updated to reflect this.

Which leads to a different question. The assumption that was made for
the driver patch was that we wanted the alarm and enable bits to match
in user-space (and the driver would hide the problem if the chip
didn't do this). Is this the correct assumption? Or should userspace
get the values directly from the chip (so it matches the chip
documentation) and let the user-space code deal with the bit
twiddling?

Oh, and I just noticed the inconsistency in the 2.6 w83791d driver
patch in the Documentation file - needs to be:

14 - in9 (VINR1)

Depending on your answer to the previous question (how do we handle
the situation where the enable bit ordering is different from the
alarm bit ordering), I will update or remove the patch... And yes, I
understand this is yet another argument for updating this code to the
standardized sysfs beep/alarm model. :)

-- charles


On 8/12/06, Jean Delvare <khali at linux-fr.org> wrote:
> Hi Charles, Sven,
>
> Sorry for the late answer.
>
> > Modified patch from Sven Anders to enhance w83791d support. Partial
> > support was already implemented, but it was missing IN9/FAN4/FAN5 output.
>
> >  /* PWM 782D (1-4) and 783S (1-2) only */
> > @@ -385,16 +385,22 @@ static struct i2c_driver w83781d_driver
> >  #define W83781D_ALARM_IN4 0x0100
> >  #define W83781D_ALARM_IN5 0x0200
> >  #define W83781D_ALARM_IN6 0x0400
> > -#define W83782D_ALARM_IN7 0x10000
> > -#define W83782D_ALARM_IN8 0x20000
> > +#define W83782D_ALARM_IN7 0x10000    /* 782D/791D */
> > +#define W83782D_ALARM_IN8 0x20000    /* 782D/791D */
> > +#define W83791D_ALARM_IN9 0x40000    /* 791D only */
>
> This does NOT match the W83791D datasheet I have here. These bits are
> OK for the 782D, but the 791D seems to use a different mapping:
>
> 5VSB = in7 = register 0xAB bit 3 -> 0x80000
> VBAT = in8 = register 0xAB bit 4 -> 0x100000
> VINR1 = in9 = register 0xAA bit 6 -> 0x4000
>
> >  #define W83781D_ALARM_FAN1 0x0040
> >  #define W83781D_ALARM_FAN2 0x0080
> >  #define W83781D_ALARM_FAN3 0x0800
> > +#define W83791D_ALARM_FAN4 0x200000  /* 791D only */
> > +#define W83791D_ALARM_FAN5 0x400000  /* 791D only */
>
> I'm OK with these ones.
>
> >  #define W83781D_ALARM_TEMP1 0x0010
> >  #define W83781D_ALARM_TEMP23 0x0020  /* 781D only */
> > -#define W83781D_ALARM_TEMP2 0x0020   /* 782D/783S */
> > -#define W83781D_ALARM_TEMP3 0x2000   /* 782D only */
> > +#define W83781D_ALARM_TEMP2 0x0020   /* 782D/783S/791D */
> > +#define W83781D_ALARM_TEMP3 0x2000   /* 782D/791D */
>
> I'm OK here as well.
>
> >  #define W83781D_ALARM_CHAS 0x1000
> > +#define W83791D_ALARM_VINR1 0x04000  /* 782D/791D */
> > +#define W83791D_ALARM_VSB 0x80000    /* 791D only */
> > +#define W83791D_ALARM_VBAT 0x100000  /* 791D only */
>
> And here you have the same values I have above. These are the ones we
> want to use! But I'd rather name them W83791D_ALARM_IN{7,8,9} to keep
> some consistency in the naming.
>
> > diff -urpN lm-sensors-r4079-20060730/prog/sensors/chips.c lm-sensors-r4079-20060730_sven_changes/prog/sensors/chips.c
> > --- lm-sensors-r4079-20060730/prog/sensors/chips.c    2006-07-29 21:10:45.000000000 -0700
> > +++ lm-sensors-r4079-20060730_sven_changes/prog/sensors/chips.c       2006-07-30 22:26:05.000000000 -0700
> > @@ -2187,7 +2187,7 @@ void print_w83781d(const sensors_chip_na
> >    char *label;
> >    double cur,min,max,fdiv,sens;
> >    int alarms,beeps;
> > -  int is81d, is82d, is83s, is697hf, is627thf, valid;
> > +  int is81d, is82d, is83s, is91d, is697hf, is627thf, valid;
> >
> >    is81d = !strcmp(name->prefix,"w83781d");
> >    is82d = (!strcmp(name->prefix,"w83782d")) ||
> > @@ -2196,6 +2196,7 @@ void print_w83781d(const sensors_chip_na
> >            (!strcmp(name->prefix, "w83627thf")) ||
> >            (!strcmp(name->prefix, "w83687thf"));
> >    is83s = !strcmp(name->prefix,"w83783s");
> > +  is91d = !strcmp(name->prefix,"w83791d");
> >    is627thf = (!strcmp(name->prefix,"w83627thf")) ||
> >               (!strcmp(name->prefix, "w83637hf")) ||
> >               (!strcmp(name->prefix, "w83687thf"));
> > @@ -2310,7 +2311,7 @@ void print_w83781d(const sensors_chip_na
> >        printf("ERROR: Can't get IN6 data!\n");
> >      free(label);
> >    } /* !is627thf */
> > -  if (is82d || is697hf || is627thf) {
> > +  if (is82d || is697hf || is627thf || is91d) {
> >      if (!sensors_get_label_and_valid(*name,SENSORS_W83782D_IN7,&label,&valid) &&
> >          !sensors_get_feature(*name,SENSORS_W83782D_IN7,&cur) &&
> >          !sensors_get_feature(*name,SENSORS_W83782D_IN7_MIN,&min) &&
> > @@ -2339,6 +2340,22 @@ void print_w83781d(const sensors_chip_na
> >      free(label);
> >    }
> >
> > +  if (is91d) {
> > +    if (!sensors_get_label_and_valid(*name,SENSORS_W83791D_IN9,&label,&valid) &&
> > +        !sensors_get_feature(*name,SENSORS_W83791D_IN9,&cur) &&
> > +        !sensors_get_feature(*name,SENSORS_W83791D_IN9_MIN,&min) &&
> > +        !sensors_get_feature(*name,SENSORS_W83791D_IN9_MAX,&max)) {
> > +      if (valid) {
> > +        print_label(label,10);
> > +        printf("%+6.2f V  (min = %+6.2f V, max = %+6.2f V)       %s  %s\n",
> > +             cur,min,max,alarms&W83791D_ALARM_IN9?"ALARM":"     ",
> > +             beeps&W83791D_ALARM_IN9?"(beep)":"");
>
> OK if and only if W83791D_ALARM_IN9 is set to the right value.
>
> > +      }
> > +    } else
> > +      printf("ERROR: Can't get IN9 data!\n");
> > +    free(label);
> > +  }
> > +
> >    if (!sensors_get_label_and_valid(*name,SENSORS_W83781D_FAN1,&label,&valid) &&
> >        !sensors_get_feature(*name,SENSORS_W83781D_FAN1,&cur) &&
> >        !sensors_get_feature(*name,SENSORS_W83781D_FAN1_DIV,&fdiv) &&
> > @@ -2382,6 +2399,35 @@ void print_w83781d(const sensors_chip_na
> >      free(label);
> >    }
> >
> > +  if(is91d) {
> > +    if (!sensors_get_label_and_valid(*name,SENSORS_W83791D_FAN4,&label,&valid) &&
> > +        !sensors_get_feature(*name,SENSORS_W83791D_FAN4,&cur) &&
> > +        !sensors_get_feature(*name,SENSORS_W83791D_FAN4_DIV,&fdiv) &&
> > +        !sensors_get_feature(*name,SENSORS_W83791D_FAN4_MIN,&min)) {
> > +      if (valid) {
> > +        print_label(label,10);
> > +        printf("%4.0f RPM  (min = %4.0f RPM, div = %1.0f)              %s  %s\n",
> > +             cur,min,fdiv, alarms&W83791D_ALARM_FAN4?"ALARM":"     ",
> > +             beeps&W83791D_ALARM_FAN4?"(beep)":"");
> > +      }
> > +    } else
> > +      printf("ERROR: Can't get FAN4 data!\n");
> > +    free(label);
> > +    if (!sensors_get_label_and_valid(*name,SENSORS_W83791D_FAN5,&label,&valid) &&
> > +        !sensors_get_feature(*name,SENSORS_W83791D_FAN5,&cur) &&
> > +        !sensors_get_feature(*name,SENSORS_W83791D_FAN5_DIV,&fdiv) &&
> > +        !sensors_get_feature(*name,SENSORS_W83791D_FAN5_MIN,&min)) {
> > +      if (valid) {
> > +        print_label(label,10);
> > +        printf("%4.0f RPM  (min = %4.0f RPM, div = %1.0f)              %s  %s\n",
> > +             cur,min,fdiv, alarms&W83791D_ALARM_FAN5?"ALARM":"     ",
> > +             beeps&W83791D_ALARM_FAN5?"(beep)":"");
> > +      }
> > +    } else
> > +      printf("ERROR: Can't get FAN5 data!\n");
> > +    free(label);
> > +  }
> > +
> >    if (!sensors_get_label_and_valid(*name,SENSORS_W83781D_TEMP1,&label,&valid) &&
> >        !sensors_get_feature(*name,SENSORS_W83781D_TEMP1,&cur) &&
> >        !sensors_get_feature(*name,SENSORS_W83781D_TEMP1_HYST,&min) &&
>
> This is OK but not sufficient as far as I can see. Because of the
> difference in alarm bits for in7 and in8, you also need to add specific
> code for the w83791d in the in7 and in8 cases.
>
> I'd like to have these improvements merged soon now, can you please
> provide a new patch?
>
> Thanks,
> --
> Jean Delvare
>


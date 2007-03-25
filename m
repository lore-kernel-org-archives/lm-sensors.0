From: juergh@gmail.com (Juerg Haefliger)
Date: Sun, 25 Mar 2007 18:43:39 +0000
Subject: [lm-sensors] [PATCH] lm-sensors: add dme1737 support
Message-Id: <191fb4ca0703251143n5a755e43w19e759dae90b9272@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0703232147q3a74701ci4bedf256201ee587@mail.gmail.com>
In-Reply-To: <191fb4ca0703232147q3a74701ci4bedf256201ee587@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jean,

> > +#define SENSORS_DME1737_TEMP_FEATURES(nr) \
> > +     { { SENSORS_DME1737_TEMP(nr), "temp" #nr, \
> > +             NOMAP, NOMAP, R }, \
> > +             NOSYSCTL, VALUE(3), 3 }, \
> > +     { { SENSORS_DME1737_TEMP_MIN(nr), "temp" #nr "_min", \
> > +             SENSORS_DME1737_TEMP(nr), SENSORS_DME1737_TEMP(nr), RW }, \
> > +             NOSYSCTL, VALUE(1), 3 }, \
>
> Should be VALUE(2) - although we don't really care for a Linux 2.6-only
> driver.

OK, I was always wondering what this is for.


> > +     { { SENSORS_DME1737_TEMP_MAX(nr), "temp" #nr "_max", \
> > +             SENSORS_DME1737_TEMP(nr), SENSORS_DME1737_TEMP(nr), RW }, \
> > +             NOSYSCTL, VALUE(1), 3 }, \
> > +     { { SENSORS_DME1737_TEMP_ALARM(nr), "temp" #nr "_alarm", \
> > +             SENSORS_DME1737_TEMP(nr), NOMAP, R }, \
> > +             NOSYSCTL, VALUE(1), 3 }, \
> > +     { { SENSORS_DME1737_TEMP_FAULT(nr), "temp" #nr "_fault", \
> > +             SENSORS_DME1737_TEMP(nr), NOMAP, R }, \
> > +             NOSYSCTL, VALUE(1), 3 }
>
> Alarm and fault with magnitude 3? I don't think so.

Oops, no certainly not.


> > +#define SENSORS_DME1737_MISC_FEATURES \
> > +     { { SENSORS_DME1737_VID, "vid", \
> > +             NOMAP, NOMAP, R }, \
> > +             NOSYSCTL, VALUE(1), 3 }, \
> > +     { { SENSORS_DME1737_VRM, "vrm", \
> > +             NOMAP, NOMAP, RW }, \
> > +             NOSYSCTL, VALUE(1), 1 }
>
> No point in having a macro for these, please include them directly in
> the array of features below.

OK.


> > +/* DME1737 */
> > +
> > +#define SENSORS_DME1737_PREFIX "dme1737"
> > +
>
> Please state in a comment each time in which range "n" should be.

OK.


> >       { "pwm2", "pwm2", 0, "fan2_pwm" },
> >       { "pwm3", "pwm3", 0, "fan3_pwm" },
> >       { "pwm4", "pwm4", 0, "fan4_pwm" },
> > +     { "pwm5", "pwm5", 0, "fan5_pwm" },
> > +     { "pwm6", "pwm6", 0, "fan6_pwm" },
> >       { "pwm1_enable", "pwm1_enable", 0, "fan1_pwm_enable" },
> >       { "pwm2_enable", "pwm2_enable", 0, "fan2_pwm_enable" },
> >       { "pwm3_enable", "pwm3_enable", 0, "fan3_pwm_enable" },
> >       { "pwm4_enable", "pwm4_enable", 0, "fan4_pwm_enable" },
> > +     { "pwm5_enable", "pwm5_enable", 0, "fan5_pwm_enable" },
> > +     { "pwm6_enable", "pwm6_enable", 0, "fan6_pwm_enable" },
> >       { NULL, NULL }
> >  };
> >
>
> You shouldn't need this, the alternative names were only in use for a
> short range of early 2.6 kernels, and your driver will never be
> backported to these kernels.

If I don't have these lines I get 'Can't get pmw5 data' and 'Can't get
pwm6 data' errors. Isn't this the right fix?


> >        {
> > -     name => "SMSC DME1737 Super IO",
> > -     # Hardware monitoring features are accessed on the SMBus
> > -     driver => "not-a-sensor",
> > -     devid => 0x78,
> > +        name => "SMSC DME1737 Super IO",
> > +        # Hardware monitoring features are accessed on the SMBus
> > +        driver => "via-smbus-only",
> > +        devid => 0x78,
> > +      },
> > +      {
> > +        name => "SMSC DME1737 Super IO",
> > +        # Hardware monitoring features are accessed on the SMBus
> > +        driver => "via-smbus-only",
> > +        devid => 0x77,
> >        },
> >      ],
> >    },
>
> Please document the new special driver name you are introducing, like
> "to-be-written" and "not-a-sensor" are, in the big comment before the
> array.

OK.


> And please don't change the indentation. I know the indentation in that
> script is bad and inconsistent, but changing it only makes the patch,
> and the file history, harder to read.

OK.


> >    my ($file, $addr) = @_;
> > -  return unless i2c_smbus_read_byte_data($file, 0x3E) = 0x55
> > +  return unless i2c_smbus_read_byte_data($file, 0x3E) = 0x5C
> >             and (i2c_smbus_read_byte_data($file, 0x3F) & 0xF8) = 0x88
> > -           and (i2c_smbus_read_byte_data($file, 0x40) & 0xC4) = 0x04
> > -           and (i2c_smbus_read_byte_data($file, 0x42) & 0x02) = 0x00
> > -           and (i2c_smbus_read_byte_data($file, 0x43) & 0xC0) = 0x00;
> > +           and (i2c_smbus_read_byte_data($file, 0x73) & 0x0F) = 0x09
> > +           and (i2c_smbus_read_byte_data($file, 0x8A) & 0x7F) = 0x4D;
> >    return ($addr = 0x2e ? 6 : 5);
> >  }
> >
>
> If you change the registers that are used for detection, please update
> the comment before the function accordingly.

Oh yes, missed that one.


> > +  for (i = 0; i < 3; i++) {
> > +    print_dme1737_temp(name, i+1);
> > +  }
>
> Why don't you just do "for (i = 1; i <= 3; i++)"? That would be
> clearer, and more efficient.
>
> > +
> > +  for (i = 0; i < 6; i++) {
> > +    print_dme1737_fan(name, i+1);
> > +  }
> > +
> > +  for (i = 0; i < 6; i++) {
> > +    if (i = 3)
> > +      continue;
> > +    print_dme1737_pwm(name, i+1);
> > +  }
>
> Same for fan and pwm.

Sure.

Thanks for the review.

...juerg



> Thanks,
> --
> Jean Delvare
>


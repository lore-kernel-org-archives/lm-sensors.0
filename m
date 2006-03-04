From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 04 Mar 2006 16:57:23 +0000
Subject: [lm-sensors] [PATCH] Add voltage support to W83627EHF
Message-Id: <20060304175723.d845d809.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4409700D.8010604@sh.cvut.cz>
In-Reply-To: <4409700D.8010604@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Rudolf,

> I'm attaching the userspace part this should work applying on the top of the
> latest version of lm-sensors.

My comments:

> +    { SENSORS_W83627EHF_IN0_ALARM, "in0_alarm", NOMAP, NOMAP, 
> +                        R, NOSYSCTL, VALUE(1), 0 },

Now that we have individual alarm files, it would make sense to express
their mapping with the corresponding input. That is, the first "NOMAP"
above should be "SENSORS_W83627EHF_IN0".

> +#define SENSORS_W83627EHF_IN0 1 /* R */
> (...)
> +#define SENSORS_W83627EHF_IN9_MAX 30 /* RW */

Please align the values with tabs, like I did for the rest of the
W83627EHF defines.

> +  double cur, min, div, max, alarm;

If you want to give function scope to these variables, please do it
properly (i.e. also use them for temperature.)

> +    if (!sensors_get_label_and_valid(*name,SENSORS_W83627EHF_IN0+i,&label,&valid) &&
> +      !sensors_get_feature(*name,SENSORS_W83627EHF_IN0+i,&cur) &&
> +      !sensors_get_feature(*name,SENSORS_W83627EHF_IN0_MIN+i,&min) &&
> +      !sensors_get_feature(*name,SENSORS_W83627EHF_IN0_MAX+i,&max) &&
> +      !sensors_get_feature(*name,SENSORS_W83627EHF_IN0_ALARM+i,&alarm)) {
> +      if (valid) {
> +        print_label(label,10);
> +        printf("%+6.2f V  (min = %+6.2f V, max = %+6.2f V) %s\n",
> +               cur,min,max,alarm ? "ALARM" : "");
> +      }
> +    } else
> +    printf("ERROR: Can't get IN%d data!\n",i+1);
> +    free(label);
> +  }

Coding style, please! I know that sensors' coding style is quite bad,
but let's not make it worse. Just follow the coding style I used for
the rest of the function, so that we have some kind of local
homogeneity.

> -    double cur, min, div;
> +    

No blank line here please.

>  # Winbond W83627EHF configuration originally contributed by Leon Moonen
>  # This is for an Asus P5P800.
>  chip "w83627ehf-*"

This will need some rewording as you have a different board so the
voltage part may not match the P5P800 at all.

> +    label in0 "VCore"
> +    label in1 "VIN0"
> +    label in2 "AVCC"
> +    label in3 "3VCC"
> +    label in4 "VIN1"
> +    label in5 "VIN2"
> +    label in6 "VIN3"
> +    label in7 "VSB"
> +    label in8 "VBAT"
> +    label in9 "VIN4"

The VIN[0-4] labels are not helping much, and may in fact add to
confusion, as they don't match our in0-9 numbering.

> +# +12V is in1 and +5V is in6 as recommended by datasheet 
> +    compute in1 @*(1+(56/10)),  @/(1+(56/10))
> +    compute in6 @*(1+(22/10)),  @/(1+(22/10))

Just label them that way then.

> -   set fan1_min    1200
> -   set fan2_min    1700
> +  set fan1_min    1200
> +  set fan2_min    1700

No whitespace changes please.

> +   label temp3     "AUX Temp"

s/AUX/Aux/ for consistency.

> -   set temp1_over  45
> -   set temp1_hyst  40
> -   set temp2_over  45
> -   set temp2_hyst  40
> +#  set temp1_over  45
> +#  set temp1_hyst  40
> +#  set temp2_over  45
> +#  set temp2_hyst  40

Yes you're right, we should preserve the BIOS settings by default.

Thanks,
-- 
Jean Delvare


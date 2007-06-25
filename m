From: Christian Emmerich <christian_emmerich@yahoo.de>
Date: Mon, 25 Jun 2007 05:19:33 +0000
Subject: Re: [lm-sensors] Help needed for implementing&testing Fintek F75375
Message-Id: <963399.77609.qm@web25113.mail.ukl.yahoo.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="0-1761500654-1182748773=:77609"
List-Id: <lm-sensors.vger.kernel.org>
References: <5327.79319.qm@web25109.mail.ukl.yahoo.com>
In-Reply-To: <5327.79319.qm@web25109.mail.ukl.yahoo.com>
To: lm-sensors@vger.kernel.org

--0-1761500654-1182748773=:77609
Content-Type: multipart/alternative; boundary="0-1942744997-1182748773=:77609"

--0-1942744997-1182748773=:77609
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Jean,

The first version of this message was to large and was rejected, so i had t=
o cut the quote a little bit.

> Did pwmconfig work?
I get it working now, i just have to set FCTEMPS and FCFANS correct in /etc=
/fancontrol now it work.
The only problem is, that if i stop fancontrol, the program set pwm1_enable=
 to 0, but
after this the fan turns at 23rpm. This also happens if i set pwm1_enable t=
o 0 by hand.


> sensors output looks like:
> mythtv@pc:~$ sensors F75373-*
> F75373-i2c-1-2d
> Adapter: SMBus nForce2 adapter at 5100
> :
> CPU PWM:    31      (enable =3D 1)
>
> Did you try setting limits?
I try to set limits in sensors.conf but i could see no change.


> That's not correct, you should have "in0", "in1"... etc. here, not
> "in0_input", "in1_input" etc? The fan and temperature symbols below are
> correct.

> Also, these compute lines don't make sense. The second formula is
> supposed to be the reserve of the first formula, that's not the case
> here.

> Lastly, you really shouldn't have to divide the values by 1000. This
> suggests that the magnitude wasn't set properly in libsensors (it
> should be 3, I suggest it is 0). This issue is most probably related to
> the incorrect symbol names.

I saw values >800V so i thought i have to divide it by 1000 in sensors.conf.
Magnitude is 3 and the symbol name is correct now, but the values are still=
 over 800V. What's the reason?


> This means that the driver isn't reporting the values in RPM as it
> should. Usually no compute statement is needed for fans.
That's correct, the value is not in RPM, in the document '2005111153128.pdf=
' you can download on the fintek page
( http://www.fintek.com.tw/eng/products.asp?BID=3D4&SID=3D5 )its written on=
 page 8:
"Determine the fan counter according to:
Count =3D (1.5=D710^6) / RPM "
That means that the driver is reporting the count value, not the rpm.
So i have to compute in sensors.conf:
RPM =3D (1.5=D710^6)/ Count


> > +#define SENSORS_F75373_IN_FEATURES(nr) \
> > +        { { SENSORS_F75373_IN(nr), "in" #nr "_input", \
> > +                NOMAP, NOMAP, R }, \
> > +                NOSYSCTL, VALUE(3), 3 }, \
>
> OK, the problem is here: This should be"in" #nr, not "in" #nr
> "_input". This will fix your magnitude problem.
I changed it to "in" #nr, \


> +        { { SENSORS_F75373_IN_MIN(nr), "in" #nr "_min", \
> +                SENSORS_F75373_IN(nr), SENSORS_F75373_IN(nr), RW },
 \
> +                NOSYSCTL, VALUE(2), 3 }, \
>
> VALUE(1) (although it won't make a difference for a Linux 2.6 only
> driver.
VALUE(2) changed to VALUE(1)


> +        { { SENSORS_F75373_IN_MAX(nr), "in" #nr "_max", \
> +                SENSORS_F75373_IN(nr), SENSORS_F75373_IN(nr), RW },
> :
> +                NOSYSCTL, VALUE(1), 3 }, \
> +        { { SENSORS_F75373_TEMP_HYST(nr), "temp" #nr "_hyst", \
> +                SENSORS_F75373_TEMP(nr), NOMAP, R }, \
> +                NOSYSCTL, VALUE(1), 0 }

> SENSORS_F75373_TEMP(nr) instead of NOMAP, VALUE(2) instead of VALUE(1),
> and magnitude 3 instead of 0. Is it really read-only?
>
> (Unless this isn't an hysteresis temperature at all - see below.)
I changed it. It is not only read-only, i changed it to RW.


> +
> +#define SENSORS_F75373_FAN_FEATURES(nr) \
> +        { { SENSORS_F75373_FAN(nr), "fan" #nr, \
> +                NOMAP, NOMAP, R }, \
> +                NOSYSCTL, VALUE(2), 0 }, \
> +        { { SENSORS_F75373_FAN_MAX(nr), "fan" #nr "_max", \
> +                SENSORS_F75373_FAN(nr), SENSORS_F75373_FAN(nr), RW
 }, \
> +                NOSYSCTL, VALUE(1), 0 }, \
>
> Strange, I've never seen a fan speed sensor with a high limit. What
> does it correspond to exactly? Why don't you display this value in
> "sensors"?
I get the information out of the documentation on page 26:
"When power on, the PWMOUT1 will output full duty cycle (FFh) to
enable system FAN. After 10 seconds when detecting FANIN1
signal, assuming the fan has been fully turned on, the fan speed
count detected will be recorded in the register.".
Dunno if it should be removed?


> +        { { SENSORS_F75373_FAN_MIN(nr), "fan" #nr "_min", \
> +                SENSORS_F75373_FAN(nr), NOMAP, R }, \
> +                NOSYSCTL, VALUE(1), 0 }
>
> SENSORS_F75373_FAN(nr) instead of NOMAP.
>
> Is it really read-only?
I changed it to SENSORS_F75373_FAN(nr), it is RW.
But fanX_min is allways zero, so it lead to an error on calling
'sensors_get_feature(*name, SENSORS_F75373_FAN_MIN(i), &min)',
i have to disable it, sensors output is now
CPU Fan:  1866 RPM  (min =3D    0 RPM)
to
CPU Fan:  1866 RPM


> +
> +#define SENSORS_F75373_PWM_FEATURES(nr) \
> +        { { SENSORS_F75373_PWM(nr), "pwm" #nr, \
> +                NOMAP, NOMAP, RW }, \
> +                NOSYSCTL, VALUE(1), 0 }, \
> +        { { SENSORS_F75373_PWM_ENABLE(nr), "pwm" #nr "_enable", \
> +                SENSORS_F75373_PWM(nr), SENSORS_F75373_PWM(nr), RW
 }, \
> +                NOSYSCTL, VALUE(3), 0 }
>
> In fact we don't include PWM stuff in libsensors. They are not sensors,
> and are better handled using pwmconfig and fancontrol.
I only copied it from SENSORS_DME1737_PWM_FEATURES, should i remove it?


> +
> +static sensors_chip_feature f75373_features[] =3D
> :
> +#define SENSORS_F75373_PREFIX "f75373"
> +
> +// voltage n from 0 to 3
>
> No C++-style comments please. Use /* */.
I used now /**/.


> +#define SENSORS_F75373_IN(nr)           (0x10 + (nr))
> +#define SENSORS_F75373_IN_MAX(nr)       (0x20 + (nr) * 2 )
> +#define SENSORS_F75373_IN_MIN(nr)       (0x21 + (nr) * 2 )
>
> Coding style: no space before closing parenthesis.
I changed it.


> +
> +// temp n from 0 to 1
> +#define SENSORS_F75373_TEMP(nr)         (0x14 + (nr))
> :
> +#define SENSORS_F75373_PWM_ENABLE(nr)   (0x7D + (nr) * 0x10 )
> +
>
> I hope that you realize that these numbers do NOT have to match the
> register numbers in the chip? These numbers are completely arbitrary.
> So please make them as simple as possible.
No :-), i changed it.


>  #endif /* def LIB_SENSORS_CHIPS_H */
> diff -urN lm-sensors_org/prog/sensors/chips.c
 lm-sensors/prog/sensors/chips.c
> --- lm-sensors_org/prog/sensors/chips.c    2007-06-17 15:34:33.000000000
 +0200
> +++ lm-sensors/prog/sensors/chips.c    2007-06-17 16:29:50.000000000
 +0200
> @@ -6131,6 +6131,114 @@
>      }
>  }
> =20
> +static void print_f75373_in(const sensors_chip_name *name, int i)
> :
> +      printf("%+6.2f V  (min =3D %+6.2f V, max =3D %+6.2f V)  \n",
> +             cur, min, max);
>
> If you don't have any alarm flag to display, you can remove the spaces
> before the newline.
I changed it.


> +    }
> +  } else {
> +    printf("ERROR: Can't get in%d data!\n", i);
> :
> +      !sensors_get_feature(*name, SENSORS_F75373_TEMP_HYST(i),
 &alarm)
> +      ) {
>
> Coding style: move this at the end of the previous line.
I changed it.

> +    if (valid) {
> +      print_label(label, 10);
> +      print_temp_info(cur, max, 0, HYST , 0, 0);
> +      printf("%s\n", alarm ? "ALARM" : "");
> +    }
>
> This doesn't make sense. What is SENSORS_F75373_TEMP_HYST exactly? Why
> do you display it as an alarm?
It was a mistake, i deleted the Alarm output, now it is only printf("\n"),
there seems not to be a value for an alarm.
temp1_max_hyst is always zero, i don't now what it is exactly and
when it is not zero.


> +  } else {
> +    printf("ERROR: Can't get temp%d data!\n", i);
> :
> +                                   &valid) &&
> +      !sensors_get_feature(*name, SENSORS_F75373_FAN(i), &cur) &&
> +      !sensors_get_feature(*name, SENSORS_F75373_FAN_MIN(i), &min)
> +     ){
>
> Coding style: move this at the end of the previous line.
I changed it.


> +    if (valid) {
> +      print_label(label, 10);
> +      printf("%4.0f RPM  (min =3D %4.0f RPM)\n",
> +             cur, min);
> :
> +  int i;
> +
> +  for (i =3D 0; i < 4; i++) {
> +    print_f75373_in(name, i);
> +  }
> +
> +  for (i =3D 1; i < 3; i++) {
>
> I'd suggest writing it i <=3D 2, to make it more visible that there are 2
> temperature inputs, not 3. Same below for fans.
I changed it.


> +    print_f75373_temp(name, i);
> +  }
> +
> :
> @@ -424,6 +424,7 @@
>       { "coretemp", print_coretemp },
>       { "dme1737", print_dme1737 },
>      { "applesmc", print_applesmc },
> +    { "F75373", print_f75373 },
>
> Should be "f75373", no capital. I'm even surprised it worked with the
> capital.
If i use f75373 i get following output:
F75373-i2c-1-2d
Adapter: SMBus nForce2 adapter at 5100
VCC: 1720.00 (in0)
  in0_min: 0.00 (in0_min)
  in0_max: 0.00 (in0_max)
V1: 1336.00 (in1)
  in1_min: 0.00 (in1_min)
  in1_max: 0.00 (in1_max)
V2: 1008.00 (in2)
  in2_min: 0.00 (in2_min)
  in2_max: 0.00 (in2_max)
V3: 792.00 (in3)
  in3_min: 0.00 (in3_min)
  in3_max: 0.00 (in3_max)
CPU Temp: 49.00 (temp1)
  temp1_max: 0.00 (temp1_max)
  temp1_hyst: 0.00 (temp1_hyst)
Sys Temp: 46.00 (temp2)
  temp2_max: 0.00 (temp2_max)
  temp2_hyst: 0.00 (temp2_hyst)
CPU Fan: 1787.84 (fan1)
  fan1_max: 5681.82 (fan1_max)
ERROR: Can't get feature `fan1_min' data!
CPU PWM: 31.00 (pwm1)
What's the reason? Did I still have to use "F75373"?


> Please update your patch and resend it.
>
> Also, what about the F75375 support? As far as I know the f75375s
>  driver
> supports both chips, so it'd be nice to have user-space support for
> both. Also, it might be less confusing to use F75375 for all the
> libsensors defines, rather than F75373, so that they match the driver
> name.
I changed every define/function from F75373 to F75375, i added also:
#define SENSORS_F75373_PREFIX "f75373"
#define SENSORS_F75375_PREFIX "f75375"
and
{ SENSORS_F75375_PREFIX, f75375_features },
{ SENSORS_F75373_PREFIX, f75375_features },
and
{ "F75375", print_f75375 },
{ "F75373", print_f75375 },
i hope that this is ok.


>
> Thanks,
> --
> Jean Delvare
Thank you for your review,
christian.
 	=09
---------------------------------
Was ist Gl=FCck? Schlafen Fische =FCberhaupt? Die Antworten gibt=92s auf Ya=
hoo! Clever.
--0-1942744997-1182748773=:77609
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<span style=3D"font-family: courier;">Hi Jean,</span><br style=3D"font-fami=
ly: courier;"><br style=3D"font-family: courier;"><span style=3D"font-famil=
y: courier;">The first version of this message was to large and was rejecte=
d, so i had to cut the quote a little bit.</span><br style=3D"font-family: =
courier;"><br style=3D"font-family: courier;"><span style=3D"font-family: c=
ourier;">&gt; Did pwmconfig work?</span><br style=3D"font-family: courier;"=
><span style=3D"font-family: courier;">I get it working now, i just have to=
 set FCTEMPS and FCFANS correct in /etc/fancontrol now it work.</span><br s=
tyle=3D"font-family: courier;"><span style=3D"font-family: courier;">The on=
ly problem is, that if i stop fancontrol, the program set pwm1_enable to 0,=
 but</span><br style=3D"font-family: courier;"><span style=3D"font-family: =
courier;">after this the fan turns at 23rpm. This also happens if i set pwm=
1_enable to 0 by hand.</span><br style=3D"font-family: courier;"><br style=
=3D"font-family: courier;"><br
 style=3D"font-family: courier;"><span style=3D"font-family: courier;">&gt;=
 sensors output looks like:</span><br style=3D"font-family: courier;"><span=
 style=3D"font-family: courier;">&gt; mythtv@pc:~$ sensors F75373-*</span><=
br style=3D"font-family: courier;"><span style=3D"font-family: courier;">&g=
t; F75373-i2c-1-2d</span><br style=3D"font-family: courier;"><span style=3D=
"font-family: courier;">&gt; Adapter: SMBus nForce2 adapter at 5100</span><=
br style=3D"font-family: courier;"><span style=3D"font-family: courier;">&g=
t; :</span><br style=3D"font-family: courier;"><span style=3D"font-family: =
courier;">&gt; CPU PWM:&nbsp;&nbsp;&nbsp; 31&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
(enable =3D 1)</span><br style=3D"font-family: courier;"><span style=3D"fon=
t-family: courier;">&gt;</span><br style=3D"font-family: courier;"><span st=
yle=3D"font-family: courier;">&gt; Did you try setting limits?</span><br st=
yle=3D"font-family: courier;"><span style=3D"font-family: courier;">I try t=
o set limits in sensors.conf but i could see no
 change.</span><br style=3D"font-family: courier;"><br style=3D"font-family=
: courier;"><br style=3D"font-family: courier;"><span style=3D"font-family:=
 courier;">&gt; That's not correct, you should have "in0", "in1"... etc. he=
re, not</span><br style=3D"font-family: courier;"><span style=3D"font-famil=
y: courier;">&gt; "in0_input", "in1_input" etc? The fan and temperature sym=
bols below are</span><br style=3D"font-family: courier;"><span style=3D"fon=
t-family: courier;">&gt; correct.</span><br style=3D"font-family: courier;"=
><br style=3D"font-family: courier;"><span style=3D"font-family: courier;">=
&gt; Also, these compute lines don't make sense. The second formula is</spa=
n><br style=3D"font-family: courier;"><span style=3D"font-family: courier;"=
>&gt; supposed to be the reserve of the first formula, that's not the case<=
/span><br style=3D"font-family: courier;"><span style=3D"font-family: couri=
er;">&gt; here.</span><br style=3D"font-family: courier;"><br style=3D"font=
-family: courier;"><span style=3D"font-family:
 courier;">&gt; Lastly, you really shouldn't have to divide the values by 1=
000. This</span><br style=3D"font-family: courier;"><span style=3D"font-fam=
ily: courier;">&gt; suggests that the magnitude wasn't set properly in libs=
ensors (it</span><br style=3D"font-family: courier;"><span style=3D"font-fa=
mily: courier;">&gt; should be 3, I suggest it is 0). This issue is most pr=
obably related to</span><br style=3D"font-family: courier;"><span style=3D"=
font-family: courier;">&gt; the incorrect symbol names.</span><br style=3D"=
font-family: courier;"><br style=3D"font-family: courier;"><span style=3D"f=
ont-family: courier;">I saw values &gt;800V so i thought i have to divide i=
t by 1000 in sensors.conf.</span><br style=3D"font-family: courier;"><span =
style=3D"font-family: courier;">Magnitude is 3 and the symbol name is corre=
ct now, but the values are still over 800V. What's the reason?</span><br st=
yle=3D"font-family: courier;"><br style=3D"font-family: courier;"><br style=
=3D"font-family: courier;"><span
 style=3D"font-family: courier;">&gt; This means that the driver isn't repo=
rting the values in RPM as it</span><br style=3D"font-family: courier;"><sp=
an style=3D"font-family: courier;">&gt; should. Usually no compute statemen=
t is needed for fans.</span><br style=3D"font-family: courier;"><span style=
=3D"font-family: courier;">That's correct, the value is not in RPM, in the =
document '2005111153128.pdf' you can download on the fintek page</span><br =
style=3D"font-family: courier;"><span style=3D"font-family: courier;">( htt=
p://www.fintek.com.tw/eng/products.asp?BID=3D4&amp;SID=3D5 )its written on =
page 8:</span><br style=3D"font-family: courier;"><span style=3D"font-famil=
y: courier;">"Determine the fan counter according to:</span><br style=3D"fo=
nt-family: courier;"><span style=3D"font-family: courier;">Count =3D (1.5=
=D710^6) / RPM "</span><br style=3D"font-family: courier;"><span style=3D"f=
ont-family: courier;">That means that the driver is reporting the count val=
ue, not the rpm.</span><br style=3D"font-family:
 courier;"><span style=3D"font-family: courier;">So i have to compute in se=
nsors.conf:</span><br style=3D"font-family: courier;"><span style=3D"font-f=
amily: courier;">RPM =3D (1.5=D710^6)/ Count</span><br style=3D"font-family=
: courier;"><br style=3D"font-family: courier;"><br style=3D"font-family: c=
ourier;"><span style=3D"font-family: courier;">&gt; &gt; +#define SENSORS_F=
75373_IN_FEATURES(nr) \</span><br style=3D"font-family: courier;"><span sty=
le=3D"font-family: courier;">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; { { SENSORS_F75373_IN(nr), "in" #nr "_input", \</span><br style=3D"=
font-family: courier;"><span style=3D"font-family: courier;">&gt; &gt; +&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; NOMAP, NOMAP, R }, \</span><br style=3D"font-family: courier;"=
><span style=3D"font-family: courier;">&gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NOSYSCTL,=
 VALUE(3), 3 }, \</span><br
 style=3D"font-family: courier;"><span style=3D"font-family: courier;">&gt;=
</span><br style=3D"font-family: courier;"><span style=3D"font-family: cour=
ier;">&gt; OK, the problem is here: This should be"in" #nr, not "in" #nr</s=
pan><br style=3D"font-family: courier;"><span style=3D"font-family: courier=
;">&gt; "_input". This will fix your magnitude problem.</span><br style=3D"=
font-family: courier;"><span style=3D"font-family: courier;">I changed it t=
o "in" #nr, \</span><br style=3D"font-family: courier;"><br style=3D"font-f=
amily: courier;"><br style=3D"font-family: courier;"><span style=3D"font-fa=
mily: courier;">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { { SENSOR=
S_F75373_IN_MIN(nr), "in" #nr "_min", \</span><br style=3D"font-family: cou=
rier;"><span style=3D"font-family: courier;">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SENSORS_=
F75373_IN(nr), SENSORS_F75373_IN(nr), RW },</span><br style=3D"font-family:=
 courier;"><span style=3D"font-family:
 courier;">&nbsp;\</span><br style=3D"font-family: courier;"><span style=3D=
"font-family: courier;">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NOSYSCTL, VALUE(2), 3 }, \</s=
pan><br style=3D"font-family: courier;"><span style=3D"font-family: courier=
;">&gt;</span><br style=3D"font-family: courier;"><span style=3D"font-famil=
y: courier;">&gt; VALUE(1) (although it won't make a difference for a Linux=
 2.6 only</span><br style=3D"font-family: courier;"><span style=3D"font-fam=
ily: courier;">&gt; driver.</span><br style=3D"font-family: courier;"><span=
 style=3D"font-family: courier;">VALUE(2) changed to VALUE(1)</span><br sty=
le=3D"font-family: courier;"><br style=3D"font-family: courier;"><br style=
=3D"font-family: courier;"><span style=3D"font-family: courier;">&gt; +&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { { SENSORS_F75373_IN_MAX(nr), "in" =
#nr "_max", \</span><br style=3D"font-family: courier;"><span style=3D"font=
-family: courier;">&gt;
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; SENSORS_F75373_IN(nr), SENSORS_F75373_IN(nr), RW },</span=
><br style=3D"font-family: courier;"><span style=3D"font-family: courier;">=
&gt; :</span><br style=3D"font-family: courier;"><span style=3D"font-family=
: courier;">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NOSYSCTL, VALUE(1), 3 }, \</span><br styl=
e=3D"font-family: courier;"><span style=3D"font-family: courier;">&gt; +&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { { SENSORS_F75373_TEMP_HYST(nr), "=
temp" #nr "_hyst", \</span><br style=3D"font-family: courier;"><span style=
=3D"font-family: courier;">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SENSORS_F75373_TEMP(nr), N=
OMAP, R }, \</span><br style=3D"font-family: courier;"><span style=3D"font-=
family: courier;">&gt;
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; NOSYSCTL, VALUE(1), 0 }</span><br style=3D"font-family: c=
ourier;"><br style=3D"font-family: courier;"><span style=3D"font-family: co=
urier;">&gt; SENSORS_F75373_TEMP(nr) instead of NOMAP, VALUE(2) instead of =
VALUE(1),</span><br style=3D"font-family: courier;"><span style=3D"font-fam=
ily: courier;">&gt; and magnitude 3 instead of 0. Is it really read-only?</=
span><br style=3D"font-family: courier;"><span style=3D"font-family: courie=
r;">&gt;</span><br style=3D"font-family: courier;"><span style=3D"font-fami=
ly: courier;">&gt; (Unless this isn't an hysteresis temperature at all - se=
e below.)</span><br style=3D"font-family: courier;"><span style=3D"font-fam=
ily: courier;">I changed it. It is not only read-only, i changed it to RW.<=
/span><br style=3D"font-family: courier;"><br style=3D"font-family: courier=
;"><br style=3D"font-family: courier;"><span style=3D"font-family: courier;=
">&gt; +</span><br style=3D"font-family:
 courier;"><span style=3D"font-family: courier;">&gt; +#define SENSORS_F753=
73_FAN_FEATURES(nr) \</span><br style=3D"font-family: courier;"><span style=
=3D"font-family: courier;">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 { { SENSORS_F75373_FAN(nr), "fan" #nr, \</span><br style=3D"font-family: c=
ourier;"><span style=3D"font-family: courier;">&gt; +&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NOMAP,=
 NOMAP, R }, \</span><br style=3D"font-family: courier;"><span style=3D"fon=
t-family: courier;">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NOSYSCTL, VALUE(2), 0 }, \</span>=
<br style=3D"font-family: courier;"><span style=3D"font-family: courier;">&=
gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { { SENSORS_F75373_FAN_MAX(=
nr), "fan" #nr "_max", \</span><br style=3D"font-family: courier;"><span st=
yle=3D"font-family: courier;">&gt;
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; SENSORS_F75373_FAN(nr), SENSORS_F75373_FAN(nr), RW</span>=
<br style=3D"font-family: courier;"><span style=3D"font-family: courier;">&=
nbsp;}, \</span><br style=3D"font-family: courier;"><span style=3D"font-fam=
ily: courier;">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NOSYSCTL, VALUE(1), 0 }, \</span><br s=
tyle=3D"font-family: courier;"><span style=3D"font-family: courier;">&gt;</=
span><br style=3D"font-family: courier;"><span style=3D"font-family: courie=
r;">&gt; Strange, I've never seen a fan speed sensor with a high limit. Wha=
t</span><br style=3D"font-family: courier;"><span style=3D"font-family: cou=
rier;">&gt; does it correspond to exactly? Why don't you display this value=
 in</span><br style=3D"font-family: courier;"><span style=3D"font-family: c=
ourier;">&gt; "sensors"?</span><br style=3D"font-family: courier;"><span st=
yle=3D"font-family: courier;">I get the
 information out of the documentation on page 26:</span><br style=3D"font-f=
amily: courier;"><span style=3D"font-family: courier;">"When power on, the =
PWMOUT1 will output full duty cycle (FFh) to</span><br style=3D"font-family=
: courier;"><span style=3D"font-family: courier;">enable system FAN. After =
10 seconds when detecting FANIN1</span><br style=3D"font-family: courier;">=
<span style=3D"font-family: courier;">signal, assuming the fan has been ful=
ly turned on, the fan speed</span><br style=3D"font-family: courier;"><span=
 style=3D"font-family: courier;">count detected will be recorded in the reg=
ister.".</span><br style=3D"font-family: courier;"><span style=3D"font-fami=
ly: courier;">Dunno if it should be removed?</span><br style=3D"font-family=
: courier;"><br style=3D"font-family: courier;"><br style=3D"font-family: c=
ourier;"><span style=3D"font-family: courier;">&gt; +&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; { { SENSORS_F75373_FAN_MIN(nr), "fan" #nr "_min", \</s=
pan><br style=3D"font-family:
 courier;"><span style=3D"font-family: courier;">&gt; +&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SENS=
ORS_F75373_FAN(nr), NOMAP, R }, \</span><br style=3D"font-family: courier;"=
><span style=3D"font-family: courier;">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NOSYSCTL, VALU=
E(1), 0 }</span><br style=3D"font-family: courier;"><span style=3D"font-fam=
ily: courier;">&gt;</span><br style=3D"font-family: courier;"><span style=
=3D"font-family: courier;">&gt; SENSORS_F75373_FAN(nr) instead of NOMAP.</s=
pan><br style=3D"font-family: courier;"><span style=3D"font-family: courier=
;">&gt;</span><br style=3D"font-family: courier;"><span style=3D"font-famil=
y: courier;">&gt; Is it really read-only?</span><br style=3D"font-family: c=
ourier;"><span style=3D"font-family: courier;">I changed it to SENSORS_F753=
73_FAN(nr), it is RW.</span><br style=3D"font-family: courier;"><span style=
=3D"font-family: courier;">But fanX_min is
 allways zero, so it lead to an error on calling</span><br style=3D"font-fa=
mily: courier;"><span style=3D"font-family: courier;">'sensors_get_feature(=
*name, SENSORS_F75373_FAN_MIN(i), &amp;min)',</span><br style=3D"font-famil=
y: courier;"><span style=3D"font-family: courier;">i have to disable it, se=
nsors output is now</span><br style=3D"font-family: courier;"><span style=
=3D"font-family: courier;">CPU Fan:&nbsp; 1866 RPM&nbsp; (min =3D&nbsp;&nbs=
p;&nbsp; 0 RPM)</span><br style=3D"font-family: courier;"><span style=3D"fo=
nt-family: courier;">to</span><br style=3D"font-family: courier;"><span sty=
le=3D"font-family: courier;">CPU Fan:&nbsp; 1866 RPM</span><br style=3D"fon=
t-family: courier;"><br style=3D"font-family: courier;"><br style=3D"font-f=
amily: courier;"><span style=3D"font-family: courier;">&gt; +</span><br sty=
le=3D"font-family: courier;"><span style=3D"font-family: courier;">&gt; +#d=
efine SENSORS_F75373_PWM_FEATURES(nr) \</span><br style=3D"font-family: cou=
rier;"><span style=3D"font-family: courier;">&gt;
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { { SENSORS_F75373_PWM(nr), "p=
wm" #nr, \</span><br style=3D"font-family: courier;"><span style=3D"font-fa=
mily: courier;">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NOMAP, NOMAP, RW }, \</span><br style=
=3D"font-family: courier;"><span style=3D"font-family: courier;">&gt; +&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp; NOSYSCTL, VALUE(1), 0 }, \</span><br style=3D"font-family: cour=
ier;"><span style=3D"font-family: courier;">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; { { SENSORS_F75373_PWM_ENABLE(nr), "pwm" #nr "_enable", \=
</span><br style=3D"font-family: courier;"><span style=3D"font-family: cour=
ier;">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; SENSORS_F75373_PWM(nr), SENSORS_F75373_PWM(nr),=
 RW</span><br style=3D"font-family: courier;"><span style=3D"font-family: c=
ourier;">&nbsp;}, \</span><br
 style=3D"font-family: courier;"><span style=3D"font-family: courier;">&gt;=
 +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; NOSYSCTL, VALUE(3), 0 }</span><br style=3D"font-family: c=
ourier;"><span style=3D"font-family: courier;">&gt;</span><br style=3D"font=
-family: courier;"><span style=3D"font-family: courier;">&gt; In fact we do=
n't include PWM stuff in libsensors. They are not sensors,</span><br style=
=3D"font-family: courier;"><span style=3D"font-family: courier;">&gt; and a=
re better handled using pwmconfig and fancontrol.</span><br style=3D"font-f=
amily: courier;"><span style=3D"font-family: courier;">I only copied it fro=
m SENSORS_DME1737_PWM_FEATURES, should i remove it?</span><br style=3D"font=
-family: courier;"><br style=3D"font-family: courier;"><br style=3D"font-fa=
mily: courier;"><span style=3D"font-family: courier;">&gt; +</span><br styl=
e=3D"font-family: courier;"><span style=3D"font-family: courier;">&gt; +sta=
tic sensors_chip_feature f75373_features[]
 =3D</span><br style=3D"font-family: courier;"><span style=3D"font-family: =
courier;">&gt; :</span><br style=3D"font-family: courier;"><span style=3D"f=
ont-family: courier;">&gt; +#define SENSORS_F75373_PREFIX "f75373"</span><b=
r style=3D"font-family: courier;"><span style=3D"font-family: courier;">&gt=
; +</span><br style=3D"font-family: courier;"><span style=3D"font-family: c=
ourier;">&gt; +// voltage n from 0 to 3</span><br style=3D"font-family: cou=
rier;"><span style=3D"font-family: courier;">&gt;</span><br style=3D"font-f=
amily: courier;"><span style=3D"font-family: courier;">&gt; No C++-style co=
mments please. Use /* */.</span><br style=3D"font-family: courier;"><span s=
tyle=3D"font-family: courier;">I used now /**/.</span><br style=3D"font-fam=
ily: courier;"><br style=3D"font-family: courier;"><br style=3D"font-family=
: courier;"><span style=3D"font-family: courier;">&gt; +#define SENSORS_F75=
373_IN(nr)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0x1=
0 + (nr))</span><br style=3D"font-family:
 courier;"><span style=3D"font-family: courier;">&gt; +#define SENSORS_F753=
73_IN_MAX(nr)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0x20 + (nr) * 2 )</span>=
<br style=3D"font-family: courier;"><span style=3D"font-family: courier;">&=
gt; +#define SENSORS_F75373_IN_MIN(nr)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
(0x21 + (nr) * 2 )</span><br style=3D"font-family: courier;"><span style=3D=
"font-family: courier;">&gt;</span><br style=3D"font-family: courier;"><spa=
n style=3D"font-family: courier;">&gt; Coding style: no space before closin=
g parenthesis.</span><br style=3D"font-family: courier;"><span style=3D"fon=
t-family: courier;">I changed it.</span><br style=3D"font-family: courier;"=
><br style=3D"font-family: courier;"><br style=3D"font-family: courier;"><s=
pan style=3D"font-family: courier;">&gt; +</span><br style=3D"font-family: =
courier;"><span style=3D"font-family: courier;">&gt; +// temp n from 0 to 1=
</span><br style=3D"font-family: courier;"><span style=3D"font-family: cour=
ier;">&gt; +#define
 SENSORS_F75373_TEMP(nr)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; (0=
x14 + (nr))</span><br style=3D"font-family: courier;"><span style=3D"font-f=
amily: courier;">&gt; :</span><br style=3D"font-family: courier;"><span sty=
le=3D"font-family: courier;">&gt; +#define SENSORS_F75373_PWM_ENABLE(nr)&nb=
sp;&nbsp; (0x7D + (nr) * 0x10 )</span><br style=3D"font-family: courier;"><=
span style=3D"font-family: courier;">&gt; +</span><br style=3D"font-family:=
 courier;"><span style=3D"font-family: courier;">&gt;</span><br style=3D"fo=
nt-family: courier;"><span style=3D"font-family: courier;">&gt; I hope that=
 you realize that these numbers do NOT have to match the</span><br style=3D=
"font-family: courier;"><span style=3D"font-family: courier;">&gt; register=
 numbers in the chip? These numbers are completely arbitrary.</span><br sty=
le=3D"font-family: courier;"><span style=3D"font-family: courier;">&gt; So =
please make them as simple as possible.</span><br style=3D"font-family: cou=
rier;"><span style=3D"font-family:
 courier;">No :-), i changed it.</span><br style=3D"font-family: courier;">=
<br style=3D"font-family: courier;"><br style=3D"font-family: courier;"><sp=
an style=3D"font-family: courier;">&gt;&nbsp; #endif /* def LIB_SENSORS_CHI=
PS_H */</span><br style=3D"font-family: courier;"><span style=3D"font-famil=
y: courier;">&gt; diff -urN lm-sensors_org/prog/sensors/chips.c</span><br s=
tyle=3D"font-family: courier;"><span style=3D"font-family: courier;">&nbsp;=
lm-sensors/prog/sensors/chips.c</span><br style=3D"font-family: courier;"><=
span style=3D"font-family: courier;">&gt; --- lm-sensors_org/prog/sensors/c=
hips.c&nbsp;&nbsp;&nbsp; 2007-06-17 15:34:33.000000000</span><br style=3D"f=
ont-family: courier;"><span style=3D"font-family: courier;">&nbsp;+0200</sp=
an><br style=3D"font-family: courier;"><span style=3D"font-family: courier;=
">&gt; +++ lm-sensors/prog/sensors/chips.c&nbsp;&nbsp;&nbsp; 2007-06-17 16:=
29:50.000000000</span><br style=3D"font-family: courier;"><span style=3D"fo=
nt-family: courier;">&nbsp;+0200</span><br
 style=3D"font-family: courier;"><span style=3D"font-family: courier;">&gt;=
 @@ -6131,6 +6131,114 @@</span><br style=3D"font-family: courier;"><span st=
yle=3D"font-family: courier;">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }</span><b=
r style=3D"font-family: courier;"><span style=3D"font-family: courier;">&gt=
;&nbsp; }</span><br style=3D"font-family: courier;"><span style=3D"font-fam=
ily: courier;">&gt; &nbsp;</span><br style=3D"font-family: courier;"><span =
style=3D"font-family: courier;">&gt; +static void print_f75373_in(const sen=
sors_chip_name *name, int i)</span><br style=3D"font-family: courier;"><spa=
n style=3D"font-family: courier;">&gt; :</span><br style=3D"font-family: co=
urier;"><span style=3D"font-family: courier;">&gt; +&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp; printf("%+6.2f V&nbsp; (min =3D %+6.2f V, max =3D %+6.2f V)&nbsp; \=
n",</span><br style=3D"font-family: courier;"><span style=3D"font-family: c=
ourier;">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; cur, min, max);</span><br
 style=3D"font-family: courier;"><span style=3D"font-family: courier;">&gt;=
</span><br style=3D"font-family: courier;"><span style=3D"font-family: cour=
ier;">&gt; If you don't have any alarm flag to display, you can remove the =
spaces</span><br style=3D"font-family: courier;"><span style=3D"font-family=
: courier;">&gt; before the newline.</span><br style=3D"font-family: courie=
r;"><span style=3D"font-family: courier;">I changed it.</span><br style=3D"=
font-family: courier;"><br style=3D"font-family: courier;"><br style=3D"fon=
t-family: courier;"><span style=3D"font-family: courier;">&gt; +&nbsp;&nbsp=
;&nbsp; }</span><br style=3D"font-family: courier;"><span style=3D"font-fam=
ily: courier;">&gt; +&nbsp; } else {</span><br style=3D"font-family: courie=
r;"><span style=3D"font-family: courier;">&gt; +&nbsp;&nbsp;&nbsp; printf("=
ERROR: Can't get in%d data!\n", i);</span><br style=3D"font-family: courier=
;"><span style=3D"font-family: courier;">&gt; :</span><br style=3D"font-fam=
ily: courier;"><span style=3D"font-family:
 courier;">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !sensors_get_feature(*name,=
 SENSORS_F75373_TEMP_HYST(i),</span><br style=3D"font-family: courier;"><sp=
an style=3D"font-family: courier;">&nbsp;&amp;alarm)</span><br style=3D"fon=
t-family: courier;"><span style=3D"font-family: courier;">&gt; +&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; ) {</span><br style=3D"font-family: courier;"><span sty=
le=3D"font-family: courier;">&gt;</span><br style=3D"font-family: courier;"=
><span style=3D"font-family: courier;">&gt; Coding style: move this at the =
end of the previous line.</span><br style=3D"font-family: courier;"><span s=
tyle=3D"font-family: courier;">I changed it.</span><br style=3D"font-family=
: courier;"><br style=3D"font-family: courier;"><span style=3D"font-family:=
 courier;">&gt; +&nbsp;&nbsp;&nbsp; if (valid) {</span><br style=3D"font-fa=
mily: courier;"><span style=3D"font-family: courier;">&gt; +&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; print_label(label, 10);</span><br style=3D"font-family: cou=
rier;"><span style=3D"font-family:
 courier;">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; print_temp_info(cur, max, 0=
, HYST , 0, 0);</span><br style=3D"font-family: courier;"><span style=3D"fo=
nt-family: courier;">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf("%s\n", al=
arm ? "ALARM" : "");</span><br style=3D"font-family: courier;"><span style=
=3D"font-family: courier;">&gt; +&nbsp;&nbsp;&nbsp; }</span><br style=3D"fo=
nt-family: courier;"><span style=3D"font-family: courier;">&gt;</span><br s=
tyle=3D"font-family: courier;"><span style=3D"font-family: courier;">&gt; T=
his doesn't make sense. What is SENSORS_F75373_TEMP_HYST exactly? Why</span=
><br style=3D"font-family: courier;"><span style=3D"font-family: courier;">=
&gt; do you display it as an alarm?</span><br style=3D"font-family: courier=
;"><span style=3D"font-family: courier;">It was a mistake, i deleted the Al=
arm output, now it is only printf("\n"),</span><br style=3D"font-family: co=
urier;"><span style=3D"font-family: courier;">there seems not to be a value=
 for an alarm.</span><br
 style=3D"font-family: courier;"><span style=3D"font-family: courier;">temp=
1_max_hyst is always zero, i don't now what it is exactly and</span><br sty=
le=3D"font-family: courier;"><span style=3D"font-family: courier;">when it =
is not zero.</span><br style=3D"font-family: courier;"><br style=3D"font-fa=
mily: courier;"><br style=3D"font-family: courier;"><span style=3D"font-fam=
ily: courier;">&gt; +&nbsp; } else {</span><br style=3D"font-family: courie=
r;"><span style=3D"font-family: courier;">&gt; +&nbsp;&nbsp;&nbsp; printf("=
ERROR: Can't get temp%d data!\n", i);</span><br style=3D"font-family: couri=
er;"><span style=3D"font-family: courier;">&gt; :</span><br style=3D"font-f=
amily: courier;"><span style=3D"font-family: courier;">&gt; +&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &amp;valid) &amp;&amp;</span><br s=
tyle=3D"font-family: courier;"><span
 style=3D"font-family: courier;">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !sens=
ors_get_feature(*name, SENSORS_F75373_FAN(i), &amp;cur) &amp;&amp;</span><b=
r style=3D"font-family: courier;"><span style=3D"font-family: courier;">&gt=
; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; !sensors_get_feature(*name, SENSORS_F7537=
3_FAN_MIN(i), &amp;min)</span><br style=3D"font-family: courier;"><span sty=
le=3D"font-family: courier;">&gt; +&nbsp;&nbsp;&nbsp;&nbsp; ){</span><br st=
yle=3D"font-family: courier;"><span style=3D"font-family: courier;">&gt;</s=
pan><br style=3D"font-family: courier;"><span style=3D"font-family: courier=
;">&gt; Coding style: move this at the end of the previous line.</span><br =
style=3D"font-family: courier;"><span style=3D"font-family: courier;">I cha=
nged it.</span><br style=3D"font-family: courier;"><br style=3D"font-family=
: courier;"><br style=3D"font-family: courier;"><span style=3D"font-family:=
 courier;">&gt; +&nbsp;&nbsp;&nbsp; if (valid) {</span><br style=3D"font-fa=
mily: courier;"><span style=3D"font-family:
 courier;">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; print_label(label, 10);</sp=
an><br style=3D"font-family: courier;"><span style=3D"font-family: courier;=
">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; printf("%4.0f RPM&nbsp; (min =3D %4.=
0f RPM)\n",</span><br style=3D"font-family: courier;"><span style=3D"font-f=
amily: courier;">&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; cur, min);</span><br style=3D"font-family: courier;"><=
span style=3D"font-family: courier;">&gt; :</span><br style=3D"font-family:=
 courier;"><span style=3D"font-family: courier;">&gt; +&nbsp; int i;</span>=
<br style=3D"font-family: courier;"><span style=3D"font-family: courier;">&=
gt; +</span><br style=3D"font-family: courier;"><span style=3D"font-family:=
 courier;">&gt; +&nbsp; for (i =3D 0; i &lt; 4; i++) {</span><br style=3D"f=
ont-family: courier;"><span style=3D"font-family: courier;">&gt; +&nbsp;&nb=
sp;&nbsp; print_f75373_in(name, i);</span><br style=3D"font-family: courier=
;"><span style=3D"font-family: courier;">&gt;
 +&nbsp; }</span><br style=3D"font-family: courier;"><span style=3D"font-fa=
mily: courier;">&gt; +</span><br style=3D"font-family: courier;"><span styl=
e=3D"font-family: courier;">&gt; +&nbsp; for (i =3D 1; i &lt; 3; i++) {</sp=
an><br style=3D"font-family: courier;"><span style=3D"font-family: courier;=
">&gt;</span><br style=3D"font-family: courier;"><span style=3D"font-family=
: courier;">&gt; I'd suggest writing it i &lt;=3D 2, to make it more visibl=
e that there are 2</span><br style=3D"font-family: courier;"><span style=3D=
"font-family: courier;">&gt; temperature inputs, not 3. Same below for fans=
.</span><br style=3D"font-family: courier;"><span style=3D"font-family: cou=
rier;">I changed it.</span><br style=3D"font-family: courier;"><br style=3D=
"font-family: courier;"><br style=3D"font-family: courier;"><span style=3D"=
font-family: courier;">&gt; +&nbsp;&nbsp;&nbsp; print_f75373_temp(name, i);=
</span><br style=3D"font-family: courier;"><span style=3D"font-family: cour=
ier;">&gt; +&nbsp; }</span><br style=3D"font-family:
 courier;"><span style=3D"font-family: courier;">&gt; +</span><br style=3D"=
font-family: courier;"><span style=3D"font-family: courier;">&gt; :</span><=
br style=3D"font-family: courier;"><span style=3D"font-family: courier;">&g=
t; @@ -424,6 +424,7 @@</span><br style=3D"font-family: courier;"><span styl=
e=3D"font-family: courier;">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { "cor=
etemp", print_coretemp },</span><br style=3D"font-family: courier;"><span s=
tyle=3D"font-family: courier;">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { "=
dme1737", print_dme1737 },</span><br style=3D"font-family: courier;"><span =
style=3D"font-family: courier;">&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { "apple=
smc", print_applesmc },</span><br style=3D"font-family: courier;"><span sty=
le=3D"font-family: courier;">&gt; +&nbsp;&nbsp;&nbsp; { "F75373", print_f75=
373 },</span><br style=3D"font-family: courier;"><span style=3D"font-family=
: courier;">&gt;</span><br style=3D"font-family: courier;"><span style=3D"f=
ont-family: courier;">&gt; Should be "f75373",
 no capital. I'm even surprised it worked with the</span><br style=3D"font-=
family: courier;"><span style=3D"font-family: courier;">&gt; capital.</span=
><br style=3D"font-family: courier;"><span style=3D"font-family: courier;">=
If i use f75373 i get following output:</span><br style=3D"font-family: cou=
rier;"><span style=3D"font-family: courier;">F75373-i2c-1-2d</span><br styl=
e=3D"font-family: courier;"><span style=3D"font-family: courier;">Adapter: =
SMBus nForce2 adapter at 5100</span><br style=3D"font-family: courier;"><sp=
an style=3D"font-family: courier;">VCC: 1720.00 (in0)</span><br style=3D"fo=
nt-family: courier;"><span style=3D"font-family: courier;">&nbsp; in0_min: =
0.00 (in0_min)</span><br style=3D"font-family: courier;"><span style=3D"fon=
t-family: courier;">&nbsp; in0_max: 0.00 (in0_max)</span><br style=3D"font-=
family: courier;"><span style=3D"font-family: courier;">V1: 1336.00 (in1)</=
span><br style=3D"font-family: courier;"><span style=3D"font-family: courie=
r;">&nbsp; in1_min: 0.00 (in1_min)</span><br
 style=3D"font-family: courier;"><span style=3D"font-family: courier;">&nbs=
p; in1_max: 0.00 (in1_max)</span><br style=3D"font-family: courier;"><span =
style=3D"font-family: courier;">V2: 1008.00 (in2)</span><br style=3D"font-f=
amily: courier;"><span style=3D"font-family: courier;">&nbsp; in2_min: 0.00=
 (in2_min)</span><br style=3D"font-family: courier;"><span style=3D"font-fa=
mily: courier;">&nbsp; in2_max: 0.00 (in2_max)</span><br style=3D"font-fami=
ly: courier;"><span style=3D"font-family: courier;">V3: 792.00 (in3)</span>=
<br style=3D"font-family: courier;"><span style=3D"font-family: courier;">&=
nbsp; in3_min: 0.00 (in3_min)</span><br style=3D"font-family: courier;"><sp=
an style=3D"font-family: courier;">&nbsp; in3_max: 0.00 (in3_max)</span><br=
 style=3D"font-family: courier;"><span style=3D"font-family: courier;">CPU =
Temp: 49.00 (temp1)</span><br style=3D"font-family: courier;"><span style=
=3D"font-family: courier;">&nbsp; temp1_max: 0.00 (temp1_max)</span><br sty=
le=3D"font-family: courier;"><span
 style=3D"font-family: courier;">&nbsp; temp1_hyst: 0.00 (temp1_hyst)</span=
><br style=3D"font-family: courier;"><span style=3D"font-family: courier;">=
Sys Temp: 46.00 (temp2)</span><br style=3D"font-family: courier;"><span sty=
le=3D"font-family: courier;">&nbsp; temp2_max: 0.00 (temp2_max)</span><br s=
tyle=3D"font-family: courier;"><span style=3D"font-family: courier;">&nbsp;=
 temp2_hyst: 0.00 (temp2_hyst)</span><br style=3D"font-family: courier;"><s=
pan style=3D"font-family: courier;">CPU Fan: 1787.84 (fan1)</span><br style=
=3D"font-family: courier;"><span style=3D"font-family: courier;">&nbsp; fan=
1_max: 5681.82 (fan1_max)</span><br style=3D"font-family: courier;"><span s=
tyle=3D"font-family: courier;">ERROR: Can't get feature `fan1_min' data!</s=
pan><br style=3D"font-family: courier;"><span style=3D"font-family: courier=
;">CPU PWM: 31.00 (pwm1)</span><br style=3D"font-family: courier;"><span st=
yle=3D"font-family: courier;">What's the reason? Did I still have to use "F=
75373"?</span><br style=3D"font-family:
 courier;"><br style=3D"font-family: courier;"><br style=3D"font-family: co=
urier;"><span style=3D"font-family: courier;">&gt; Please update your patch=
 and resend it.</span><br style=3D"font-family: courier;"><span style=3D"fo=
nt-family: courier;">&gt;</span><br style=3D"font-family: courier;"><span s=
tyle=3D"font-family: courier;">&gt; Also, what about the F75375 support? As=
 far as I know the f75375s</span><br style=3D"font-family: courier;"><span =
style=3D"font-family: courier;">&gt;&nbsp; driver</span><br style=3D"font-f=
amily: courier;"><span style=3D"font-family: courier;">&gt; supports both c=
hips, so it'd be nice to have user-space support for</span><br style=3D"fon=
t-family: courier;"><span style=3D"font-family: courier;">&gt; both. Also, =
it might be less confusing to use F75375 for all the</span><br style=3D"fon=
t-family: courier;"><span style=3D"font-family: courier;">&gt; libsensors d=
efines, rather than F75373, so that they match the driver</span><br style=
=3D"font-family: courier;"><span
 style=3D"font-family: courier;">&gt; name.</span><br style=3D"font-family:=
 courier;"><span style=3D"font-family: courier;">I changed every define/fun=
ction from F75373 to F75375, i added also:</span><br style=3D"font-family: =
courier;"><span style=3D"font-family: courier;">#define SENSORS_F75373_PREF=
IX "f75373"</span><br style=3D"font-family: courier;"><span style=3D"font-f=
amily: courier;">#define SENSORS_F75375_PREFIX "f75375"</span><br style=3D"=
font-family: courier;"><span style=3D"font-family: courier;">and</span><br =
style=3D"font-family: courier;"><span style=3D"font-family: courier;">{ SEN=
SORS_F75375_PREFIX, f75375_features },</span><br style=3D"font-family: cour=
ier;"><span style=3D"font-family: courier;">{ SENSORS_F75373_PREFIX, f75375=
_features },</span><br style=3D"font-family: courier;"><span style=3D"font-=
family: courier;">and</span><br style=3D"font-family: courier;"><span style=
=3D"font-family: courier;">{ "F75375", print_f75375 },</span><br style=3D"f=
ont-family: courier;"><span style=3D"font-family:
 courier;">{ "F75373", print_f75375 },</span><br style=3D"font-family: cour=
ier;"><span style=3D"font-family: courier;">i hope that this is ok.</span><=
br style=3D"font-family: courier;"><br style=3D"font-family: courier;"><br =
style=3D"font-family: courier;"><span style=3D"font-family: courier;">&gt;<=
/span><br style=3D"font-family: courier;"><span style=3D"font-family: couri=
er;">&gt; Thanks,</span><br style=3D"font-family: courier;"><span style=3D"=
font-family: courier;">&gt; --</span><br style=3D"font-family: courier;"><s=
pan style=3D"font-family: courier;">&gt; Jean Delvare</span><br style=3D"fo=
nt-family: courier;"><span style=3D"font-family: courier;">Thank you for yo=
ur review,</span><br style=3D"font-family: courier;"><span style=3D"font-fa=
mily: courier;">christian.</span><p>&#32;
		<hr size=3D1>Was ist Gl=FCck? Schlafen Fische =FCberhaupt? Die Antworten =
gibt=92s auf <a href=3Dhttp://de.rd.yahoo.com/xx/searchpromo/i/tagline/clev=
erfp/*http://de.answers.yahoo.com>Yahoo! Clever</a>.
--0-1942744997-1182748773=:77609--

--0-1761500654-1182748773=:77609
Content-Type: application/octet-stream; name="fintek_75373s_support_v2.patch"
Content-Transfer-Encoding: base64
Content-Description: 3093308178-fintek_75373s_support_v2.patch
Content-Disposition: attachment; filename="fintek_75373s_support_v2.patch"

ZGlmZiAtdXJOIGxtLXNlbnNvcnNfb3JnL2V0Yy9zZW5zb3JzLmNvbmYuZWcg
bG0tc2Vuc29ycy9ldGMvc2Vuc29ycy5jb25mLmVnCi0tLSBsbS1zZW5zb3Jz
X29yZy9ldGMvc2Vuc29ycy5jb25mLmVnCTIwMDctMDYtMTcgMTc6MTc6Mjku
MDAwMDAwMDAwICswMjAwCisrKyBsbS1zZW5zb3JzL2V0Yy9zZW5zb3JzLmNv
bmYuZWcJMjAwNy0wNi0yNCAxODoxMzoxNy4wMDAwMDAwMDAgKzAyMDAKQEAg
LTI4ODAsMyArMjg4MCwzMSBAQAogIyAgIHNldCBmYW40X21pbiAxMDAwCiAj
ICAgc2V0IGZhbjVfbWluIDEwMDAKICMgICBzZXQgZmFuNl9taW4gMTAwMAor
CisKKyMKKyMgU2FtcGxlIGNvbmZpZ3VyYXRpb24gZm9yIHRoZSBGaW50ZWsg
Rjc1Mzc1L0Y3NTM3M1MKKyMKK2NoaXAgIkY3NTM3NS0qIiAiRjc1MzczLSoi
CisKKyMgVm9sdGFnZXMKKyAgIGxhYmVsIGluMCAiVkNDIgorICAgbGFiZWwg
aW4xICJWMSIKKyAgIGxhYmVsIGluMiAiVjIiCisgICBsYWJlbCBpbjMgIlYz
IgorICAgIAorIyBGYW5zCisgICBsYWJlbCBmYW4xICJDUFUgRmFuIgorICAg
bGFiZWwgZmFuMiAiU3lzIEZhbiIKKworICAgY29tcHV0ZSBmYW4xICAoIDEu
NSAqIDEwMDAwMDAgKS9ALCAgKCAxLjUgKiAxMDAwMDAwICkvQAorICAgY29t
cHV0ZSBmYW4yICAoIDEuNSAqIDEwMDAwMDAgKS9ALCAgKCAxLjUgKiAxMDAw
MDAwICkvQAorCisjIFRlbXBlcmF0dXJlcworICAgbGFiZWwgdGVtcDEgIkNQ
VSBUZW1wIgorICAgbGFiZWwgdGVtcDIgIlN5cyBUZW1wIgorICAgCisjIFBX
TQorICAgbGFiZWwgcHdtMSAgICJDUFUgUFdNIgorICAgbGFiZWwgcHdtMiAg
ICJTeXMgUFdNIgorCmRpZmYgLXVyTiBsbS1zZW5zb3JzX29yZy9saWIvY2hp
cHMuYyBsbS1zZW5zb3JzL2xpYi9jaGlwcy5jCi0tLSBsbS1zZW5zb3JzX29y
Zy9saWIvY2hpcHMuYwkyMDA3LTA2LTE3IDE3OjE3OjI1LjAwMDAwMDAwMCAr
MDIwMAorKysgbG0tc2Vuc29ycy9saWIvY2hpcHMuYwkyMDA3LTA2LTI0IDE3
OjUwOjQ5LjAwMDAwMDAwMCArMDIwMApAQCAtNjEwOCw2ICs2MTA4LDY0IEBA
CiAgICAgeyB7IDAgfSwgMCB9CiAgIH07CiAKKworCisjZGVmaW5lIFNFTlNP
UlNfRjc1Mzc1X0lOX0ZFQVRVUkVTKG5yKSBcCisgICAgICAgIHsgeyBTRU5T
T1JTX0Y3NTM3NV9JTihuciksICJpbiIgI25yLCBcCisgICAgICAgICAgICAg
ICAgTk9NQVAsIE5PTUFQLCBSIH0sIFwKKyAgICAgICAgICAgICAgICBOT1NZ
U0NUTCwgVkFMVUUoMyksIDMgfSwgXAorICAgICAgICB7IHsgU0VOU09SU19G
NzUzNzVfSU5fTUlOKG5yKSwgImluIiAjbnIgIl9taW4iLCBcCisgICAgICAg
ICAgICAgICAgU0VOU09SU19GNzUzNzVfSU4obnIpLCBTRU5TT1JTX0Y3NTM3
NV9JTihuciksIFJXIH0sIFwKKyAgICAgICAgICAgICAgICBOT1NZU0NUTCwg
VkFMVUUoMSksIDMgfSwgXAorICAgICAgICB7IHsgU0VOU09SU19GNzUzNzVf
SU5fTUFYKG5yKSwgImluIiAjbnIgIl9tYXgiLCBcCisgICAgICAgICAgICAg
ICAgU0VOU09SU19GNzUzNzVfSU4obnIpLCBTRU5TT1JTX0Y3NTM3NV9JTihu
ciksIFJXIH0sIFwKKyAgICAgICAgICAgICAgICBOT1NZU0NUTCwgVkFMVUUo
MiksIDMgfQorCisjZGVmaW5lIFNFTlNPUlNfRjc1Mzc1X1RFTVBfRkVBVFVS
RVMobnIpIFwKKyAgICAgICAgeyB7IFNFTlNPUlNfRjc1Mzc1X1RFTVAobnIp
LCAidGVtcCIgI25yLCBcCisgICAgICAgICAgICAgICAgTk9NQVAsIE5PTUFQ
LCBSIH0sIFwKKyAgICAgICAgICAgICAgICBOT1NZU0NUTCwgVkFMVUUoMyks
IDMgfSwgXAorICAgICAgICB7IHsgU0VOU09SU19GNzUzNzVfVEVNUF9NQVgo
bnIpLCAidGVtcCIgI25yICJfbWF4IiwgXAorICAgICAgICAgICAgICAgIFNF
TlNPUlNfRjc1Mzc1X1RFTVAobnIpLCBTRU5TT1JTX0Y3NTM3NV9URU1QKG5y
KSwgUlcgfSwgXAorICAgICAgICAgICAgICAgIE5PU1lTQ1RMLCBWQUxVRSgx
KSwgMyB9LCBcCisgICAgICAgIHsgeyBTRU5TT1JTX0Y3NTM3NV9URU1QX0hZ
U1QobnIpLCAidGVtcCIgI25yICJfaHlzdCIsIFwKKyAgICAgICAgICAgICAg
ICBTRU5TT1JTX0Y3NTM3NV9URU1QKG5yKSwgU0VOU09SU19GNzUzNzVfVEVN
UChuciksIFJXIH0sIFwKKyAgICAgICAgICAgICAgICBOT1NZU0NUTCwgVkFM
VUUoMiksIDMgfQorCisjZGVmaW5lIFNFTlNPUlNfRjc1Mzc1X0ZBTl9GRUFU
VVJFUyhucikgXAorICAgICAgICB7IHsgU0VOU09SU19GNzUzNzVfRkFOKG5y
KSwgImZhbiIgI25yLCBcCisgICAgICAgICAgICAgICAgTk9NQVAsIE5PTUFQ
LCBSIH0sIFwKKyAgICAgICAgICAgICAgICBOT1NZU0NUTCwgVkFMVUUoMiks
IDAgfSwgXAorICAgICAgICB7IHsgU0VOU09SU19GNzUzNzVfRkFOX01BWChu
ciksICJmYW4iICNuciAiX21heCIsIFwKKyAgICAgICAgICAgICAgICBTRU5T
T1JTX0Y3NTM3NV9GQU4obnIpLCBTRU5TT1JTX0Y3NTM3NV9GQU4obnIpLCBS
VyB9LCBcCisgICAgICAgICAgICAgICAgTk9TWVNDVEwsIFZBTFVFKDEpLCAw
IH0sIFwKKyAgICAgICAgeyB7IFNFTlNPUlNfRjc1Mzc1X0ZBTl9NSU4obnIp
LCAiZmFuIiAjbnIgIl9taW4iLCBcCisgICAgICAgICAgICAgICAgU0VOU09S
U19GNzUzNzVfRkFOKG5yKSwgU0VOU09SU19GNzUzNzVfRkFOKG5yKSwgUlcg
fSwgXAorICAgICAgICAgICAgICAgIE5PU1lTQ1RMLCBWQUxVRSgxKSwgMCB9
CisKKyNkZWZpbmUgU0VOU09SU19GNzUzNzVfUFdNX0ZFQVRVUkVTKG5yKSBc
CisgICAgICAgIHsgeyBTRU5TT1JTX0Y3NTM3NV9QV00obnIpLCAicHdtIiAj
bnIsIFwKKyAgICAgICAgICAgICAgICBOT01BUCwgTk9NQVAsIFJXIH0sIFwK
KyAgICAgICAgICAgICAgICBOT1NZU0NUTCwgVkFMVUUoMSksIDAgfSwgXAor
ICAgICAgICB7IHsgU0VOU09SU19GNzUzNzVfUFdNX0VOQUJMRShuciksICJw
d20iICNuciAiX2VuYWJsZSIsIFwKKyAgICAgICAgICAgICAgICBTRU5TT1JT
X0Y3NTM3NV9QV00obnIpLCBTRU5TT1JTX0Y3NTM3NV9QV00obnIpLCBSVyB9
LCBcCisgICAgICAgICAgICAgICAgTk9TWVNDVEwsIFZBTFVFKDMpLCAwIH0K
Kworc3RhdGljIHNlbnNvcnNfY2hpcF9mZWF0dXJlIGY3NTM3NV9mZWF0dXJl
c1tdID0KK3sKKyAgICAgICAgU0VOU09SU19GNzUzNzVfSU5fRkVBVFVSRVMo
MCksCisgICAgICAgIFNFTlNPUlNfRjc1Mzc1X0lOX0ZFQVRVUkVTKDEpLAor
ICAgICAgICBTRU5TT1JTX0Y3NTM3NV9JTl9GRUFUVVJFUygyKSwKKyAgICAg
ICAgU0VOU09SU19GNzUzNzVfSU5fRkVBVFVSRVMoMyksCisgICAgICAgIFNF
TlNPUlNfRjc1Mzc1X1RFTVBfRkVBVFVSRVMoMSksCisgICAgICAgIFNFTlNP
UlNfRjc1Mzc1X1RFTVBfRkVBVFVSRVMoMiksCisgICAgICAgIFNFTlNPUlNf
Rjc1Mzc1X0ZBTl9GRUFUVVJFUygxKSwKKyAgICAgICAgU0VOU09SU19GNzUz
NzVfRkFOX0ZFQVRVUkVTKDIpLAorICAgICAgICBTRU5TT1JTX0Y3NTM3NV9Q
V01fRkVBVFVSRVMoMSksCisgICAgICAgIFNFTlNPUlNfRjc1Mzc1X1BXTV9G
RUFUVVJFUygyKSwKKyAgICAgICAgeyB7IDAgfSwgMCB9Cit9OworCiBzZW5z
b3JzX2NoaXBfZmVhdHVyZXMgc2Vuc29yc19jaGlwX2ZlYXR1cmVzX2xpc3Rb
XSA9CiB7CiAgeyBTRU5TT1JTX0xNNzhfUFJFRklYLCBsbTc4X2ZlYXR1cmVz
IH0sCkBAIC02MjIzLDUgKzYyODEsNyBAQAogIHsgU0VOU09SU19DT1JFVEVN
UF9QUkVGSVgsIGNvcmV0ZW1wX2ZlYXR1cmVzIH0sCiAgeyBTRU5TT1JTX0RN
RTE3MzdfUFJFRklYLCBkbWUxNzM3X2ZlYXR1cmVzIH0sCiAgeyBTRU5TT1JT
X0FQUExFU01DX1BSRUZJWCwgYXBwbGVzbWNfZmVhdHVyZXMgfSwKKyB7IFNF
TlNPUlNfRjc1Mzc1X1BSRUZJWCwgZjc1Mzc1X2ZlYXR1cmVzIH0sCisgeyBT
RU5TT1JTX0Y3NTM3M19QUkVGSVgsIGY3NTM3NV9mZWF0dXJlcyB9LAogIHsg
MCB9CiB9OwpkaWZmIC11ck4gbG0tc2Vuc29yc19vcmcvbGliL2NoaXBzLmgg
bG0tc2Vuc29ycy9saWIvY2hpcHMuaAotLS0gbG0tc2Vuc29yc19vcmcvbGli
L2NoaXBzLmgJMjAwNy0wNi0xNyAxNzoxNzoyNS4wMDAwMDAwMDAgKzAyMDAK
KysrIGxtLXNlbnNvcnMvbGliL2NoaXBzLmgJMjAwNy0wNi0yNCAxODoxNDo0
Ny4wMDAwMDAwMDAgKzAyMDAKQEAgLTIzMTIsNCArMjMxMiwyOSBAQAogI2Rl
ZmluZSBTRU5TT1JTX0FQUExFU01DX0ZBTl9NQVgobikJCSgweDYxICsgKG4p
KSAvKiBSICovCiAjZGVmaW5lIFNFTlNPUlNfQVBQTEVTTUNfRkFOX1NBRkUo
bikJCSgweDgxICsgKG4pKSAvKiBSICovCiAKKy8qIEZpbnRlayBGNzUzNzMg
cmVnaXN0ZXJzICAqLworCisjZGVmaW5lIFNFTlNPUlNfRjc1MzczX1BSRUZJ
WCAiZjc1MzczIgorI2RlZmluZSBTRU5TT1JTX0Y3NTM3NV9QUkVGSVggImY3
NTM3NSIKKworLyogdm9sdGFnZSBuIGZyb20gMSB0byA0ICovCisjZGVmaW5l
IFNFTlNPUlNfRjc1Mzc1X0lOKG5yKSAgICAgICAgICAgKDB4MDEgKyAobnIp
KQorI2RlZmluZSBTRU5TT1JTX0Y3NTM3NV9JTl9NQVgobnIpICAgICAgICgw
eDExICsgKG5yKSAqIDIpCisjZGVmaW5lIFNFTlNPUlNfRjc1Mzc1X0lOX01J
TihucikgICAgICAgKDB4MjEgKyAobnIpICogMikKKworLyogdGVtcCBuIGZy
b20gMSB0byAyICovCisjZGVmaW5lIFNFTlNPUlNfRjc1Mzc1X1RFTVAobnIp
ICAgICAgICAgKDB4MzEgKyAobnIpKQorI2RlZmluZSBTRU5TT1JTX0Y3NTM3
NV9URU1QX01BWChucikgICAgICgweDQxICsgKG5yKSAqIDIpCisjZGVmaW5l
IFNFTlNPUlNfRjc1Mzc1X1RFTVBfSFlTVChucikgICAgKDB4NTEgKyAobnIp
ICogMikKKworLyogZmFuIG4gZnJvbSAxIHRvIDIgKi8KKyNkZWZpbmUgU0VO
U09SU19GNzUzNzVfRkFOKG5yKSAgICAgICAgICAoMHg2MSArIChucikgKiAy
KQorI2RlZmluZSBTRU5TT1JTX0Y3NTM3NV9GQU5fTUlOKG5yKSAgICAgICgw
eDcxICsgKG5yKSAqIDIpCisvKiBGQU4gRnVsbCBTcGVlZCBDb3VudCBSZWdp
c3RlciBJbmRleCA3MGggKi8KKyNkZWZpbmUgU0VOU09SU19GNzUzNzVfRkFO
X01BWChucikgICAgICAoMHg4MSArIChucikgKiAweDEwKQorCisvKiBwd20g
biBmcm9tIDEgdG8gMiAqLworI2RlZmluZSBTRU5TT1JTX0Y3NTM3NV9QV00o
bnIpICAgICAgICAgICgweGExICsgKG5yKSAqIDB4MTApCisjZGVmaW5lIFNF
TlNPUlNfRjc1Mzc1X1BXTV9FTkFCTEUobnIpICAgKDB4YzEgKyAobnIpICog
MHgxMCkKKwogI2VuZGlmIC8qIGRlZiBMSUJfU0VOU09SU19DSElQU19IICov
CmRpZmYgLXVyTiBsbS1zZW5zb3JzX29yZy9wcm9nL3NlbnNvcnMvY2hpcHMu
YyBsbS1zZW5zb3JzL3Byb2cvc2Vuc29ycy9jaGlwcy5jCi0tLSBsbS1zZW5z
b3JzX29yZy9wcm9nL3NlbnNvcnMvY2hpcHMuYwkyMDA3LTA2LTE3IDE3OjE3
OjI3LjAwMDAwMDAwMCArMDIwMAorKysgbG0tc2Vuc29ycy9wcm9nL3NlbnNv
cnMvY2hpcHMuYwkyMDA3LTA2LTI0IDE2OjQ0OjQxLjAwMDAwMDAwMCArMDIw
MApAQCAtNjEzMSw2ICs2MTMxLDExMiBAQAogCX0KIH0KIAorc3RhdGljIHZv
aWQgcHJpbnRfZjc1Mzc1X2luKGNvbnN0IHNlbnNvcnNfY2hpcF9uYW1lICpu
YW1lLCBpbnQgaSkKK3sKKyAgY2hhciAqbGFiZWw7CisgIGRvdWJsZSBjdXIs
IG1pbiwgbWF4OworICBpbnQgdmFsaWQ7CisKKyAgaWYgKCFzZW5zb3JzX2dl
dF9sYWJlbF9hbmRfdmFsaWQoKm5hbWUsIFNFTlNPUlNfRjc1Mzc1X0lOKGkp
LCAmbGFiZWwsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
JnZhbGlkKSAmJgorICAgICAgIXNlbnNvcnNfZ2V0X2ZlYXR1cmUoKm5hbWUs
IFNFTlNPUlNfRjc1Mzc1X0lOKGkpLCAmY3VyKSAmJgorICAgICAgIXNlbnNv
cnNfZ2V0X2ZlYXR1cmUoKm5hbWUsIFNFTlNPUlNfRjc1Mzc1X0lOX01BWChp
KSwgJm1heCkgJiYKKyAgICAgICFzZW5zb3JzX2dldF9mZWF0dXJlKCpuYW1l
LCBTRU5TT1JTX0Y3NTM3NV9JTl9NSU4oaSksICZtaW4pKSB7CisgICAgaWYg
KHZhbGlkKSB7CisgICAgICBwcmludF9sYWJlbChsYWJlbCwgMTApOworICAg
ICAgcHJpbnRmKCIlKzYuMmYgViAgKG1pbiA9ICUrNi4yZiBWLCBtYXggPSAl
KzYuMmYgVilcbiIsCisgICAgICAgICAgICAgY3VyLCBtaW4sIG1heCk7Cisg
ICAgfQorICB9IGVsc2UgeworICAgIHByaW50ZigiRVJST1I6IENhbid0IGdl
dCBpbiVkIGRhdGEhXG4iLCBpKTsKKyAgfQorICBmcmVlKGxhYmVsKTsKK30K
Kworc3RhdGljIHZvaWQgcHJpbnRfZjc1Mzc1X3RlbXAoY29uc3Qgc2Vuc29y
c19jaGlwX25hbWUgKm5hbWUsIGludCBpKQoreworICBjaGFyICpsYWJlbDsK
KyAgZG91YmxlIGN1ciwgbWF4OworICBpbnQgdmFsaWQ7CisKKyAgaWYgKCFz
ZW5zb3JzX2dldF9sYWJlbF9hbmRfdmFsaWQoKm5hbWUsIFNFTlNPUlNfRjc1
Mzc1X1RFTVAoaSksICZsYWJlbCwKKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgJnZhbGlkKSAmJgorICAgICAgIXNlbnNvcnNfZ2V0X2Zl
YXR1cmUoKm5hbWUsIFNFTlNPUlNfRjc1Mzc1X1RFTVAoaSksICZjdXIpICYm
CisgICAgICAhc2Vuc29yc19nZXRfZmVhdHVyZSgqbmFtZSwgU0VOU09SU19G
NzUzNzVfVEVNUF9NQVgoaSksICZtYXgpKSB7CisgICAgaWYgKHZhbGlkKSB7
CisgICAgICBwcmludF9sYWJlbChsYWJlbCwgMTApOworICAgICAgcHJpbnRf
dGVtcF9pbmZvKGN1ciwgbWF4LCAwLCBNQVhPTkxZLCAwLCAwKTsKKyAgICAg
IHByaW50ZigiXG4iKTsKKyAgICB9CisgIH0gZWxzZSB7CisgICAgcHJpbnRm
KCJFUlJPUjogQ2FuJ3QgZ2V0IHRlbXAlZCBkYXRhIVxuIiwgaSk7CisgIH0K
KyAgZnJlZShsYWJlbCk7Cit9CisKK3N0YXRpYyB2b2lkIHByaW50X2Y3NTM3
NV9mYW4oY29uc3Qgc2Vuc29yc19jaGlwX25hbWUgKm5hbWUsIGludCBpKQor
eworICBjaGFyICpsYWJlbDsKKyAgZG91YmxlIGN1cjsKKyAgaW50IHZhbGlk
OworCisgIGlmICghc2Vuc29yc19nZXRfbGFiZWxfYW5kX3ZhbGlkKCpuYW1l
LCBTRU5TT1JTX0Y3NTM3NV9GQU4oaSksICZsYWJlbCwKKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgJnZhbGlkKSAmJgorICAgICAgIXNl
bnNvcnNfZ2V0X2ZlYXR1cmUoKm5hbWUsIFNFTlNPUlNfRjc1Mzc1X0ZBTihp
KSwgJmN1cikpIHsKKyAgICBpZiAodmFsaWQpIHsKKyAgICAgIHByaW50X2xh
YmVsKGxhYmVsLCAxMCk7CisgICAgICAvKnByaW50ZigiJTQuMGYgUlBNICAo
bWluID0gJTQuMGYgUlBNKVxuIiwgCisgICAgICAgICAgICAgY3VyLCBtaW4p
OyovCisgICAgICBwcmludGYoIiU0LjBmIFJQTVxuIiwKKyAgICAgICAgICAg
ICBjdXIpOworICAgIH0KKyAgfSBlbHNlIHsKKyAgICBwcmludGYoIkVSUk9S
OiBDYW4ndCBnZXQgZmFuJWQgZGF0YSFcbiIsIGkpOworICB9CisgIGZyZWUo
bGFiZWwpOworfQorCitzdGF0aWMgdm9pZCBwcmludF9mNzUzNzVfcHdtKGNv
bnN0IHNlbnNvcnNfY2hpcF9uYW1lICpuYW1lLCBpbnQgaSkKK3sKKyAgY2hh
ciAqbGFiZWw7CisgIGRvdWJsZSBjdXIsIGVuYWJsZTsKKyAgaW50IHZhbGlk
OworCisgIGlmICghc2Vuc29yc19nZXRfbGFiZWxfYW5kX3ZhbGlkKCpuYW1l
LCBTRU5TT1JTX0Y3NTM3NV9QV00oaSksICZsYWJlbCwKKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgJnZhbGlkKSAmJgorICAgICAgIXNl
bnNvcnNfZ2V0X2ZlYXR1cmUoKm5hbWUsIFNFTlNPUlNfRjc1Mzc1X1BXTShp
KSwgJmN1cikgJiYKKyAgICAgICFzZW5zb3JzX2dldF9mZWF0dXJlKCpuYW1l
LCBTRU5TT1JTX0Y3NTM3NV9QV01fRU5BQkxFKGkpLCAmZW5hYmxlKSkgewor
ICAgIGlmICh2YWxpZCkgeworICAgICAgcHJpbnRfbGFiZWwobGFiZWwsIDEw
KTsKKyAgICAgIHByaW50ZigiJTQuMGYgICAgICAoZW5hYmxlID0gJTEuMGYp
XG4iLCBjdXIsIGVuYWJsZSk7CisgICAgfQorICB9IGVsc2UgeworICAgIHBy
aW50ZigiRVJST1I6IENhbid0IGdldCBwd20lZCBkYXRhIVxuIiwgaSk7Cisg
IH0KKyAgZnJlZShsYWJlbCk7Cit9CisKK3ZvaWQgcHJpbnRfZjc1Mzc1KGNv
bnN0IHNlbnNvcnNfY2hpcF9uYW1lICpuYW1lKQoreworICBpbnQgaTsKKwor
ICBmb3IgKGkgPSAwOyBpIDw9IDM7IGkrKykgeworICAgIHByaW50X2Y3NTM3
NV9pbihuYW1lLCBpKTsKKyAgfQorCisgIGZvciAoaSA9IDE7IGkgPD0gMjsg
aSsrKSB7CisgICAgcHJpbnRfZjc1Mzc1X3RlbXAobmFtZSwgaSk7CisgIH0K
KworICBmb3IgKGkgPSAxOyBpIDw9IDI7IGkrKykgeworICAgIHByaW50X2Y3
NTM3NV9mYW4obmFtZSwgaSk7CisgIH0KKworICBmb3IgKGkgPSAxOyBpIDw9
IDI7IGkrKykgeworICAgIHByaW50X2Y3NTM3NV9wd20obmFtZSwgaSk7Cisg
IH0KK30KKwogdm9pZCBwcmludF91bmtub3duX2NoaXAoY29uc3Qgc2Vuc29y
c19jaGlwX25hbWUgKm5hbWUpCiB7CiAgIGludCBhLGIsdmFsaWQ7CmRpZmYg
LXVyTiBsbS1zZW5zb3JzX29yZy9wcm9nL3NlbnNvcnMvY2hpcHMuaCBsbS1z
ZW5zb3JzL3Byb2cvc2Vuc29ycy9jaGlwcy5oCi0tLSBsbS1zZW5zb3JzX29y
Zy9wcm9nL3NlbnNvcnMvY2hpcHMuaAkyMDA3LTA2LTE3IDE3OjE3OjI3LjAw
MDAwMDAwMCArMDIwMAorKysgbG0tc2Vuc29ycy9wcm9nL3NlbnNvcnMvY2hp
cHMuaAkyMDA3LTA2LTI0IDE2OjM3OjUxLjAwMDAwMDAwMCArMDIwMApAQCAt
NzgsNSArNzgsNiBAQAogZXh0ZXJuIHZvaWQgcHJpbnRfY29yZXRlbXAoY29u
c3Qgc2Vuc29yc19jaGlwX25hbWUgKm5hbWUpOwogZXh0ZXJuIHZvaWQgcHJp
bnRfZG1lMTczNyhjb25zdCBzZW5zb3JzX2NoaXBfbmFtZSAqbmFtZSk7CiBl
eHRlcm4gdm9pZCBwcmludF9hcHBsZXNtYyhjb25zdCBzZW5zb3JzX2NoaXBf
bmFtZSAqbmFtZSk7CitleHRlcm4gdm9pZCBwcmludF9mNzUzNzUoY29uc3Qg
c2Vuc29yc19jaGlwX25hbWUgKm5hbWUpOwogCiAjZW5kaWYgLyogZGVmIFBS
T0dfU0VOU09SU19DSElQU19IICovCmRpZmYgLXVyTiBsbS1zZW5zb3JzX29y
Zy9wcm9nL3NlbnNvcnMvbWFpbi5jIGxtLXNlbnNvcnMvcHJvZy9zZW5zb3Jz
L21haW4uYwotLS0gbG0tc2Vuc29yc19vcmcvcHJvZy9zZW5zb3JzL21haW4u
YwkyMDA3LTA2LTE3IDE3OjE3OjI3LjAwMDAwMDAwMCArMDIwMAorKysgbG0t
c2Vuc29ycy9wcm9nL3NlbnNvcnMvbWFpbi5jCTIwMDctMDYtMjQgMTg6MjU6
MTAuMDAwMDAwMDAwICswMjAwCkBAIC00MjQsNiArNDI0LDggQEAKICAJeyAi
Y29yZXRlbXAiLCBwcmludF9jb3JldGVtcCB9LAogIAl7ICJkbWUxNzM3Iiwg
cHJpbnRfZG1lMTczNyB9LAogCXsgImFwcGxlc21jIiwgcHJpbnRfYXBwbGVz
bWMgfSwKKyAgICAgICAgeyAiRjc1Mzc1IiwgcHJpbnRfZjc1Mzc1IH0sCisg
ICAgICAgIHsgIkY3NTM3MyIsIHByaW50X2Y3NTM3NSB9LAogCXsgTlVMTCwg
TlVMTCB9CiB9OwogCg==

--0-1761500654-1182748773=:77609
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--0-1761500654-1182748773=:77609--

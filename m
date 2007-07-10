From: Christian Emmerich <christian_emmerich@yahoo.de>
Date: Tue, 10 Jul 2007 19:44:25 +0000
Subject: Re: [lm-sensors] Help needed for implementing&testing Fintek F75375
Message-Id: <80743.59813.qm@web25110.mail.ukl.yahoo.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="0-892538531-1184096665=:59813"
List-Id: <lm-sensors.vger.kernel.org>
References: <5327.79319.qm@web25109.mail.ukl.yahoo.com>
In-Reply-To: <5327.79319.qm@web25109.mail.ukl.yahoo.com>
To: lm-sensors@vger.kernel.org

--0-892538531-1184096665=:59813
Content-Type: multipart/alternative; boundary="0-1846721365-1184096665=:59813"

--0-1846721365-1184096665=:59813
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Jean,

> The reject message explained that you shouldn't be sending HTML mails.
> This makes your mails more than twice as big as they should, and that
> explains the reject.
Sorry, i'm not able to change it. I'm using just a freemail account.

> Sounds like a bug in the driver then. Setting pwm1_enable to 0 should
> turn the fan to full speed.
Fixed, using new driver version lets the fan turn to full speed.

> > I try to set limits in sensors.conf but i could see no change.
>
> You must run "sensors -s" after changing the limits
> in /etc/sensors.conf for the new limits to be applied. Please test this,
> this is a good way to test both the libsensors code you added, and the
> driver itself.
After using "sensors -s" i can see the limits i set in sensors.conf (e.g. "=
VCC: +1.72 V (min =3D +1.65 V, max =3D +1.85 V)").
But a inx_alarm is missing, so i see only the values.
What would be a good value for the sensors.conf.eg entry e.g.
set in0_min   1.72 * 0.95
set in0_max   1.72 * 1.05 ?

> > > Lastly, you really shouldn't have to divide the values by 1000. This
> > > suggests that the magnitude wasn't set properly in libsensors (it
> > > should be 3, I suggest it is 0). This issue is most probably related =
to
> > > the incorrect symbol names.
> >
> > I saw values >800V so i thought i have to divide it by 1000 in sensors.=
conf.
> > Magnitude is 3 and the symbol name is correct now, but the values are s=
till
> > over 800V. What's the reason?
>
> I guess that's a bug in the driver. What values do you see in the
> in*_input sysfs files?
Fixed, if i use the new driver version i can see correct values (e.g. 1.72V=
).

> > > This means that the driver isn't reporting the values in RPM as it
> > > should. Usually no compute statement is needed for fans.
> >
> > That's correct, the value is not in RPM, in the document '2005111153128=
.pdf' you can download on the fintek page
> > ( http://www.fintek.com.tw/eng/products.asp?BID=3D4&SID=3D5 )its writte=
n on page 8:
> > "Determine the fan counter according to:
> > Count =3D (1.5=D710^6) / RPM "
> > That means that the driver is reporting the count value, not the rpm.
> > So i have to compute in sensors.conf:
> > RPM =3D (1.5=D710^6)/ Count
>
> Almost all chips do that, but that's not the point. Our sysfs-interface
> standard says that the conversion to RPM must occur in the driver and
> not in user-space. So the f75375 driver needs to be updated.
Fixed, if i use the new driver version i can see correct values (e.g. 2329 =
RPM).

> > > +#define SENSORS_F75373_FAN_FEATURES(nr) \
> > > +        { { SENSORS_F75373_FAN(nr), "fan" #nr, \
> > > +                NOMAP, NOMAP, R }, \
> > > +                NOSYSCTL, VALUE(2), 0 }, \
> > > +        { { SENSORS_F75373_FAN_MAX(nr), "fan" #nr "_max", \
> > > +                SENSORS_F75373_FAN(nr), SENSORS_F75373_FAN(nr), RW }=
, \
> > > +                NOSYSCTL, VALUE(1), 0 }, \
> > >
> > > Strange, I've never seen a fan speed sensor with a high limit. What
> > > does it correspond to exactly? Why don't you display this value in
> > > "sensors"?
> >
> > I get the information out of the documentation on page 26:
> > "When power on, the PWMOUT1 will output full duty cycle (FFh) to
> > enable system FAN. After 10 seconds when detecting FANIN1
> > signal, assuming the fan has been fully turned on, the fan speed
> > count detected will be recorded in the register.".
> > Dunno if it should be removed?
>
> Oh, I see, it is recording the maximum possible speed. It should be
> marked read-only then, I guess. I am also reluctant to naming this
> feature fan1_max, even if we don't use that name yet, because the _max
> suffix is only used for limits at the moment so it might be confusing
> to use _max for something else now. Maybe fan1_full? This should be
> discussed separately. In the meantime, I suggest that you omit this
> value in libsensors.
I have omited the fan1_max/_full part.

> > > +        { { SENSORS_F75373_FAN_MIN(nr), "fan" #nr "_min", \
> > > +                SENSORS_F75373_FAN(nr), NOMAP, R }, \
> > > +                NOSYSCTL, VALUE(1), 0 }
> > >
> > > SENSORS_F75373_FAN(nr) instead of NOMAP.
> > >
> > > Is it really read-only?
> >
> > I changed it to SENSORS_F75373_FAN(nr), it is RW.
> > But fanX_min is allways zero, so it lead to an error on calling
> > 'sensors_get_feature(*name, SENSORS_F75373_FAN_MIN(i), &min)',
> > i have to disable it, sensors output is now
> > CPU Fan:  1866 RPM  (min =3D    0 RPM)
> > to
> > CPU Fan:  1866 RPM
>
> fan1_min =3D 0 isn't an error per se. If you see an error, then something
> else must be wrong. Can you read the value from fan1_min directly from
> sysfs?
Yes, i read 0 directly from sysfs, but i can set another value, i've discus=
sed it with Riku Voipio, the author of the driver, he said maybe my bios is=
 setting it to zero.
Should the fanx_min value be displayed using sensors (e.g. "CPU Fan:  1866 =
RPM  (min =3D  4242 RPM)" ) ?

> >
> > I only copied it from SENSORS_DME1737_PWM_FEATURES, should i remove it?
>
> Ah, I hadn't noticed that the DME1737 had definitions for PWM. It's
> more of an exception than the rule. So yes, please remove the PWM stuff.
I deleted the PWM- stuff.

> > > +    if (valid) {
> > > +      print_label(label, 10);
> > > +      print_temp_info(cur, max, 0, HYST , 0, 0);
> > > +      printf("%s\n", alarm ? "ALARM" : "");
> > > +    }
> > >
> > > This doesn't make sense. What is SENSORS_F75373_TEMP_HYST exactly? Why
> > > do you display it as an alarm?
> >
> > It was a mistake, i deleted the Alarm output, now it is only printf("\n=
"),
> > there seems not to be a value for an alarm.
> > temp1_max_hyst is always zero, i don't now what it is exactly and
> > when it is not zero.
>
> temp1_max_hyst is supposed to represent the hysteresis temperature
> value for the temp1_max limit, and the value should be passed as the
> 3rd argument to print_temp_info(). If it reads 0, maybe that's a driver
> bug. Again, try reading the value directly from sysfs. And please
> report the problems you find to the driver author so that he can fix
> them.
>
tempx_max_hyst is always zero:
<output>
root@pc:/sys/devices/pci0000:00/0000:00:01.1/i2c-2/2-002d# cat temp1_max_hy=
st
0
</output>
but i can set it by hand. It's now shown ( e.g. "CPU Temp:    +47=B0C  (hig=
h =3D   +54=B0C, hyst =3D   +41=B0C)" ).

> > ERROR: Can't get feature `fan1_min' data!
> > CPU PWM: 31.00 (pwm1)
> > What's the reason? Did I still have to use "F75373"?
>
> I see. This suggests that the driver itself identifies the chip as
> F75373, and that's not correct. You need to put "f75373" in sensors,
> and the driver needs to be updated in the same way.
Fixed in the driver.

> > > Also, what about the F75375 support? As far as I know the f75375s
> > >  driver
> > > supports both chips, so it'd be nice to have user-space support for
> > > both. Also, it might be less confusing to use F75375 for all the
> > > libsensors defines, rather than F75373, so that they match the driver
> > > name.
> >
> > I changed every define/function from F75373 to F75375, i added also:
> > #define SENSORS_F75373_PREFIX "f75373"
> > #define SENSORS_F75375_PREFIX "f75375"
> > and
> > { SENSORS_F75375_PREFIX, f75375_features },
> > { SENSORS_F75373_PREFIX, f75375_features },
> > and
> > { "F75375", print_f75375 },
> > { "F75373", print_f75375 },
>
> Except for the leading capital, yes, it's OK. That being said, what's
> the difference between the F75373 and the F75375? If the F75375 has
> less inputs, then you'll need to adjust the code in "sensors" to not
> try to display the missing inputs.
Fixed i can now use f75375 & f75373.


best regards
christian.

      =20
---------------------------------
Beginnen Sie den Tag mit den neuesten Nachrichten. Machen Sie Yahoo! zu Ihr=
er Startseite!
--0-1846721365-1184096665=:59813
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<span style=3D"font-family: courier;">Hi Jean,</span><br style=3D"font-fami=
ly: courier;"><br style=3D"font-family: courier;"><span style=3D"font-famil=
y: courier;">&gt; The reject message explained that you shouldn't be sendin=
g HTML mails.</span><br style=3D"font-family: courier;"><span style=3D"font=
-family: courier;">&gt; This makes your mails more than twice as big as the=
y should, and that</span><br style=3D"font-family: courier;"><span style=3D=
"font-family: courier;">&gt; explains the reject.</span><br style=3D"font-f=
amily: courier;"><span style=3D"font-family: courier;">Sorry, i'm not able =
to change it. I'm using just a freemail account.</span><br style=3D"font-fa=
mily: courier;"><br style=3D"font-family: courier;"><span style=3D"font-fam=
ily: courier;">&gt; Sounds like a bug in the driver then. Setting pwm1_enab=
le to 0 should</span><br style=3D"font-family: courier;"><span style=3D"fon=
t-family: courier;">&gt; turn the fan to full speed.</span><br style=3D"fon=
t-family: courier;"><span style=3D"font-family:
 courier;">Fixed, using new driver version lets the fan turn to full speed.=
</span><br style=3D"font-family: courier;"><br style=3D"font-family: courie=
r;"><span style=3D"font-family: courier;">&gt; &gt; I try to set limits in =
sensors.conf but i could see no change.</span><br style=3D"font-family: cou=
rier;"><span style=3D"font-family: courier;">&gt;</span><br style=3D"font-f=
amily: courier;"><span style=3D"font-family: courier;">&gt; You must run "s=
ensors -s" after changing the limits</span><br style=3D"font-family: courie=
r;"><span style=3D"font-family: courier;">&gt; in /etc/sensors.conf for the=
 new limits to be applied. Please test this,</span><br style=3D"font-family=
: courier;"><span style=3D"font-family: courier;">&gt; this is a good way t=
o test both the libsensors code you added, and the</span><br style=3D"font-=
family: courier;"><span style=3D"font-family: courier;">&gt; driver itself.=
</span><br style=3D"font-family: courier;"><span style=3D"font-family: cour=
ier;">After using "sensors -s" i can see
 the limits i set in sensors.conf (e.g. "VCC: +1.72 V (min =3D +1.65 V, max=
 =3D +1.85 V)").</span><br style=3D"font-family: courier;"><span style=3D"f=
ont-family: courier;">But a inx_alarm is missing, so i see only the values.=
</span><br style=3D"font-family: courier;"><span style=3D"font-family: cour=
ier;">What would be a good value for the sensors.conf.eg entry e.g.</span><=
br style=3D"font-family: courier;"><span style=3D"font-family: courier;">se=
t in0_min&nbsp;&nbsp; 1.72 * 0.95</span><br style=3D"font-family: courier;"=
><span style=3D"font-family: courier;">set in0_max&nbsp;&nbsp; 1.72 * 1.05 =
?</span><br style=3D"font-family: courier;"><br style=3D"font-family: couri=
er;"><span style=3D"font-family: courier;">&gt; &gt; &gt; Lastly, you reall=
y shouldn't have to divide the values by 1000. This</span><br style=3D"font=
-family: courier;"><span style=3D"font-family: courier;">&gt; &gt; &gt; sug=
gests that the magnitude wasn't set properly in libsensors (it</span><br st=
yle=3D"font-family: courier;"><span
 style=3D"font-family: courier;">&gt; &gt; &gt; should be 3, I suggest it i=
s 0). This issue is most probably related to</span><br style=3D"font-family=
: courier;"><span style=3D"font-family: courier;">&gt; &gt; &gt; the incorr=
ect symbol names.</span><br style=3D"font-family: courier;"><span style=3D"=
font-family: courier;">&gt; &gt;</span><br style=3D"font-family: courier;">=
<span style=3D"font-family: courier;">&gt; &gt; I saw values &gt;800V so i =
thought i have to divide it by 1000 in sensors.conf.</span><br style=3D"fon=
t-family: courier;"><span style=3D"font-family: courier;">&gt; &gt; Magnitu=
de is 3 and the symbol name is correct now, but the values are still</span>=
<br style=3D"font-family: courier;"><span style=3D"font-family: courier;">&=
gt; &gt; over 800V. What's the reason?</span><br style=3D"font-family: cour=
ier;"><span style=3D"font-family: courier;">&gt;</span><br style=3D"font-fa=
mily: courier;"><span style=3D"font-family: courier;">&gt; I guess that's a=
 bug in the driver. What values do you see
 in the</span><br style=3D"font-family: courier;"><span style=3D"font-famil=
y: courier;">&gt; in*_input sysfs files?</span><br style=3D"font-family: co=
urier;"><span style=3D"font-family: courier;">Fixed, if i use the new drive=
r version i can see correct values (e.g. 1.72V).</span><br style=3D"font-fa=
mily: courier;"><br style=3D"font-family: courier;"><span style=3D"font-fam=
ily: courier;">&gt; &gt; &gt; This means that the driver isn't reporting th=
e values in RPM as it</span><br style=3D"font-family: courier;"><span style=
=3D"font-family: courier;">&gt; &gt; &gt; should. Usually no compute statem=
ent is needed for fans.</span><br style=3D"font-family: courier;"><span sty=
le=3D"font-family: courier;">&gt; &gt;</span><br style=3D"font-family: cour=
ier;"><span style=3D"font-family: courier;">&gt; &gt; That's correct, the v=
alue is not in RPM, in the document '2005111153128.pdf' you can download on=
 the fintek page</span><br style=3D"font-family: courier;"><span style=3D"f=
ont-family: courier;">&gt; &gt; (
 http://www.fintek.com.tw/eng/products.asp?BID=3D4&amp;SID=3D5 )its written=
 on page 8:</span><br style=3D"font-family: courier;"><span style=3D"font-f=
amily: courier;">&gt; &gt; "Determine the fan counter according to:</span><=
br style=3D"font-family: courier;"><span style=3D"font-family: courier;">&g=
t; &gt; Count =3D (1.5=D710^6) / RPM "</span><br style=3D"font-family: cour=
ier;"><span style=3D"font-family: courier;">&gt; &gt; That means that the d=
river is reporting the count value, not the rpm.</span><br style=3D"font-fa=
mily: courier;"><span style=3D"font-family: courier;">&gt; &gt; So i have t=
o compute in sensors.conf:</span><br style=3D"font-family: courier;"><span =
style=3D"font-family: courier;">&gt; &gt; RPM =3D (1.5=D710^6)/ Count</span=
><br style=3D"font-family: courier;"><span style=3D"font-family: courier;">=
&gt;</span><br style=3D"font-family: courier;"><span style=3D"font-family: =
courier;">&gt; Almost all chips do that, but that's not the point. Our sysf=
s-interface</span><br style=3D"font-family:
 courier;"><span style=3D"font-family: courier;">&gt; standard says that th=
e conversion to RPM must occur in the driver and</span><br style=3D"font-fa=
mily: courier;"><span style=3D"font-family: courier;">&gt; not in user-spac=
e. So the f75375 driver needs to be updated.</span><br style=3D"font-family=
: courier;"><span style=3D"font-family: courier;">Fixed, if i use the new d=
river version i can see correct values (e.g. 2329 RPM).</span><br style=3D"=
font-family: courier;"><br style=3D"font-family: courier;"><span style=3D"f=
ont-family: courier;">&gt; &gt; &gt; +#define SENSORS_F75373_FAN_FEATURES(n=
r) \</span><br style=3D"font-family: courier;"><span style=3D"font-family: =
courier;">&gt; &gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { { SE=
NSORS_F75373_FAN(nr), "fan" #nr, \</span><br style=3D"font-family: courier;=
"><span style=3D"font-family: courier;">&gt; &gt; &gt; +&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NOM=
AP, NOMAP, R }, \</span><br
 style=3D"font-family: courier;"><span style=3D"font-family: courier;">&gt;=
 &gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; NOSYSCTL, VALUE(2), 0 }, \</span><br style=3D"f=
ont-family: courier;"><span style=3D"font-family: courier;">&gt; &gt; &gt; =
+&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { { SENSORS_F75373_FAN_MAX(nr),=
 "fan" #nr "_max", \</span><br style=3D"font-family: courier;"><span style=
=3D"font-family: courier;">&gt; &gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SENSORS_F75373_F=
AN(nr), SENSORS_F75373_FAN(nr), RW }, \</span><br style=3D"font-family: cou=
rier;"><span style=3D"font-family: courier;">&gt; &gt; &gt; +&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; NOSYSCTL, VALUE(1), 0 }, \</span><br style=3D"font-family: courier;"><spa=
n style=3D"font-family: courier;">&gt; &gt; &gt;</span><br style=3D"font-fa=
mily: courier;"><span
 style=3D"font-family: courier;">&gt; &gt; &gt; Strange, I've never seen a =
fan speed sensor with a high limit. What</span><br style=3D"font-family: co=
urier;"><span style=3D"font-family: courier;">&gt; &gt; &gt; does it corres=
pond to exactly? Why don't you display this value in</span><br style=3D"fon=
t-family: courier;"><span style=3D"font-family: courier;">&gt; &gt; &gt; "s=
ensors"?</span><br style=3D"font-family: courier;"><span style=3D"font-fami=
ly: courier;">&gt; &gt;</span><br style=3D"font-family: courier;"><span sty=
le=3D"font-family: courier;">&gt; &gt; I get the information out of the doc=
umentation on page 26:</span><br style=3D"font-family: courier;"><span styl=
e=3D"font-family: courier;">&gt; &gt; "When power on, the PWMOUT1 will outp=
ut full duty cycle (FFh) to</span><br style=3D"font-family: courier;"><span=
 style=3D"font-family: courier;">&gt; &gt; enable system FAN. After 10 seco=
nds when detecting FANIN1</span><br style=3D"font-family: courier;"><span s=
tyle=3D"font-family: courier;">&gt; &gt;
 signal, assuming the fan has been fully turned on, the fan speed</span><br=
 style=3D"font-family: courier;"><span style=3D"font-family: courier;">&gt;=
 &gt; count detected will be recorded in the register.".</span><br style=3D=
"font-family: courier;"><span style=3D"font-family: courier;">&gt; &gt; Dun=
no if it should be removed?</span><br style=3D"font-family: courier;"><span=
 style=3D"font-family: courier;">&gt;</span><br style=3D"font-family: couri=
er;"><span style=3D"font-family: courier;">&gt; Oh, I see, it is recording =
the maximum possible speed. It should be</span><br style=3D"font-family: co=
urier;"><span style=3D"font-family: courier;">&gt; marked read-only then, I=
 guess. I am also reluctant to naming this</span><br style=3D"font-family: =
courier;"><span style=3D"font-family: courier;">&gt; feature fan1_max, even=
 if we don't use that name yet, because the _max</span><br style=3D"font-fa=
mily: courier;"><span style=3D"font-family: courier;">&gt; suffix is only u=
sed for limits at the moment so it might
 be confusing</span><br style=3D"font-family: courier;"><span style=3D"font=
-family: courier;">&gt; to use _max for something else now. Maybe fan1_full=
? This should be</span><br style=3D"font-family: courier;"><span style=3D"f=
ont-family: courier;">&gt; discussed separately. In the meantime, I suggest=
 that you omit this</span><br style=3D"font-family: courier;"><span style=
=3D"font-family: courier;">&gt; value in libsensors.</span><br style=3D"fon=
t-family: courier;"><span style=3D"font-family: courier;">I have omited the=
 fan1_max/_full part.</span><br style=3D"font-family: courier;"><br style=
=3D"font-family: courier;"><span style=3D"font-family: courier;">&gt; &gt; =
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; { { SENSORS_F75373_FAN_MIN=
(nr), "fan" #nr "_min", \</span><br style=3D"font-family: courier;"><span s=
tyle=3D"font-family: courier;">&gt; &gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SENSORS_F753=
73_FAN(nr), NOMAP, R }, \</span><br
 style=3D"font-family: courier;"><span style=3D"font-family: courier;">&gt;=
 &gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; NOSYSCTL, VALUE(1), 0 }</span><br style=3D"font=
-family: courier;"><span style=3D"font-family: courier;">&gt; &gt; &gt;</sp=
an><br style=3D"font-family: courier;"><span style=3D"font-family: courier;=
">&gt; &gt; &gt; SENSORS_F75373_FAN(nr) instead of NOMAP.</span><br style=
=3D"font-family: courier;"><span style=3D"font-family: courier;">&gt; &gt; =
&gt;</span><br style=3D"font-family: courier;"><span style=3D"font-family: =
courier;">&gt; &gt; &gt; Is it really read-only?</span><br style=3D"font-fa=
mily: courier;"><span style=3D"font-family: courier;">&gt; &gt;</span><br s=
tyle=3D"font-family: courier;"><span style=3D"font-family: courier;">&gt; &=
gt; I changed it to SENSORS_F75373_FAN(nr), it is RW.</span><br style=3D"fo=
nt-family: courier;"><span style=3D"font-family: courier;">&gt; &gt; But fa=
nX_min is allways zero, so it lead to an error
 on calling</span><br style=3D"font-family: courier;"><span style=3D"font-f=
amily: courier;">&gt; &gt; 'sensors_get_feature(*name, SENSORS_F75373_FAN_M=
IN(i), &amp;min)',</span><br style=3D"font-family: courier;"><span style=3D=
"font-family: courier;">&gt; &gt; i have to disable it, sensors output is n=
ow</span><br style=3D"font-family: courier;"><span style=3D"font-family: co=
urier;">&gt; &gt; CPU Fan:&nbsp; 1866 RPM&nbsp; (min =3D&nbsp;&nbsp;&nbsp; =
0 RPM)</span><br style=3D"font-family: courier;"><span style=3D"font-family=
: courier;">&gt; &gt; to</span><br style=3D"font-family: courier;"><span st=
yle=3D"font-family: courier;">&gt; &gt; CPU Fan:&nbsp; 1866 RPM</span><br s=
tyle=3D"font-family: courier;"><span style=3D"font-family: courier;">&gt;</=
span><br style=3D"font-family: courier;"><span style=3D"font-family: courie=
r;">&gt; fan1_min =3D 0 isn't an error per se. If you see an error, then so=
mething</span><br style=3D"font-family: courier;"><span style=3D"font-famil=
y: courier;">&gt; else must be wrong. Can you
 read the value from fan1_min directly from</span><br style=3D"font-family:=
 courier;"><span style=3D"font-family: courier;">&gt; sysfs?</span><br styl=
e=3D"font-family: courier;"><span style=3D"font-family: courier;">Yes, i re=
ad 0 directly from sysfs, but i can set another value, i've discussed it wi=
th Riku Voipio, the author of the driver, he said maybe my bios is setting =
it to zero.</span><br style=3D"font-family: courier;"><span style=3D"font-f=
amily: courier;">Should the fanx_min value be displayed using sensors (e.g.=
 "CPU Fan:&nbsp; 1866 RPM&nbsp; (min =3D&nbsp; 4242 RPM)" ) ?</span><br sty=
le=3D"font-family: courier;"><br style=3D"font-family: courier;"><span styl=
e=3D"font-family: courier;">&gt; &gt;</span><br style=3D"font-family: couri=
er;"><span style=3D"font-family: courier;">&gt; &gt; I only copied it from =
SENSORS_DME1737_PWM_FEATURES, should i remove it?</span><br style=3D"font-f=
amily: courier;"><span style=3D"font-family: courier;">&gt;</span><br style=
=3D"font-family: courier;"><span
 style=3D"font-family: courier;">&gt; Ah, I hadn't noticed that the DME1737=
 had definitions for PWM. It's</span><br style=3D"font-family: courier;"><s=
pan style=3D"font-family: courier;">&gt; more of an exception than the rule=
. So yes, please remove the PWM stuff.</span><br style=3D"font-family: cour=
ier;"><span style=3D"font-family: courier;">I deleted the PWM- stuff.</span=
><br style=3D"font-family: courier;"><br style=3D"font-family: courier;"><s=
pan style=3D"font-family: courier;">&gt; &gt; &gt; +&nbsp;&nbsp;&nbsp; if (=
valid) {</span><br style=3D"font-family: courier;"><span style=3D"font-fami=
ly: courier;">&gt; &gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; print_label(la=
bel, 10);</span><br style=3D"font-family: courier;"><span style=3D"font-fam=
ily: courier;">&gt; &gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; print_temp_in=
fo(cur, max, 0, HYST , 0, 0);</span><br style=3D"font-family: courier;"><sp=
an style=3D"font-family: courier;">&gt; &gt; &gt; +&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; printf("%s\n", alarm ? "ALARM" :
 "");</span><br style=3D"font-family: courier;"><span style=3D"font-family:=
 courier;">&gt; &gt; &gt; +&nbsp;&nbsp;&nbsp; }</span><br style=3D"font-fam=
ily: courier;"><span style=3D"font-family: courier;">&gt; &gt; &gt;</span><=
br style=3D"font-family: courier;"><span style=3D"font-family: courier;">&g=
t; &gt; &gt; This doesn't make sense. What is SENSORS_F75373_TEMP_HYST exac=
tly? Why</span><br style=3D"font-family: courier;"><span style=3D"font-fami=
ly: courier;">&gt; &gt; &gt; do you display it as an alarm?</span><br style=
=3D"font-family: courier;"><span style=3D"font-family: courier;">&gt; &gt;<=
/span><br style=3D"font-family: courier;"><span style=3D"font-family: couri=
er;">&gt; &gt; It was a mistake, i deleted the Alarm output, now it is only=
 printf("\n"),</span><br style=3D"font-family: courier;"><span style=3D"fon=
t-family: courier;">&gt; &gt; there seems not to be a value for an alarm.</=
span><br style=3D"font-family: courier;"><span style=3D"font-family: courie=
r;">&gt; &gt; temp1_max_hyst is always zero,
 i don't now what it is exactly and</span><br style=3D"font-family: courier=
;"><span style=3D"font-family: courier;">&gt; &gt; when it is not zero.</sp=
an><br style=3D"font-family: courier;"><span style=3D"font-family: courier;=
">&gt;</span><br style=3D"font-family: courier;"><span style=3D"font-family=
: courier;">&gt; temp1_max_hyst is supposed to represent the hysteresis tem=
perature</span><br style=3D"font-family: courier;"><span style=3D"font-fami=
ly: courier;">&gt; value for the temp1_max limit, and the value should be p=
assed as the</span><br style=3D"font-family: courier;"><span style=3D"font-=
family: courier;">&gt; 3rd argument to print_temp_info(). If it reads 0, ma=
ybe that's a driver</span><br style=3D"font-family: courier;"><span style=
=3D"font-family: courier;">&gt; bug. Again, try reading the value directly =
from sysfs. And please</span><br style=3D"font-family: courier;"><span styl=
e=3D"font-family: courier;">&gt; report the problems you find to the driver=
 author so that he can fix</span><br
 style=3D"font-family: courier;"><span style=3D"font-family: courier;">&gt;=
 them.</span><br style=3D"font-family: courier;"><span style=3D"font-family=
: courier;">&gt;</span><br style=3D"font-family: courier;"><span style=3D"f=
ont-family: courier;">tempx_max_hyst is always zero:</span><br style=3D"fon=
t-family: courier;"><span style=3D"font-family: courier;">&lt;output&gt;</s=
pan><br style=3D"font-family: courier;"><span style=3D"font-family: courier=
;">root@pc:/sys/devices/pci0000:00/0000:00:01.1/i2c-2/2-002d# cat temp1_max=
_hyst</span><br style=3D"font-family: courier;"><span style=3D"font-family:=
 courier;">0</span><br style=3D"font-family: courier;"><span style=3D"font-=
family: courier;">&lt;/output&gt;</span><br style=3D"font-family: courier;"=
><span style=3D"font-family: courier;">but i can set it by hand. It's now s=
hown ( e.g. "CPU Temp:&nbsp;&nbsp;&nbsp; +47=B0C&nbsp; (high =3D&nbsp;&nbsp=
; +54=B0C, hyst =3D&nbsp;&nbsp; +41=B0C)" ).</span><br style=3D"font-family=
: courier;"><br style=3D"font-family: courier;"><span
 style=3D"font-family: courier;">&gt; &gt; ERROR: Can't get feature `fan1_m=
in' data!</span><br style=3D"font-family: courier;"><span style=3D"font-fam=
ily: courier;">&gt; &gt; CPU PWM: 31.00 (pwm1)</span><br style=3D"font-fami=
ly: courier;"><span style=3D"font-family: courier;">&gt; &gt; What's the re=
ason? Did I still have to use "F75373"?</span><br style=3D"font-family: cou=
rier;"><span style=3D"font-family: courier;">&gt;</span><br style=3D"font-f=
amily: courier;"><span style=3D"font-family: courier;">&gt; I see. This sug=
gests that the driver itself identifies the chip as</span><br style=3D"font=
-family: courier;"><span style=3D"font-family: courier;">&gt; F75373, and t=
hat's not correct. You need to put "f75373" in sensors,</span><br style=3D"=
font-family: courier;"><span style=3D"font-family: courier;">&gt; and the d=
river needs to be updated in the same way.</span><br style=3D"font-family: =
courier;"><span style=3D"font-family: courier;">Fixed in the driver.</span>=
<br style=3D"font-family: courier;"><br
 style=3D"font-family: courier;"><span style=3D"font-family: courier;">&gt;=
 &gt; &gt; Also, what about the F75375 support? As far as I know the f75375=
s</span><br style=3D"font-family: courier;"><span style=3D"font-family: cou=
rier;">&gt; &gt; &gt;&nbsp; driver</span><br style=3D"font-family: courier;=
"><span style=3D"font-family: courier;">&gt; &gt; &gt; supports both chips,=
 so it'd be nice to have user-space support for</span><br style=3D"font-fam=
ily: courier;"><span style=3D"font-family: courier;">&gt; &gt; &gt; both. A=
lso, it might be less confusing to use F75375 for all the</span><br style=
=3D"font-family: courier;"><span style=3D"font-family: courier;">&gt; &gt; =
&gt; libsensors defines, rather than F75373, so that they match the driver<=
/span><br style=3D"font-family: courier;"><span style=3D"font-family: couri=
er;">&gt; &gt; &gt; name.</span><br style=3D"font-family: courier;"><span s=
tyle=3D"font-family: courier;">&gt; &gt;</span><br style=3D"font-family: co=
urier;"><span style=3D"font-family:
 courier;">&gt; &gt; I changed every define/function from F75373 to F75375,=
 i added also:</span><br style=3D"font-family: courier;"><span style=3D"fon=
t-family: courier;">&gt; &gt; #define SENSORS_F75373_PREFIX "f75373"</span>=
<br style=3D"font-family: courier;"><span style=3D"font-family: courier;">&=
gt; &gt; #define SENSORS_F75375_PREFIX "f75375"</span><br style=3D"font-fam=
ily: courier;"><span style=3D"font-family: courier;">&gt; &gt; and</span><b=
r style=3D"font-family: courier;"><span style=3D"font-family: courier;">&gt=
; &gt; { SENSORS_F75375_PREFIX, f75375_features },</span><br style=3D"font-=
family: courier;"><span style=3D"font-family: courier;">&gt; &gt; { SENSORS=
_F75373_PREFIX, f75375_features },</span><br style=3D"font-family: courier;=
"><span style=3D"font-family: courier;">&gt; &gt; and</span><br style=3D"fo=
nt-family: courier;"><span style=3D"font-family: courier;">&gt; &gt; { "F75=
375", print_f75375 },</span><br style=3D"font-family: courier;"><span style=
=3D"font-family: courier;">&gt; &gt; {
 "F75373", print_f75375 },</span><br style=3D"font-family: courier;"><span =
style=3D"font-family: courier;">&gt;</span><br style=3D"font-family: courie=
r;"><span style=3D"font-family: courier;">&gt; Except for the leading capit=
al, yes, it's OK. That being said, what's</span><br style=3D"font-family: c=
ourier;"><span style=3D"font-family: courier;">&gt; the difference between =
the F75373 and the F75375? If the F75375 has</span><br style=3D"font-family=
: courier;"><span style=3D"font-family: courier;">&gt; less inputs, then yo=
u'll need to adjust the code in "sensors" to not</span><br style=3D"font-fa=
mily: courier;"><span style=3D"font-family: courier;">&gt; try to display t=
he missing inputs.</span><br style=3D"font-family: courier;"><span style=3D=
"font-family: courier;">Fixed i can now use f75375 &amp; f75373.</span><br =
style=3D"font-family: courier;"><br style=3D"font-family: courier;"><pre st=
yle=3D"font-family: courier;">best regards<br>christian.</pre><p>&#32;



      <hr size=3D1>Beginnen Sie den Tag mit den neuesten Nachrichten. <a hr=
ef=3D"http://de.rd.yahoo.com/evt=3D41213/*http://de.yahoo.com/set" target=
=3D_new >Machen Sie Yahoo! zu Ihrer Startseite!</a>
--0-1846721365-1184096665=:59813--

--0-892538531-1184096665=:59813
Content-Type: application/octet-stream; name="fintek_75373s_support_v3.patch"
Content-Transfer-Encoding: base64
Content-Description: pat943948581
Content-Disposition: attachment; filename="fintek_75373s_support_v3.patch"

ZGlmZiAtdXJOIGxtLXNlbnNvcnNfb3JnL2V0Yy9zZW5zb3JzLmNvbmYuZWcg
bG0tc2Vuc29ycy9ldGMvc2Vuc29ycy5jb25mLmVnCi0tLSBsbS1zZW5zb3Jz
X29yZy9ldGMvc2Vuc29ycy5jb25mLmVnCTIwMDctMDctMDIgMTg6NTY6MDAu
MDAwMDAwMDAwICswMjAwCisrKyBsbS1zZW5zb3JzL2V0Yy9zZW5zb3JzLmNv
bmYuZWcJMjAwNy0wNy0xMCAyMDowMTozNy4wMDAwMDAwMDAgKzAyMDAKQEAg
LTI5MjcsMyArMjkyNywyMyBAQAogICAgIGNvbXB1dGUgaW42ICAgICAgIChA
ICogNS4yNSksIChAIC8gNS4yNSkKICAgICBjb21wdXRlIGluNyAgICAgICAo
QCAqIDIpLCAoQCAvIDIpCiAgICAgY29tcHV0ZSBpbjggICAgICAgKEAgKiAy
KSwgKEAgLyAyKQorCisKKyMKKyMgU2FtcGxlIGNvbmZpZ3VyYXRpb24gZm9y
IHRoZSBGaW50ZWsgRjc1Mzc1L0Y3NTM3M1MKKyMKK2NoaXAgImY3NTM3NS0q
IiAiZjc1MzczLSoiCisKKyMgVm9sdGFnZXMKKyAgIGxhYmVsIGluMCAiVkND
IgorICAgbGFiZWwgaW4xICJWMSIKKyAgIGxhYmVsIGluMiAiVjIiCisgICBs
YWJlbCBpbjMgIlYzIgorICAgIAorIyBGYW5zCisgICBsYWJlbCBmYW4xICJD
UFUgRmFuIgorICAgbGFiZWwgZmFuMiAiU3lzIEZhbiIKKworIyBUZW1wZXJh
dHVyZXMKKyAgIGxhYmVsIHRlbXAxICJDUFUgVGVtcCIKKyAgIGxhYmVsIHRl
bXAyICJTeXMgVGVtcCIKZGlmZiAtdXJOIGxtLXNlbnNvcnNfb3JnL2xpYi9j
aGlwcy5jIGxtLXNlbnNvcnMvbGliL2NoaXBzLmMKLS0tIGxtLXNlbnNvcnNf
b3JnL2xpYi9jaGlwcy5jCTIwMDctMDctMDIgMTg6NTU6NTkuMDAwMDAwMDAw
ICswMjAwCisrKyBsbS1zZW5zb3JzL2xpYi9jaGlwcy5jCTIwMDctMDctMTAg
MjE6MTM6MDguMDAwMDAwMDAwICswMjAwCkBAIC02MjE3LDYgKzYyMTcsNDkg
QEAKIAl7IHsgMCB9LCAwIH0KIH07CiAKKyNkZWZpbmUgU0VOU09SU19GNzUz
NzVfSU5fRkVBVFVSRVMobnIpIFwKKyAgICAgICAgeyB7IFNFTlNPUlNfRjc1
Mzc1X0lOKG5yKSwgImluIiAjbnIsIFwKKyAgICAgICAgICAgICAgICBOT01B
UCwgTk9NQVAsIFIgfSwgXAorICAgICAgICAgICAgICAgIE5PU1lTQ1RMLCBW
QUxVRSgzKSwgMyB9LCBcCisgICAgICAgIHsgeyBTRU5TT1JTX0Y3NTM3NV9J
Tl9NSU4obnIpLCAiaW4iICNuciAiX21pbiIsIFwKKyAgICAgICAgICAgICAg
ICBTRU5TT1JTX0Y3NTM3NV9JTihuciksIFNFTlNPUlNfRjc1Mzc1X0lOKG5y
KSwgUlcgfSwgXAorICAgICAgICAgICAgICAgIE5PU1lTQ1RMLCBWQUxVRSgx
KSwgMyB9LCBcCisgICAgICAgIHsgeyBTRU5TT1JTX0Y3NTM3NV9JTl9NQVgo
bnIpLCAiaW4iICNuciAiX21heCIsIFwKKyAgICAgICAgICAgICAgICBTRU5T
T1JTX0Y3NTM3NV9JTihuciksIFNFTlNPUlNfRjc1Mzc1X0lOKG5yKSwgUlcg
fSwgXAorICAgICAgICAgICAgICAgIE5PU1lTQ1RMLCBWQUxVRSgyKSwgMyB9
CisKKyNkZWZpbmUgU0VOU09SU19GNzUzNzVfVEVNUF9GRUFUVVJFUyhucikg
XAorICAgICAgICB7IHsgU0VOU09SU19GNzUzNzVfVEVNUChuciksICJ0ZW1w
IiAjbnIsIFwKKyAgICAgICAgICAgICAgICBOT01BUCwgTk9NQVAsIFIgfSwg
XAorICAgICAgICAgICAgICAgIE5PU1lTQ1RMLCBWQUxVRSgzKSwgMyB9LCBc
CisgICAgICAgIHsgeyBTRU5TT1JTX0Y3NTM3NV9URU1QX01BWChuciksICJ0
ZW1wIiAjbnIgIl9tYXgiLCBcCisgICAgICAgICAgICAgICAgU0VOU09SU19G
NzUzNzVfVEVNUChuciksIFNFTlNPUlNfRjc1Mzc1X1RFTVAobnIpLCBSVyB9
LCBcCisgICAgICAgICAgICAgICAgTk9TWVNDVEwsIFZBTFVFKDEpLCAzIH0s
IFwKKyAgICAgICAgeyB7IFNFTlNPUlNfRjc1Mzc1X1RFTVBfSFlTVChuciks
ICJ0ZW1wIiAjbnIgIl9oeXN0IiwgXAorICAgICAgICAgICAgICAgIFNFTlNP
UlNfRjc1Mzc1X1RFTVAobnIpLCBTRU5TT1JTX0Y3NTM3NV9URU1QKG5yKSwg
UlcgfSwgXAorICAgICAgICAgICAgICAgIE5PU1lTQ1RMLCBWQUxVRSgyKSwg
MyB9CisKKyNkZWZpbmUgU0VOU09SU19GNzUzNzVfRkFOX0ZFQVRVUkVTKG5y
KSBcCisgICAgICAgIHsgeyBTRU5TT1JTX0Y3NTM3NV9GQU4obnIpLCAiZmFu
IiAjbnIsIFwKKyAgICAgICAgICAgICAgICBOT01BUCwgTk9NQVAsIFIgfSwg
XAorICAgICAgICAgICAgICAgIE5PU1lTQ1RMLCBWQUxVRSgyKSwgMCB9LCBc
CisgICAgICAgIHsgeyBTRU5TT1JTX0Y3NTM3NV9GQU5fTUlOKG5yKSwgImZh
biIgI25yICJfbWluIiwgXAorICAgICAgICAgICAgICAgIFNFTlNPUlNfRjc1
Mzc1X0ZBTihuciksIFNFTlNPUlNfRjc1Mzc1X0ZBTihuciksIFJXIH0sIFwK
KyAgICAgICAgICAgICAgICBOT1NZU0NUTCwgVkFMVUUoMSksIDAgfQorCitz
dGF0aWMgc2Vuc29yc19jaGlwX2ZlYXR1cmUgZjc1Mzc1X2ZlYXR1cmVzW10g
PQoreworICAgICAgICBTRU5TT1JTX0Y3NTM3NV9JTl9GRUFUVVJFUygwKSwK
KyAgICAgICAgU0VOU09SU19GNzUzNzVfSU5fRkVBVFVSRVMoMSksCisgICAg
ICAgIFNFTlNPUlNfRjc1Mzc1X0lOX0ZFQVRVUkVTKDIpLAorICAgICAgICBT
RU5TT1JTX0Y3NTM3NV9JTl9GRUFUVVJFUygzKSwKKyAgICAgICAgU0VOU09S
U19GNzUzNzVfVEVNUF9GRUFUVVJFUygxKSwKKyAgICAgICAgU0VOU09SU19G
NzUzNzVfVEVNUF9GRUFUVVJFUygyKSwKKyAgICAgICAgU0VOU09SU19GNzUz
NzVfRkFOX0ZFQVRVUkVTKDEpLAorICAgICAgICBTRU5TT1JTX0Y3NTM3NV9G
QU5fRkVBVFVSRVMoMiksCisgICAgICAgIHsgeyAwIH0sIDAgfQorfTsKKwog
c2Vuc29yc19jaGlwX2ZlYXR1cmVzIHNlbnNvcnNfY2hpcF9mZWF0dXJlc19s
aXN0W10gPQogewogIHsgU0VOU09SU19MTTc4X1BSRUZJWCwgbG03OF9mZWF0
dXJlcyB9LApAQCAtNjMzNCw1ICs2Mzc3LDcgQEAKICB7IFNFTlNPUlNfRE1F
MTczN19QUkVGSVgsIGRtZTE3MzdfZmVhdHVyZXMgfSwKICB7IFNFTlNPUlNf
QVBQTEVTTUNfUFJFRklYLCBhcHBsZXNtY19mZWF0dXJlcyB9LAogIHsgU0VO
U09SU19GNzE4ODJGR19QUkVGSVgsIGY3MTg4MmZnX2ZlYXR1cmVzIH0sCisg
eyBTRU5TT1JTX0Y3NTM3NV9QUkVGSVgsIGY3NTM3NV9mZWF0dXJlcyB9LAor
IHsgU0VOU09SU19GNzUzNzNfUFJFRklYLCBmNzUzNzVfZmVhdHVyZXMgfSwK
ICB7IDAgfQogfTsKZGlmZiAtdXJOIGxtLXNlbnNvcnNfb3JnL2xpYi9jaGlw
cy5oIGxtLXNlbnNvcnMvbGliL2NoaXBzLmgKLS0tIGxtLXNlbnNvcnNfb3Jn
L2xpYi9jaGlwcy5oCTIwMDctMDctMDIgMTg6NTU6NTkuMDAwMDAwMDAwICsw
MjAwCisrKyBsbS1zZW5zb3JzL2xpYi9jaGlwcy5oCTIwMDctMDctMTAgMjA6
MzQ6MDMuMDAwMDAwMDAwICswMjAwCkBAIC0yMzM3LDQgKzIzMzcsMjUgQEAK
ICNkZWZpbmUgU0VOU09SU19GNzE4ODJGR19URU1QX0ZBVUxUKG4pCQkoMTQw
ICsgKG4pKQogI2RlZmluZSBTRU5TT1JTX0Y3MTg4MkZHX1RFTVBfVFlQRShu
KQkJKDE1MCArIChuKSkKIAorLyogRmludGVrIEY3NTM3NS9GNzUzNzNTIHJl
Z2lzdGVycyAgKi8KKworI2RlZmluZSBTRU5TT1JTX0Y3NTM3M19QUkVGSVgg
ImY3NTM3MyIKKyNkZWZpbmUgU0VOU09SU19GNzUzNzVfUFJFRklYICJmNzUz
NzUiCisKKy8qIHZvbHRhZ2UgbiBmcm9tIDEgdG8gNCAqLworI2RlZmluZSBT
RU5TT1JTX0Y3NTM3NV9JTihucikgICAgICAgICAgICgweDAxICsgKG5yKSkK
KyNkZWZpbmUgU0VOU09SU19GNzUzNzVfSU5fTUFYKG5yKSAgICAgICAoMHgx
MSArIChucikgKiAyKQorI2RlZmluZSBTRU5TT1JTX0Y3NTM3NV9JTl9NSU4o
bnIpICAgICAgICgweDIxICsgKG5yKSAqIDIpCisKKy8qIHRlbXAgbiBmcm9t
IDEgdG8gMiAqLworI2RlZmluZSBTRU5TT1JTX0Y3NTM3NV9URU1QKG5yKSAg
ICAgICAgICgweDMxICsgKG5yKSkKKyNkZWZpbmUgU0VOU09SU19GNzUzNzVf
VEVNUF9NQVgobnIpICAgICAoMHg0MSArIChucikgKiAyKQorI2RlZmluZSBT
RU5TT1JTX0Y3NTM3NV9URU1QX0hZU1QobnIpICAgICgweDUxICsgKG5yKSAq
IDIpCisKKy8qIGZhbiBuIGZyb20gMSB0byAyICovCisjZGVmaW5lIFNFTlNP
UlNfRjc1Mzc1X0ZBTihucikgICAgICAgICAgKDB4NjEgKyAobnIpICogMikK
KyNkZWZpbmUgU0VOU09SU19GNzUzNzVfRkFOX01JTihucikgICAgICAoMHg3
MSArIChucikgKiAyKQorLyogRkFOIEZ1bGwgU3BlZWQgQ291bnQgUmVnaXN0
ZXIgKi8KKyNkZWZpbmUgU0VOU09SU19GNzUzNzVfRkFOX0ZVTEwobnIpICAg
ICAgKDB4ODEgKyAobnIpICogMHgxMCkKKwogI2VuZGlmIC8qIGRlZiBMSUJf
U0VOU09SU19DSElQU19IICovCmRpZmYgLXVyTiBsbS1zZW5zb3JzX29yZy9w
cm9nL3NlbnNvcnMvY2hpcHMuYyBsbS1zZW5zb3JzL3Byb2cvc2Vuc29ycy9j
aGlwcy5jCi0tLSBsbS1zZW5zb3JzX29yZy9wcm9nL3NlbnNvcnMvY2hpcHMu
YwkyMDA3LTA3LTAyIDE4OjU2OjAwLjAwMDAwMDAwMCArMDIwMAorKysgbG0t
c2Vuc29ycy9wcm9nL3NlbnNvcnMvY2hpcHMuYwkyMDA3LTA3LTEwIDIwOjA5
OjU0LjAwMDAwMDAwMCArMDIwMApAQCAtNjI1NCw2ICs2MjU0LDg5IEBACiAg
ICAgcHJpbnRfZjcxODgyZmdfdGVtcChuYW1lLCBpKTsKIH0KIAorc3RhdGlj
IHZvaWQgcHJpbnRfZjc1Mzc1X2luKGNvbnN0IHNlbnNvcnNfY2hpcF9uYW1l
ICpuYW1lLCBpbnQgaSkKK3sKKyAgY2hhciAqbGFiZWw7CisgIGRvdWJsZSBj
dXIsIG1pbiwgbWF4OworICBpbnQgdmFsaWQ7CisKKyAgaWYgKCFzZW5zb3Jz
X2dldF9sYWJlbF9hbmRfdmFsaWQoKm5hbWUsIFNFTlNPUlNfRjc1Mzc1X0lO
KGkpLCAmbGFiZWwsCisgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgJnZhbGlkKSAmJgorICAgICAgIXNlbnNvcnNfZ2V0X2ZlYXR1cmUoKm5h
bWUsIFNFTlNPUlNfRjc1Mzc1X0lOKGkpLCAmY3VyKSAmJgorICAgICAgIXNl
bnNvcnNfZ2V0X2ZlYXR1cmUoKm5hbWUsIFNFTlNPUlNfRjc1Mzc1X0lOX01B
WChpKSwgJm1heCkgJiYKKyAgICAgICFzZW5zb3JzX2dldF9mZWF0dXJlKCpu
YW1lLCBTRU5TT1JTX0Y3NTM3NV9JTl9NSU4oaSksICZtaW4pKSB7CisgICAg
aWYgKHZhbGlkKSB7CisgICAgICBwcmludF9sYWJlbChsYWJlbCwgMTApOwor
ICAgICAgcHJpbnRmKCIlKzYuMmYgViAgKG1pbiA9ICUrNi4yZiBWLCBtYXgg
PSAlKzYuMmYgVilcbiIsCisgICAgICAgICAgICAgY3VyLCBtaW4sIG1heCk7
CisgICAgfQorICB9IGVsc2UgeworICAgIHByaW50ZigiRVJST1I6IENhbid0
IGdldCBpbiVkIGRhdGEhXG4iLCBpKTsKKyAgfQorICBmcmVlKGxhYmVsKTsK
K30KKworc3RhdGljIHZvaWQgcHJpbnRfZjc1Mzc1X3RlbXAoY29uc3Qgc2Vu
c29yc19jaGlwX25hbWUgKm5hbWUsIGludCBpKQoreworICBjaGFyICpsYWJl
bDsKKyAgZG91YmxlIGN1ciwgbWF4LCBoeXN0OworICBpbnQgdmFsaWQ7CisK
KyAgaWYgKCFzZW5zb3JzX2dldF9sYWJlbF9hbmRfdmFsaWQoKm5hbWUsIFNF
TlNPUlNfRjc1Mzc1X1RFTVAoaSksICZsYWJlbCwKKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgJnZhbGlkKSAmJgorICAgICAgIXNlbnNv
cnNfZ2V0X2ZlYXR1cmUoKm5hbWUsIFNFTlNPUlNfRjc1Mzc1X1RFTVAoaSks
ICZjdXIpICYmCisgICAgICAhc2Vuc29yc19nZXRfZmVhdHVyZSgqbmFtZSwg
U0VOU09SU19GNzUzNzVfVEVNUF9NQVgoaSksICZtYXgpICYmCisgICAgICAh
c2Vuc29yc19nZXRfZmVhdHVyZSgqbmFtZSwgU0VOU09SU19GNzUzNzVfVEVN
UF9IWVNUKGkpLCAmaHlzdCkpIHsKKyAgICBpZiAodmFsaWQpIHsKKyAgICAg
IHByaW50X2xhYmVsKGxhYmVsLCAxMCk7CisgICAgICBwcmludF90ZW1wX2lu
Zm8oY3VyLCBtYXgsIGh5c3QsIEhZU1QsIDAsIDApOworICAgICAgcHJpbnRm
KCJcbiIpOworICAgIH0KKyAgfSBlbHNlIHsKKyAgICBwcmludGYoIkVSUk9S
OiBDYW4ndCBnZXQgdGVtcCVkIGRhdGEhXG4iLCBpKTsKKyAgfQorICBmcmVl
KGxhYmVsKTsKK30KKworc3RhdGljIHZvaWQgcHJpbnRfZjc1Mzc1X2Zhbihj
b25zdCBzZW5zb3JzX2NoaXBfbmFtZSAqbmFtZSwgaW50IGkpCit7CisgIGNo
YXIgKmxhYmVsOworICBkb3VibGUgY3VyOworICBpbnQgdmFsaWQ7CisKKyAg
aWYgKCFzZW5zb3JzX2dldF9sYWJlbF9hbmRfdmFsaWQoKm5hbWUsIFNFTlNP
UlNfRjc1Mzc1X0ZBTihpKSwgJmxhYmVsLAorICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAmdmFsaWQpICYmCisgICAgICAhc2Vuc29yc19n
ZXRfZmVhdHVyZSgqbmFtZSwgU0VOU09SU19GNzUzNzVfRkFOKGkpLCAmY3Vy
KSkgeworICAgIGlmICh2YWxpZCkgeworICAgICAgcHJpbnRfbGFiZWwobGFi
ZWwsIDEwKTsKKyAgICAgIC8qcHJpbnRmKCIlNC4wZiBSUE0gIChtaW4gPSAl
NC4wZiBSUE0pXG4iLCAKKyAgICAgICAgICAgICBjdXIsIG1pbik7Ki8KKyAg
ICAgIHByaW50ZigiJTQuMGYgUlBNXG4iLAorICAgICAgICAgICAgIGN1cik7
CisgICAgfQorICB9IGVsc2UgeworICAgIHByaW50ZigiRVJST1I6IENhbid0
IGdldCBmYW4lZCBkYXRhIVxuIiwgaSk7CisgIH0KKyAgZnJlZShsYWJlbCk7
Cit9CisKK3ZvaWQgcHJpbnRfZjc1Mzc1KGNvbnN0IHNlbnNvcnNfY2hpcF9u
YW1lICpuYW1lKQoreworICBpbnQgaTsKKworICBmb3IgKGkgPSAwOyBpIDw9
IDM7IGkrKykgeworICAgIHByaW50X2Y3NTM3NV9pbihuYW1lLCBpKTsKKyAg
fQorCisgIGZvciAoaSA9IDE7IGkgPD0gMjsgaSsrKSB7CisgICAgcHJpbnRf
Zjc1Mzc1X3RlbXAobmFtZSwgaSk7CisgIH0KKworICBmb3IgKGkgPSAxOyBp
IDw9IDI7IGkrKykgeworICAgIHByaW50X2Y3NTM3NV9mYW4obmFtZSwgaSk7
CisgIH0KK30KKwogdm9pZCBwcmludF91bmtub3duX2NoaXAoY29uc3Qgc2Vu
c29yc19jaGlwX25hbWUgKm5hbWUpCiB7CiAgIGludCBhLGIsdmFsaWQ7CmRp
ZmYgLXVyTiBsbS1zZW5zb3JzX29yZy9wcm9nL3NlbnNvcnMvY2hpcHMuaCBs
bS1zZW5zb3JzL3Byb2cvc2Vuc29ycy9jaGlwcy5oCi0tLSBsbS1zZW5zb3Jz
X29yZy9wcm9nL3NlbnNvcnMvY2hpcHMuaAkyMDA3LTA3LTAyIDE4OjU2OjAw
LjAwMDAwMDAwMCArMDIwMAorKysgbG0tc2Vuc29ycy9wcm9nL3NlbnNvcnMv
Y2hpcHMuaAkyMDA3LTA3LTEwIDIwOjA5OjU0LjAwMDAwMDAwMCArMDIwMApA
QCAtODAsNSArODAsNiBAQAogZXh0ZXJuIHZvaWQgcHJpbnRfZG1lMTczNyhj
b25zdCBzZW5zb3JzX2NoaXBfbmFtZSAqbmFtZSk7CiBleHRlcm4gdm9pZCBw
cmludF9hcHBsZXNtYyhjb25zdCBzZW5zb3JzX2NoaXBfbmFtZSAqbmFtZSk7
CiBleHRlcm4gdm9pZCBwcmludF9mNzE4ODJmZyhjb25zdCBzZW5zb3JzX2No
aXBfbmFtZSAqbmFtZSk7CitleHRlcm4gdm9pZCBwcmludF9mNzUzNzUoY29u
c3Qgc2Vuc29yc19jaGlwX25hbWUgKm5hbWUpOwogCiAjZW5kaWYgLyogZGVm
IFBST0dfU0VOU09SU19DSElQU19IICovCmRpZmYgLXVyTiBsbS1zZW5zb3Jz
X29yZy9wcm9nL3NlbnNvcnMvbWFpbi5jIGxtLXNlbnNvcnMvcHJvZy9zZW5z
b3JzL21haW4uYwotLS0gbG0tc2Vuc29yc19vcmcvcHJvZy9zZW5zb3JzL21h
aW4uYwkyMDA3LTA3LTAyIDE4OjU2OjAwLjAwMDAwMDAwMCArMDIwMAorKysg
bG0tc2Vuc29ycy9wcm9nL3NlbnNvcnMvbWFpbi5jCTIwMDctMDctMTAgMjA6
MzI6NTUuMDAwMDAwMDAwICswMjAwCkBAIC00MjYsNiArNDI2LDggQEAKICAJ
eyAiZG1lMTczNyIsIHByaW50X2RtZTE3MzcgfSwKIAl7ICJhcHBsZXNtYyIs
IHByaW50X2FwcGxlc21jIH0sCiAJeyAiZjcxODgyZmciLCBwcmludF9mNzE4
ODJmZyB9LAorICAgICAgICB7ICJmNzUzNzUiLCBwcmludF9mNzUzNzUgfSwK
KyAgICAgICAgeyAiZjc1MzczIiwgcHJpbnRfZjc1Mzc1IH0sCiAJeyBOVUxM
LCBOVUxMIH0KIH07CiAK

--0-892538531-1184096665=:59813
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
--0-892538531-1184096665=:59813--

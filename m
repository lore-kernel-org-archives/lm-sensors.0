From: "Jim Cromie" <jim.cromie@gmail.com>
Date: Thu, 11 Oct 2007 23:37:31 +0000
Subject: Re: [lm-sensors] [patch 1/1] de-macro w83627hf
Message-Id: <cfe85dfa0710111637u6f422905r7562f8b1b34c825d@mail.gmail.com>
MIME-Version: 1
Content-Type: multipart/mixed; boundary="----=_Part_22448_9150642.1192145851473"
List-Id: <lm-sensors.vger.kernel.org>
References: <cfe85dfa0709301138u30442dbch1f2508c4c8ccf337@mail.gmail.com>
In-Reply-To: <cfe85dfa0709301138u30442dbch1f2508c4c8ccf337@mail.gmail.com>
To: lm-sensors@vger.kernel.org

------=_Part_22448_9150642.1192145851473
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 10/9/07, Jean Delvare <khali@linux-fr.org> wrote:
> Hi Mark, hi Jim,
>
> On Tue, 9 Oct 2007 09:04:02 -0400, Mark M. Hoffman wrote:
> > * Jean Delvare <khali@linux-fr.org> [2007-10-02 12:50:55 +0200]:
> > > Once you send a patch that I can apply on top of Mark's tree, I'll
> > > review it.
> >
> > Here you go, I merged it for you.  Or git did, but I resolved one conflict.
>
> OK, thank you. After reviewing and testing, here are the problems I've found:
>

> > @@ -218,7 +219,7 @@ static const u8 regpwm_627hf[] = { W83627HF_REG_PWM1, W83627HF_REG_PWM2 };
> >  static const u8 regpwm[] = { W83627THF_REG_PWM1, W83627THF_REG_PWM2,
> >                               W83627THF_REG_PWM3 };
> >  #define W836X7HF_REG_PWM(type, nr) (((type) == w83627hf) ? \
> > -                                     regpwm_627hf[(nr) - 1] : regpwm[(nr) - 1])
> > +                                     regpwm_627hf[nr] : regpwm[nr])
>
> Tabs should be used for indentation (not introduced by your patch but
> still worth fixing.)

Done.

>
> >
> >  #define W83627HF_REG_PWM_FREQ                0x5C    /* Only for the 627HF */
> >
> > @@ -400,72 +401,71 @@ static struct platform_driver w83627hf_driver = {
> >       .remove         = __devexit_p(w83627hf_remove),
> >  };
> >
> > -/* following are the sysfs callback functions */
> > -#define show_in_reg(reg) \
> > -static ssize_t show_##reg (struct device *dev, char *buf, int nr) \
> > -{ \
> > -     struct w83627hf_data *data = w83627hf_update_device(dev); \
> > -     return sprintf(buf,"%ld\n", (long)IN_FROM_REG(data->reg[nr])); \
> > +static ssize_t
> > +show_in_input(struct device *dev, struct device_attribute *devattr, char *buf)
> > +{
> > +     int nr = to_sensor_dev_attr(devattr)->index;
> > +     struct w83627hf_data *data = w83627hf_update_device(dev);
> > +     return sprintf(buf,"%ld\n", (long)IN_FROM_REG(data->in[nr]));
>
> Missing space after comma (not introduced by your patch but still worth
> fixing.)

done



> > @@ -1171,30 +1145,13 @@ static const struct attribute_group w83627hf_group = {
> >  };
> >
> >  static struct attribute *w83627hf_attributes_opt[] = {
> > -     &dev_attr_in1_input.attr,
> > -     &dev_attr_in1_min.attr,
> > -     &dev_attr_in1_max.attr,
> > -     &dev_attr_in5_input.attr,
> > -     &dev_attr_in5_min.attr,
> > -     &dev_attr_in5_max.attr,
> > -     &dev_attr_in6_input.attr,
> > -     &dev_attr_in6_min.attr,
> > -     &dev_attr_in6_max.attr,
> > -
> > -     &dev_attr_fan3_input.attr,
> > -     &dev_attr_fan3_min.attr,
> > -     &dev_attr_fan3_div.attr,
> > -
> > -     &dev_attr_temp3_input.attr,
> > -     &dev_attr_temp3_max.attr,
> > -     &dev_attr_temp3_max_hyst.attr,
> > -     &dev_attr_temp3_type.attr,
> > -
> > -     &dev_attr_pwm3.attr,
> > -
> > -     &dev_attr_pwm1_freq.attr,
> > -     &dev_attr_pwm2_freq.attr,
> > -     &dev_attr_pwm3_freq.attr,
> > +     VIN_UNIT_ATTRS(1),
> > +     VIN_UNIT_ATTRS(5),
> > +     VIN_UNIT_ATTRS(6),
> > +
> > +     FAN_UNIT_ATTRS(3),
> > +     TEMP_UNIT_ATTRS(3),
> > +     &sensor_dev_attr_pwm3.dev_attr.attr,
>
> Missing pwm1_freq, pwm2_freq and pwm3_freq attributes.
>


Ack. Done.


> >       NULL
> >  };
> >
> > @@ -1252,27 +1209,41 @@ static int __devinit w83627hf_probe(struct platform_device *pdev)
> >
> >       /* Register chip-specific device attributes */
> >       if (data->type == w83627hf || data->type == w83697hf)
> > -             if ((err = device_create_file(dev, &dev_attr_in5_input))
> > -              || (err = device_create_file(dev, &dev_attr_in5_min))
> > -              || (err = device_create_file(dev, &dev_attr_in5_max))
> > -              || (err = device_create_file(dev, &dev_attr_in6_input))
> > -              || (err = device_create_file(dev, &dev_attr_in6_min))
> > -              || (err = device_create_file(dev, &dev_attr_in6_max))
> > -              || (err = device_create_file(dev, &dev_attr_pwm1_freq))
> > -              || (err = device_create_file(dev, &dev_attr_pwm2_freq)))
> > +             if ((err = device_create_file(dev,
> > +                             &sensor_dev_attr_in5_input.dev_attr))
> > +              || (err = device_create_file(dev,
> > +                             &sensor_dev_attr_in5_min.dev_attr))
> > +              || (err = device_create_file(dev,
> > +                             &sensor_dev_attr_in5_max.dev_attr))
> > +              || (err = device_create_file(dev,
> > +                             &sensor_dev_attr_in6_input.dev_attr))
> > +              || (err = device_create_file(dev,
> > +                             &sensor_dev_attr_in6_min.dev_attr))
> > +              || (err = device_create_file(dev,
> > +                             &sensor_dev_attr_in6_max.dev_attr)))
>
> pwm1_freq and pwm2_freq attributes are no longer created.

Ack.  Done.

> > *w83627hf_update_device(struct device *dev)
> >                           w83627hf_read_value(data,
> >                                              W83781D_REG_FAN_MIN(i));
> >               }
> > -             for (i = 1; i <= 3; i++) {
> > +             for (i = 0; i <= 2; i++) {
> >                       u8 tmp = w83627hf_read_value(data,
> >                               W836X7HF_REG_PWM(data->type, i));
> >                       /* bits 0-3 are reserved  in 627THF */
> >                       if (data->type == w83627thf)
> >                               tmp &= 0xf0;
> > -                     data->pwm[i - 1] = tmp;
> > -                     if(i == 2 &&
> > +                     data->pwm[i] = tmp;
> > +                     if(i == 1 &&
>
> Missing space before opening parenthesis.

Done.
Also fixed one other found when searching for 'if(', I hope thats ok.


>
> >                          (data->type == w83627hf || data->type == w83697hf))
> >                               break;
> >               }
>
>
> --
> Jean Delvare
>


Im attaching an incremental patch (on top of Mark's),
assuming that this is easiest.

If you want it against hwmon-testing (with change-entry, diffstat, signoff)
or you want the extraneous 'if(' fix removed, let me know.

Again, thanks to both of you.

------=_Part_22448_9150642.1192145851473
Content-Type: application/octet-stream; name="diff.demacro-on-marks"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="diff.demacro-on-marks";
	filename="diff.demacro-on-marks";
	filename="diff.demacro-on-marks";
	filename="diff.demacro-on-marks";
	filename="diff.demacro-on-marks"; 
	filename="diff.demacro-on-marks"
X-Attachment-Id: f_f7nw6q4a

ZGlmZiAtcnUgaHdtb24tZGVtYWNyby1tYXJrL2RyaXZlcnMvaHdtb24vdzgzNjI3aGYuYyBod21v
bi1kZW1hY3JvL2RyaXZlcnMvaHdtb24vdzgzNjI3aGYuYwotLS0gaHdtb24tZGVtYWNyby1tYXJr
L2RyaXZlcnMvaHdtb24vdzgzNjI3aGYuYwkyMDA3LTEwLTExIDE1OjM0OjAxLjAwMDAwMDAwMCAt
MDYwMAorKysgaHdtb24tZGVtYWNyby9kcml2ZXJzL2h3bW9uL3c4MzYyN2hmLmMJMjAwNy0xMC0x
MSAxNjowMzoxMC4wMDAwMDAwMDAgLTA2MDAKQEAgLTIxOSw3ICsyMTksNyBAQAogc3RhdGljIGNv
bnN0IHU4IHJlZ3B3bVtdID0geyBXODM2MjdUSEZfUkVHX1BXTTEsIFc4MzYyN1RIRl9SRUdfUFdN
MiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVzgzNjI3VEhGX1JFR19QV00zIH07CiAj
ZGVmaW5lIFc4MzZYN0hGX1JFR19QV00odHlwZSwgbnIpICgoKHR5cGUpID09IHc4MzYyN2hmKSA/
IFwKLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZWdwd21fNjI3aGZbbnJd
IDogcmVncHdtW25yXSkKKwkJCQkgICAgcmVncHdtXzYyN2hmW25yXSA6IHJlZ3B3bVtucl0pCiAK
ICNkZWZpbmUgVzgzNjI3SEZfUkVHX1BXTV9GUkVRCQkweDVDCS8qIE9ubHkgZm9yIHRoZSA2MjdI
RiAqLwogCkBAIC00MDYsNyArNDA2LDcgQEAKIHsKIAlpbnQgbnIgPSB0b19zZW5zb3JfZGV2X2F0
dHIoZGV2YXR0ciktPmluZGV4OwogCXN0cnVjdCB3ODM2MjdoZl9kYXRhICpkYXRhID0gdzgzNjI3
aGZfdXBkYXRlX2RldmljZShkZXYpOwotCXJldHVybiBzcHJpbnRmKGJ1ZiwiJWxkXG4iLCAobG9u
ZylJTl9GUk9NX1JFRyhkYXRhLT5pbltucl0pKTsKKwlyZXR1cm4gc3ByaW50ZihidWYsICIlbGRc
biIsIChsb25nKUlOX0ZST01fUkVHKGRhdGEtPmluW25yXSkpOwogfQogc3RhdGljIHNzaXplX3QK
IHNob3dfaW5fbWluKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IGRldmljZV9hdHRyaWJ1dGUg
KmRldmF0dHIsIGNoYXIgKmJ1ZikKQEAgLTExNTIsNiArMTE1MiwxMCBAQAogCUZBTl9VTklUX0FU
VFJTKDMpLAogCVRFTVBfVU5JVF9BVFRSUygzKSwKIAkmc2Vuc29yX2Rldl9hdHRyX3B3bTMuZGV2
X2F0dHIuYXR0ciwKKworCSZzZW5zb3JfZGV2X2F0dHJfcHdtMV9mcmVxLmRldl9hdHRyLmF0dHIs
CisJJnNlbnNvcl9kZXZfYXR0cl9wd20yX2ZyZXEuZGV2X2F0dHIuYXR0ciwKKwkmc2Vuc29yX2Rl
dl9hdHRyX3B3bTNfZnJlcS5kZXZfYXR0ci5hdHRyLAogCU5VTEwKIH07CiAKQEAgLTEyMjAsNyAr
MTIyNCwxMSBAQAogCQkgfHwgKGVyciA9IGRldmljZV9jcmVhdGVfZmlsZShkZXYsCiAJCQkJJnNl
bnNvcl9kZXZfYXR0cl9pbjZfbWluLmRldl9hdHRyKSkKIAkJIHx8IChlcnIgPSBkZXZpY2VfY3Jl
YXRlX2ZpbGUoZGV2LAotCQkJCSZzZW5zb3JfZGV2X2F0dHJfaW42X21heC5kZXZfYXR0cikpKQor
CQkJCSZzZW5zb3JfZGV2X2F0dHJfaW42X21heC5kZXZfYXR0cikpCisJCSB8fCAoZXJyID0gZGV2
aWNlX2NyZWF0ZV9maWxlKGRldiwKKwkJCQkmc2Vuc29yX2Rldl9hdHRyX3B3bTFfZnJlcS5kZXZf
YXR0cikpCisJCSB8fCAoZXJyID0gZGV2aWNlX2NyZWF0ZV9maWxlKGRldiwKKwkJCQkmc2Vuc29y
X2Rldl9hdHRyX3B3bTJfZnJlcS5kZXZfYXR0cikpKQogCQkJZ290byBFUlJPUjQ7CiAKIAlpZiAo
ZGF0YS0+dHlwZSAhPSB3ODM2OTdoZikKQEAgLTE1MDIsNyArMTUxMCw3IEBACiAJCQlicmVhazsK
IAl9CiAKLQlpZihpbml0KSB7CisJaWYgKGluaXQpIHsKIAkJLyogRW5hYmxlIHRlbXAyICovCiAJ
CXRtcCA9IHc4MzYyN2hmX3JlYWRfdmFsdWUoZGF0YSwgVzgzNzgxRF9SRUdfVEVNUDJfQ09ORklH
KTsKIAkJaWYgKHRtcCAmIDB4MDEpIHsKQEAgLTE1NzAsOCArMTU3OCw4IEBACiAgCQkJaWYgKGRh
dGEtPnR5cGUgPT0gdzgzNjI3dGhmKQogCQkJCXRtcCAmPSAweGYwOwogCQkJZGF0YS0+cHdtW2ld
ID0gdG1wOwotCQkJaWYoaSA9PSAxICYmCi0JCQkgICAoZGF0YS0+dHlwZSA9PSB3ODM2MjdoZiB8
fCBkYXRhLT50eXBlID09IHc4MzY5N2hmKSkKKwkJCWlmIChpID09IDEgJiYKKwkJCSAgICAoZGF0
YS0+dHlwZSA9PSB3ODM2MjdoZiB8fCBkYXRhLT50eXBlID09IHc4MzY5N2hmKSkKIAkJCQlicmVh
azsKIAkJfQogCQlpZiAoZGF0YS0+dHlwZSA9PSB3ODM2MjdoZikgewo=
------=_Part_22448_9150642.1192145851473
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
------=_Part_22448_9150642.1192145851473--

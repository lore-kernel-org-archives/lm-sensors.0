From: "J, KEERTHY" <j-keerthy@ti.com>
Date: Fri, 07 Jan 2011 11:32:31 +0000
Subject: Re: [lm-sensors] [PATCH v3] hwmon: twl4030: Driver for twl4030 madc
Message-Id: <AANLkTik-zMPu+y+ksVHBORk0JkcqiuMLKyFhkrBpr+X1@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1294286200-16446-1-git-send-email-j-keerthy@ti.com>
	<20110106120433.GC17184@sirena.org.uk>
	<AANLkTinuwejAgJ+F0e4LFAhR-gL8bfFmyOwHdSEWAsRw@mail.gmail.com>
	<20110107104455.GB9209@opensource.wolfsonmicro.com>
In-Reply-To: <20110107104455.GB9209@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: lm-sensors@lm-sensors.org, guenter.roeck@ericsson.com, sameo@linux.intel.com, khali@linux-fr.org, mikko.k.ylinen@nokia.com, linux-omap@vger.kernel.org, amit.kucheria@canonical.com, balajitk@ti.com

On Fri, Jan 7, 2011 at 4:14 PM, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> On Fri, Jan 07, 2011 at 02:55:45PM +0530, J, KEERTHY wrote:
>> On Thu, Jan 6, 2011 at 5:34 PM, Mark Brown
>> > On Thu, Jan 06, 2011 at 09:26:40AM +0530, Keerthy wrote:
>
>> >> +static ssize_t madc_read(struct device *dev,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct device_attribute =
*devattr, char *buf)
>> >> +{
>> >> + =A0 =A0 struct sensor_device_attribute *attr =3D to_sensor_dev_attr=
(devattr);
>
> ...
>
>> >> + =A0 =A0 return sprintf(buf, "%ld\n", val);
>
>> > Does this return data in the appropriate units - milivolts for voltage=
s?
>
>> This function returns the raw channel values read and not in terms of the
>> units.
>
> It needs to convert the values into real world units before they go to
> userspace - look at what applications like sensors do with the values.
>
Ok. Converting to the real world units will be added.

>> >> + =A0 =A0 case TWL4030_MADC_RT:
>> >> + =A0 =A0 default:
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>
>> > This looks odd - the function won't actually do anything for non-SW
>> > conversions but won't return an error?
>
>> Ok. In the case of RT conversion request no software setting is required
>> and it is signal driven. So the function does nothing in case of RT.
>
> Again, the biggest problem is that the code isn't clear.

OK. I will add comments explaining the flow.
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

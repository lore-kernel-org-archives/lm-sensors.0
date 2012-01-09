From: "Darrick J. Wong" <djwong@us.ibm.com>
Date: Mon, 09 Jan 2012 16:32:19 +0000
Subject: Re: [lm-sensors] [PATCH 17/17] drivers/hwmon/i5k_amb.c:
Message-Id: <20120109163219.GN19857@tux1.beaverton.ibm.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Jan 08, 2012 at 06:52:39PM +0100, Frans Meulenbroeks wrote:
> 2012/1/8 Guenter Roeck <guenter.roeck@ericsson.com>
> 
> > Hi Frans,
> >
> > On Sun, Jan 08, 2012 at 11:23:40AM -0500, Frans Meulenbroeks wrote:
> > > Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
> > > ---
> > >  drivers/hwmon/i5k_amb.c |   15 ++++++++++++---
> > >  1 files changed, 12 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/hwmon/i5k_amb.c b/drivers/hwmon/i5k_amb.c
> > > index d22f241..c516bdc 100644
> > > --- a/drivers/hwmon/i5k_amb.c
> > > +++ b/drivers/hwmon/i5k_amb.c
> > > @@ -159,7 +159,10 @@ static ssize_t store_amb_min(struct device *dev,
> > >  {
> > >       struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> > >       struct i5k_amb_data *data = dev_get_drvdata(dev);
> > > -     unsigned long temp = simple_strtoul(buf, NULL, 10) / 500;
> > > +     unsigned long temp;
> > > +     int ret = kstrtoul(buf, 10, &temp) / 500;
> >
> > This divides the error code by 500, not temp.
> >
> > > +     if (ret < 0)
> > > +             return ret;
> > >
> > >       if (temp > 255)
> > >               temp = 255;
> > > @@ -175,7 +178,10 @@ static ssize_t store_amb_mid(struct device *dev,
> > >  {
> > >       struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> > >       struct i5k_amb_data *data = dev_get_drvdata(dev);
> > > -     unsigned long temp = simple_strtoul(buf, NULL, 10) / 500;
> > > +     unsigned long temp;
> > > +     int ret = kstrtoul(buf, 10, &temp) / 500;
> >
> > Same here.
> >
> > > +     if (ret < 0)
> > > +             return ret;
> > >
> > >       if (temp > 255)
> > >               temp = 255;
> > > @@ -191,7 +197,10 @@ static ssize_t store_amb_max(struct device *dev,
> > >  {
> > >       struct sensor_device_attribute *attr = to_sensor_dev_attr(devattr);
> > >       struct i5k_amb_data *data = dev_get_drvdata(dev);
> > > -     unsigned long temp = simple_strtoul(buf, NULL, 10) / 500;
> > > +     unsigned long temp;
> > > +     int ret = kstrtoul(buf, 10, &temp) / 500;
> >
> > and here.
> >
> > Guenter
> >
> Yes of course!
> That is one of the risks of these edits. At some point too much autopilot
> creeps in.
> I'll send an update. There are not otehr places that hae this issue.
> 
> BTW, there is one other thing with this code that might be questionalble
> and that is the fact that temp is an unsigned long.
> Is it not possible with this sensor to have a temp < 0 (I'm assuming temp
> is degrees C or maybe F).
> This might also be an issue on other places. (actually I seem to recall
> having seen a place where the var was signed and the conversion function
> was unsigned (or the other way around))

According to section 14.5.3.6 of the Intel 6400/6402 AMB datasheet, the TEMP
register is an 8-bit value that measures AMB temperature from 0 to 127.5C in
0.5C increments.

--D


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

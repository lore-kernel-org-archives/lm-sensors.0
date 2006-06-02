From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 02 Jun 2006 18:56:26 +0000
Subject: [lm-sensors] PATCH: libsensors and sensors prog support for
Message-Id: <20060602205626.1eeeea5c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4470B176.5000703@hhs.nl>
In-Reply-To: <4470B176.5000703@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

> > > +void print_abituguru(const sensors_chip_name *name)
> > > +{
> > > +  int i;
> > > +
> > > +  for (i=0;i<11;i++)
> > > +    print_abituguru_in(name, SENSORS_ABITUGURU_IN(i),
> > > +      SENSORS_ABITUGURU_IN_MIN(i), SENSORS_ABITUGURU_IN_MIN_ALARM(i),
> > > +      SENSORS_ABITUGURU_IN_MAX(i), SENSORS_ABITUGURU_IN_MAX_ALARM(i));
> > > +
> > > +  for (i=1;i<=7;i++)
> > > +    print_abituguru_temp(name, SENSORS_ABITUGURU_TEMP(i),
> > > +      SENSORS_ABITUGURU_TEMP_ALARM(i), SENSORS_ABITUGURU_TEMP_MAX(i),
> > > +      SENSORS_ABITUGURU_TEMP_CRIT(i));
> > > +
> > > +  for (i=1;i<=6;i++)
> > > +    print_abituguru_fan(name, SENSORS_ABITUGURU_FAN(i),
> > > +      SENSORS_ABITUGURU_FAN_ALARM(i), SENSORS_ABITUGURU_FAN_MIN(i));
> > > +}
> > 
> > This looks inefficient to me. You could pass only name and i as
> > parameters to the three sub-functions. What do you think?
> 
> Yes, with the new macro's which take the sensor number as argument I
> could do that. This would make the abituguru_print function deviate from
> how things are done in all other print functions though. So the current
> way is more consistent.

I don't see how it makes a difference. Most other chips don't use
macros for symbols and don't use sub-functions either, so your code IS
different anyway. And this is not a problem.

> Eitherway let me know what you want and I'll make the necessary changes.
>  Lemme guess, you want me to change things as per your first mail :)

No, I am not insisting either. I've applied your patch (almost) as is.
Thanks for your contribution :)

-- 
Jean Delvare


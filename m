From: Leandro de Marco <leandromarco@gmail.com>
Date: Wed, 07 May 2014 19:37:05 +0000
Subject: Re: [lm-sensors] Global hyst value representation
Message-Id: <CAFO4QpAMEsHJLGbtWBBDZ-=_xey4t5LBtERcS=jX_7AWyuZpCg@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAFO4QpA84_mzcA2o9yBLxALQWwHZ_M7A5khqERDaod882ZV0vg@mail.gmail.com>
In-Reply-To: <CAFO4QpA84_mzcA2o9yBLxALQWwHZ_M7A5khqERDaod882ZV0vg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter.
Thanks for the help. :-)

On Wed, May 7, 2014 at 12:35 PM, Guenter Roeck <linux@roeck-us.net> wrote:
>
> On Wed, May 07, 2014 at 11:55:19AM -0300, Leandro de Marco wrote:
> > Hi.
> >
> > I am implementing a driver for the TMP512/513 temperature chip.
> >
> > It has a local temp sensor and 2/3 remote temp sensors. There is a hyst
> > setting, but this setting is unique and applies for all 3/4 sensors. I am
> > not sure what is the best way to represent this setting on sysfs.
> >
> > I read the instructions at Documentation/hwmon/sysfs-interface, and tried
> > to find other drivers with only one global hyst value, but have found
> > nothing.
> >
> > My solution would be to create an attribute temp1_max_hyst, so it will be
> > listed as subfeature by the lm_sensors library, and explain in the
> > Documentation that it applies for all sensors.
> >
> Common solution is to provide the hyst attribute for all temperatures
> to which it applies, but make it writable for only one. There are several
> drivers using this approach. tmp401.c is an example, but there are others.
>
> Guenter




-- 
Leandro
--------------------------------------------------------------------------
My Mind is Not for Rent.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

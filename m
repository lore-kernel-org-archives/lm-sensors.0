From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 13 Aug 2013 20:27:11 +0000
Subject: Re: [lm-sensors] reading on-die temperature sensor of AMD A10 5700 processor
Message-Id: <20130813202711.GC18358@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CAFSPGzQyxOOhjawcQj=wH+k1b=OC1gGf6CKWoU89TWVTykNcOQ@mail.gmail.com>
In-Reply-To: <CAFSPGzQyxOOhjawcQj=wH+k1b=OC1gGf6CKWoU89TWVTykNcOQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Aug 13, 2013 at 03:05:58PM -0400, Dev, Kapil wrote:
> Hi,
> 
> I just changed the motherboard and the processor while the hard-disk is the
> same. I am trying to read the on-die temperature of the AMD A10 5700
> processor. Based on the output of "sensors-detect" command, I
> installed f71882fg
> driver, but the "sensors" command doesn't seem to give me the value of
> core-temperature. IN particular, I am getting following output from sensors
> command:
> 
> ----------------------------------------------------------------------------------------------------
> f71869-isa-0e80
> Adapter: ISA adapter
> in0:         +1.68 V
> in1:         +1.05 V
> in2:         +1.21 V
> in3:         +1.22 V
> in4:         +1.54 V
> in5:         +1.19 V
> in6:         +1.19 V
> in7:         +1.73 V
> in8:         +1.65 V
> fan1:          0 RPM  ALARM
> fan2:          0 RPM  ALARM
> fan3:          0 RPM  ALARM
> temp1:       +31.0 C  (high = +85.0 C, hyst = +81.0 C)
>                       (crit = +100.0 C, hyst = +96.0 C)  sensor = thermistor
> temp2:       +30.0 C  (high = +85.0 C, hyst = +81.0 C)
>                       (crit = +100.0 C, hyst = +96.0 C)  sensor = thermistor
> temp3:       +48.0 C  (high = +70.0 C, hyst = +68.0 C)
>                       (crit = +85.0 C, hyst = +83.0 C)  sensor = thermistor

One of those three is probably from the CPU (wild guess would be temp3).
You might be able to find a correlation by putting the system under load
and observing temperature rises.

> ----------------------------------------------------------------------------------------------------
> 
> I am wondering if I have to install lm_sensors package all over again.
> Also, I am wondering if "sensors-detect" is up-to-date to detect all
> devices/drivers. I guess the fans' rpm readings are 0 because I am using a
> custom liquid-based cooling system  instead of regular fan.
> 
If nothing turns it can't measure rpm ...

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

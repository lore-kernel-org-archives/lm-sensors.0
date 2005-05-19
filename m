From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: Asus a7v266ex // lm_sensors // fan solution
Message-Id: <20030804144003.12d2777d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200308040114.06823.info@i-service.de>
In-Reply-To: <200308040114.06823.info@i-service.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> > > I tried to find out the correct settings and I've seen that the
> > > Asus tool for watching the sensors is using a switch fan_div 4 and
> > > I tried that to set for the AS99127F settings in /etc/sensors.conf
> >
> > What tool are you talking about? SmartDoctor2? How could you seen
> > the flag there?
> 
> I used "Motherboard Monitor 5", downloaded from
> http://mbm.livewiredev.com/
> to examine if the fan monitoring is available for any monitoring tool.
> well, it is and so I thought, I should play a bit with the dividor
> settings like seen in MBM.

MBM is a great tool, and it's not made by Asus ;) The div=4 value may be
set by MBM itself, it's not necessarily the default value for your chip
(but it could be as well, I'm just trying to guess who does what).
Anyway, the main thing is that you could see that and that it solved
your problem. BTW, I don't think it depends on your chipset (as99127f).
Fan divisors need to be increased when the fan rpm value is low, which
is the case there. I think it's just that (I have an as99127f too and
the fan readings are correct with no additional tricks required) so we
won't add anything special to our FAQ with regard to that topic.


> Another output to show, I'm a bit confused. I did again a "sensors -s"
> like yesterday, but now, without any changes to sensors.conf I got
> this:
> 
> (root@athlon) ~$ sensors -s
> (root@athlon) ~$ sensors
> as99127f-i2c-0-2d
> Adapter: SMBus Via Pro adapter at e800
> Algorithm: Non-I2C SMBus adapter
> [...]
> - -5V:       -4.03 V  (min =  -5.24 V, max =  -4.74 V)       ALARM
> CPU FAN:  2311 RPM  (min = 1795 RPM, div = 4)
> [...]
> 
> setting is still 1800, I got 1795, I think its ok so far.

Yes, it's OK. I can't tell you why it didn't work yesterday (damn Asus
again). 1795 is OK, don't expect to get exactly 1800, resolution is
limited so you usually get rounded values (even if it doesn't look so
"round" from a human point of view).



-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 15 Nov 2010 11:00:44 +0000
Subject: Re: [lm-sensors] IT8721F fan control?
Message-Id: <20101115120044.14bd11b9@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20101106002259.GA1871@hellug.gr>
In-Reply-To: <20101106002259.GA1871@hellug.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Alexandros,

On Fri, 12 Nov 2010 22:01:25 +0200, Alexandros Diamantidis wrote:
> * Luca Tettamanti [2010-11-12 14:13]:
> > The problem with the native driver is that it uses resources that are
> > claimed by ACPI, which might be unsafe.
> 
> Hmm... How unsafe would it be? A crash once a year I wouldn't
> mind much, frequent random memory corruption would be worse ;-)

Data corruption when reading the sensor values or writing the limits.
This may simply mean that "sensors" will return wrong values once in a
while, but could also result in the BIOS taking actions to fight what
it thinks is a critical thermal condition. This would mean CPU
throttling or instant shutdown.

> * Jean Delvare [2010-11-12 19:03]:
> > Can you please test the standalone driver at:
> >   http://khali.linux-fr.org/devel/misc/it87/
> > 
> > It has fixed manual fan speed control for the IT8721F. Hopefully it
> > works now...
> 
> Just tried the new version with no obvious change. pwmconfig still
> doesn't seem to do anything. Also tried echo 1 > pwm[123]_enable;
> echo 0 > pwm[123], which should have stopped the fans, right?

Yes it should have... Hmm.

Could you please:

* Try again after disabling Q-Fan in the BIOS. Maybe I missed an
  initialization step for the manual mode.
* Both with and without Q-Fan, check whether the values you write to
  pwm[123] and pwm[123]_enable stick. Read them once 3 seconds after
  writing them, and then again 6 and 30 seconds after writing them. Test
  values 0, 1 and 2 for pwm[123]_enable, and any two random values for
  pwm[123] after writing 1 to pwm[123]_enable.
* With Q-Fan mode set, not trying to enable manual control mode, check
  the values of pwm[123]_enable. One of them at least should be 2. See
  if the corresponding reported pwmX value changes over time depending
  on CPU load.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

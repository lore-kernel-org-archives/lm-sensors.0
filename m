From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 14 Jan 2009 10:29:53 +0000
Subject: Re: [lm-sensors] Supporting ADT7481 temperature sensor
Message-Id: <20090114112953.7bdefd27@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF6D174B07759740B0259F914CE6D7D305339414@LONMLVEM04.e2k.ad.ge.com>
In-Reply-To: <FF6D174B07759740B0259F914CE6D7D305339414@LONMLVEM04.e2k.ad.ge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 12 Jan 2009 19:49:04 +0100, Hans de Goede wrote:
> Crossley, Malcolm (GE EntSol, Intelligent Platforms) wrote:
> > Hello,
> > 
> > I am tasked with writing linux kernel support for the ADT7481 sensor. 
> > This sensor is a dual remote, single local, sensor with an extended
> > temperature 
> > range capability on the remote sensors. 
> > 
> > Most of the register layout of the device is compliant with the LM90
> > driver but unfortunately the official manufacturer ID and device ID
> > registers are not in 
> > a LM90 compliant location. 
> > 
> > The LM90 driver supports the ADT7481 extended temperature range
> > registers through it's
> > ADT7461 support. 
> > 
> > The ADT7481 does have register values at 0xfe and 0xff but they are not
> > documented in 
> > the datasheet.
> > 
> > Here is an i2cdump output:
> >      0  1  2  3  4  5  6  7  8  9  a  b  c  d  e  f    0123456789abcdef
> > 00: 67 6b 00 24 08 9a 13 a9 13 24 08 9a 13 a9 13 00    gk.$?????$?????.
> > 10: 40 00 00 00 00 00 00 00 00 a4 00 00 00 00 00 00    @........?......
> > 20: 98 05 07 00 00 00 00 00 00 00 00 00 00 00 00 00    ???.............
> > 30: 6d ae 13 c0 00 00 00 00 00 a9 00 00 00 81 41 02    m???.....?...?A?
> > 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > 70: 08 00 00 c0 00 00 00 00 00 00 00 00 00 00 00 00    ?..?............
> > 80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00    ................
> > f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 41 62    ..............Ab
> > 
> > The official manufacturer ID register is at 0x3e and the official device
> > ID register is at
> > 0x3d.
> > 
> > My question is whether it would be better to?
> > 1. Modify the lm90 driver, using undocumented registers for detection
> > and adding second 
> >    remote channel support
> > Or 
> > 2. Write a new driver from scratch but borrow code from the existing
> > LM90 driver
> > 
> > I would like to get this driver included into the kernel.
> > 
> 
> I think one would be the best, if the changes are not to invasive (which they 
> probably are not).

I beg to disagree. The lm90 driver already supports a lot of different
devices. The ADT7481 differs in a significant way in that it supports
an additional external sensor. This is probably the right time to start
a new driver. Then maybe the support for the ADT7461 can be moved to
this new driver so that the lm90 driver can be simplified a bit.

For now it would be good to add the ADT7481 to wiki/Devices and
detection to sensors-detect.

Malcolm, if you want an account on lm-sensors' wiki, please send _me_
the output of the following command:
  htdigest -c $user-passwd lm-sensors/i2c $user
where $user is your desired login.

Can you please also send us a patch against the latest version of
sensors-detect:
http://www.lm-sensors.org/svn/lm-sensors/branches/lm-sensors-3.0.0/prog/detect/sensors-detect
adding detection of the ADT7481?

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

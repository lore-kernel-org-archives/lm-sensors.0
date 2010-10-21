From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 21 Oct 2010 07:23:33 +0000
Subject: Re: [lm-sensors] Tyan S2466 and lm_sensors 3
Message-Id: <20101021092333.32d465e8@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <E1P8fJt-000075-89@mendel.bio.caltech.edu>
In-Reply-To: <E1P8fJt-000075-89@mendel.bio.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

On Wed, 20 Oct 2010 14:41:07 -0700, David Mathog wrote:
> > Please read this FAQ entry:
> >
> > http://www.lm-sensors.org/wiki/FAQ/Chapter3#MyfansreportexactlyhalfdoubletheirvaluescomparedtotheBIOS
>
> OK, that worked.
> 
> > Note how you have sensor type set to transistor here, as opposed to
> > thermistor on the other (non-working) system. You should uncomment the
> > set temp#_type statements in the chip "w83627hf-*" section of your
> > configuration file, and then run "sensors -s" to apply the change. Your
> > temperature readings should be back then.
> 
> That worked too.
> 
> Remaining mystery - min values for fan are odd, sensors shows:
> 
> w83627hf-isa-0c00
> CPU1 Fan:      0 RPM  (min = 5314 RPM, div = 2)  ALARM
> CPU0 Fan:   6616 RPM  (min = 21092 RPM, div = 2)  ALARM
> 
> w83782d-i2c-0-2d
> Ch Fan 1:      0 RPM  (min =  664 RPM, div = 8)  ALARM
> Ch Fan 2:   4326 RPM  (min =  664 RPM, div = 8)
> Ch Fan 3:   4500 RPM  (min = 1328 RPM, div = 4)
> 
> when sensors3.conf has these settings:
> 
> chip "w83782d-*"
>     label   fan1 "Ch Fan 1"
>     label   fan2 "Ch Fan 2"
>     label   fan3 "Ch Fan 3"
>     set fan1_min 3000
>     set fan2_min 3000
>     set fan3_min 3000

Did you run "sensors -s"?

Do you have any "set fan#_div" statement in this chip section? If you
do, it is important that these come before the "set fan#_min"
statements.

> 
> chip "w83627hf-*"
>     label   fan1 "CPU1 Fan"
>     label   fan2 "CPU0 Fan"
>     ignore  fan3 
>     compute fan1 2*@,@/2
>     compute fan2 2*@,@/2
> 
> Apparently div is in play on the second set of min values, although how
> any of them get to the displayed min values escapes me.

You don't have any "set fan#_min" statement in the chip "w83627hf-*"
section, so how do you expect any min value to be set for these fans?

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 28 Jun 2009 08:48:12 +0000
Subject: Re: [lm-sensors] dme1737 sensors force_start
Message-Id: <20090628104812.0a7206e0@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <SNT106-W242B7EE77BE87384F8FE15BA3D0@phx.gbl>
In-Reply-To: <SNT106-W242B7EE77BE87384F8FE15BA3D0@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

On Sat, 27 Jun 2009 11:37:34 -0700, Juerg Haefliger wrote:
> > On Thu, 18 Jun 2009 10:09:33 -0700, Kushal Koolwal wrote:
> >> Any ideas why I need to give force_start? Is this a chip /BIOS/OS issues?
> >
> > BIOS issue. It's up to the BIOS to enable monitoring after the chip is
> > properly set up. That being said, some of our drivers silently enable
> > parts if they were disabled. I'm not so sure why the dme1737 driver
> > asks for the user to pass an extra parameter. But I can't really
> > complain, maybe I'm the one who asked for it, I just can't remember.
> > Juerg?
> 
> Just being conservative. I didn't want to flip any bits without the
> user explicitly asking for it. I thought that was the general approach
> for the hwmon subsystem.

Not really. Looking at other drivers you'll see more than 20 examples
where we do start monitoring if needed: adm1026, adm9240, adt7470,
adt7473, asb100, dme1737, it87, lm78, lm80, lm85, lm93, smsc47m192,
via686a, w83627ehf, w83627hf, w83781d, w83791d, w83792d, w83793,
w83l786ng, adm1031 and f71805f, and maybe more.

What we do _not_ forcibly enable by default is the I/O area of Super-I/O
chips. But if the I/O area is setup and enabled, I have no objection to
letting the driver enable monitoring itself if needed. Whether you want
to update the dme1737 driver in that direction, is up to you.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

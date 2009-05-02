From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 02 May 2009 16:27:27 +0000
Subject: Re: [lm-sensors] Ramp-up time for fan speed
Message-Id: <20090502182727.056b1771@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <9871ee5f0905011459o3b8480a9j2a73845f5f84248a@mail.gmail.com>
In-Reply-To: <9871ee5f0905011459o3b8480a9j2a73845f5f84248a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Timothy,

On Sat, 2 May 2009 11:21:36 -0400, Timothy Normand Miller wrote:
> On 5/2/09, Jean Delvare <khali@linux-fr.org> wrote:
> >  On Fri, 1 May 2009 17:59:35 -0400, Timothy Normand Miller wrote:
> >  > Is there a way I can control fancontrol's ramp-up rate?  I wasn't able
> >  > to find anything on this in the documentation.
> >
> > The fancontrol script really isn't that smart. It doesn't implement any
> >  form of ramp-up, the target speed (actually, output duty cycle) is
> >  computed linearly based on the measured temperature, and applied
> >  immediately.
> 
> I got the source code to fancontrol and discovered that, although I'm
> not so great at reading either bash or perl.  It occurs to me that
> whatever circuitry controls the duty cycle itself has slow reaction
> time.

Does it? In my experience it was always pretty fast.

>        I'd love to know what makes it snap on full quickly at boot
> time.  Actually, that I can get.  But how it so quickly drops to 50%
> (under control of BIOS) would be interesting to know.  When fancontrol
> sets 50%, it takes a while to slow down.

Are you speaking of the same fan in both cases? Different fans can
behave differently. Large fans have more inertia. Also, 4-pin fans are
a totally different beast, as they include additional electronics which
converts the PWM signal. For 3-pin fans, the PWM signal controls the
fan directly, which frequently results in a non-linear response (that
is, 50% duty cycle does _not_ lead to 50% speed.)

> >  However it is known that fans need a relatively high duty cycle to
> >  start spinning, and we do have a mechanism for that: MINSTART. I
> >  suppose you didn't set its value high enough. Probably the best is that
> >  you share your /etc/fancontrol configuration file with us and I'll tell
> >  you what I think should be changed.
> 
> Actually, after 150 wasn't quick enough, I tried 255 for MINSTART.  It
> didn't seem to help any.

That's what I would have suggested, but if it did not help...

> I'll fiddle with it a bit more, but I'm
> quite sure that it's not fancontrol's problem.  And besides, since
> it's a script, I can easily alter it.

Correct. You can also access the sysfs interface directly if it makes
your testing easier.

> >  Please also tell us which version of lm-sensors you're running, to make
> >  sure you aren't affected by an old bug.
> 
> sensors version 2.10.7 with libsensors version 2.10.7

That's a little old... Assuming you're running a 2.6 kernel, you may
want to try the fancontrol script from lm-sensors 3.1.0 instead, it
includes a number of bugfixes.

If you need more help, please make sure to mention the kernel version
you're running, the driver use for fan speed control, the mainboard
brand and model, and the characteristics of the fans (in particular,
size and number of pins.)

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

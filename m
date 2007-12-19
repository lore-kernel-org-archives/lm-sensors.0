From: "Juerg Haefliger" <juergh@gmail.com>
Date: Wed, 19 Dec 2007 18:22:35 +0000
Subject: Re: [lm-sensors] auto_pwm_min in dme1737 driver
Message-Id: <191fb4ca0712191022i313516d2t759f71a95e561ff1@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Michel,

For the future, please keep the lm-sensors list in the loop so that
others can profit from the information.


On Dec 19, 2007 6:07 AM, Michel Lespinasse <walken@zoy.org> wrote:
> Hi Juerg,
>
> I'm using the dme1737 driver with an asus p1-ah2 barebones system.
> A believe it's using an asus A8000 chip, I have not double checked
> that though. But the driver seems to work quite nicely, thanks !

You're welcome, I'm glad people like it :-)


> There is however a small detail I could not manage to get working:
> I can't get the CPU fan (pwm1) to go off when the temps are low enough.
> All 3 pwm*_auto_pwm_min values always stay equal to their corresponding
> pwm*_auto_point1_pwm value, even if I try to write 0 to the pwm*_auto_pwm_min
> value. Is this a hardware limitation (i.e. nonwritable bit) on the asus chip ?
> Is there anything I could do to help figure out the issue ?

Well yes, I've seen issues with this as well. I couldn't get it to
work on my machine (P1-AH2) as described in the datasheet of the
dme1737. Don't know if it's a chip or driver bug. Anyways, here is how
it's supposed to work:

Mode 1) In this mode, the fan will be on all time with PWM between
auto_point1_pwm and auto_point2_pwm (which is hard-wired to 255, i.e.
100%) depending on the corresponding temp values. To set the chip up
in this mode, do the following:
echo <LOW_TEMP> > XXX_auto_point1_temp
echo <FULL_TEMP> > XXX_auto_point2_temp
echo <MIN_PWM> > XXX_auto_point1_pwm
echo <MIN_PWM> > XXX_auto_pwm_min

Mode 2) This mode is like mode 1) except that the fan will turn off if
the associated temp goes below the auto_point1_temp_hyst value. I
believe this is what you want and this is what I couldn't get to work
:-) Anyways, please give it a try. To set the chip up in this mode, do
this:
echo <MIN_TEMP> > XXX_auto_point1_temp_hyst
echo <LOW_TEMP> > XXX_auto_point1_temp
echo <MAX_TEMP> > XXX_auto_point2_temp
echo <MIN_PWM> > XXX_auto_point1_pwm
echo 0 > XXX_auto_pwm_min

After you set the chip up, please run 'grep ""
/sys/class/hwmon/hwmon*/device/*' and post the output to the list.

....juerg





> Cheers,
>
> --
> Michel Lespinasse
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

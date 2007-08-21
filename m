From: "dave jones" <s.dave.jones@gmail.com>
Date: Tue, 21 Aug 2007 07:29:30 +0000
Subject: Re: [lm-sensors] Questions about sysfs
Message-Id: <5628d8010708210029m609177bap26b5b7f228e7863@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <5628d8010708170444i76bdc033t900cec37a726e2c1@mail.gmail.com>
In-Reply-To: <5628d8010708170444i76bdc033t900cec37a726e2c1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 8/18/07, Jean Delvare wrote:
> Hi Dave,

Hi Jean,

> On Fri, 17 Aug 2007 19:44:36 +0800, dave jones wrote:
> > I'm trying to use pwmconfig to verify whether my porting driver is
> > working or not.
> > While running pwmconfig, I got the following result:
> >
> > Found the following PWM controls:
> >    0-002e/pwm1
> > /usr/sbin/pwmconfig: line 102: echo: write error: Invalid argument
>
> What are the permissions on that file? The error message suggests that
> your driver returned -EINVAL to the write request.
>
> > Found the following fan sensors:
> >    0-002e/fan1_input     current speed: 6683 RPM
> >    0-002e/fan2_input     current speed: 6192 RPM
> >
> > My question is why it displays 0-002e instead of hwmon0/devices ?
>
> Which version of lm-sensors are you running? Support for the hwmon
> class was added relatively recently (2.10.2).

Thanks.  I used 2.10.0. After installing lm-sensors 2.10.4 without modifying
my driver, run pwmconfig, the result is:

Found the following devices:
   hwmon0/device is w83l786ng

Found the following PWM controls:
   hwmon0/device/pwm1
hwmon0/device/pwm1_enable stuck to 1
Failed to set pwmhwmon0/device/pwm1 to full speed
Something's wrong, check your fans!

Did I miss something? Why it can't detect my fans? Thank you.

> --
> Jean Delvare
>

BR,
Dave.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

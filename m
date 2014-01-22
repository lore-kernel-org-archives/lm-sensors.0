From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 22 Jan 2014 17:27:16 +0000
Subject: Re: [lm-sensors] Asus H87-PRO /usr/sbin/pwmconfig: There are no pwm-capable sensor modules installed
Message-Id: <20140122172716.GB24358@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CALiX4iZMuV2446GaK9qyS8Cfa=q1RV0w8-UUXYnOFXfROkBoaw@mail.gmail.com>
In-Reply-To: <CALiX4iZMuV2446GaK9qyS8Cfa=q1RV0w8-UUXYnOFXfROkBoaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
To: lm-sensors@vger.kernel.org

On Wed, Jan 22, 2014 at 06:01:07PM +0100, Mathias Gerber wrote:
> Hi G=FCnther, Hi Michael
>=20
> On 22.01.2014 17:25, Guenter Roeck wrote:
> > you were faster than me ;-). Michael, let me know if you have any
> > problems with the driver.
> I'm just through all this during the last few days ;-)
>=20
> > Interesting that pwmconfig doesn't recognize this. CPU fans usually
> > never stop completely, and afaik the script should recognize the
> > speed change.
> The output in this step of pwmconfig is:
> > Testing pwm control hwmon1/device/pwm2 ... hwmon1/device/fan2_input
> > ... speed was 2292 now 2292 no correlation hwmon1/device/fan4_input
> > ... speed was 1739 now 1739 no correlation
> >=20
> > No correlations were detected. There is either no fan connected to
> > the output of hwmon1/device/pwm2, or the connected fan has no
> > rpm-signal connected to one of the tested fan sensors. (Note: not
> > all motherboards have the pwm outputs connected to the fan
> > connectors, check out the hardware database on
> > http://www.almico.com/forumindex.php)
> >=20
> > Did you see/hear a fan stopping during the above test (n)? ^C
>=20
> During this few seconds test, /sys/class/hwmon/hwmon1/device/pwm2 is
> set to 0. But if you set this pwm2 to 0, the CPU fan runs with full
> speed (same rpm as with pwm2=3D255)
> The other pwm output with a fan connected (pwm4) does not behave like
> this and stops the fan with pwm0.
>=20
Interesting. Obviously that doesn't help ;-). What is returned back
if you read pwm2 after setting it to 0 ?

> > Anyway, I would recommend to use the chip's automatic fan control
> > if possible. It doesn't rely on a script running in the OS to
> > control fan speeds, and usually works pretty well (and can be
> > reconfigured if you dislike the BIOS settings).
> Normally, yes. But it was not possible to go that low with the fan
> speed within the BIOS settings (20% or 25% is the minimum IIRC)

You might try setting pwm2_auto_point1_pwm to your preferred minimum
(assuming pwm2_enable is set to 5). If that doesn't help, please send me the
output of all pwm2 attributes ('grep . /sys/class/hwmon/hwmon1/device/pwm2*=
').

Side note: If you run 3.13 or later kernels, the attributes will move to
/sys/class/hwmon/hwmonX/.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

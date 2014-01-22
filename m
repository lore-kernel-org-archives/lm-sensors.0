From: Guenter Roeck <linux@roeck-us.net>
Date: Wed, 22 Jan 2014 18:34:45 +0000
Subject: Re: [lm-sensors] Asus H87-PRO /usr/sbin/pwmconfig: There are no pwm-capable sensor modules installed
Message-Id: <20140122183445.GB25841@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CALiX4iZMuV2446GaK9qyS8Cfa=q1RV0w8-UUXYnOFXfROkBoaw@mail.gmail.com>
In-Reply-To: <CALiX4iZMuV2446GaK9qyS8Cfa=q1RV0w8-UUXYnOFXfROkBoaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Jan 22, 2014 at 06:59:00PM +0100, Mathias Gerber wrote:
> Hi Guenter
> 
> On 22.01.2014 18:27, Guenter Roeck wrote:
> > Interesting. Obviously that doesn't help ;-). What is returned
> > back if you read pwm2 after setting it to 0 ?
> 0 (zero). Maybe some sort of protection?
> 
No idea. Might be the fan itself doing it. What happens if you set it to 1 ?

> > You might try setting pwm2_auto_point1_pwm to your preferred
> > minimum (assuming pwm2_enable is set to 5). If that doesn't help,
> > please send me the output of all pwm2 attributes ('grep .
> > /sys/class/hwmon/hwmon1/device/pwm2*').
> Thanks for this hint. I didn't knew about this possibility.
> 
Well-kept secret ;-)

> For my needs I set these values:
> pwm2_auto_point1_pwm	7
> pwm2_auto_point1_temp	30000
> pwm2_auto_point2_pwm	178 (default)
> pwm2_auto_point2_temp	55000
> pwm2_auto_point3_pwm	255 (default)
> pwm2_auto_point3_temp	75000 (default)
> 
> With these settings the CPU fan (fan2) runs quiet as wished :-)
> 
Excellent. Note there is one problem in the driver - any changed pwm
settings will revert to the default after a suspend/resume cycle.
That requires a major change to the driver to fix, so it will take a while.
Until then, you'll have to re-apply the changed configuration after
suspend/resume.

Thanks,
Guenter 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

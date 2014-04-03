From: Jean Delvare <jdelvare@suse.de>
Date: Thu, 03 Apr 2014 07:42:32 +0000
Subject: Re: [lm-sensors] [PATCH] fancontrol aborts after suspend/resume
Message-Id: <20140403094232.0744a5f2@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <201404021253.49647.l.lunak@centrum.cz>
In-Reply-To: <201404021253.49647.l.lunak@centrum.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Lubos,

On Wed, 2 Apr 2014 12:53:49 +0200, Lubos Lunak wrote:
>  if system running fancontrol is suspended and resumed, fancontrol will abort, 
> as writing the pwm value will fail because of pwm control being set to 
> automatic control after the resume (google for 'fancontrol suspend' for 
> various discussions about this). The attached patch fixes the problem.

I'm afraid this is fixing the problem in the wrong place. The BIOS is
responsible for restoring the hardware settings at resume time. Failing
that, the kernel should do it.

So you should first look for a BIOS update, even though the chances
that it fixes this specific problem are rather low. Then you should
tell us which hwmon driver you are using, so that we can add proper
suspend/resume code to it. If fan speed control mode settings are lost,
other settings may be lost as well and would need to be saved and
restored too.

That being said I have to admit that your approach, although not clean,
has the merit to work around the problem regardless of the BIOS or
hwmon chip in use. This is certainly attractive. My only worry is that
it _assumes_ that problem comes from an improperly handled
suspend/resume cycle, which may or may not be the case. It might as
well be the BIOS/ACPI changing the settings at run-time, or another fan
monitoring application running in parallel, or a driver bug. In which
case failing with an error is the right thing to do.

Guenter, do you have an opinion on this?

-- 
Jean Delvare
SUSE L3 Support

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

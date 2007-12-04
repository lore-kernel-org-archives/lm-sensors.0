From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 04 Dec 2007 10:41:54 +0000
Subject: Re: [lm-sensors] pwmconfig patch
Message-Id: <20071204114154.41279fbc@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Sorry for the late answer ;)

On Sun, 18 Mar 2007 15:32:02 -0400, Straterra wrote:
> I have a Shuttle SN25P and like most shuttles, all of the fans in it
> are controlled via PWM. I recently tried pwmconfig to set them up for
> automatic speed control and found that there was an issue in the lm85
> driver that has been known, but not fixed. Hopefully, this patch will
> generate enough of a stir that people with the broken driver will
> email and nag the devs so the fix gets done.
> 
> This patch merely detects to see if there was a problem disabling the
> pwm control interfaces. When the user gets an access denied error,
> this is a sure symptom of a problem with the underlying driver. It
> detects this and spits out a warning and instructs the user to let the
> appropriate people know.

I've applied a different fix to the pwmconfig script. A read-only
pwmN_enable file doesn't necessarily mean that the driver is broken.
The device might as well support only one control mode and the only way
to let user-space know what it is is to create a read-only pwmN_enable
file. So I had pwmconfig simply skip PWM outputs that it cannot control.

I have also submitted two patches yesterday that fix the lm85 driver so
that it finally works correctly with pwmconfig. Please test if you can.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

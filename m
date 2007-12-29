From: David Bender <codehero@gmail.com>
Date: Sat, 29 Dec 2007 19:48:13 +0000
Subject: Re: [lm-sensors] abituguru3 does not work with Abit IX38
Message-Id: <loom.20071229T193556-146@post.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <loom.20071229T015954-296@post.gmane.org>
In-Reply-To: <loom.20071229T015954-296@post.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hans de Goede <j.w.r.degoede <at> hhs.nl> writes:

> I'm afraid that the abituguru3 driver only supports reading sensors and 
> sensors settings, the pwm part is completely unsupported, not even 
> reading the settings is supported.

I am willing to spend a few hours staring at assembly before I break down and
buy their guru control panel.

Is there anyway to read the microcode on the uguru uC?

Perhaps looking at the BIOS code may help? I am sure there must be some routine
for communicating with their uC in that code.

I noticed a W83320G PWM control chip on my mobo. Could this possibly control
 the fans?


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

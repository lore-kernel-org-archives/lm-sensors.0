From: jthiessen@penguincomputing.com (Justin Thiessen)
Date: Thu, 19 May 2005 06:25:20 +0000
Subject: adm1026 driver port for kernel 2.6.X
Message-Id: <20041025210057.GB19053@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041018210758.GB14960@penguincomputing.com>
In-Reply-To: <20041018210758.GB14960@penguincomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, Oct 25, 2004 at 10:39:58PM +0200, Jean Delvare wrote:
> > But I see your point.  If we keep the DAC output as well as the PWM
> > output in the interface, there really is no reason to provide separate
> > pwm1_* and pwm2_* entries, since only one can operate at a time.  Then
> > we would need to replace
> > 
> > pwm[1-2]_enable, {0,1,2}
> > 
> > with a single file such as:
> > 
> > pwm_enable, {0,1,2,3,4}
> > 
> > where:
> > 
> > 0 -> no fan control, fans set @ full speed
> > 1 -> manual PWM fan control
> > 2 -> manual DAC fan control
> > 3 -> automatic PWM fan control
> > 4 -> automatic DAC fan control
> 
> This won't be allowed since value 2 is standardized as auto mode. You
> could default to PWM and allow the used to switch to DAC, or provide a
> non-standard file to switch from PWM to DAC and back (pwm1_mode?)

Ok.  Let's try this:

pwm1                    {0-255}   Actual PWM/DAC value, single interface to
                                  both registers.
pwm1_auto_pwm_min       {0-255}   Scaled to {0-15}, single interface to both
                                  registers.
pwm1_enable             {0-2}     Fan control:  off, manual, and automatic, 
                                  respectively
pwm1_mode               {0-1}     0 (default) is PWM control of fans, 1 is DAC.

-------

Thanks,

Justin Thiessen
---------------
jthiessen@penguincomputing.com



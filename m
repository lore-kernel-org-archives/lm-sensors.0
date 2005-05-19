From: jthiessen@penguincomputing.com (Justin Thiessen)
Date: Thu, 19 May 2005 06:25:20 +0000
Subject: adm1026 driver port for kernel 2.6.X
Message-Id: <20041029191229.GB803@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041018210758.GB14960@penguincomputing.com>
In-Reply-To: <20041018210758.GB14960@penguincomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Oct 26, 2004 at 09:49:22AM +0200, Jean Delvare wrote:
> 
> >Ok.  Let's try this:
> >
> >pwm1                    {0-255}   Actual PWM/DAC value, single interface to
> >                                  both registers.
> >pwm1_auto_pwm_min       {0-255}   Scaled to {0-15}, single interface to both
> >                                  registers.
> >pwm1_enable             {0-2}     Fan control:  off, manual, and automatic,
> >                                  respectively
> >pwm1_mode               {0-1}     0 (default) is PWM control of fans, 1 is
> >                                  DAC.
> 
> Fine with me. You may even rename pwm1_mode to pwm1_dac or use text
> strings as the values (say "pwm" and "dac") so as to make the
> interface self-explaining. Not a big deal anyway, and we obviously lack
> the knowledge of other chips with similar functionality to decide what
> the smartest move would be. We can always change it afterwards if such
> chips arise. I don't think it'll happen though, since DAC have
> completely disappeared from newer chips.

Ah, I've been an idiot.  After making these changes I went through and
tested fan control bits again.  

It turns out that the DAC is not connected to *any* of the fan outputs on the 
Arima HDAMA.  (A fact which I have just verified by connecting fans to all
fan connectors on the motherboard, including ones listed as not being 
connected to the adm1026, and writing minimum and maximum values to the
DAC register, and to the DAC fan-control enable bit.) I was sure that I had 
tested DAC-only driving of the fans earlier, but apparently I had only done 
so with automatic _PWM_ control of the fans enabled.  Since the 4 most 
significant bits of the DAC register determine BOTH minimum PWM frequency and 
minimum DAC driving voltage when both PWM and DAC automatic fan control are 
enabled, the fact that the DAC is not connected to the fans is camouflaged by 
the continued operation of the PWM.  I misinterpreted the ADM1026 docs in the 
lm_sensors doc/chips directory as implying that a set of fans could be 
controlled by either the PWM or the DAC, depending on how the register 00h 
was set.  The more likely situation is, of course, that mutually exclusive 
sets of fans could be connected to PWM and the DAC outputs.

Because of this, my previous interface design is rather borked.  It is 
rather obviously a Bad Idea to allow the user to believe he was setting the 
DAC as the output driving all the fans.  Done blindly, it would result in the 
fans totally failing to function on the HDAMA. 

So:

(1)  There is no pwm1_mode or pwm1_dac, and therefore no end-user method
     provided that implies it is possible to set the DAC as the driving 
     output for all the fans.  This was based on my faulty interpretation
     of the docs, and has to go.

(2)  There is now no way provided to set up automatic fan control driven by 
     the DAC.  This encompasses the step taken in (1) but also excludes
     any exposure of the bit necessary to set the DAC output into automatic
     fan control mode.  I have provided simple access to the DAC register,
     (see (3)), but nothing else.

     As noted before, when the DAC is set to automatic fan control mode, the 
     value in the 4 MSB of the DAC register supersedes that in the 4 MSB of 
     the PWM control register.  It would be extremely bad form to provide 
     access to a "toggle" bit that does nothing in the known implementation
     other than change which sysfs file must be written in order to set
     minimum fan speed under automatic fan control!  As for slaving the DAC
     registers and sysfs files to the PWM ones, see (4)

(3)  I've added the sysfs file "analog_out" which provides access to
     the DAC register, and which is displayed in millivolts.  At the moment,
     this has no utility (AFAIK) with respect to the HDAMA board, but because
     it might have some use in other applications and because it was provided
     in the 2.4.X driver I have included it.

(4)  The pwm* sysfs files now only change PWM-specific registers.  I could
     simply hard-code the set_pwm* and show_pwm* functions to write both
     PWM and DAC outputs with identical values, but slaving DAC-specific 
     sysfs files and registers to their PWM counterparts looks like a bad 
     idea considering that I have no way of actually testing the results in 
     a system with the DAC connected.

     The possible solution I see is to provide a sysfs file to allow 
     toggling of whether or not the DAC registers are slaved to the PWM
     values.  Something like:

     pwm1_controls_dac     {0-1}

    (Even though in actuality the value in the DAC register overrides the
     one in the PWM register during automatic fan control, introducing 
     dac_controls_pwm1 is poor design because the name implies the existence
     of dac_specific sysfs files that would need to be manipulated.  
     dac_mirrors_pwm might be better(?)) 

     could be added to the pwm* set of sysfs files.

     pwm1                  {0-255}
     pwm1_auto_pwm_min     {0-255}
     pwm1_enable           {0-1}
 
     With sensible defaults and checks to ensure appropriate mode-change
     behavior.  E.g:

     (A)  When pwm1_controls_dac is turned on, all PWM settings are copied to
          the corresponding DAC ones and applied.
     (B)  When pwm1_controls_dac is turned off, the fan control via the DAC
          is turned off and the DAC register is set back to its maximum value.

     analog_out could be preserved under this scheme, and a simple check of
     pwm1_controls_dac might be used to fake changing it from RW to RO when
     the DAC was slaved to the PWM registers, thus preserving the ability to
     monitor the DAC's output in terms of voltage, even during DAC automatic
     fan control, but obviating the possibility of changing driving voltages
     to fans through more than one sysfs entry.

Opinions on (4)?  I think it would work, but I'm not sure it's really worth
implementing.  I'm inclined to just go back to:

pwm1
pwm1_auto_pwm_min
pwm1_enable
analog_out

I appologize for wasting everyone's time discussing this issue.

Justin Thiessen
---------------
jthiessen@penguincomputing.com




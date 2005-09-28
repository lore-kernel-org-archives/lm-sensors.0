From: grant_lkml@dodo.com.au (Grant Coady)
Date: Wed, 28 Sep 2005 23:55:20 +0000
Subject: [lm-sensors] Fan control with Winbond W83627EHF
Message-Id: <6l3mj15beageia09j6b0fk03m1tvu82q27@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <433B00C3.90205@liberalismen.dk>
In-Reply-To: <433B00C3.90205@liberalismen.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 28 Sep 2005 22:44:51 +0200, Kjeld Flarup <kjeld.flarup@liberalismen.dk> wrote:
>
>I have an ASUS A8V-E SE Motherboard with a Winbond W83627EHF chip. Im 
>running kernel 2.13
>I got lm_sensors detect the fan speed now, but the pwmconfig script fails.
>As far as I can see it is because there are no fan1_pwm devices created 
>by the driver.
>
>I only got these devices with these current values:
>fan1_div:8
>fan1_input:1360
>fan1_min:1205
>fan2_div:8
>fan2_input:1834
>fan2_min:1704
>fan3_div:4
>fan3_input:1360
>fan3_min:0
>
>_div & _input is readonly, while I can write to _min. But writing to _min does not seem to have any efect.

fan?_min is not a speed control, it is a low speed alarm setpoint.
>
>Is it possible to control the fan with the above or does the drivers miss something?
Controlling fan speed is a different issue, no pwm means the speed 
control is not available (yet).  Check your mobo, I have a similar 
Winbond chip on a Sempron SktA mobo but no fan speed control hardware.
>
>If the drivers are missing something, then I'm willing to code whats needed if I can get some hints.
If you dual-boot windows you can get a second opinion on hardware 
with SpeedFan <http://www.almico.com/speedfan.php>, particularly 
if fans are controllable.

Read up on lmsensors site docs, the chip datasheet, and have a go.
People here will help.

Cheers,
Grant.


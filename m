From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 24 Jan 2014 14:40:24 +0000
Subject: Re: [lm-sensors] Asus H87-PRO /usr/sbin/pwmconfig: There are no pwm-capable sensor modules installed
Message-Id: <52E27B58.10107@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <CALiX4iZMuV2446GaK9qyS8Cfa=q1RV0w8-UUXYnOFXfROkBoaw@mail.gmail.com>
In-Reply-To: <CALiX4iZMuV2446GaK9qyS8Cfa=q1RV0w8-UUXYnOFXfROkBoaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 01/22/2014 11:25 PM, mathias_g@tuxedo.ath.cx wrote:
> Hi Guenter
>
>> Can you send me the output of "grep . pwm2*" ? I'll see if I can
>> find anything in the datasheet that might explain this behavior.
> Sure. Here is the output:
> pwm2:27
> pwm2_auto_point1_pwm:7
> pwm2_auto_point1_temp:30000
> pwm2_auto_point2_pwm:178
> pwm2_auto_point2_temp:55000
> pwm2_auto_point3_pwm:255
> pwm2_auto_point3_temp:75000
> pwm2_auto_point4_pwm:255
> pwm2_auto_point4_temp:75000
> pwm2_auto_point5_pwm:255
> pwm2_auto_point5_temp:75000
> pwm2_crit_temp_tolerance:2000
> pwm2_enable:5
> pwm2_floor:1
> pwm2_mode:1
> pwm2_start:1
> pwm2_step_down_time:100
> pwm2_step_up_time:100
> pwm2_stop_time:6000
> pwm2_target_temp:50000
> pwm2_temp_sel:7
> pwm2_temp_tolerance:0
> pwm2_weight_duty_base:0
> pwm2_weight_duty_step:0
> pwm2_weight_temp_sel:1
> pwm2_weight_temp_step:0
> pwm2_weight_temp_step_base:0
> pwm2_weight_temp_step_tol:0
>
> BIOS profile set to "Quiet", values modified like mentioned in my previous
> post.
>
> Maybe Michael (with the same Mainboard) could try to reproduce this effect
> on his hardware?
>

Might be a good idea. For my part I have no idea why that happens. I don't find
anything in the chip datasheet, nor in the code, nor in your configuration,
that would explain this behavior :-(.

One interesting experiment might be to check what happens if you set
pwm2_auto_point1_pwm to a value between 1 and 4. If that results in the fan
running at full speed, we have some indication that either the fan or the
board hardware is causing this behavior.

Thanks,
Guenter


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

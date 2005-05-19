From: rutger@nospam.com (rutger@nospam.com)
Date: Thu, 19 May 2005 06:24:56 +0000
Subject: pwmconfig fix
Message-Id: <20040506215442.GA31272@nospam.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

[little bug report + fix]

On my Asus P4P800 motherboard with a w83627thf sensor chip, pwmconfig
from lm_sensors-2.8.6 doesn't detect the pwm-files by default
(2.6.6-rc3, module w83627hf). This is the listing of
/sys/devices/platform/i2c-1/1-0290:

alarms        fan2_input  in0_min    in3_max    in8_max         temp2_max
beep_enable   fan2_min    in0_ref    in3_min    in8_min         temp2_max_hyst
beep_mask     fan2_pwm    in1_input  in4_input  name            temp2_type
detach_state  fan3_div    in1_max    in4_max    power           temp3_input
fan1_div      fan3_input  in1_min    in4_min    temp1_input     temp3_max
fan1_input    fan3_min    in2_input  in7_input  temp1_max       temp3_max_hyst
fan1_min      fan3_pwm    in2_max    in7_max    temp1_max_hyst  temp3_type
fan1_pwm      in0_input   in2_min    in7_min    temp1_type      vrm
fan2_div      in0_max     in3_input  in8_input  temp2_input

As you can see the pwm files are called 'fan[1-9]_pwm'. Likewise for
the fan inputs, which are called fan[1-9]_input.

After changing this in pwmconfig to take those files into account,
your script worked. Thanks.

Regards,
Rutger.

-- 
Rutger Nijlunsing ---------------------------- rutger ed tux tmfweb nl
never attribute to a conspiracy which can be explained by incompetence
----------------------------------------------------------------------

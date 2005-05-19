From: frank@vfx.to (Frank Hellmann)
Date: Thu, 19 May 2005 06:25:25 +0000
Subject: Ticket 1834 Update
Message-Id: <41B1D44F.4090303@vfx.to>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi!

The chip on the MSI KT8 Neo is actually a Winbond w83697hf and is not 
detected correctly during sensors-detect.

I loaded the module with    modprobe w83781d force_w83697hf  , but this 
didn't change the PWM problem.

pwmconfig can't detect a usable a correlation:

Testing pwm control 1-0290/fan1_pwm ...
  1-0290/fan1_input ... speed was 3229 now 0
    It appears that fan 1-0290/fan1_input
    is controlled by pwm 1-0290/fan1_pwm
Would you like to generate a detailed correlation (y)?
    PWM 255 FAN 3229
    PWM 240 FAN 3214
    PWM 225 FAN 3214
    PWM 210 FAN 3229
    PWM 195 FAN 3229
    PWM 180 FAN 3229
    PWM 165 FAN 3229
    PWM 150 FAN 3229
    PWM 135 FAN 3229
    PWM 120 FAN 3229
    PWM 105 FAN 3214
    PWM 90 FAN 3214
    PWM 75 FAN 3229
    PWM 60 FAN 3214
    PWM 45 FAN 3214
    PWM 30 FAN 3214
    PWM 15 FAN 3169
    PWM 0 FAN 0
    Fan Stopped at PWM = 0


    Thanks,
                   Frank...

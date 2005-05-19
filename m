From: rutger@nospam.com (rutger@nospam.com)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: pwmconfig fix
Message-Id: <20040509165715.GA8977@nospam.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040506215442.GA31272@nospam.com>
In-Reply-To: <20040506215442.GA31272@nospam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, May 08, 2004 at 09:39:03PM +0200, Jean Delvare wrote:
> > Latest version of lm_sensors2? I did a fresh checkout of lm_sensors2
> > which didn't solve anything (cvs -d
> > :pserver:anon@cvs.lm-sensors.nu:/home/cvs checkout lm_sensors2).
> 
> Hm, that's bad :(
> 
> That said, I just realized that I fixed only pwmconfig, while fancontrol
> needed a change too. Just changed that. And I had missed some changes in
> pwmconfig as well. I should really have been more careful, sorry.
> 
> Care to test again? It should be better.

Ok, doing better now. Output attached.

Found the following PWM controls:
   1-0290/fan1_pwm
   1-0290/fan2_pwm
   1-0290/fan3_pwm

Found the following fan sensors:
   1-0290/fan1_input     current speed: 0 ... skipping!
   1-0290/fan2_input     current speed: 2667 RPM
   1-0290/fan3_input     current speed: 0 ... skipping!

Testing pwm control 1-0290/fan1_pwm ...
  1-0290/fan2_input ... speed was 2667 now 2700
    no correlation

Testing pwm control 1-0290/fan2_pwm ...
  1-0290/fan2_input ... speed was 2667 now 0
    It appears that fan 1-0290/fan2_input
    is controlled by pwm 1-0290/fan2_pwm
Would you like to generate a detailed correlation (y)? 
Would you like to generate a graphical plot using gnuplot (y)? 
    PWM 255 FAN 2689
    PWM 240 FAN 2689
    PWM 225 FAN 0
    Fan Stopped at PWM = 225
    Hit return to continue...

Testing pwm control 1-0290/fan3_pwm ...
  1-0290/fan2_input ... speed was 2667 now 2667
    no correlation

The problem is fan2_pwm, where only 3 samples are taken. This is not enough in this case.

Bug in script:
Line 242:
		if [ "$S" = "0" -o "S" = "-1" ]
Shouldn't "S" be "$S" ?


pwmconfig delivers quite a dull gnuplot, but I do not understand the
relation between the _pwm value and the fan speed myself.

Problems:
  - at pwm 240, the fan speed reported in 0 while I still hear it turning.
  - at pwm 200, is goes even faster than at 255, and it reports 3139 as rpm(!).

It appears the speed is also depending on the speed from which it came. Doing
  echo 255 >fan2_pwm; sleep 2; echo 200 >fan2_pwm
will give me +-3100, while doing
  echo 0 >fan2_pwm; sleep 2; echo 200 >fan2_pwm
will give me 0. Strange...

Where do I report such strange interaction?

-- 
Rutger Nijlunsing ---------------------------- rutger ed tux tmfweb nl
never attribute to a conspiracy which can be explained by incompetence
----------------------------------------------------------------------

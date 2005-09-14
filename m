From: grant_lkml@dodo.com.au (Grant Coady)
Date: Wed, 14 Sep 2005 07:01:50 +0000
Subject: [lm-sensors] Query: anyone working on w83627hf.c?
Message-Id: <sabfi1lu8kki8qvck3nc923n9vluq6l33b@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi there,

Since I have a w83697hf in a box I'm looking to cleanup the driver, 
convert to dynamic sysfs and perhaps fit auto-fan-divider, cannot 
test thermal cruise as AMD CPU doesn't vary much and  it appears the 
onboard fans not hooked to PWM, SpeedFan doesn't work either.

Will also correct voltage multiplier on one input not match datasheet, 
whitespace cleanup last since planning to excise a fair amount of 
macros.

Cheers,
Grant.


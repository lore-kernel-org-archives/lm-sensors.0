From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:52 +0000
Subject: [PATCH 2.6.12-rc2-mm3] i2c: modify lm87 to use auto fan_div
Message-Id: <3og4619ng5oidibb1ed4v2ta475jd4grs7@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <t4uv511i3ntqtdblptvsko6tfvcm27k7hf@4ax.com>
In-Reply-To: <t4uv511i3ntqtdblptvsko6tfvcm27k7hf@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Khali,
On Sun, 17 Apr 2005 12:57:09 +0200, Jean Delvare <khali@linux-fr.org> wrote:

>Hi Grant,
>
>> So I see it more as me putting wrong priorities on things, thus 
>> I now accept your argument of valid alarm + fan speed display, 
>> the 'sufferer' will be fan speed resolution, but that does not 
>> matter for ridiculous settings, which is what we want handle 
>> with "Just Works".  Agree?
>
>Agreed. We want to handle all cases but with varying level of effort.
>
..
>In particular, we do not want to do anything special when the low limit
>is disabled. There are only two valid reasons to disable the limit:
>1* No fan is connected. No need to waste our energy on this case,
>obviously.
Reasons don't matter, user says zero, we disable alarm, no touch 
fan clock easy rule.

OT:
I lost sight of some things, spent hours yesterday proving negative 
voltage readings, as they are ratiometric to the positive +5V, not 
a reference -- dunno if 'sensors' can do that -- then only one of 
three datasheets had a useful transfer calculation.  Sorted the 
switch "what" for limits, just the display of min/max get swapped, 
the register settings -- though I did that empirically, rather 
than prove a transfer function. 

>2* The fan is actually running slower that the chip supports. The
>current code will switch to the highest divider, which is the correct
>thing to do. No additional code is needed.
okay, yes -- but should we not then return error message in this 
case?  User has set a value and apparently nothing happened, (user 
doesn't check her logs any :)  Why bother?

>
>Disabling the low limit when you have a fan running at a standard speed
>is a bad idea, which is why I ask you not to add code to support that
>case.
I see your point know I had the alarm state in sight, we want 
fan speed, even when fan_min register goes to zero we have alarm 
state, so it is okay.  Just want fan speed too, can do that.

Having to explain this to each other improves my understanding.
Hope you not too annoyed with me :)

Something has to take a hit, and fan limit resolution is it, I've 
already dropped the chop point from 192 down to 128, then check 
if fan > 192 and do one adjustment in the set_fan_min.  Rest of 
adjustment in measurement side, not bidirectional until we see a 
need?  Hitting fan_min resolution early will (I hope) improve the 
thing.  Getting late my time -- more tomorrow.  

With measurements, proof.

Cheers,
Grant.

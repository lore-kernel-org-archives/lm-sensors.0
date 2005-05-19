From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:52 +0000
Subject: [PATCH 2.6.12-rc2-mm3] i2c: modify lm87 to use auto fan_div
Message-Id: <3qo461lsbqggplo9kfibbmj7e03tijrfft@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <t4uv511i3ntqtdblptvsko6tfvcm27k7hf@4ax.com>
In-Reply-To: <t4uv511i3ntqtdblptvsko6tfvcm27k7hf@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Khali,

On Sun, 17 Apr 2005 15:17:13 +0200, Jean Delvare <khali@linux-fr.org> wrote:

>> Something has to take a hit, and fan limit resolution is it, I've 
>> already dropped the chop point from 192 down to 128, then check 
>> if fan > 192 and do one adjustment in the set_fan_min.
>
>What exactly are you trying to achieve? 192 seemed to be a good
>equilibrium between range margin and resolution.

Exploring, it did nothing good for us, back up at 192 :)

>> Rest of adjustment in measurement side, not bidirectional until we
>> see a need?
>
>Absolutely. Note that this guarantees a "stable" divider, while
>bidirectional could result in endless divider change, which I would like
>to avoid, because divider change is somewhat expensive.

Okay, what I have so far is fan_min set to zero, disable fan alarm, 
no touch divider.

fan_min set too low, set to lowest value (div = 8, fan_min = 254), 
this indicates to the user the lowest limit value for adm9240: 664.
Since their fan is (mine was) running alarm not asserted, alarm will 
be asserted if fan speed goes below min operating point --> correct 
operation.

fan_min set too high?  50000 -> fan_min, displayed back as something 
like 42000 and alarm asserted :)  Takes a few measurement cycles to 
recover fan speed display...  that's what you wanted?  

Not quite right yet...  

The rules seem to be don't auto-adjust fan clock divider unless 
fan_min > 192, speed = 255 and div < max_div...

Then my brain stopped :)  And I just shut down the other machines.

Cheers,
Grant.

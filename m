From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:25:00 +0000
Subject: Second auto pwm interface proposal
Message-Id: <40B515DF.50103@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040522142546.0ddb37c0.khali@linux-fr.org>
In-Reply-To: <20040522142546.0ddb37c0.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:

>Temperature channel selection
>-----------------------------
>
>The interface was designed so that more than one channel can be
>associated with one given fan. I proposed that because the ADM1031 can
>do that. Question is: does the user need this? I doubt it.
>
>The drawback of the current interface is that you never know which
>values are supported by the chip. Reading from the files is fine, it
>reflects the current state in a standard way. But writing is not, which
>makes the interface bad IMHO.
>
>Can't we just support one channel per fan? 0 would still mean disabled,
>1-N for the channel number. This is easier to understand for the user,
>and I'd expect it to be enough for almost all users.
>
>  
>
Simplification is good.  I'd support that...

Unfortunately, I've got a situation where I *need* to be able to use the 
"greater of two channels" mode of the lm85 where multiple channels are 
selected.  In this case the system is a dual CPU system and the fan 
control/PWM in question controls *both* CPU fans.

I'd be OK if we grandfather the existing LM85 interface, or some up with 
some other way to poke the chip specific controls.

Perhaps the simplified stuff is left to user space and libsensors rather 
than implemented in the kernel driver itself?

:v)


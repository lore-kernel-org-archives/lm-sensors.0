From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: RFC parameter based voltage scaling
Message-Id: <n10381tg1rejgouc272lhar7dvf2122bof@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <rl8u711rq5bc1e1jtt91s76fed180ctoav@4ax.com>
In-Reply-To: <rl8u711rq5bc1e1jtt91s76fed180ctoav@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Khali,
On Mon, 9 May 2005 15:35:36 +0200 (CEST), "Jean Delvare" <khali@linux-fr.org> wrote:

Okay, its up, some notes, the script, the runtime output
at http://scatter.mine.nu/hwmon/voltage/

If you could confirm sensors compute can do the transforms in one 
of my earlier answers this morning (before coffee) then we can 
leave it for now.  

I'm thinking an array of u16 'fake' nominal scale readings for internal 
scaling is easiest to do for winbond, that way all drivers have similar 
looking scaling transform, it works, I had it in at some stage.

Probably less confusing than having R1/R2 scaling perhaps just in
winbond chips, a comment would advise derivation of values.  Yes?

Problem now is the backwards compatability issue, or simply document 
what has been done and move on.  I'd prefer to see correct mV from 
sysfs.  Same as fan rpm, temperature -- other oddball is pwm presented 
as 0..255 rather than percentage?

--Grant.




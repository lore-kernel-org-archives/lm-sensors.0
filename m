From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 17 Dec 2005 17:27:51 +0000
Subject: [lm-sensors] [PATCH] lm_sensors2 w83792d fix fan auto adjust
Message-Id: <20051217182751.4883ee0a.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECEB7BF78@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECEB7BF78@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Yuan,

Sorry for the late answer.

> > Can you please rework your patch in that direction?
> 
> I hope I get your idea :) The new patch is attached with this mail,
> please check.

Looks OK to me, you got it all right, I've just committed it.

On top of it, I've made some cleanups (no functional change):
* In w83792d_set_fan_div(), I've dropped the checks on newdiv. Now that
this function is no more called with user input data, these checks were
no more needed. I also removed useless initializations to 0.
* In w83792d_fan(), I've changed the code to avoid the double settings
when fans are disabled.
I hope you're OK with these cleanups.

> I don't know what kind of attachment type to choose, I have changed it
> to BINHEX, is it right?

Not quite. I had to decode the data manually using "uudecode", which
wasn't very convenient.

I think that the previous method was almost correct. The only thing
that wasn't OK was the mime type of the attachement. Next time, I
suggest that you try adding ".txt" to the name of your patch file
before attaching it, and attach it like you did before (not BINHEX).
Your email client should hopefully pick the correct mime type if you do
that.

You may send test mails to me directly if you want to test attachement
methods before sending to the list, and I'll tell you what it looks
like on my end.

Thanks for your good work once again, this is very much appreciated.

-- 
Jean Delvare


From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 04 Oct 2006 14:43:44 +0000
Subject: [lm-sensors] Answer Epox - EPoX EP1308 sensor-chip
Message-Id: <20061004164344.b7653473.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <450B14DB.2090505@sh.cvut.cz>
In-Reply-To: <450B14DB.2090505@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

> Jean Delvare wrote:
> > Note that I am unlikely to accept undocumented fan control functions in
> > the mainline kernel anyway. I don't want to put the user's system at
> > risk, and I don't want to encourage manufacturers to keep their
> > documentation secret.
> 
> Define undocumented, if undocumented means the chip can do it, but the 
> motherboard manufacturer didn't implement this in its drivers for other 
> OS and BIOS, then I agree with you. However here the settings can be 
> controlled through the bios, thus I believe we should allow modifying 
> them from lm-sensors too (to the limits the bios allows and no more). 
> This ofcourse assumes we manage to find out exactly how these work, to 
> the point where we can say this setting in the BIOs matches that and 
> that byte in X increment units. If it stays as vague as this setting 
> influences those bytes, then I fully agree with you.

Hehe, I agree expected some reaction from you ;)

If we can use the BIOS to find out additional chip features, and these
are straightforward enough for me to feel safe, why not. However Hans
Edgington's investigation didn't really sound as "things are easy to
understand" to me. Furthermore, I'm ready to take some (limited) risk
with extra monitoring functions, but fan speed control is something
different. If you get it wrong you can kill the hardware, so we can't
just implement it and wait for users to report. We've seen enough odd
things happen even with documented chips to imagine how bad it can get
without documentation.

Put in short, I have two objectives:
* Make it safe for the users.
* No increase to my maintenance workload.
If I feel both objectives are fulfilled, I won't object.

-- 
Jean Delvare


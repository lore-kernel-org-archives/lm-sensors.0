From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Wed, 04 Oct 2006 14:01:49 +0000
Subject: [lm-sensors] Answer Epox - EPoX EP1308 sensor-chip
Message-Id: <4523BECD.5080603@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <450B14DB.2090505@sh.cvut.cz>
In-Reply-To: <450B14DB.2090505@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Note that I am unlikely to accept undocumented fan control functions in
> the mainline kernel anyway. I don't want to put the user's system at
> risk, and I don't want to encourage manufacturers to keep their
> documentation secret.
> 

Define undocumented, if undocumented means the chip can do it, but the 
motherboard manufacturer didn't implement this in its drivers for other 
OS and BIOS, then I agree with you. However here the settings can be 
controlled through the bios, thus I believe we should allow modifying 
them from lm-sensors too (to the limits the bios allows and no more). 
This ofcourse assumes we manage to find out exactly how these work, to 
the point where we can say this setting in the BIOs matches that and 
that byte in X increment units. If it stays as vague as this setting 
influences those bytes, then I fully agree with you.

Regards,

Hans



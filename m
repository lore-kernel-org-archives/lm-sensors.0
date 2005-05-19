From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:06 +0000
Subject: i2c/isa command line tools
Message-Id: <20040725222521.1df8dfad.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I plan to operate the following changes on isaset and i2cset:
1* Add an optional mask to the byte being written.
2* Remove the 5 second delay.

The idea is that these tools should be usable to fix broken
configurations or tweak the chips above what drivers do.

In that respect we may need i2cget and isaget someday.

While we're at it I guess we could remove the 5 second delay from the
other tools as well (i2cdump, isadump and even i2cdetect). I doubt it
really helps. Who reads and understands the command summary anyway? If
you didn't take care of what you typed, there's no reason you will care
much about what the program says.

Objections?

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/

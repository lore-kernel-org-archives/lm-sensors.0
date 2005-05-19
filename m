From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:07 +0000
Subject: i2c/isa command line tools
Message-Id: <41058EF7.6000407@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040725222521.1df8dfad.khali@linux-fr.org>
In-Reply-To: <20040725222521.1df8dfad.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I was thinking, instead, about an option we could add to all the tools
(say -y for "yes") that would skip the warning and the delay.
This would make the tools better for use in scripts.


Jean Delvare wrote:
> Hi all,
> 
> I plan to operate the following changes on isaset and i2cset:
> 1* Add an optional mask to the byte being written.
> 2* Remove the 5 second delay.
> 
> The idea is that these tools should be usable to fix broken
> configurations or tweak the chips above what drivers do.
> 
> In that respect we may need i2cget and isaget someday.
> 
> While we're at it I guess we could remove the 5 second delay from the
> other tools as well (i2cdump, isadump and even i2cdetect). I doubt it
> really helps. Who reads and understands the command summary anyway? If
> you didn't take care of what you typed, there's no reason you will care
> much about what the program says.
> 
> Objections?
> 

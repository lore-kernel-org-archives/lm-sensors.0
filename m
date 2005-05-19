From: frank.beesley@aeroflex.com (Frank Beesley)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: Clean up of i2c-elektor.c build for 2.6.11
Message-Id: <4231FB69.2010601@aeroflex.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <422E2417.7020707@aeroflex.com>
In-Reply-To: <422E2417.7020707@aeroflex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I will try this again. I did a "diff -v" and see that our workstations 
have colordiff 1.0.4 on top of diff (GNU diffutils) 2.8.7. This would 
explain the wonderful colors. I went back to our target machines that 
have just he diffutils, not colordiff.


This patch changes the flags variable type from long to unsigned long in  one function. This removes a couple of warnings from the compile messages for elektor i2c bus driver.

Signed-Off-By Frank Beesley <frank.beesley@aeroflex.com>


-------------- next part --------------
A non-text attachment was scrubbed...
Name: elektor.diff
Type: text/x-patch
Size: 350 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050311/5bc2daf4/elektor.bin

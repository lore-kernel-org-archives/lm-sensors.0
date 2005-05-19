From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:20 +0000
Subject: #1787 Wrong temps on dual 533FSB Xeon with i7505 chipset
Message-Id: <20041023095743.5d37c8d0.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <416FDE52.2040804@liv.ac.uk>
In-Reply-To: <416FDE52.2040804@liv.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Hi Jean,
> 
> Am willing to keep trying something. This machine is one of 16
> identical machines in a cluster, so it is worth that little more
> effort.
> 
> Output before loading i2c driver:
> isadump 0xC05 0xC06 1
> (...)

Nothing especially relevant here.

I found a report for the same Tyan board you are using here:
http://www2.lm-sensors.nu/~lm78/readticket.cgi?ticket11
The guy obviously has the same problem as you have. Read my comments at
the very bottom for hints about the voltage inputs.

I am out of ideas as far as investigation is concerned. Our only hope is
with Tyan. Since you own a significant number of these boards, I think
that they owe you some support, don't you think? Please contact them,
expose your problem, and ask them for a sample lm_sensors configuration
file for this board. Since they were able to produce a sample output,
they must have had a configuration file back then.

Sorry that I cannot do much more myself.

-- 
Jean Delvare
http://khali.linux-fr.org/

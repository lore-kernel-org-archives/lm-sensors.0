From: gimeshell@web.de (gimeshell at web.de)
Date: Sun, 18 Jun 2006 18:11:11 +0000
Subject: [lm-sensors] better temp2 computation for asus CUSL2C
Message-Id: <20060618201111.c4f9a4ff.gimeshell@web.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060618021736.f08a39bb.gimeshell@web.de>
In-Reply-To: <20060618021736.f08a39bb.gimeshell@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 18 Jun 2006 19:02:30 +0200
Jean Delvare <khali at linux-fr.org> wrote:

Hi,

> Actually my point was that there is probably nothing to correct.

my BIOS does have such an idle loop, too.
Temperature is increasing from about 35 degrees immidiately after
entering BIOS up to 46 degrees met after a few minutes.
Looking at sensors output while linux is idle, i get shown about 30
degrees with sensors default computation line for asus CUSL.

> 
> We use the formula which gives the best result for the applicable
> range of temperatures. There's little point in having a slighly more
> simple equation if it gives less accurate results.
> 

But what's the mathematic principle behind this method (first
to multiply with value, then to add another value)?
Isn't the bottom line outcome the same if only adding fixed value
instead of first to multiply and after that to add another value?

regards,
gimshell


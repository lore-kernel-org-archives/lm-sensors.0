From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:37 +0000
Subject: Intel D865GLC (was: Re: Interested to donate a board to get a
Message-Id: <20050210210130.1027bd96.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <cug5mm$bct$1@sea.gmane.org>
In-Reply-To: <cug5mm$bct$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Timo,

> You seem to have pretty good manual there :-)

Intel has, actually:
ftp://download.intel.com/design/motherbd/lc/C3263401.pdf

That's one really great thing with Intel :)

> So, this problem seems to be solved now; what still remain is that I'm
> a little suspicious about voltage readings looking too much
> idealistic, like Vcore 1.500 Volts...

Isn't it rather VID? VID is the nominal voltage value for the CPU, not
the measured one. in0 or in1 would be. VID is there so that you can set
the relevant low and high limits to something that makes sense for your
specific CPU.

> The output of sensors-detect is attached to the end of the message
> anyway, although it obviously is now of little use.

Especially when you did not unload the i2c client chips, so i2c chips
couldn't be identified ;) Nevermind, it wasn't really useful anymore, as
you said.

> Hey, it's me who is supposed to say thanks!
> You just lost a new motherboard... ;-)

Too bad for us :')

But if you really feel disappointed, remember you still can donate
something at any time in the future if you want to support the project.
I can't think of any hardware part we couldn't possibly make a use of ;)
Alternatively you can make a donation to any global free software
supporting organization of your choice (FSF, FFII etc..), we appreciate
that.

-- 
Jean Delvare

From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:33 +0000
Subject: ASUS P4P800/W83627THF Fan Problems
Message-Id: <20040110231459.43ea643f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <40001A2D.5030007@gmx.de>
In-Reply-To: <40001A2D.5030007@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> OK after changing the fan divisor from 2 to 4 it seems to work now, 
> sorry, I guess I thought that dividing 0 is pointless and thus the 
> divisor isnt the problem..

"Fan divisor" is an obviously misleading term, but well, that's how
chipset makers call it so we stick to it.

> Well, the changing of the Fan's speed works in Windows with Speedfan
> on that Board, so its supported by the hardware.. About the user
> space tools, do they do anything different than changing the pwms?

First they help you figure out which fans are controled by the PWM pins
(pwmconfig) and which temperature channels are associated with these
fans, then they regulate the fan speed automatically according to the
temperature measurements. Much similar to what Speedfan does I guess,
except that this is through shell scripts, without a GUI.

> >Note that we have another driver for the W83627THF but it hasn't been
> >ported to Linux 2.6 yet... When it will be, you should get better
> >results using it than the w83781d driver. If you're interested in
> >porting it yourself, let me know and I'll tell you everything you
> >need to know.
> 
> Well I've read about that, but i guess im not suited for that job, i 
> hardly know c++, i don't know anything about the internals of a
> kernel and drivers etc... and i hardly have the the next few months,
> I'll graduate from school..

FYI the kernel is written in C, not C++. But if you don't know C at all,
I agree that you can't possibly port the driver. In this case, you'll
have to be patient until someone else does.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

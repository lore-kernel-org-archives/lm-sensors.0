From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 06 Apr 2006 19:47:41 +0000
Subject: [lm-sensors] En:Re:  p5gdc problems
Message-Id: <20060406214741.6041c07c.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > > I have a P5gdc Asus, with the w83627ehf chip, but I can`t recieve any
> > > feedback from any lm-sensors based programs. I want to know if I`ll be
> > > able to run this programs, because I want to check my cpu temperature,
> > > and that`s all. I have Ubuntu 5.10 breezy on my pc and I`ve tried all
> > > procedures from the net, but all of them went wrong. Please, help me.
> >
> > Can you post what version of the linux kernel you are running?
>
> Thanks for the answer. So, I`m working with a 2.6.12-9 kernel, Ubuntu
> Breezy 5.10, lm-sensor package from the ubuntu's repository, sensors
> none (but DDR memory-EEPRON-) and this is my output after I run
> sensors-detect:

The w83627ehf driver was first added to Linux 2.6.13, so you don't have
it. You'll need to upgrade to a more recent kernel if you want hardware
monitoring on this machine.

-- 
Jean Delvare


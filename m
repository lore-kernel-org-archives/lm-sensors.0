From: zorba@ds14.agh.edu.pl (Marcin Kielar)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: cpu temperature on abit bx133 (w83782d)
Message-Id: <20040214224729.GA10866@zorba.ds14.agh.edu.pl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040103175546.GA560@zorba.ds14.agh.edu.pl>
In-Reply-To: <20040103175546.GA560@zorba.ds14.agh.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hi

On Fri, Feb 13, 2004 at 09:06:29PM +0100, Jean Delvare wrote:
> > i've installed lm_sensors on my linux box
> > (2.4.22, abit bx133 raid, celeron 800)
> > and have problems with cpu temperature.
......
> Not really. The only thing I could suggest is loading the w83781d module
> with the "init=0" parameter (after a reboot, preferably) so that it
> keeps as much as possible from how the BIOS configured it. Then run
> "sensors -u" without running "sensors -s" first, and see if it is any
> better.

sorry for waisting your time - i've finally found where the problem was 
(meaning there was no problem at all)...

seems that during bios setup the idle loop (awaiting keyboard input, etc)
is not quite idle - cpu is heavy loaded. after booting linux temperatue
falls down, it raises to that level only under heavy load...

that explains why cpu clock had no influence under linux - 800 mhz
cpu doing nothing is almost same as 500 mhz cpu doing nothing...

once again sorry...

-- 
greetings
Marcin Kielar

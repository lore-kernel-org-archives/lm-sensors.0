From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:36 +0000
Subject: Ticket #: 1533 / Cant use Sensors -s
Message-Id: <20040125181737.209cf744.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1074957554.5412.3.camel@Technetium.pse.local>
In-Reply-To: <1074957554.5412.3.camel@Technetium.pse.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > Well, that was supposed to work ;) The common (and unsolved so far)
> > problem is that people can write to the files using "echo" but not
> > through libsensors (which sensors uses).
> 
> I see :)

But this is a different thing here, see below.

> > Yes it does. From what I can see there, you have a second i2c bus (a
> > real one, as opposed to the isa emulation). Looks like there is much
> > trouble on this second adapter. It is probably a completely
> > different problem though. That said, please tell us what that second
> > i2c bus is and what chips are present here, just in case there is
> > some kind of interaction between both problems.
> 
> I really don't know where and what the second i2c bus is, I guess
> there isn't something like lsi2c ? 

There is "i2cdetect -l", and lsmod too ;)

> > Back to the initial problem, I'd like you to strace "sensors -s". I
> > put a trap in there some times ago, maybe it'll confirm my
> > suspicions.
> 
> Here is the output. 

Turns out to be an error in sensors.conf. This file references a third
temperature channel that the w83697hf doesn't have. It's commented out
by default, but I guess you uncommented the lines (set temp3_over and
set temp3_hyst), and this causes the trouble you're in.

Delete these lines from your configuration file, and it should be OK.

I'll do the same in our default configuration file. Strange that nobody
reported the problem so far. Maybe people simply don't uncomment lines
they don't need.

Thanks for the report.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

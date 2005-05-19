From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:20 +0000
Subject: Turn off alarm?
Message-Id: <20041029195920.2371b057.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041027104054.BBF3.TIMEBANDIT@dzn.mine.nu>
In-Reply-To: <20041027104054.BBF3.TIMEBANDIT@dzn.mine.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I'm not sure if i really want to try reverse to 2.4 again now i have
> updated all the system for 2.6 kernel... Everything runs to smooth and
> good now except f?r lm_sensors but that we till change to work too =)

I am simply suggesting that you could try to boot on the old kernel just
once. A system which is able to run a 2.6 kernel will run a 2.4 kernel
just as well.

> Yeah, i managed to fix that +3.3V to show the correct value...
> But those -5V and -12V, they show up as they should in BIOS, shouldn't
> it in the sensors program too? I know that value might not be so
> intresting in the long run...

You're right, if the BIOS display them, then they have to be wired. Most
likely the board simply uses different resistors. You can adjust the
reading by changing the "compute in5" and "compute in6" lines in
sensors.conf. The default configuration files has alternative lines for
these, please try them first.

> chip "it87-*" "it8712-*" <--- Is is there i should begin comment out
> everything that starts with a line as "set" ?

Yes. Stop just before the next section (the big commented out block for
the 786LCD board).

> After i commented out those lines etc should i after every change run
> "sensors-s" ?

Yes. This is how you can find out which "set" line precisely causes the
trouble. Or at least I hope so.

-- 
Jean Delvare
http://khali.linux-fr.org/

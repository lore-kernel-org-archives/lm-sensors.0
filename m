From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: Support DB Entry 1770
Message-Id: <20040915203022.593b22e8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <007201c49733$ef934970$0a01a8c0@enterprise>
In-Reply-To: <007201c49733$ef934970$0a01a8c0@enterprise>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > I thought that Asus
> > started to implement such silly behaviors only recently, but it
> > seems not. The SMBus locks you were experiencing speak for
> > themselves.
> 
> :-\  Ahh well, I always thought they did a pretty good job in other
> regards.  Fabrication of the boards was always nice, not sloppy
> looking like some other boards at the time.

Agreed, I have enjoyed Asus boards too for quite some times, until they
started shipping their boards with undocumented proprietary monitoring
chips (AS99127F, ASB100...) and implemented really weird "active"
hardware monitoring.

> I've got a suggestion for "sensors-detect".  Command-line options for
> the specific tests to perform or skip would be cool, so I could run
> one command line.  Otherwise, I've got to use an input file with my
> prompt-answers, run a command to take the file as input, run another
> command to dump STDOUT and STDERR to a file, and run another command
> to read the output file.  For example this is what I'd use for this
> testing:
> 
> sensors-detect --pci-no --isa-yes --superio-no --summary-yes
> --commands-no

Not sure it would be that useful for the average user. Usually you only
run the script once, so you want to detect everything.

A much more interessant improvement IMHO would be a fully automatic mode
(non-interactive), simply generating the configuration files without the
user having to care. Unfortunatelly, sensors-detect is a very old piece
of code and it'll be hard to accomplish such a miracle, especially since
it would require motherboard-specific information we don't really have.

> Disabling "Delayed Transaction" seems to fix the problems.  in3 has no
> persistent ALARM, temp2 is read correctly, temp2_over and temp2_hyst
> are connect, no chirping.  The cost is a performance hit of 50-60 PCI
> clocks during ISA access (sensors, maybe modem and sound card).  Funny
> they don't clearly state that enabling "Delayed Transaction" will
> break ISA access to the "Health Monitoring".  "sensors" and "sensord"
> appear to work fine.  No force or force_w83781d required.

This is VERY interesting and surprising too. I wouldn't have imagined
that such a broken behavior could result in "bad" BIOS settings (one may
wonder why they propose the option at all if enabling it breaks the
box.)


> The only odd looking thing at this point is the "registering" annd
> "Detect" lines.  It reports "0-0290", but should it be 9191-0290?

Interesting question, I can't really tell why it is this way. The bus
numbering typically depends on the order in which drivers are inserted.
For some reasons, the ISA bus has a kind of alias with the "9191" bus
number. I agree this makes thing more confusing than it helps.

Thanks a lot for the details report, I'll update the ticket.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/

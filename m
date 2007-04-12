From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 12 Apr 2007 07:13:54 +0000
Subject: Re: [lm-sensors] Taking a closer look at lm-sensors,
Message-Id: <20070412091354.10f4bef7@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Mon, 09 Apr 2007 16:03:11 +0200, Hans de Goede wrote:
> Because of the integration of the dynamic chip support written by my students, 
> I've been taking a (much) closer look at lm-sensors userspace.
> 
> The current makefile is broken for use by any serious distribution / any 
> distribution will need to patch it.
> 
> Why? Well because of the abundant use of ":=" instead of "="
> 
> For example the Makefile says:
> "PREFIX := /usr/local"
> 
> Now when one wants an other prefix, normally in the build script for the distro 
> one would invoke make like this:
> 
> make PREFIX=/usr
> 
> however because of the unnecessary use of :=, this isn;'t work as := will 
> overwrite any environment / make commandline settings. This leads to distro's 
> using patches to the makefile like the one attached.

Missing attachment.

> Is it ok if I fix this in the 3.0.0 branch?

I would need to be convinced that this needs to be fixed first. I wrote
a minimal Makefile for testing purposes as follows:

--- 8< ---
PREFIX := /usr/local
BINDIR := $(PREFIX)/bin

all :
	@echo $(PREFIX)
	@echo $(BINDIR)
--- 8< ---

khali@hyperion:~/tmp> make
/usr/local
/usr/local/bin
khali@hyperion:~/tmp> make PREFIX=/usr
/usr
/usr/bin
khali@hyperion:~/tmp>

This is with GNU make 3.81, but I also tested with 3.80 and 3.78.1 with
the same result. So ":=" seems to allow variable value override from
the command line just fine, and I fail to see why a distribution would
need to patch our Makefile. In fact I just tried a "make PREFIX=/foo
user_install" and it installed lm-sensors in /foo just fine. So what's
the problem exactly?

Checking the Slackware and openSuse lm-sensors package sources, I see
that they do indeed patch our Makefile to change the prefix and other
variables. But given my tests above, this seems to be by choice, and I
doubt they would do it any differently if we were using "=" instead of
":=" in the Makefile.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

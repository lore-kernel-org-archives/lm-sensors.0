From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Thu, 12 Apr 2007 10:07:51 +0000
Subject: Re: [lm-sensors] Taking a closer look at lm-sensors,
Message-Id: <461E04F7.4030903@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070412091354.10f4bef7@hyperion.delvare>
In-Reply-To: <20070412091354.10f4bef7@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Hans,
> 
> I would need to be convinced that this needs to be fixed first. I wrote
> a minimal Makefile for testing purposes as follows:
> 
> --- 8< ---
> PREFIX := /usr/local
> BINDIR := $(PREFIX)/bin
> 
> all :
> 	@echo $(PREFIX)
> 	@echo $(BINDIR)
> --- 8< ---
> 
> khali@hyperion:~/tmp> make
> /usr/local
> /usr/local/bin
> khali@hyperion:~/tmp> make PREFIX=/usr
> /usr
> /usr/bin
> khali@hyperion:~/tmp>
> 
> This is with GNU make 3.81, but I also tested with 3.80 and 3.78.1 with
> the same result. So ":=" seems to allow variable value override from
> the command line just fine, and I fail to see why a distribution would
> need to patch our Makefile. In fact I just tried a "make PREFIX=/foo
> user_install" and it installed lm-sensors in /foo just fine. So what's
> the problem exactly?
> 
> Checking the Slackware and openSuse lm-sensors package sources, I see
> that they do indeed patch our Makefile to change the prefix and other
> variables. But given my tests above, this seems to be by choice, and I
> doubt they would do it any differently if we were using "=" instead of
> ":=" in the Makefile.
> 

Hmm,

You are right, still I seem to remember patching Makefiles myself because of := 
causing passing stuff on the cmdline to not work. Maybe this has changed and 
the patched used by opensuse / slackware (and Fedora) were there because this 
didn't use to work??

Anyways overriding them from the cmdline seems to work fine now a days, or 
maybe the replacing of := with = in other cases was just plastering over other 
issues.

Regards,

Hans


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

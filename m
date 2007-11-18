From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 18 Nov 2007 17:12:02 +0000
Subject: Re: [lm-sensors] PATCH: fix building of 3.0.0-rc3 on powerpc and
Message-Id: <20071118181202.423fa77e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <473ECD90.5090603@hhs.nl>
In-Reply-To: <473ECD90.5090603@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Sat, 17 Nov 2007 12:16:32 +0100, Hans de Goede wrote:
> Hi All,
> 
> I just build 3.0.0-rc3 for Fedora's devel branch and it needs the attached 
> patch to compile on powerpc.
> 
> I've not committed this to svn as I'm not sure this is the best way todo this.

Good catch, thanks. I'd rather address the problem in the top Makefile:
there's no point in including prog/dump in the list of source
directories if we won't build anything there. So I'd suggest something
like:

ifneq (,$(findstring $(MACHINE), i386 i486 i586 i686 x86_64))
SRCDIRS += prog/dump
endif

in the top Makefile. Then you can even remove the architecture tests
in prog/dump/Module.mk, as they will be redundant, and clean up that
file a bit.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

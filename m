From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:06 +0000
Subject: w83627hf module
Message-Id: <Pine.LNX.4.58.0407212051280.182@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <200407201955.33362.cezarym@pf.pl>
In-Reply-To: <200407201955.33362.cezarym@pf.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


From cezarym@pf.pl Wed Jul 21 20:51:22 2004
Date: Tue, 20 Jul 2004 23:29:08 +0200
From: Cezary Morga <cezarym@pf.pl>
To: Rudolf Marek <R.Marek@sh.cvut.cz>
Subject: Re: w83627hf module

Dnia wto 20. lipca 2004 22:37, napisa?e?:
> Hello
>
> > And when I try to $modprobe w83781d module is loaded successfuly but
>
> Really running as root?
>
> I see $ instead of # in prompt.
>
> did you use "su" command to switch to root?


Yes, really as root. You have seen $ because I've run it su'ed from my user
account to copy messages into an e-mail... Normally I've run it as a root and
the messages were the same...

> > $sensors -s
> > outputs :
> > w83697hf-isa-0290: Can't access procfs/sysfs file for writing;
> > Run as root?
> > though I'm a root...
> > What's going on?
>
> Please could you tell us the kenel version. You can use
>
> uname -a
>
> command to get it.

It's 2.6.3-7mdk

-- 
Cezary Morga <cezarym@pf.pl>
GG# 169903 ICQ# 328-700-565
Jabber: thereidos@jabber.aster.pl
	thereidos@jabberpl.org

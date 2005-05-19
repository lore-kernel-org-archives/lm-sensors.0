From: R.Marek@sh.cvut.cz (Rudolf Marek)
Date: Thu, 19 May 2005 06:25:06 +0000
Subject: w83627hf module
Message-Id: <Pine.LNX.4.58.0407202226030.30452@desitka.sh.cvut.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <200407201955.33362.cezarym@pf.pl>
In-Reply-To: <200407201955.33362.cezarym@pf.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hello

> And when I try to $modprobe w83781d module is loaded successfuly but

Really running as root?

I see $ instead of # in prompt.

did you use "su" command to switch to root?


> $sensors -s
> outputs :
> w83697hf-isa-0290: Can't access procfs/sysfs file for writing;
> Run as root?
> though I'm a root...
> What's going on?

Please could you tell us the kenel version. You can use

uname -a

command to get it.


Thank you

regards

Rudolf

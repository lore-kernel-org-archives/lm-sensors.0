From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:33 +0000
Subject: CPU temp does not update
Message-Id: <J8F8musF.1106745392.0006200.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <200501241750.44403.jrclarke@btinternet.com>
In-Reply-To: <200501241750.44403.jrclarke@btinternet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi John,

> Just a quick follow up to my reply (now I am late for work but who cares)

Your boss maybe? ;)

> Despite the error, sensors is now updating as you predicted,

Great :) I was about to ask you.

I will investigate as why the error occurs, but in fact it isn't really
a problem as this is only a temporary solution.

> my last question
> (I hope) is do I need to run the script with every reboot ? If so can you
> tell me where to put it please ?

Yes you have to. Put is right before (or right after) the "modprobe
w83627hf" in /etc/rc.d/rc.local, that should do it.

> Thank you very much for your hard work, it is truly appreciated.

Thanks for your excellent testing! I'm glad we nailed this bug (as I
said I seem to remember you are not the first one to report it), and
will work on definitive patches ASAP.

Thanks again,
--
Jean Delvare

From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:20 +0000
Subject: Turn off alarm?
Message-Id: <GWdeJ53j.1098871751.2106030.khali@gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041027104054.BBF3.TIMEBANDIT@dzn.mine.nu>
In-Reply-To: <20041027104054.BBF3.TIMEBANDIT@dzn.mine.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


>I runned lm_sensors over 2 months before it stoped working :( Can't find
>the problem... All the readings are all wrong and the alarm sound wents
>off constantly. IT87 ithink i'm using.
>Is there any way to turn of the alarm sound for this chip? I find it bad
>to need to reboot all the time just to get the alarm to silence...

The problem you describe reminds me of two previous reports. Cannot get
my hands back on the second one, but the first one's here:

http://secure.netroedge.com/~lm78/readticket.cgi?ticket59
http://archives.andrew.net.au/lm-sensors/msg26610.html

Does it look similar to what you observe?

Unfortunately we never found what was causing the trouble.

For the records, we would need to know what motherboard it is, what exact
chip is on it, and what version of lm_sensors and linux kernel you are
using.

--
Jean Delvare

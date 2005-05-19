From: zdavatz@ywesee.com (Zeno Davatz)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: Gnome hangs after sensors installation
Message-Id: <BB4EF057.6D5C%zdavatz@ywesee.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <BB4EE262.6D4C%zdavatz@ywesee.com>
In-Reply-To: <BB4EE262.6D4C%zdavatz@ywesee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 31.7.2003 16:05, "Jean Delvare" <khali@linux-fr.org> wrote:

> Use "runlevel" to know which runlevel you are in. Then look for a
> lm_sensors script in /etc/rcX.d, where X is the runlevel. It could have
> any name or even not be in a specific script. You could use "grep
> sensors -ir *" there to locate the script.
Runlevel gives me N 2

So I done: 
Grep sensors -ir * /etc/rc2.d/

It tells me that it found something in a binary file called: ld.so.cache...

And then it greps forever...

> 
>> My computer still hangs when starting Gnome, also some other settings
>> seem messed up.
> 
> Which other settings? Details are precious.
Fonts are wrong when starting GNOME, also GNOME complains about some
applets.

Thanks for more Feedback.

Zeno

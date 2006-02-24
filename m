From: list0570@paradise.net.nz (Volker Kuhlmann)
Date: Fri, 24 Feb 2006 22:12:03 +0000
Subject: [lm-sensors] Added hysteresis to fancontrol
Message-Id: <20060224221203.GE6667@paradise.net.nz>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060124032204.GG28986@paradise.net.nz>
In-Reply-To: <20060124032204.GG28986@paradise.net.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Now after a release is good time to go on and apply it. Have you some
> new version?

Everything I have is here:
http://volker.dnsalias.net/linux/tech/lm_sensors/

No change to /usr/sbin/fancontrol since I posted it to this list on 24
Jan, and it works very well for me, but I added more comments just now.
The script is a complete tidyup, the diff is longer than the file.

If you have the idea to pick'n'mix, pay attention to the sleep and
signal handling, or you'll break the usability of the fancontrol script
within system service scripts. The construction I have now is already in
SUSE 10.1 and works, don't unfix it.

I haven't put the hysteresis handling into pwmconfig yet, and because I
don't really need it myself, I'm reluctant to work on it unless I can
feel somewhat assured that it'll make it into the official source.

Someone posted a patch to fancontrol on 14 Feb, the only real difference
to my script I can see is that awk is no longer used. In my opinion I
don't see the point, awk is a low-resource barebones program which can
be relied upon to exist for system services (remove it and your system
will no longer as much as boot). The expression evaluation is also
better and less headachey in gawk than in bash.

The fancontrol also needs to be started by /etc/init.d/lm_sensors, I had
added that and SUSE made some more changes to it. The current state is
at the above URL. Works fine for me.

Thanks + greetings,

Volker

-- 
Volker Kuhlmann			is possibly list0570 with the domain in header
http://volker.dnsalias.net/		Please do not CC list postings to me.


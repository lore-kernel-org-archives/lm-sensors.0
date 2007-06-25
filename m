From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 25 Jun 2007 18:44:24 +0000
Subject: Re: [lm-sensors] Quick Question about latest IBM thinkpads!
Message-Id: <20070625204424.29228ed7@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <524002.68161.qm@web82504.mail.mud.yahoo.com>
In-Reply-To: <524002.68161.qm@web82504.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 23 Jun 2007 11:05:59 -0300, Henrique de Moraes Holschuh wrote:
> On Sat, 23 Jun 2007, Jean Delvare wrote:
> > If you have specific questions on the way, just ask and we'll try to
> > help. I'll be happy to review (and test) your code when you're done.
> 
> I have one.  What is NOSYSCTL and VALUE()? (or where are them documented)?

Old stuff for the Linux 2.4 procfs/sysctl interface. Just put NOSYSCTL
and VALUE(1) everywhere, that will be fine.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

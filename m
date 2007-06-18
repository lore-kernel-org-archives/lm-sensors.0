From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 18 Jun 2007 08:18:41 +0000
Subject: Re: [lm-sensors] Help needed for implementing&testing Fintek F75375
Message-Id: <20070618101841.74b89e05@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <5327.79319.qm@web25109.mail.ukl.yahoo.com>
In-Reply-To: <5327.79319.qm@web25109.mail.ukl.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Christian,

On Sun, 17 Jun 2007 16:14:55 +0200 (CEST), Christian Emmerich wrote:
> I have tried to commit the changes i made for 
> Fintek F75373S support, but it failed. 
> ( bash shows:
> root@pc:/usr/src# svn commit command
> Anmeldebereich: <http://lm-sensors.org:80> lm-sensors/i2c
> Passwort fuer 'root':
> and so on )
> Is a Username/Password required for a svn commit 

Of course. Have you ever seen one open source project where anonymous
CVS/SVN writes are allowed?

> / who can create a login for me?

This isn't how things work, sorry. Please submit your patch to this
mailing list and we'll review it first, then we'll apply it for you
when it's ready.

Only if you become a regular contributor to the lm-sensors project,
we'll take the time to create an account for you.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

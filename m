From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:11 +0000
Subject: sensors -s & adm1027
Message-Id: <20040813200411.04788fa2.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <web-77741@free.net>
In-Reply-To: <web-77741@free.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> >> sensors-detect works normally. But sensors -s says
> >> "adm1027-i2c-1-2d can't read or write". It looks something like
> >> Ticket#1682 (partially).

OK, I think you simply have a bogus line in /etc/sensors.conf. You're
most likely trying to "set" a read-only feature like "vid" or any
measured value. That was the case for ticket #1682 (which I updated).

If you can't find out the faulty line, just post the adm1027 section
here and we'll try to help.

Hint: according to the strace output, I'd say that the first "set" line
of the adm1027 section is the faulty one.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/

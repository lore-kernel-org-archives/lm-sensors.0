From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:36 +0000
Subject: Ticket #: 1533 / Cant use Sensors -s
Message-Id: <20040124165459.726e74d6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1074957554.5412.3.camel@Technetium.pse.local>
In-Reply-To: <1074957554.5412.3.camel@Technetium.pse.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Here is the Output of ls -l /sys/bus/i2c/devices/0-0290
> 
> lrwxrwxrwx    1 root     root           38 2004-01-24 14:42
> /sys/bus/i2c/devices/0-0290 -> ../../../devices/platform/i2c-0/0-0290

Hehe this is of course a link :/ Try "ls -lL" instead, or whatever will
give us the list of files within the directory with permissions. One
possible problem would be that a file supposedly in read+write access
would be read-only.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

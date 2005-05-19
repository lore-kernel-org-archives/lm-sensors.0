From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:34 +0000
Subject: Drivers web pages
Message-Id: <20040111142855.2ccb2e84.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Wouldn't make it sense to add a column "first in Linux 2.X.Y" to our
drivers web pages? Most users now won't really care about versions of
lm_sensors (as far as drivers are concerned; user-space is a completely
different matter), but will be interested in linux versions.

OTOH, I wonder if the "mkpatched" column is worth the place it wastes. I
don't think people really care, and the same information is easily
available from mkpatch/FILES. What's more, the fact that a driver is
mkpatched depends on the version (yeah, I think I remember that I'm the
one who removed this information, I know). All drivers should be
mkpatched anyway. I don't see any reason to exclude drivers from
mkpatch.

So basically I propose to replace the "mkpatched" column with a "first
in Linux 2.X.Y" column.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:26 +0000
Subject: 82801DA support?
Message-Id: <20031122092822.4b155203.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3FBD076A.8050206@metz.supelec.fr>
In-Reply-To: <3FBD076A.8050206@metz.supelec.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


> I was wondering why 82801DA is not supported, unlike many 82801**
> chips... I apologize if this email address was not intended to receive
> such mails. Thanks again for your work on the sensors, it's
> appreciated! Regards,

No particular reason. I suspect it has the same PCI ID as the 82801DB so
using i2c-i801 could work out of the box. If not, please provide the
output of lspci -v and lspci -n, so that we can add the ID and let you
test if it works.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

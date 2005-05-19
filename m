From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: it87: temp_min or temp_hyst?
Message-Id: <20040117224931.7ce44ec4.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Can anyone who has an it87 chip tell me wether the "low" temperature
limits are minimums or hysteresis? According to the data sheet I'd say
min, so I did not correct it in my hyst patch, but libsensors and
sensors.conf say it's hyst. I doubt it since sensors.conf has these
default values:

    label temp1       "M/B Temp"
    set   temp1_over  40
    set   temp1_hyst  20

That doesn't look like a correct temperature for hysteresis. So I
believe it is min and that libsensors and sensors.conf should be fixed.
But I'd like someone who has that chip to confirm first before I do so.

At the moment, Linux 2.6.1 users get errors because of this (much like
Linux 2.6.0 users used to get errors with w83781d, lm75 and via686a
drivers). Tickets 1527 and 1528 point this problem out.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:07 +0000
Subject: w83781d_detect
Message-Id: <20030724150130.419b493f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi all,

In the w83781d_detect function in sensors-detect, the device ID register
is masked with 0xfe (LSB ignored). I read the w83781d, w83782d and
w83783s datasheets and couldn't find any reason for that. What's the
idea?

I ask this because the w83782d has an id of 0x30 and the as99127f has
0x31, so masking the LSB seem to be a source of problems more than
anything else. However, I can't imagine the mask was added with no goal
in mind.

Someone?

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: issue with ticket 1519
Message-Id: <1074178400.4006a960ef6ca@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <200401151525.31758.ehmke@gmx.de>
In-Reply-To: <200401151525.31758.ehmke@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I have the same problem described in ticket 1519.
> I have done a sensors -u and it shows the following when trying to
> read out 
> temperature:
> 
> M/B Temp: 31.00 (temp1)
> ERROR: Can't get feature `temp1_hyst' data!
>   temp1_over: 80.00 (temp1_over)
> CPU Temp: 39.40 (temp2)
> ERROR: Can't get feature `temp2_hyst' data!
>   temp2_over: 100.00 (temp2_over)
> temp3: 255.40 (temp3)
> ERROR: Can't get feature `temp3_hyst' data!
>   temp3_over: 60.00 (temp3_over)

As mentioned on our main page, you need to get lm_sensors from CVS if
you are using Linux 2.6.1. Lm_sensors version 2.8.2 doesn't support
Linux 2.6.1 correctly.

We plan to release lm_sensors 2.8.3 shortly to prevent too many user
from experiencing and reporting this problem.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

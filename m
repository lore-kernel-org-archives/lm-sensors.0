From: ehmke@gmx.de (Martin Ehmke)
Date: Thu, 19 May 2005 06:24:35 +0000
Subject: issue with ticket 1519
Message-Id: <200401151525.31758.ehmke@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I have the same problem described in ticket 1519.
I have done a sensors -u and it shows the following when trying to read out 
temperature:

M/B Temp: 31.00 (temp1)
ERROR: Can't get feature `temp1_hyst' data!
  temp1_over: 80.00 (temp1_over)
CPU Temp: 39.40 (temp2)
ERROR: Can't get feature `temp2_hyst' data!
  temp2_over: 100.00 (temp2_over)
temp3: 255.40 (temp3)
ERROR: Can't get feature `temp3_hyst' data!
  temp3_over: 60.00 (temp3_over)

Perhaps this will help you.

Regards
Martin Ehmke

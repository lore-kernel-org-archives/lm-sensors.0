From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: Data block transactions fail on i2c-i801 controller?
Message-Id: <41B5C8EE.7040107@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <13938324.1095712833883.JavaMail.root@scooter.psp.pas.earthlink.net>
In-Reply-To: <13938324.1095712833883.JavaMail.root@scooter.psp.pas.earthlink.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

wow, a week turned into 2 1/2 months :)
sorry for the delay.

There is no problem in the i801 block code.
The bug is in the lm93 driver. 
There is no check for success in lm93_read_block().
Therefore every block transaction is called 5 times (MAX_RETRIES).
What should have been 9 transactions turned into 45.
Rather obvious from the logs (which are still at the link David posted - thanks David).
I'll fix lm93.

mds

Jean Delvare wrote:
>>I did the i801 block code.
>>I'll take a look at it.
>>Give me about a week.
> 
> 
> Mark, any news?
> 
> Thanks,

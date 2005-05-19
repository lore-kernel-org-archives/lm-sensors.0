From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:51 +0000
Subject: i2c-sis645.c patch (Experimental SiS 655 support)
Message-Id: <407343CE.7060700@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <4063CA9F@webmail.ucc.ie>
In-Reply-To: <4063CA9F@webmail.ucc.ie>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

the i2c-sis96x driver doesn't have a list of PCI ID's so a 'similar patch'
isn't possible. MMH does anything need to change in 2.6 for this new chip?

Jean Delvare wrote:
>>>This patch experimentally enables SiS 655 support by the i2c-sis645
>>>driver.
>>>(...)
>>>The patch is against the lm_sensors-2.8.5 release.
> 
> 
> A similar patch against Linux 2.6.5-mm1 would be appreciated.
> 
> Thanks.
> 

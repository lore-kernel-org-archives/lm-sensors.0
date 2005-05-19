From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:51 +0000
Subject: Bug in lm_sensors-2.8.6 for lm75
Message-Id: <20040409195401.7e6a9480.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3B7A491B88659F4FA3578A728CDC8896015F1455@pr-ex1.corp.myfamilyinc.com>
In-Reply-To: <3B7A491B88659F4FA3578A728CDC8896015F1455@pr-ex1.corp.myfamilyinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> In reference to ticket #1647
> 
> I found that the sensors binary was looking for temp1_hyst, but in the
> source temp_hyst is referenced for LM75.  Here are the changes I made
> to make it work.

For reference: the patch itself was not very useful, but we investigated
(on IRC) and finally found the cause of the problem (bad sysfs name
mappings in library). I just fixed that in CVS.

Robert, thanks a lot for your time and help!

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

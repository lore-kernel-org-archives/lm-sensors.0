From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:51 +0000
Subject: subclient leak in asb100 driver
Message-Id: <20040410110533.49ba7483.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark,

I think that there is a i2c client and memory leak in your asb100 driver
(2.4/CVS). In asb100_detach_client, you neither call i2c_detach_client
on subclients, nor do you kfree their memory.

Could you please take a look?

I think that the same problem exists in the 2.6 version of the driver,
as well as in the w83781d driver there. The 2.4/CVS version of the
w83781d driver, on the other hand, seems OK.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

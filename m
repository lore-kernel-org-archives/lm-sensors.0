From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:40 +0000
Subject: Linux 2.6.2 i2c debug bug
Message-Id: <20040205223149.4e8137d1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Apparently one of the dev_dbg in i2c_master_recv in i2c_core.c in
> 2.6.2 has a little issue in that it's dereferencing the wrong
> element (client->dev instead of client->adapter->dev)
> 
> Fix is below

Thanks for reporting the problem and providing a fix. However, the
problem was already reported on the LKML [1] and a similar fix is
already in Greg's bk tree [2].

[1] http://marc.theaimsgroup.com/?l=linux-kernel&m7573527929342&w=2
[2] http://marc.theaimsgroup.com/?l=linux-kernel&m7585749612115&w=2

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

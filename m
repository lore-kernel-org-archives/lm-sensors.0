From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:09 +0000
Subject: number of the day (adm1025)
Message-Id: <20030804104638.221473a1.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi all,

The number of the day is: -9%. This is how less memory the adm1025
module uses after my cleanups (5056 bytes before, 4608 bytes after,
according to lsmod). Not bad for an overall simple driver, and this
shows IMHO that it's possibly worth doing the same for other modules
too.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

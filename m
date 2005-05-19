From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:03 +0000
Subject: ADM1023 vs. ADM1021A
Message-Id: <20030704104521.242e47b5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Reading the ADM1021A and ADM1023 datasheets, it seems to me that there
is no way to distinguish  between these two chips. Am I right? Both are
treated as ADM1023 (high precision) in our code, what would happen if an
ADM1021A (low precision) was really there? I'd say that if should work
(if ADM1021A has all the ADM1023 high-resolution registers set to zero
and read accesses don't fail) but I'm not really sure.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

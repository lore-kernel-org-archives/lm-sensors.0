From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:04 +0000
Subject: i2c built-in warning
Message-Id: <20030710132706.5565bbc8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


After the repport we had this morning, I wonder if we shouldn't print
some warning at the end of either make or make install if the user
installs i2c with method 1 and has i2c already built-in his/her kernel.
Letting i2c install quitely although we know lm_sensors will fail
installing doesn't sound very clever.

Another possibility would be to *prevent* the user from installing i2c
if he/she has i2c built-in. Why isn't it that way already? Are there
cases where we want the user to be able to install i2c in these
conditions?

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

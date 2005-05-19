From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:23:59 +0000
Subject: i2c/kernel i2c-proc.c
Message-Id: <20030610112617.1eb23f0e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <3EE246E6.1020806@penguincomputing.com>
In-Reply-To: <3EE246E6.1020806@penguincomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Log Message:
> (mds) fix problem with multiple chips from same driver
>       found by Khali. This was caused by not mallocing space for
>       and copying the ctl_template.
>       This also fixes incomplete removal of the sysctl table
>       when i2c-proc is rmmodded.

Tested, it's working OK now.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

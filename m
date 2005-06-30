From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 30 Jun 2005 23:09:15 +0000
Subject: [lm-sensors] [Patch 4/5] w1: sysfs, select-slave, ds2433
Message-Id: <20050630230846.603d8439.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <200506300918.17966.bgardner@wabtec.com>
In-Reply-To: <200506300918.17966.bgardner@wabtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Ben,

> w1-slave-sysfs.diff
> Every slave now has at least two sysfs files:
>  - id : an 8 byte binary file that holds the 64 bit id
>    example: [23 6c dc 1c 00 00 00 43]

I see no reason why this should be a binary file. Please make it a text
file. Binary files in sysfs are supposed to be an exception, not the
rule.

Thanks,
-- 
Jean Delvare

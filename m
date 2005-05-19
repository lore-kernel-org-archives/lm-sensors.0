From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:59 +0000
Subject: [lm-sensors] [PATCH 2.6] I2C: driver adm1021: remove die_code
Message-Id: <0hik81ls65b88v6pl5v4j1bi43abentu9q@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050517205623.03cfee12.khali@linux-fr.org>
In-Reply-To: <20050517205623.03cfee12.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Khali,
On Tue, 17 May 2005 20:56:23 +0200, Jean Delvare <khali@linux-fr.org> wrote:
>> This patch removes die_code from adm1021 as nothing within the 
>> driver uses it.  Compile tested, this time with the patch, sorry.
>
>Except for the misleading subject line, I'm fine with that patch.

Example of better subject line please?

--Grant.


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

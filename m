From: grant_lkml@dodo.com.au (Grant Coady)
Date: Sat, 28 May 2005 00:25:48 +0000
Subject: [lm-sensors] RFC PATCH I2C: w83781d: remove redundant w83697hf,
Message-Id: <t97f915d9bkld14kcg2qvq6tjilq4qhfga@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <eq4d91hhldf7u9jjp8s03hc7qrv0e9jo1k@4ax.com>
In-Reply-To: <eq4d91hhldf7u9jjp8s03hc7qrv0e9jo1k@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 27 May 2005 22:47:15 +0200, Jean Delvare <khali@linux-fr.org> wrote:

>Hi Grant,
>
>> This patch replaces previous one posted this day, removing redundant 
>> drivers w83697hf, w83627hf, w83627thf from w83781d as they are
>> handled by the w83627hf driver.  Compile tested.
>
>Please do not remove the w83627hf support for now. The W83627HF chip has
>an I2C/SMBus interface, which the w83627hf driver doesn't support (and
>we don't want to add I2C/SMBus support to the w83627hf driver).

Okay, that would be true for lm_sensors2 as well?  Will do, gets easier 
each time I go in :)  Perhaps I'll wait for okay on this before going to 
lm_sensors2 again?

--Grant.


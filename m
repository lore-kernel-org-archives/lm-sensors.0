From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:51 +0000
Subject: sensors-detect in lm_sensors-2.9.1 has one bug in detecting
Message-Id: <20050414194647.3e754a4d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF9D611BFCDB1E42B37FAA148096BECE37013F@weshml03.winbond.com.tw>
In-Reply-To: <FF9D611BFCDB1E42B37FAA148096BECE37013F@weshml03.winbond.com.tw>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Chunhao,

> The 792 part in lm_sensors-2.9.1 need update. Some of the detect
> result is:
> 
> Probing for `Winbond W83792D'... Success!
>     (confidence 7, driver `to-be-written'), other addresses: 0x4b 0x4f
> 
> Driver `to-be-written' (should be inserted):
>   Detects correctly:
>   * Bus `SMBus ALi 1563 Adapter @ 5000' (Non-i2c SMBus adapter)
>     Busdriver `i2c-ali1563', I2C address 0x2f (and 0x4b 0x4f)
>     Chip `Winbond W83792D' (confidence: 7)
> 
> Since 792 driver has been finished, so the message need modification.

You're right. I just commited a fix. Thanks for reporting, and sorry
about this error...

-- 
Jean Delvare

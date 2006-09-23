From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 23 Sep 2006 08:15:26 +0000
Subject: [lm-sensors] [patch] hwmon: w83781d - check return code of
Message-Id: <20060923101526.134f0da8.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <44F70D89.30409@gmail.com>
In-Reply-To: <44F70D89.30409@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Add 2 attr-file groups (for base and model-specific attrs respectively),
> create the base group with single call to sysfs_create_group, and
> check the return code on individual calls to device_create_file for each
> of the model-specific attr-files.
> 
> Signed-off-by:  Jim Cromie <jim.cromie at gmail.com>

Applied with some additions (you forgot to delete some macros and to
replace some occurrences of &client->dev by dev).

Thanks,
-- 
Jean Delvare


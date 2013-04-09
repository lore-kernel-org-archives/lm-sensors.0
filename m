From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 09 Apr 2013 12:12:45 +0000
Subject: Re: [lm-sensors] [PATCH v2] sensors-detect: Update Nuvoton chip information
Message-Id: <20130409141245.695f77d3@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1365409539-17414-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1365409539-17414-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon,  8 Apr 2013 01:25:39 -0700, Guenter Roeck wrote:
> NCT5577D datasheet says that the chip ID can be 0xC333, same as NCT6776F.
> So we can not use the chip revision to detect the actual chip.
> Merge entries for NCT5577D and NCT6776F into one.
> 
> List NCT5572D as another variant of W83677HG-I (NCT6775).
> 
> NCT6106D chip ID as observed on a real system is 0xC452, not 0x1061 as
> claimed by the data sheet. Confirmed with Nuvoton that the correct
> chip ID is 0xC452. Also list its variants NCT6102D and NCT6104D.
> 
> List NCT5532D as variant of NCT6779D. Data sheets list possible chip
> IDs of 0xC561 and 0xC562, so detect and accept all chip revisions.
> 
> Point to new nct6775 driver for NCT6775, NCT6776, and NCT6779.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2: Chip ID for NCT6106D is 0xC452. 0x1061 was wrong.

Looks good, please commit.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 26 Feb 2011 14:06:46 +0000
Subject: Re: [lm-sensors] [PATCH v4 0/4] hwmon: Add support for EMC6D103S
Message-Id: <20110226150646.6a3c97a7@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1298660246-6484-1-git-send-email-guenter.roeck@ericsson.com>
In-Reply-To: <1298660246-6484-1-git-send-email-guenter.roeck@ericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 25 Feb 2011 10:57:22 -0800, Guenter Roeck wrote:
> This patchset adds support for EMC6D103S, plus some additional cleanups.
> 
> v4:
> - Replaced vid5 configuration macro with boolean
> - Swapped parameters of lm85_remove_files()
> - Removed now unnecessary variable off_desired

Looks alright this time. For the whole patch set:

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 12 Sep 2012 08:24:41 +0000
Subject: Re: [lm-sensors] [PATCH 3/5] hwmon: (ina2xx) Fix word size register read and write operations
Message-Id: <20120912102441.66e7999c@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1347381259-14585-4-git-send-email-linux@roeck-us.net>
In-Reply-To: <1347381259-14585-4-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 11 Sep 2012 09:34:17 -0700, Guenter Roeck wrote:
> The driver uses be16_to_cpu and cpu_to_be16 to convert data in SMBus word
> operations from chip to host byte order. However, the data passed from and to
> the SMBus word API functions is in host byte order, not in chip byte order.
> Conversion should therefore use swab16 instead of be16 to change the byte order.
> 
> Replace driver internal word conversion functions with SMBus API functions to
> solve the problem.
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> Candidate for 3.6 and -stable.

Agreed, down to 3.2 (when i2c_smbus_read/write_word_swapped were
introduced.) If anyone needs the fix for a kernel older than this, it
will have to be implemented differently.

Acked-by: Jean Delvare <khali@linux-fr.org>

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

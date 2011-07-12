From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 12 Jul 2011 07:36:06 +0000
Subject: Re: [lm-sensors] [PATCH v3] MAX1111: Fix Race condition causing
Message-Id: <20110712093606.5db834cb@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <1310421038-14823-1-git-send-email-morpheus.ibis@gmail.com>
In-Reply-To: <1310421038-14823-1-git-send-email-morpheus.ibis@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-arm-kernel@lists.infradead.org

On Mon, 11 Jul 2011 23:50:38 +0200, Pavel Herrmann wrote:
> spi_sync call uses its spi_message parameter to keep completion information,
> using a drvdata structure is not thread-safe, potentially causing one thread
> having pointers to memory on or above other threads stack. use mutex to
> prevent multiple access

Honestly, I have no idea what "causing one thread having pointers to
memory on or above other threads stack" means (nor why this would be
bad.)

Patch applied nevertheless, as it fixes an actual bug which should be
fixed ASAP. Thanks for your contribution.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

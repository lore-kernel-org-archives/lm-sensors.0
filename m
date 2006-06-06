From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 06 Jun 2006 17:50:02 +0000
Subject: [lm-sensors] [PATCH] I2C: *write_block* doesn't modify the data
Message-Id: <20060606195002.a22b4006.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <m364jez6re.fsf@defiant.localdomain>
In-Reply-To: <m364jez6re.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hi Krzysztof,

> The attached patch marks i2c_smbus_write_block_data() and
> i2c_smbus_write_i2c_block_data() buffers as const.
> 
> Signed-off-by: Krzysztof Halasa <khc at pm.waw.pl>

That's right. Applied, thanks.

-- 
Jean Delvare


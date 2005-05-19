From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:58 +0000
Subject: [PATCH 2.6] I2C: adm9240 driver cleanup, take 1
Message-Id: <bnfuf9yg.1115978065.6871070.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <ccs881d9udtiesr60rl07knb7j12dk9f96@4ax.com>
In-Reply-To: <ccs881d9udtiesr60rl07knb7j12dk9f96@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Grant,

> This patch adds a no-op write accessor to fan_div to silence an
> ambiguous 'unable to write' warning from 'sensors -s' when a set
> fan_div is specified, the write data is ignored as this driver
> implements auto fan_div.  This seems to be best option in light
> of planned move to auto fan_div in other drivers.

No. The 2.6 drivers are to be kept clean of such tricks. The solution is
to comment out the set div lines in the default sensors.conf file, and
properly comment in that file that these lines should not be used with
the 2.6 version of the driver.

> Secondly it adds an info print of detected VRM stolen from Sebastian
> Witt's atxp1 sriver.  ADM9240 already has vrm accessor removed.

Could idea, it might help debugging that part of the code.

> Thirdly, a whitespace cleanup in macro area and minor comment
> corrections.  The messy bit :)

Comment corrections are fine, but the "whitespace cleanup" is not. The
macros used one accepted whitespace scheme, and there is no need to
change them to the other accepted one. This doesn't add anything to the
driver and makes your patch harder to read. Furthermore, all this macro
stuff is planned for rewrite anyway (when Yani Ioannou's sysfs
attribute extension is be included into the kernel).

Thanks,
--
Jean Delvare

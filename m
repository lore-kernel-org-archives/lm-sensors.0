From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 21 Oct 2008 12:50:37 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: Add LTC4245 driver
Message-Id: <20081021145037.39f19b1c@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20081020160308.GA22915@ovro.caltech.edu>
In-Reply-To: <20081020160308.GA22915@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Oh, BTW... Your driver doesn't build:

drivers/hwmon/ltc4245.c: In function ‘ltc4245_get_current’:
drivers/hwmon/ltc4245.c:168: warning: function declaration isn’t a prototype
drivers/hwmon/ltc4245.c:168: error: conflicting types for ‘get_current’
include/asm/current.h:24: error: previous definition of ‘get_current’ was here

Apparently get_current is a global symbol already so you will need to
come up with a different name. Prefixing your function names with the
driver name is usually a good way to protect against this.

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

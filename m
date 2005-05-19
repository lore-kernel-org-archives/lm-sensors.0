From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: W83637HF support in lm_sensors
Message-Id: <20040214155413.4e06aa1f.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040213201852.79ee2bcf.khali@linux-fr.org>
In-Reply-To: <20040213201852.79ee2bcf.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > Please check it out and tell me how it is working for you.
> I've downloaded lm_sensors-2.8.4. I can't compile it:

Please note that the W83637HF support is in CVS, not 2.8.4. Instructions
for getting the CVS version of lm_sensors are here:
http://secure.netroedge.com/~lm78/download.html#cvs

> kernel/chips/w83l785ts.c:89: `I2C_DRIVERID_W83L785TS' undeclared here 
> (not in a function)
> kernel/chips/w83l785ts.c:89: initializer element is not constant
> kernel/chips/w83l785ts.c:89: (near initialization for
> `w83l785ts_driver.id') make: *** [kernel/chips/w83l785ts.o] Error 1
> 
> The same is for I2C_DRIVERID_ADM1026

Because you'd need i2c-2.8.4 too. If you already have a recent (>2.8.0) i2c, you can either ignore the errors (make -k), or edit i2c-id.h
(wherever it is on your system) and add the following lines (around line
170):
#define I2C_DRIVERID_W83L785TS 1047
#define I2C_DRIVERID_ADM1026 1048

Hope that helps.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

From: andrei@mart.ck.ua (Andrei N.Sobchuck)
Date: Thu, 19 May 2005 06:24:41 +0000
Subject: W83637HF support in lm_sensors
Message-Id: <402E316D.2040104@mart.ck.ua>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040213201852.79ee2bcf.khali@linux-fr.org>
In-Reply-To: <20040213201852.79ee2bcf.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:

> Hi guys,
> 
> I just commited changes to the lm_sensors CVS repository so that the
> w83627hf driver and sensors program handle the W83637HF chipset you had
> been requesting a driver for some times ago.
> 
> Please check it out and tell me how it is working for you.
I've downloaded lm_sensors-2.8.4. I can't compile it:

kernel/chips/w83l785ts.c:89: `I2C_DRIVERID_W83L785TS' undeclared here 
(not in a function)
kernel/chips/w83l785ts.c:89: initializer element is not constant
kernel/chips/w83l785ts.c:89: (near initialization for `w83l785ts_driver.id')
make: *** [kernel/chips/w83l785ts.o] Error 1

The same is for I2C_DRIVERID_ADM1026

-- 
Andrei N.Sobchuck
JabberID: andreis@jabber.ru. ICQ UIN: 46466235.

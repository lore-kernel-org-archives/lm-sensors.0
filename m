From: Guenter Roeck <linux@roeck-us.net>
Date: Fri, 27 Sep 2013 16:20:16 +0000
Subject: Re: [lm-sensors] Two Temp 1 Values
Message-Id: <20130927162016.GB10392@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20130924170243.708363fa@mail.btinternet.com>
In-Reply-To: <20130924170243.708363fa@mail.btinternet.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Sep 24, 2013 at 05:02:43PM +0100, Alan wrote:
> Hi lm-sensors,
> 
> I have a peculiar situation where lm-sensors produces two different
> values of "temp 1". The output from "sensors" at the command line shows

If the system has 10 different temperature sensor chips, you'll see ten times
"temp1".

Just to give you an example, this is the output from a line card
on a high end switch with a large number of temperature sensors:

root@fpc2:~# sensors | grep temp
temp1:        +34.5 C  (low  = +75.0 C, high = +80.0 C)  ALARM (LOW)
temp1:        +38.0 C  (low  = +75.0 C, high = +80.0 C)  ALARM (LOW)
temp1:        +24.5 C  (low  = +75.0 C, high = +80.0 C)  ALARM (LOW)
temp1:        +25.5 C  (low  = +75.0 C, high = +80.0 C)  ALARM (LOW)
temp1:        +34.5 C  (low  = +75.0 C, high = +80.0 C)  ALARM (LOW)
temp1:        +34.5 C  (low  = +75.0 C, high = +80.0 C)  ALARM (LOW)
temp1:        +28.8 C  (low  =  +0.0 C)                  ALARM (HIGH, CRIT)
temp1:        +37.0 C  (high = +90.0 C)
temp2:        +41.5 C  (high = +110.0 C, crit = +110.0 C)
temp3:        +40.0 C  (high = +127.0 C)
temp4:        +45.0 C  (high = +100.0 C)
temp5:        +46.0 C  (high = +100.0 C, crit = +127.0 C)
temp6:          FAULT  (high = +100.0 C, crit = +90.0 C)
temp7:          FAULT  (high = +100.0 C, crit = +90.0 C)
temp1:        +39.0 C  (high = +90.0 C)
temp2:        +38.8 C  (high = +110.0 C, crit = +110.0 C)
temp3:        +37.0 C  (high = +127.0 C)
temp4:        +43.0 C  (high = +100.0 C)
temp5:        +40.0 C  (high = +100.0 C, crit = +127.0 C)
temp6:          FAULT  (high = +100.0 C, crit = +90.0 C)
temp7:          FAULT  (high = +100.0 C, crit = +90.0 C)
temp1:        +25.4 C  (low  = -10.0 C, high = +105.0 C)
temp1:        +39.8 C  (low  = -10.0 C, high = +75.0 C)
temp1:        +42.2 C  (low  = -10.0 C, high = +75.0 C)
temp1:        +43.1 C  (low  = -10.0 C, high = +75.0 C)
temp1:        +35.2 C  (low  = -10.0 C, high = +75.0 C)
temp1:        +29.5 C  (low  = -10.0 C, high = +75.0 C)
temp1:        +29.4 C  (low  = -10.0 C, high = +75.0 C)
temp1:        +30.4 C  (low  =  +0.0 C, high = +75.0 C)
temp1:        +28.8 C  (low  =  +0.0 C, high = +75.0 C)
temp1:        +27.7 C  (low  = -30.0 C, high = +110.0 C)
temp1:        +29.8 C  (low  = -30.0 C, high = +110.0 C)
temp1:        +33.8 C  (low  = -30.0 C, high = +110.0 C)
temp1:        +37.2 C  (low  = -30.0 C, high = +110.0 C)
temp1:        +28.9 C  (low  = -30.0 C, high = +110.0 C)
temp1:        +29.5 C  (low  = -30.0 C, high = +110.0 C)
temp1:        +32.3 C  (low  = -30.0 C, high = +110.0 C)
temp1:        +39.8 C  (low  = -30.0 C, high = +110.0 C)

Nothing wrong with that (except that limits are not initialized correctly
in some cases, and unused sensor inputs are not disabled). Your application
needs to be able to distinguish between sensor chips, not just between
sensor attribute names.

Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

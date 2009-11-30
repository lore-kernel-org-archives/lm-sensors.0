From: Jean Delvare <khali@linux-fr.org>
Date: Mon, 30 Nov 2009 21:41:27 +0000
Subject: Re: [lm-sensors] LPC47M192-NC Fans
Message-Id: <20091130224127.7276add9@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <alpine.OSX.2.00.0911301621550.346@blackbird.local>
In-Reply-To: <alpine.OSX.2.00.0911301621550.346@blackbird.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Sean,

On Mon, 30 Nov 2009 16:30:42 -0500 (EST), Sean Fidler wrote:
> I recently installed Ubuntu Server 9.10 on a Compaq Presario 
> S4000NX. Sensor info: chip is LPC47M192-NC and the bus is 
> bus "i2c-2" "SMBus I801 adapter at 1880"
> 
> When running "sensors" no information is shown for the CPU fan (there 
> are no entries for fans at all.) Only entries for voltages and 
> temperatures are available.
> 
> pwmconfig states that there are no modules installed. Am I out of luck 
> with trying to control the CPU fan speed? Thanks!

Full output of sensors-detect please. The SMSC LPC47M192 is supported
by two drivers: smsc47m1 for the fans and smsc47m192 for the voltages
and temperatures. Make sure both are loaded. If it still doesn't work,
please also provide the contents of /proc/ioports and check for error
messages in your kernel logs when loading the smsc47m1 driver.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

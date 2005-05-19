From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:23 +0000
Subject: Please list which file to etc/rc* file modiify
Message-Id: <20041122223412.6559cf7b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1100659621.2956.12.camel@Oneniisama>
In-Reply-To: <1100659621.2956.12.camel@Oneniisama>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> can you walk  me through how to change those values?  are we still
> messing with the conf file?

No, I think that the config file is innocent, which is why I want you to
try to change the driver values directly. Please try the following
sequence and report results:

cat /sys/bus/i2c/devices/1-002d/fan_div1
echo 4 > /sys/bus/i2c/devices/1-002d/fan_div1
(wait 3 seconds)
cat /sys/bus/i2c/devices/1-002d/fan_div1

(and try with other writable files in the
/sys/bus/i2c/devices/1-002d/directory if you want, too)

Thanks,

-- 
Jean Delvare
http://khali.linux-fr.org/

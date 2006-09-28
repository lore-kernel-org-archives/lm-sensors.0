From: michaelnel@comcast.net (Michael Nelson)
Date: Thu, 28 Sep 2006 01:06:43 +0000
Subject: [lm-sensors] coretemp - digital temperature driver for Intel
Message-Id: <20060928010643.GA6118@seahunt.dyndns.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4519A5C1.8010207@assembler.cz>
In-Reply-To: <4519A5C1.8010207@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Sep 28, 2006 at 12:11:30AM +0200, Rudolf Marek wrote:

> I think I found that, please use attached version.

OK, here's the latest:

seahunt:/var/log # cat /sys/class/hwmon/hwmon0/device/temp1_input
31000
seahunt:/var/log # cat /sys/class/hwmon/hwmon1/device/temp1_input
58000
seahunt:/var/log # cat /sys/class/hwmon/hwmon2/device/temp1_input
58000
seahunt:/var/log # sensors | grep Temp
MB Temp:     +31??C  (high =   +35??C, hyst =   +40??C)
CPU Temp:  +55.5??C  (high = +70.0??C, hyst = +40.0??C)

Assuming 58000 means 58 degrees C and 31000 means 31 degrees C, it looks OK?

Thanks
Michael

-- 

San Francisco, CA


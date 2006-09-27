From: michaelnel@comcast.net (Michael Nelson)
Date: Wed, 27 Sep 2006 14:17:49 +0000
Subject: [lm-sensors] coretemp - digital temperature driver for Intel
Message-Id: <20060927141749.GA6133@seahunt.dyndns.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <4519A5C1.8010207@assembler.cz>
In-Reply-To: <4519A5C1.8010207@assembler.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Sep 27, 2006 at 03:49:25PM +0200, Rudolf Marek wrote:

> I think something has been left out in kernel. Did you rmmoded the 
> driver before inserting the new one?
> If you rmmoded, there is some problem. Please reboot and try to load the 
> driver again.

OK I did, and it loaded.  

seahunt:/var/log # cat /sys/class/hwmon/hwmon0/device/temp1_input
29000
seahunt:/var/log # cat /sys/class/hwmon/hwmon1/device/temp1_input
0
seahunt:/var/log # cat /sys/class/hwmon/hwmon2/device/temp1_input
0

So does that 29000 mean it's working?  The hwmon chip says 53.0C right now.

Michael

-- 

San Francisco, CA


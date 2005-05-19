From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: Ticket 1671
Message-Id: <20040508195722.6e98aaf6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <BAY18-F35Ejb0zNqBRH0000e079@hotmail.com>
In-Reply-To: <BAY18-F35Ejb0zNqBRH0000e079@hotmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> 1. I load i2c-dev in modules.conf yes.
> 2. The sensors -v reveals 2.8.5 and sensors is located in
> /usr/local/bin. I simply wrote wrong.
> 3. /sys/bus/i2c/devices contains these directories 1-002d,  1-002e, 
> 1-0048 and  1-0049.

Hmm, OK.

Please provide the full listing of files under 1-002d and 1-002e (exact
names matter) as well as full log of "strace sensors" and kernel
logs/dmesg of the moment you inserted both drivers (asb100 and
w83l785ts).

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/

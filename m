From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:27 +0000
Subject: Questions
Message-Id: <41CC5D7C.8010603@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021028183912.5520a527.khali@linux-fr.org>
In-Reply-To: <20021028183912.5520a527.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

did you rerun depmod after installing lm85?

Paul Aviles wrote:
> I am getting something weird.
> [root@www /]# modprobe lm85
> modprobe: Can't locate module lm85
> 
> [root@www /]# insmod lm85
> Using /lib/modules/2.4.22-1.2174.nptl/kernel/drivers/i2c/chips/lm85.o
> 
> Why will modprobe fail loading but insmod work?
> 
> Thanks
> 
> 
> 

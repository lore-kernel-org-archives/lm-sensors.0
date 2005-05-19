From: paul.aviles@palei.com (Paul Aviles)
Date: Thu, 19 May 2005 06:25:27 +0000
Subject: Questions
Message-Id: <000201c4e9dc$97c4f1c0$3224050a@avilespaxp>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021028183912.5520a527.khali@linux-fr.org>
In-Reply-To: <20021028183912.5520a527.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I am getting something weird. 

[root@www /]# modprobe lm85
modprobe: Can't locate module lm85

[root@www /]# insmod lm85
Using /lib/modules/2.4.22-1.2174.nptl/kernel/drivers/i2c/chips/lm85.o

Why will modprobe fail loading but insmod work?

Thanks



-- 
This message has been scanned for viruses and
dangerous content by MailScanner, and is
believed to be clean.

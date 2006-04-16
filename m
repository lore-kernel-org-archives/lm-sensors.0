From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 16 Apr 2006 16:22:43 +0000
Subject: [lm-sensors] ridicolous sensors output?
Message-Id: <20060416182243.05507642.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <F2CFFC9F-4DC4-4DBA-BDEB-C195DBCAD479@karlsbakk.net>
In-Reply-To: <F2CFFC9F-4DC4-4DBA-BDEB-C195DBCAD479@karlsbakk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Roy,

> running 'sensors' on this new 1U asus server, gives me quite  
> interesting data. this is on a server that's been running three weeks  
> or so without problems. attached is lspci -vvv output and  
> sensors.conf (standard from debian sarge).

Please:
* Don't compress files you send on the list. You shouldn't expect
people to take the time to save and gunzip the file to look at the
data. People are always busy.
* Don't send sensors.conf in its entirety when only a small part of it
is relevant for your configuration.

> can someone please help me figure out what's happening here?

My first guess is that this W83627THF chip is not used for hardware
monitoring on your board. You probably have another chip for that.

Please provide the following information:
* Kernel version.
* Version of lm_sensors.
* Server model.
* Full output of sensors-detect.

-- 
Jean Delvare


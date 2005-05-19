From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:29 +0000
Subject: Sensor results of P4P800
Message-Id: <20031208223306.4b31093b.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20031207071324.11967.qmail@web1204.mail.yahoo.co.jp>
In-Reply-To: <20031207071324.11967.qmail@web1204.mail.yahoo.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I inform you of current staus.
> If you have any idea of improvement, could you give me?

I created a separate "w83627thf-*" section in our sensors.conf.eg file,
partly based on the data sheet, partly on your report. Should work OK
(you'll have some line to uncomment though). Please try if you can:
http://www2.lm-sensors.nu/~lm78/cvs/lm_sensors2/etc/sensors.conf.eg

Feel free to report problems.

Again, "aligato" for your report and testings :)

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

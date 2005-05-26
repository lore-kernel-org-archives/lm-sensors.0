From: dpervushin@ru.mvista.com (dmitry pervushin)
Date: Thu, 26 May 2005 10:49:28 +0000
Subject: [lm-sensors] [RFC] SPI core ?
Message-Id: <1117097307.6365.5.camel@diimka.dev.rtsoft.ru>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello guys, 

In our internal linux tree, we have the SPI core support, which has been
derived from I2C framework. The SPI support is very valuable for our
customer; they want to attach various devices to SPI bus and want to
have SPI support in linux kernel.

What community thinks about adding the SPI core to kernel to be
maintained as part as I2C framework ? 

-- 
cheers, dmitry pervushin


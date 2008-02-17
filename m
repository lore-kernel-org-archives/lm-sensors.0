From: Sean MacLennan <seanm@seanm.ca>
Date: Sun, 17 Feb 2008 20:33:14 +0000
Subject: [lm-sensors] [PATCH] Add driver for AD7414 i2c temperature sensor
Message-Id: <47B89A0A.60800@seanm.ca>
List-Id: <lm-sensors.vger.kernel.org>
References: <A42C17A8FF150C4DB98BFD6497D1D00007F45D79@ussvlexmbpf1.spansion.com>
In-Reply-To: <A42C17A8FF150C4DB98BFD6497D1D00007F45D79@ussvlexmbpf1.spansion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I tried this driver and it didn't detect my ad7414 chip...  the probe 
function is never called

I am using the i2c-ibm_iic.c driver for the i2c bus and running 2.6.25-rc2.

It works using a different version of the driver and the attach and 
detach methods. Could the ibm iic driver be missing something?

Cheers,
  Sean

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

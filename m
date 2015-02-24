From: Servesh Muralidharan <servesh@ichec.ie>
Date: Tue, 24 Feb 2015 17:54:15 +0000
Subject: [lm-sensors] Asrock Q87 / Nuvoton NCT6681D support
Message-Id: <54ECBAC7.6060206@ichec.ie>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I recently got an Asrock Q87M motherboard for a home server. On running 
lm-sensors for hardware monitoring I found that it detected nuvoton 
nct6681D as the chip but the driver was not present. Searching through 
the mailing list showed that the device can be identified and the 
support for this chip could be added to nct6683 driver. Has there been 
any progress on this? I should be able to test / help with development 
for the driver.

Thanks!

-- 
Servesh

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

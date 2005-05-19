From: m.wientapper@gmx.de (Matthias Wientapper)
Date: Thu, 19 May 2005 06:23:31 +0000
Subject: nvidia nforce chipset
Message-Id: <3CC2C004.2020202@gmx.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

I am using a MSI K7N420 Pro Mainboard with nVIDIA nFORCE chipset.

With version 2.6.3 I am able to read out the sensor chip on this 
mainboard. (Sensors-detect did a great job and told me, that w83781d 
fitted perfectly.)

This is, what I am using (kernel 2.4.18):

i2c-isa                 1252   0  (unused)
w83781d                18784   0  (unused)
i2c-proc                6368   0  [w83781d]
i2c-core               12992   0  [i2c-isa w83781d i2c-proc]


So - with respect to your "requested bus drivers" page - I was wondering 
why there should be another driver beeing planned if everything just 
works fine?

Cheers,

Matthias

--
                          Matthias Wientapper
                          m.wientapper@gmx.de
                        http://mattzz.dyndns.org
                  I'll get you yet, you kwazy wabbit!

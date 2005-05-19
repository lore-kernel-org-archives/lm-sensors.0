From: haake@logicalimages.com (Bill Haake)
Date: Thu, 19 May 2005 06:23:31 +0000
Subject: Occasional wild  readings?
Message-Id: <NDBBJAJICLHDICAJJECFKEJDCIAA.haake@logicalimages.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi-

I have a machine running Redhat 7.2 distribution of kernel 2.4.9-31 with
lm_sensors 2.4.6. The motherboard is an Elite Group K7AMA with ALI 1645
chipset. I am using the i2c-ali1535 and gl520sm modules. Things seem to be
mostly working and I have set up some software to read and plot the data
every 30 minutes. You see the latest data by looking at http://www.oatka.com

Occasionally, I get a strange reading that is wildly different from what I
expect. For example:

normal fan reading is about 5450 and varies +/- 100 but about once a week I
get a reading of 1300
normal CPU reading is about 55 and varies +/- 4 but about once a week I get
a reading of -125 or +125

Is it normal to get a wild reading once in a while? If not, any idea what
the problem is?

Bill


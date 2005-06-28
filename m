From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Tue, 28 Jun 2005 05:25:52 +0000
Subject: [lm-sensors] PC87431C
Message-Id: <253818670506272025a803f5a@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <42C0C02A.1010909@mds.gotdns.com>
In-Reply-To: <42C0C02A.1010909@mds.gotdns.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Mark :),

I'm rewriting a lot of bmcsensors for 2.6 into ipmi-sensors (without
i2c-ipmi), using the new hwmon and  daynamic sysfs callback APIs. I
have a new IPMI 1.5 BMC in the form of the Tyan M3289 daughtercard and
am hoping it has write support so I can finally get that tested out.

When I get something workable maybe you can help me test it out (if
the company is also interested in kernel 2.6). Unfortunately I have
some obstacles in my path at the moment  (the kernel IPMI
implementation not having any sysfs device attributes to use for
hwmon).

Yani

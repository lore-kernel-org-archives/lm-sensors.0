From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: [RFC PATCH 2.6.12-rc3] dynamic driver sysfs callbacks and RFC on
Message-Id: <25381867050504231738f500f0@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2538186705042422366584aff4@mail.gmail.com>
In-Reply-To: <2538186705042422366584aff4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Wait, are you only changing the device attribute?  What about the
> general sysfs attributes?  That is where this should be changed.
> 
> thanks,
> 
> greg k-h
> 

Yes my patch changes the device attributes simply because that's all I
ever worked with, but I can see this benefiting all sysfs attributes,
I'll make the change and change __ATTR.

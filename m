From: yani.ioannou@gmail.com (Yani Ioannou)
Date: Thu, 19 May 2005 06:25:55 +0000
Subject: [RFC PATCH 2.6.12-rc3] dynamic driver sysfs callbacks and RFC on
Message-Id: <253818670504281025388236dc@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2538186705042422366584aff4@mail.gmail.com>
In-Reply-To: <2538186705042422366584aff4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> My question is, please show me how you propagate this out to the driver
> core code, so that the drivers that use the DEVICE_ATTRIBUTE() stuff can
> take advantage of this.
> 
> thanks,
> 
> greg k-h
> 

Well bmcsensors (before this patch) was creating device attributes
like the other chip drivers, just not explicitly using the
DEVICE_ATTRIBUTE macro, however I can easily modify one of the other
sensor chip drivers to show you how they might take advantage of this
if that what you are looking for? I'll probably have to do it tonight
after I get home though :-).

I was thinking of modifying the DEVICE_ATTRIBUTE macro to set the void
* pointer too, but decided against it for the moment...

Yani

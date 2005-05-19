From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:46 +0000
Subject: Fwd: [PATCH] (1/3) i2c-isa, via686a and w8378x series sensors
Message-Id: <3E2CB1F1.6070902@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200301170057.05298.kl@gjs.cc>
In-Reply-To: <200301170057.05298.kl@gjs.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I'll review the via686a and w83781d patches and merge what's appropriate into CVS.
I expect the via686a changes are useful and that the w83781d changes
we've pretty much already done.

Ky?sti M?lkki wrote:
> On Fri, 17 Jan 2003, GertJan Spoelman wrote:
> 
> 
>>I have ported the i2c-isa driver and the via686a and w83781d driver
>>and sent them to Linus for inclusion in the 2.5 kernel, don't know if
>>he will accept them. I probably should have mailed you before about
>>this, I hope you don't mind.
> 
> 
> Well, I have just put 300kB worth of 2.4/2.5 patches in the lm_sensors
> CVS. It will take some time until we get the busses PCI code converted,
> though, and then we can again offer 2.5 patches.
> 

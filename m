From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:23 +0000
Subject: New max6626.c driver for linux 2.6
Message-Id: <419E90BE.2010003@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <NHBBLBCCGMJFJIKAMKLHMEHECCAA.ralf.roesch@rw-gmbh.de>
In-Reply-To: <NHBBLBCCGMJFJIKAMKLHMEHECCAA.ralf.roesch@rw-gmbh.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

agreed. another LM75 clone.
I'll update our docs to claim support.
These may even be repackaged or slightly DS75/DS1775 chips (remember Maxim bought Dallas)

Jean Delvare wrote:
> Hi Ralf,
> 
> 
>>i would like to provide a new chip driver for the max6626 temp. sensor.
>>Could you please review and check in?
> 
> 
> After a quick look at the MAX6626 datasheet, I fear I reached the
> conclusion that the MAX6625 is 100% compatible with the LM75 for which
> we have a driver. The MAX6626 is also comaptible except for the
> additional 3 bits of resolution, but this could easily be added to the
> existing lm75 driver. The other difference is the narrower address range
> but again this is essentially compatible with the LM75.
> 
> Could you please compare the MAX6626 and LM75 datasheets and confirm? You
> might want to take a look at the lm75 driver as well. If I'm right, I
> think it's better to do some light changes to the lm75 driver than add
> a brand new, almost similar driver.
> 
> Thanks,
> Jean
> 
> 

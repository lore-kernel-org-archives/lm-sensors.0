From: Daniel Mack <daniel@caiaq.de>
Date: Tue, 03 Nov 2009 12:15:46 +0000
Subject: Re: [lm-sensors] [RFC PATCH 00/10] LIS3: Feature updates and
Message-Id: <20091103121546.GE14091@buzzloop.caiaq.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <1257250185-7929-1-git-send-email-samu.p.onkalo@nokia.com>
In-Reply-To: <1257250185-7929-1-git-send-email-samu.p.onkalo@nokia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Nov 03, 2009 at 02:09:35PM +0200, Samu Onkalo wrote:
> This patch set makes several changes to the lis3 accelerometer chip family
> driver. There are also two patches from Eric Piel.
> He may want to still adjust those, but I attached patches to this set
> because my changes are done to top of them.
> 
> I have possibility to test these changes only with 8 bit version (lis302d).
> Since part of the changes are specific to 12 bit device, I would appreciate
> if someone could try these on 12 bit device.

My system also only features an 8bit device, so I won't be much help
here. I'll still find some time to test the series for regressions to
our application, though.

> 
> 0001:
> Sync event is sent after each measurement. This helps user space applications
> to detect which 3 reported values belongs to one atomic measurement.
> 
> 0002:
> polled input device was not totally released in module unload. This corrects
> memory leak. 

You might want to get an Ack on these two from the linux-input people.
An for more exposure, I'd copy LKML for the whole series.

Thanks,
Daniel


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

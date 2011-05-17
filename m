From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 17 May 2011 15:17:22 +0000
Subject: Re: [lm-sensors] [PATCHv7 1/1] Hwmon: Merge Pkgtemp with Coretemp
Message-Id: <20110517151722.GA4385@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1305384608-17357-1-git-send-email-durgadoss.r@intel.com>
In-Reply-To: <1305384608-17357-1-git-send-email-durgadoss.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, May 17, 2011 at 01:51:44AM -0400, R, Durgadoss wrote:
> Hi Guenter,
> 
> > Hi,
> > 
> > I did some testing on a SandyBridge system with two CPUs.
> > 
> > If I take all cores of the second CPU offline, the second instance of the
> > driver
> > still sticks around and tries to display the package sensor temperature.
> > However, the temperature is always reported as "N/A". I think the driver
> > instance should be removed if all cores of a CPU are offline.
> 
> I agree with you that the driver instance should be removed, in this case.
> But how can we find that all cores of a CPU are offline ?
> One way is to use a "count" variable and manipulate it when cores are
> Onlined/offlined. Kindly let me know of any better ways to implement this.
> 
You can define a counter in platform_data, or write a simple function to count
the number of online cores for a given physical processor in pdev_list.

A simpler mechanism might be to use cpu_core_mask(). Not sure if that works, though.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

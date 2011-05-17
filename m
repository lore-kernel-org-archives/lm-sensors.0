From: "R, Durgadoss" <durgadoss.r@intel.com>
Date: Tue, 17 May 2011 05:54:26 +0000
Subject: Re: [lm-sensors] [PATCHv7 1/1] Hwmon: Merge Pkgtemp with Coretemp
Message-Id: <D6D887BA8C9DFF48B5233887EF046541095AD57132@bgsmsx502.gar.corp.intel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1305384608-17357-1-git-send-email-durgadoss.r@intel.com>
In-Reply-To: <1305384608-17357-1-git-send-email-durgadoss.r@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Guenter,

> Hi,
> 
> I did some testing on a SandyBridge system with two CPUs.
> 
> If I take all cores of the second CPU offline, the second instance of the
> driver
> still sticks around and tries to display the package sensor temperature.
> However, the temperature is always reported as "N/A". I think the driver
> instance should be removed if all cores of a CPU are offline.

I agree with you that the driver instance should be removed, in this case.
But how can we find that all cores of a CPU are offline ?
One way is to use a "count" variable and manipulate it when cores are
Onlined/offlined. Kindly let me know of any better ways to implement this.

> Also, the Physical ID is "0" for both CPUs. Is this intentional ? It does not
> make much sense to me.

Got it.. It is not intentional...I missed it..
Shall add this in the next version.

Thanks,
Durga

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

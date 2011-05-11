From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Wed, 11 May 2011 15:49:11 +0000
Subject: Re: [lm-sensors] Subject: [PATCHv6 1/1] Hwmon: Merge Pkgtemp with
Message-Id: <20110511154910.GA6492@ericsson.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <D6D887BA8C9DFF48B5233887EF046541095AD03E7D@bgsmsx502.gar.corp.intel.com>
In-Reply-To: <D6D887BA8C9DFF48B5233887EF046541095AD03E7D@bgsmsx502.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, May 11, 2011 at 09:33:02AM -0400, R, Durgadoss wrote:
> Hi,
> 
> This patch merges the pkgtemp with coretemp driver.
> It has support for CONFIG_HOTPLUG_CPU. So, the sysfs
> interfaces are created when each core comes online
> and are removed when it goes offline. This driver
> compiles properly on a non-SMP config also.
> 
> I have tested this patch on these machines for cpu hotplug
> Support. As far as I could see, it seems to work fine.
> Kindly let me know if there are any crashes, with dmesg logs.
> ---
> From: Durgadoss R <durgadoss.r@intel.com>
> 
> Date: Thu, 12 May 2011 00:19:32 +0530
> Subject: [PATCHv6 1/1] Hwmon: Merge Pkgtemp with Coretemp
> 
I can not apply your patch; tabs have been replaced with blanks.
I thought it was our mailer again, but I see the same problem
when downloading your patch directly, so it must have happened
on your side. Please resend.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

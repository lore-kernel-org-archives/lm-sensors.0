From: Guenter Roeck <guenter.roeck@ericsson.com>
Date: Tue, 08 Feb 2011 20:31:17 +0000
Subject: Re: [lm-sensors] Patch[RFC]:Merging_Pkgtemp_with_Coretemp
Message-Id: <1297197077.24938.66.camel@groeck-laptop>
List-Id: <lm-sensors.vger.kernel.org>
References: <D6D887BA8C9DFF48B5233887EF04654109449EF873@bgsmsx502.gar.corp.intel.com>
In-Reply-To: <D6D887BA8C9DFF48B5233887EF04654109449EF873@bgsmsx502.gar.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2011-02-08 at 06:11 -0500, R, Durgadoss wrote:
> Hi,
> 
> Here is the much awaited patch to merge pkgtemp with coretemp.
> 
> This patch creates the pkgtemp interfaces under the same
> hwmonX/device directory as that of the coretemp. None of the
> coretemp interfaces names are changed(for compatibility reasons).
> 
> I am working on merging/adding documentation on the same.
> Would like to receive initial review comments, so that I can add
> final documentation once the code is somewhat acceptable.
> 
> -----------------------------
> From: Durgadoss R <durgadoss.r@intel.com>
> 
> Date: Tue, 8 Feb 2011 04:21:14 +0530
> Subject: PATCH[RFC] Merging_Pkgtemp_with_Coretemp
> 
> This patch merges the pkgtemp driver with the coretemp driver.
> 
> Signed-off-by: Durgadoss R <durgadoss.r@intel.com>
> 

Even when I download the patch directly, it has all tabs replaced with
blanks, thus it can not be applied. Please re-send with tabs.

Also, the idea was to have a single instance of the driver per CPU
package. Since the sysfs attribute names are still all named temp1_XXX, 
I don't see how you could have accomplished that. 

Thanks,
Guenter



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

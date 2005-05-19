From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:08 +0000
Subject: [PATCH] automatic VRM detection part1
Message-Id: <20040805233852.GA23286@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.58.0407221024290.6769@desitka.sh.cvut.cz>
In-Reply-To: <Pine.LNX.4.58.0407221024290.6769@desitka.sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Jul 22, 2004 at 10:43:07AM +0200, Rudolf Marek wrote:
> 
> Hello,
> 
> This patch forms composite module with i2c-sensor.c and new file
> i2c-sensor-vid.c, which provides i2c_which_vrm function for detecting VRM
> version of processor using cpuid_eax func. Resulting module has unchanged
> name (i2c-sensor).
> 
> Before applaying this patch, please rename i2c-sensor.c to
> i2c-sensor-detect.c
> 
> This patch was briefly reviewed by Jean Delvare.

Looks good, I've applied this patch, and the part 2 patch.

thanks,

greg k-h

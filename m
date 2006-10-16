From: khali@linux-fr.org (Jean Delvare)
Date: Mon, 16 Oct 2006 11:04:18 +0000
Subject: [lm-sensors] new chip support kernel driver
Message-Id: <20061016130418.247591da.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <F7F9B0BE3E9BD449B110D0B1CEF6CAEF03FA5811@ABGEX01E.abg.fsc.net>
In-Reply-To: <F7F9B0BE3E9BD449B110D0B1CEF6CAEF03FA5811@ABGEX01E.abg.fsc.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Thilo,

On Mon, 16 Oct 2006 09:37:52 +0200, Cestonaro, Thilo wrote:
> I'm working for Fujitsu Siemens Computers on a chip support
> for their Heimdall SMBus Chip. I'm ready to give it to you
> under GPL. What do I need to do?
> I've two things to give. One is the kernel module and the
> other is a patch of sensors executable which implements the
> useage function for displaying the stuff.
> 
> Could you give me a hint who should recieve this stuff?

Just send the patches here on this list. We will review them as time
permits. Depending on the outcome of the review, we may ask you to
rework some parts before we can accept them in the Linux kernel or
in lm_sensors.

Is there documentation available for this Heimdall chip? It's rather
difficult to review and maintain a driver without some form of
documentation.

Thanks,
-- 
Jean Delvare


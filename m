From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 26 Jan 2007 08:15:09 +0000
Subject: [lm-sensors] patch to bmcsensors.c
Message-Id: <20070126091509.4cf01e79.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <000501c740d5$85a39350$8101a8c0@PERF.PERFORMANCESOFTWARE>
In-Reply-To: <000501c740d5$85a39350$8101a8c0@PERF.PERFORMANCESOFTWARE>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Charles,

On Thu, 25 Jan 2007 16:07:00 -0700, Charles Grant wrote:
> Here are some changes I made to get bmcsensors working on our dual-core Xeon
> ATCA carrier (Kontron 8020).
> 
> 1) I modified the code to send an initial "get device ID" command to
> determine which commands are used to subsequently retrieve the SDR data
> (this code was taken directly from ipmitool).
> 
> 2) When retrieving partial buffers for an SDR, the request for the last
> buffer would return completion code 0xCA (cannot return number of requested
> data bytes), causing the code to half its buffer size, try again, and
> ultimately give up.  To get around this, I modified bmcsensors_get_sdr() and
> bmcsensors_rcv_sdr_msg() to never request more than the known number of
> remaining bytes.
> 
> 3) Sorry, but I also put "#ifdef DEBUG" around a lot of the printk's

Please send 3 separate patches, as these 3 changes appear to be
independent from each other. Smaller patches have a much higher chance
to be reviewed and merged.

Thanks,
-- 
Jean Delvare


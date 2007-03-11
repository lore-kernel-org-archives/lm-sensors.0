From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 11 Mar 2007 07:44:17 +0000
Subject: [lm-sensors] libsensors patch to gkrellm - a report
Message-Id: <20070311084417.4d7ecbcd.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <45F1B914.6050706@hhs.nl>
In-Reply-To: <45F1B914.6050706@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Fri, 09 Mar 2007 20:44:20 +0100, Hans de Goede wrote:
> Rudolf + Jean, would it be a good idea to write a patch for libsensors 
> to make it automaticly set features not found in sysfs to ignore?

This should no longer be needed once we implement dynamic feature
discovery in libsensors. If I had some time to work on libsensors, I'd
rather spend it on reviewing these patches we already have than on
additional workarounds to make the current design look less broken.

-- 
Jean Delvare


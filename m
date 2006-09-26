From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 26 Sep 2006 12:05:02 +0000
Subject: [lm-sensors] SVN/trac requests
Message-Id: <20060926140502.00d29dd5.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Axel,

I have the two following requests with regards to lm-sensors' SVN/trac:

1* Can the "V-2-3-1" tag be renamed to "V2-3-1"?

2* We often need to ask people to try the latest version of
sensors-detect. For now we point them to:
http://www.lm-sensors.org/browser/lm-sensors/trunk/prog/detect/sensors-detect?format=txt

The problem is that this version of the SVN file doesn't have its
keywords substituted, so the version string reads:
  '$Revision$ ($Date$)'
This might become a problem in the long run when users report with this
version string, as we will be unable to tell what version of the file
they have. So, is it possible to ask trac to provide the file with
keywords substituted? I'm surprised this isn't the default...

Thanks,
-- 
Jean Delvare


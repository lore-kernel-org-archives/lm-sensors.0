From: michaelnel@comcast.net (Michael Nelson)
Date: Wed, 06 Sep 2006 14:26:50 +0000
Subject: [lm-sensors] Asus P5B Deluxe WiFi AP Sensors
Message-Id: <20060906142650.GA4641@seahunt.dyndns.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060822145643.GA5632@seahunt.dyndns.org>
In-Reply-To: <20060822145643.GA5632@seahunt.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Sep 06, 2006 at 07:07:49AM -0700, Michael Nelson wrote:

> Hmmm.  I tried the 2.6.18-rc4 because that is the one the patch is against.
> I will grab the -rc6 and see if that works.

The patch fails to apply on rc6:

File to patch: linux/drivers/hwmon/w83627ehf.c
patching file linux/drivers/hwmon/w83627ehf.c
Hunk #1 FAILED at 34.
Hunk #2 succeeded at 113 (offset -3 lines).
Hunk #3 succeeded at 249 (offset -37 lines).
Hunk #4 succeeded at 412 (offset -48 lines).
Hunk #5 FAILED at 1201.
Hunk #6 FAILED at 1241.
3 out of 6 hunks FAILED -- saving rejects to file
linux/drivers/hwmon/w83627ehf.c.rej

I don't think I can hand apply this patch to either the suse 2.6.16 source
or this rc6... I am over my head here, folks, sorry.

Michael

-- 

San Francisco, CA


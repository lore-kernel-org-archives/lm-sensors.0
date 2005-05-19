From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:57 +0000
Subject: lm-sensors install goes fine, but I only get status of EEPROMs
Message-Id: <20040508181312.47a8193e.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <409C6578.2040008@knology.net>
In-Reply-To: <409C6578.2040008@knology.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> The force parameter did the trick.  For whatever reason, the 
> auto-detection wasn't working.  Here's the dmesg output with
> debugging on in case you're interested in seeing the auto-detect
> failure.  Let me know if I can do anything else.  Thanks for your
> help.

You're welcome.

After reading the code once again, it's "normal". The code expects the
force parameter to be passed in order to accept "generic" (i.e.
non-National, non-Analog) LM85-like chips.

Philip, why is that? Looks like this should be changed (by at least
accepting SMSC chips without force parameters).

-- 
Jean Delvare
http://khali.linux-fr.org/

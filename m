From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 26 Dec 2006 18:28:02 +0000
Subject: [lm-sensors] w83627ehf informations
Message-Id: <20061226192802.e5b028ff.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1163284779.5555.34.camel@armageddon>
In-Reply-To: <1163284779.5555.34.camel@armageddon>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 19 Nov 2006 16:51:33 +0100, torsten goroll wrote:
> thanks for your answer. The version of the bash is 3.1.
> I didn't modify it and compiled lm-sensors from the current
> sources.

Ok, it appears to be a new feature of bash 3.1: it displays an error
message when a write (echo) to a file returns an error. Previous
versions of bash didn't. So we need to hide the error in pwmconfig (and
fancontrol). And while we're at it, we could handle that error
properly, as it seems we weren't so far.

Patch is attached, I can't test it right now, so testers are wanted and
feedback is welcome. If the patch works OK, I'll apply it before we
release lm_sensors 2.10.2.

-- 
Jean Delvare
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: pwm-enable-error-check.patch
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20061226/784e1217/attachment.ksh 

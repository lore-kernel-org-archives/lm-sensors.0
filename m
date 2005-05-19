From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: new MAX6653 driver
Message-Id: <20040910082401.M7669@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1094741705.29203.18.camel@pavement.sandburst.com>
In-Reply-To: <1094741705.29203.18.camel@pavement.sandburst.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 09 Sep 2004 10:55:05 -0400, Travis B. Sawyer wrote
> I've created a new max6653 chip driver but really don't have the 
> time to do a proper submission.  Should I just send the driver code?

Yes, please do. That way it'll be available through the mailing-list archive
if someone wants to do a proper submission at a later time.

Which system do you have this chip on? If it is something other users are
likely to have on their boards, I have a patch (attached) which adds support
for the MAX6653 (and MAX6663/MAX6664 for that matter) to sensors-detect. Could
you please give it a try? If it works I'll apply it to the CVS repository (as
soon as I get back to a decent Internet access).

Thanks.

-- 
Jean Delvare
http://khali.linux-fr.org/

-------------- next part --------------
A non-text attachment was scrubbed...
Name: sensors-detect.diff
Type: application/octet-stream
Size: 1880 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040910/4413d05d/sensors-detect.obj

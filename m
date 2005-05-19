From: mcarland@yahoo.com (Michael Carland)
Date: Thu, 19 May 2005 06:25:36 +0000
Subject: Error messages on ignored values
Message-Id: <20050205174014.84005.qmail@web60506.mail.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050204053725.34834.qmail@web60504.mail.yahoo.com>
In-Reply-To: <20050204053725.34834.qmail@web60504.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Updated patch attached.

--- Jean Delvare <khali@linux-fr.org> wrote:

> Hi Michael,
> 
> Quoting myself:
> > I'll apply your patch, thanks.
> 
> On second thought, I think that the patch could be improved a bit:
> 
> 1* You hide SENSORS_ERR_PROC errors for all channels, but I guess only
> some of them can actually be missing with the 2.6 driver?
> 
> 2* You return the exact same error message for the two possible causes
> of failure (sensors_get_label_and_valid failing and sensors_get_feature
> failing). Now that you separated the "if" statements, it would be better
> to have different error messages.
> 
> Care to send an updated patch?
> 
> Thanks,
> -- 
> Jean Delvare
> 

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
-------------- next part --------------
A non-text attachment was scrubbed...
Name: lm_sensors-diff
Type: application/octet-stream
Size: 15178 bytes
Desc: lm_sensors-diff
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20050205/fad4ad68/lm_sensors-diff.obj

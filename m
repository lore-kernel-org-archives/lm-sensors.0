From: warp@mercury.d2dc.net (Zephaniah E. Hull)
Date: Thu, 19 May 2005 06:24:43 +0000
Subject: [RFC 2.6] sensor chips sysfs interface change (long)
Message-Id: <20040221131318.GA31688@babylon.d2dc.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040218220845.361341c9.khali@linux-fr.org>
In-Reply-To: <20040218220845.361341c9.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: LKML <linux-kernel@vger.kernel.org>, LM Sensors <sensors@stimpy.netroedge.com>, Greg KH <greg@kroah.com>

On Wed, Feb 18, 2004 at 10:08:45PM +0100, Jean Delvare wrote:
> Hi all,
> 
> I plan to make rather important changes to the sysfs interface of I2C
> chip drivers in Linux 2.6. The topic has already been discussed on the
> lm_sensors mailing list, bug Greg KH suggested that I should explain my
> intentions here too, so here I am.

<snip>
> THE PLAN
> 
> I propose a three-step plan.
> 
> 1* Change the base scheme (e.g. temp_min1 -> temp1_min). This is the
> more important change (in the sense it affects all drivers and the
> libsensors library) and correspond to the second problem listed above.
> 
> 2* Change the hysteresis names (temp1_hyst -> temp1_max_hyst). Only some
> drivers are impacted. Changes required to the library as well.
> 
> 3* Add splitted alarm files. This doesn't break the interface (these are
> new files), but on the other hand needs that we think about it a bit
> more so that our choices are extendable and correct for all known
> drivers.
> 
> Comments welcome (or even requested, according to the subject line).

I would like to further suggest the renaming of 'sensor<n>' to
'temp<n>_sensor' or 'temp<n>_type', in the interest of being consistent.

-- 
	1024D/E65A7801 Zephaniah E. Hull <warp@babylon.d2dc.net>
	   92ED 94E4 B1E6 3624 226D  5727 4453 008B E65A 7801
	    CCs of replies from mailing lists are requested.

Perl = Being
  -- Descartes (paraphrased).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: Digital signature
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040221/05d45078/attachment.bin

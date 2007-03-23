From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 23 Mar 2007 08:25:22 +0000
Subject: [lm-sensors] #2195: Fails to detect ITE family chip with ID
Message-Id: <20070323092522.50c15a43.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <191fb4ca0703220924o604d104iaf34922f53c7cf83@mail.gmail.com>
In-Reply-To: <191fb4ca0703220924o604d104iaf34922f53c7cf83@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Juerg,

On Thu, 22 Mar 2007 21:12:25 -0700, Juerg Haefliger wrote:
> 1) The ITE superio enter sequence also works for the SMSC, so
> sensor-detects reports both an (unknown) ITE and a dme1737 SMSC chip.
> I guess there's nothing we can do about this, can we?

We can, and actually I have a local patch fixing it. I am only waiting
for lm-sensors 2.10.3 to be finally released before I commit it. I'm
attaching said patch to this post if you want to take a look and/or
give it a try. Basically, the idea is to test the families from the
shorter enter sequence (actually empty, for the National Semiconductor
chips) to the longer, and to stop as soon as one sequence was found to
work (regardless of whether or not a known chip was found.)

> 2) Even though the datasheet shows a device ID of 0x78 which matches
> the sensor-detect output of the ticket reporter, my DME1737 returns
> 0x77. Should I just add another entry for a DME1737 with dev id 0x77?

Hmm, yes, I guess you'll have to.

[/me rants against manufacturers who can't stick to their own
standards.]

-- 
Jean Delvare
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: sensors-detect-superio-family-order.patch
Url: http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070323/2f31c496/attachment.pl 

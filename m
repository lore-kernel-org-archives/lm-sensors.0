From: khali@linux-fr.org (Jean Delvare)
Date: Tue, 28 Mar 2006 20:34:53 +0000
Subject: [lm-sensors] [PATCH] New sensors program patch for SMSC47M192
Message-Id: <20060328223453.cff5b061.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.63.0603222323420.2984@Laila>
In-Reply-To: <Pine.LNX.4.63.0603222323420.2984@Laila>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hartmut,

Sorry for the late reply...

> > For temperatures, the Linux 2.4 standard is VALUE(1) for the high limit
> > and VALUE(2) for the low limit. This still doesn't affect your Linux 2.6
> 
> Ok, I've changed that for the temperatures. Does the same comment apply 
> also to voltages?

No, voltages have it the other way around. Don't ask ;)

> Otherwise I hope I've included all your comments.

Looks all OK, I just applied it to lm_sensors CVS. Thanks a lot for the
good work Hartmut!

-- 
Jean Delvare


From: khali@linux-fr.org (Jean Delvare)
Date: Wed, 22 Mar 2006 12:15:45 +0000
Subject: [lm-sensors] [PATCH] Hardware monitoring support for SMSC
Message-Id: <20060322131545.20ab4d87.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.LNX.4.63.0603192325570.3062@Laila>
In-Reply-To: <Pine.LNX.4.63.0603192325570.3062@Laila>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hartmut,

>   Thanks a lot for your comments, and sorry this takes so long.
> Here's a new patch, now with individual alarm files only.
> I've also renamed the temp[23]_fault files to temp[23]_input_fault
> in order to match your sysfs interface proposal.

Great! I've queued this version of the patch, and will send it to Greg
KH shortly. I made some whitespace cleanups, but the code is otherwise
very good now.

> Having said that, I'm still happy to have it removed if you insist that it 
> should not be there.

Naah, I'm not insisting at all, I'm fine with it.

Thanks,
-- 
Jean Delvare


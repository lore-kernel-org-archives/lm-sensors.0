From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:20 +0000
Subject: Adding S4882 support to the i2c-amd756 driver
Message-Id: <20041019190237.7e0a3c85.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041017222721.1f12466d.khali@linux-fr.org>
In-Reply-To: <20041017222721.1f12466d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > Mark, does this second approach please you more than my original
> > one? The changes to the original file are reduced to their minimal
> > form.
> 
> Heh, OK.  Could you just make sure that 'touch i2c-amd756-s4882.c'
> causes make to rebuild the object?  I think the auto dependency magic
> will figure that out, but I'm not sure.

Yes, it works properly. Thanks for pointing the potential issue out, I
admit I didn't consider the problem.

-- 
Jean Delvare
http://khali.linux-fr.org/

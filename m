From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:49 +0000
Subject: [PATCH 2.6] initialize fan_mins in w83781d, asb100 and lm78
Message-Id: <20040331020956.GB29782@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040323213245.2b5f5588.khali@linux-fr.org>
In-Reply-To: <20040323213245.2b5f5588.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Jean Delvare <khali@linux-fr.org> [2004-03-23 21:32:45 +0100]:
> Quoting myself:
> 
> > While testing, I found a corner case that isn't handled properly. It
> > doesn't seem to be handled by the lm78 and the asb100 either. Setting
> > fanN_div before ever reading from the chip or setting fanN_min will
> > make use of fanN_min while it was never initialized.
> 
> The following patch addesses the issue. Tested to work on my AS99127F
> rev.1 (which means that only the changes to the w83781d driver were
> actually tested). Testers welcome.
> 
> Mark, can you confirm it works for your ASB100 as well? Thanks.

Yes, this works.  Here is what I did exactly, in case you had something
else in mind:

modprobe asb100

echo "2000" > .../fan1_min

rmmod asb100

modprobe asb100

sensors -s (which sets fan1_div but not fan1_min)

sensors (which correctly shows fan1 min of 2000)

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

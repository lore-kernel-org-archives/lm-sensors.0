From: Guenter Roeck <linux@roeck-us.net>
Date: Tue, 09 Dec 2014 16:24:41 +0000
Subject: Re: [lm-sensors] [PATCH v3] sensors-detect: Add code to detect TMP400 and TMP435
Message-Id: <20141209162441.GC19663@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <1418096560-28548-1-git-send-email-linux@roeck-us.net>
In-Reply-To: <1418096560-28548-1-git-send-email-linux@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Dec 09, 2014 at 12:34:53PM +0100, Jean Delvare wrote:
> On Tue, 9 Dec 2014 11:45:52 +0100, Jean Delvare wrote:
> > Hi Guenter,
> > 
> > On Mon,  8 Dec 2014 19:42:40 -0800, Guenter Roeck wrote:
> > > Also strengthen chip detection for other TMP4xx chips,
> > > and update driver support status for TMP431 and TMP432.
> > > 
> > > Write new function for various TMP4xx chips and separate
> > > from lm90 detection.
> > 
> > Looks good. Minor comments inline, but this version is already good
> > enough to commit.
> 
> Oh, and please add an entry for the TMP400 to wiki/Devices.
> 

Done.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

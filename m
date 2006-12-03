From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 03 Dec 2006 12:26:45 +0000
Subject: [lm-sensors] new vt1211 driver: Can't access procfs/sysfs file
Message-Id: <20061203132645.3b06d358.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <45728865.5020308@xs4all.nl>
In-Reply-To: <45728865.5020308@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, 03 Dec 2006 12:13:50 +0100, Udo van den Heuvel wrote:
> Jean Delvare wrote:
> > are ignore statements for them in your configuration file. 
> 
> Sure. But not for the temperatures.
> (...)
> chip "vt1211-*" "vt8231-*"
> #
> #
> #ignore in6
> #set config 12
> ignore in0
> ignore in1
> ignore temp1
> ignore temp2
> ignore temp4
> ignore temp5
> ignore temp6
> ignore temp7

"No, Sir, I don't have ignore statements for temperatures. I swear!"

Tsss...

> > BTW, I hope
> > you started from the default configuration file shipped with lm_sensors
> > 2.10.1 and not an older version, as it was significantly updated to
> > properly support the new Linux 2.6 version of the driver.
> 
> And go though all of that config stuff that does not make sense for my
> board?

Or you can be smart and only copy the vt1211 section. It's up to you.

> I just see that temp sensors might have been renumbered?

Yes, they have been, and the values have been changed as well, so the
compute statements are different.

-- 
Jean Delvare


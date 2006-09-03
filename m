From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 03 Sep 2006 14:18:35 +0000
Subject: [lm-sensors] [RFC] Dropping rivatv from sensors-detect
Message-Id: <20060903161835.12cce4aa.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20060828134658.c4d0ae3c.khali@linux-fr.org>
In-Reply-To: <20060828134658.c4d0ae3c.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Quoting myself:
> Is there any objection to me dropping rivatv detection from
> sensors-detect? My reasons are:
> 
> * rivatv is still not in mainline after 3 years. I wonder if it will
> ever be. 
> 
> * rivatv is only one of the several drivers which can provide I2C/SMBus
> access to nVidia adapters. nvidiafb and rivafb do it as well (although
> I did not check if access to the same busses was provided) and they
> are in mainline. And nVidia's proprietary X driver does also in recent
> versions, even though it won't work at the moment due to improperly
> set i2c functionality flags (and we won't provide support for it, but
> that's a different point.)
> 
> * Most PCI drivers will autoload in recent Linux 2.6 kernels (in
> particular nvidiafb and rivafb do). So I'd rather let the user pick the
> driver he/she wants. sensors-detect will scan all available busses
> anyway, whether they were detected or not.
> 
> * There are many many different nVidia graphics adapters. We already
> have 22 entries, representing 20% of the total list of known PCI
> adapters. Given that the last ones were added over 2 years ago, the list
> is certainly incomplete. I don't even know which devices are supported
> by rivatv (or the other drivers mentioned above), and I don't want to
> spend time tracking this.
> 
> So unless someone finds a good reason I missed, I plan to remove all
> references to rivatv from sensors-detect soon.

Done.

-- 
Jean Delvare


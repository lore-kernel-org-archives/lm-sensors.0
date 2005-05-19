From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:23 +0000
Subject: CFA779 LCD Driver
Message-Id: <20041121224654.6b542b71.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041118202527.GB1694@hexview.com>
In-Reply-To: <20041118202527.GB1694@hexview.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I've just finished writing 2.6 kernel driver for i2c LCD controller by
> CrystalFontz. The driver is for CFA-779, it is a custom device and it
> is not available directly from CrystalFontz, but it is used on some
> appliances and they have lots of other LCD controllers with similar
> interfaces, so whoever is interested to write drivers for them could
> use my driver as a template.
> 
> If this is of interest for you, I can send you the source code.

We will probably not make it part of the package if it is for a custom
device, but if you send it it'll at least be saved in the mailing-list
archive for others to peek if they want. Be sure to include some kind of
copyright/license or explicit lack thereof.

Thanks,

-- 
Jean Delvare
http://khali.linux-fr.org/

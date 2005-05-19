From: hch@lst.de (Christoph Hellwig)
Date: Thu, 19 May 2005 06:23:45 +0000
Subject: i2c changes Was: sensors in 2.5.54
Message-Id: <20030111090422.A22280@lst.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.OSF.4.50.0301070020190.17118-200000@kosh.hut.fi>
In-Reply-To: <Pine.OSF.4.50.0301070020190.17118-200000@kosh.hut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jan 07, 2003 at 10:43:15PM -0500, Albert Cranford wrote:
> Let me see if I can get sensors.h into the kernel along
> with changes below to adm1021.c and lm75.c.  What do you
> think?  I need to tweek sensors.h. OK?
>

I removed sensors.h for a reason.  If you want the definitions in
headers add one header per driver.

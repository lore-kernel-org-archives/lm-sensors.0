From: hch@lst.de (Christoph Hellwig)
Date: Thu, 19 May 2005 06:23:45 +0000
Subject: i2c changes Was: sensors in 2.5.54
Message-Id: <20030111160527.A24084@lst.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <Pine.OSF.4.50.0301070020190.17118-200000@kosh.hut.fi>
In-Reply-To: <Pine.OSF.4.50.0301070020190.17118-200000@kosh.hut.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, Jan 07, 2003 at 09:50:32AM +0200, Kyosti Malkki wrote:
> It seems that sysctl enumeration has moved out of sensors.h, but
> libsensors depends on this. While the list is long and boring, so is
> linux/sysctl.h. I believe we want it back.

Userland programs are not supposed to include kernel headers.

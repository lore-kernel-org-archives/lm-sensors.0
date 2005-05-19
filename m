From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: linux-2.6.7 parallel port adapter
Message-Id: <20050509183412.5642e441.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <427B6E12.9000008@inf.ed.ac.uk>
In-Reply-To: <427B6E12.9000008@inf.ed.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> > i2c-parport-light does direct I/O access on the parallel-port, which
> > I think does only work on i386-like hardware.
> It works perfectly fine under Linux-2.4.26,

Except that i2c-parport-light didn't exist before 2.6.2-rc1. Which
driver are you using under 2.4.26?

-- 
Jean Delvare

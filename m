From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:43 +0000
Subject: [PATCH] Get rid of assembler code in kernel/i2c-algo-biths.c
Message-Id: <20050311212307.005dd87d.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050310003504.GA4882@bode.aurel32.net>
In-Reply-To: <20050310003504.GA4882@bode.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Aurelien,

> I propose to change it by C code, as in the patch attached. Please
> note that I haven't tested it "in live", as I don't have something
> that uses this module. However, I have tested it in a simple C
> program, and I also tested that i2c still build correctly.

Applied, thanks.

As a side note, I think we could stop building i2c-algo-biths by
default, since nobody uses it as far as I know.

-- 
Jean Delvare

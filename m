From: rusty@rustcorp.com.au (Rusty Russell)
Date: Thu, 19 May 2005 06:25:22 +0000
Subject: [PATCH] I2C update for 2.6.10-rc1
Message-Id: <1100055896.25963.62.camel@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
References: <10999778552595@kroah.com>
In-Reply-To: <10999778552595@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Mon, 2004-11-08 at 21:24 -0800, Greg KH wrote:
> +static int init = 1;
> +MODULE_PARM(init, "i");

You meant, of course, module_param(), or were you checking if my scripts
were broken? 8)

Cheers,
Rusty.
-- 
A bad analogy is like a leaky screwdriver -- Richard Braakman

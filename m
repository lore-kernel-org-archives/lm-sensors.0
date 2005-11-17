From: azummo-lists@towertech.it (Alessandro Zummo)
Date: Thu, 17 Nov 2005 19:23:51 +0000
Subject: [lm-sensors] [RFC] adding back i2c_get_clients
Message-Id: <20051117192312.348ab12e@inspiron>
List-Id: <lm-sensors.vger.kernel.org>
References: <20051117003330.21bfff26@inspiron>
In-Reply-To: <20051117003330.21bfff26@inspiron>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, 17 Nov 2005 08:34:46 -0800
Greg KH <greg@kroah.com> wrote:

> Good, exporting functions is the proper way to do things like this.
> Like Jean showed, a simple set of function pointers is the correct way.
> We want type-safe checking and explicit interfaces like this.  Not
> wide-open, unchecked, and possibly unsafe interfaces like ioctls.
> 
> That's why I, and the other kernel developers are trying to prevent any
> future ioctls being added.

 Ok, I'll work in that direction. Should I thus consider
 i2c_driver->command to be deprecated?

-- 

 Best regards,

 Alessandro Zummo,
  Tower Technologies - Turin, Italy

  http://www.towertech.it


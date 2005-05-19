From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Thu, 19 May 2005 06:24:01 +0000
Subject: [PATCH] i2c driver changes for 2.5.72
Message-Id: <20030620051126.GA29059@earth.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <10559607053930@kroah.com>
In-Reply-To: <10559607053930@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

* Mark M. Hoffman <mhoffman@lightlink.com> [2003-06-20 00:14:07 -0400]:
> 
> Remove this line from all set_foo():
> 
> 	data->foo = FOO_TO_REG(...);
> 
> And add this to xxxx_write_value():
> 
> 	data->valid = 0;
> 
> Hmmm, probably still need data->update_lock in xxxx_write_value(), but
> that should take care of it no?

*Sigh* no.  There would still be races around the set_* functions that
read the fan divisor.  OK Phil, I'm done trying to improve on your
patch.  ;)

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com

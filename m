From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:25:45 +0000
Subject: [PATCH 2.6] I2C: Kill outdated defines in i2c.h
Message-Id: <20050324000441.GE7189@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20050320185846.0b3bde3b.khali@linux-fr.org>
In-Reply-To: <20050320185846.0b3bde3b.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sun, Mar 20, 2005 at 06:58:46PM +0100, Jean Delvare wrote:
> Hi Greg,
> 
> Some defines in i2c.h (I2C_CLIENT_MODPARM and friends) are now useless.
> They should have been removed when the i2c client parameters were
> converted from MODULE_PARAM to module_parm_array, but where not. This
> patch removes them now.
> 
> Additionally, it moves the definition of I2C_CLIENT_MAX_OPTS next to
> where it is used rather than 220 lines before, which is preferable IMHO.
> 
> As a side note, I think that there is a bug in the way these options are
> handled. The i2c code looks for I2C_CLIENT_END as a list terminator, but
> if the maximum number of parameters are actually provided, no terminator
> will be left. It's rather unlikely to happen because nobody will
> probably ever provide that many parameters, but this should probably be
> fixed. I'll address this issue later, since I plan to completely rewrite
> the way these parameters are handled anyway.
> 
> Please apply,


Applied, thanks.

greg k-h

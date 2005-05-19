From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:10 +0000
Subject: Vaio eeprom security issue
Message-Id: <20030806232211.GB8298@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030806233617.5a83d0b6.khali@linux-fr.org>
In-Reply-To: <20030806233617.5a83d0b6.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Aug 06, 2003 at 11:36:17PM +0200, Jean Delvare wrote:
> 
> 3* Define a security policy for that password issue. I think we simply
> should disable the Vaio EEPROM in the eeprom module if we find there is
> a password set. It could be forced using the force_eeprom module
> parameter (or should we define another module parameter?) Another
> possibility is to hide that particular field instead, but I'm not sure
> it's worth the work.

How about only allowing root (or the proper CAP_* value) to read this
value.  I imagine it would be useful for some people to get access to
this for legimate reasons.

thanks,

greg k-h

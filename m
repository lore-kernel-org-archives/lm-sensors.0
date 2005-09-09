From: greg@kroah.com (Greg KH)
Date: Fri, 09 Sep 2005 23:33:48 +0000
Subject: [lm-sensors] Re: [PATCH 2.6] hwmon: via686a: save 0.5k by long
Message-Id: <20050909213250.GA29011@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200509010910.14824.vda@ilport.com.ua> <20050901155915.GB1235@kroah.com> <200509020854.37192.vda@ilport.com.ua> <20050903102227.03312247.khali@linux-fr.org> <20050903161331.1c76153d.khali@linux-fr.org>
In-Reply-To: <20050903161331.1c76153d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>
Cc: Denis Vlasenko <vda@ilport.com.ua>, LKML <linux-kernel@vger.kernel.org>, LM Sensors <lm-sensors@lm-sensors.org>

On Sat, Sep 03, 2005 at 04:13:31PM +0200, Jean Delvare wrote:
> Hi Greg, all,
> 
> > This patch doesn't apply on top of my stack, first because the
> > hardware monitoring drivers have been moved to drivers/hwmon, second
> > because the via686a driver had indentation cleanups since 2.6.12.
> > 
> > Could you please provide this patch against 2.6.13-mm1?
> 
> On Denis' request, I have done that myself.

Unfortunatly, no one noticed that this patch adds a build warning :(

So I'm not going to apply it, sorry.

thanks,

greg k-h

From: greg@kroah.com (Greg KH)
Date: Thu, 19 May 2005 06:24:20 +0000
Subject: Some nice feature
Message-Id: <20031001170944.GD25262@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200310011619.49340.lepalom@wol.es>
In-Reply-To: <200310011619.49340.lepalom@wol.es>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, Oct 01, 2003 at 04:19:49PM +0200, Leopold Palomo Avellaneda wrote:
> Alas, if only somebody would give the lm_sensors folks a copy of a good
> book on XML for christmas, and they decided to take the monumental step
> of converting /proc/sensors into a single xml-based file with the
> RELEVANT information presented in toplevel tags like
> 
>   <cpu_temp id="0" units="C">50.4</cpu_temp>
> 
> and the irrelevant information presented in tags like
> 
>   <hardware><name>lm78</name><version>1.22a</version></hardware>
> 
> then we could ALL reap the fruits of their labor without needing a copy
> of the lm78 version 1.22a API manual and having to write an application
> that supports each of the sensors THROUGH THEIR INTERFACE one at a
> time...;-)
> 
> [....]
> 
> What do you think?

I think people who want to put XML into the kernel need to be taken out
back and given a sound thrashing...  :)

Tell them to go look at the kernel interface in the 2.6 kernel (one
value per file with consistant units accross drivers) and if they don't
like that, for them to bring it up on this mailing list, or
linux-kernel.

thanks,

greg k-h

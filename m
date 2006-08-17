From: greg@kroah.com (Greg KH)
Date: Thu, 17 Aug 2006 20:01:09 +0000
Subject: [lm-sensors] [RFC-patch] pc87360 - unchecked
Message-Id: <20060817200109.GA32692@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <44D2514B.2090202@gmail.com>
In-Reply-To: <44D2514B.2090202@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Aug 17, 2006 at 01:35:30PM -0600, Jim Cromie wrote:
> 
> Jean Delvare wrote:
> >Hi Jim,
> >
> >  
> hi !
> 
> BTW - are you considering these as 18 bugfix material, or are they
> "long standing sub-optimalities" for 19 when it opens ?  (ie when 18 is out)
> 
> Obviously (from the experimentalism in my patches), Ive been treating it 
> as 19 stuff ;-)
> Apologies for making this more *in-need-of-feedback* than it has to be,
> but I guess I cant quite resist..
> 
> >
> >Now I agree that, even then, we probably will never see two 
> of the same kind of  (not that the distinction matters here..)
> >Super-I/O
> >chip on the same board, so that's not really an issue.
> >
> >  
> 
> Um.. I just looked at asb100.c, and Im seeing static decls like:
>        static DEVICE_ATTR(..)
> 
> Unless Im misunderstanding something, this is sufficient to preclude 
> supporting a 2nd device.
> IOW, to support multiple devices, drivers would need to create 
> attributes, groups, etc out of
> kalloc'd memory, sacrificing the (heavy) use of static initialization in 
> hwmon/*.c

No, you are incorrect, it will work just fine.  The dynamic thing is the
struct device, not the functions that make up the file callbacks.

thanks,

greg k-h


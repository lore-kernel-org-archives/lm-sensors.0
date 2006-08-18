From: greg@kroah.com (Greg KH)
Date: Fri, 18 Aug 2006 04:35:17 +0000
Subject: [lm-sensors] [RFC-patch] pc87360 - unchecked
Message-Id: <20060818043517.GA5896@kroah.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <44D2514B.2090202@gmail.com>
In-Reply-To: <44D2514B.2090202@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Thu, Aug 17, 2006 at 03:45:06PM -0600, Jim Cromie wrote:
> Greg KH wrote:
> >On Thu, Aug 17, 2006 at 01:35:30PM -0600, Jim Cromie wrote:
> >  
> >>Jean Delvare wrote:
> >>    
> >>>Hi Jim,
> >>>
> >>> 
> >>>      
> >>hi !
> >>
> >>BTW - are you considering these as 18 bugfix material, or are they
> >>"long standing sub-optimalities" for 19 when it opens ?  (ie when 18 is 
> >>out)
> >>
> >>Obviously (from the experimentalism in my patches), Ive been treating it 
> >>as 19 stuff ;-)
> >>Apologies for making this more *in-need-of-feedback* than it has to be,
> >>but I guess I cant quite resist..
> >>
> >>    
> >>>Now I agree that, even then, we probably will never see two 
> >>>      
> >>of the same kind of  (not that the distinction matters here..)
> >>    
> >>>Super-I/O
> >>>chip on the same board, so that's not really an issue.
> >>>
> >>> 
> >>>      
> >>Um.. I just looked at asb100.c, and Im seeing static decls like:
> >>       static DEVICE_ATTR(..)
> >>
> >>Unless Im misunderstanding something, this is sufficient to preclude 
> >>supporting a 2nd device.
> >>IOW, to support multiple devices, drivers would need to create 
> >>attributes, groups, etc out of
> >>kalloc'd memory, sacrificing the (heavy) use of static initialization in 
> >>hwmon/*.c
> >>    
> >
> >No, you are incorrect, it will work just fine.  The dynamic thing is the
> >struct device, not the functions that make up the file callbacks.
> >
> >  
> 
> Im not speaking of the callbacks themselves, rather the 
> device_attributes that
> keep references to them.  Assuming 2 'static DEVICE_ATTR()'s,
> that are init'd with names "in0_max", "in1_max". theyre separate 
> attributes, reusing the same show,store functions, thru separate refs.
> Correct ?

Yes.

> Are you saying that I could reuse a statically defined group (ie the 
> device_attrs within it) to create another set of attr-files ?

Yes.

> IOW - pc87360 creates this:
> 
> soekris:/sys/devices/platform/i2c-9191/9191-6620# ls
> alarms_in      in1_input   in4_min     in8_input     temp2_crit    
> temp4_status
> alarms_temp    in1_max     in4_status  in8_max       temp2_input   
> temp5_crit
> bus@           in1_min     in5_input   in8_min       temp2_max     
> temp5_input
> cpu0_vid       in1_status  in5_max     in8_status    temp2_min     temp5_max
> ...
> 
> Could same static structures also support a 2nd set  ?   (assuming other 
> limits are lifted)
> 
> soekris:/sys/devices/platform/i2c-(another-number)/(another-number)-6620# ls
> alarms_in      in1_input   in4_min     in8_input     temp2_crit    
> temp4_status
> alarms_temp    in1_max     in4_status  in8_max       temp2_input   
> temp5_crit

Yes.

> or would they need to be separate ? ( and hence better to be kallocd, 
> then initialized )

No.  Please see the driver core chapter in the Linux Device Drivers book
(free online) for more details here.

> Also, Id rather hoped you'd respond to the hack in fs/sysfs/group.c,
> were you just being polite ? :-}

Hm, I vaguely remember that, and I think I was probably just being
polite :)

But if you want me to take it seriously, please, resend it.  Conference
season is now over so I will have more time to focus back on kernel
issues.

thanks,

greg k-h


From: mhoffman@lightlink.com (Mark M. Hoffman)
Date: Fri, 18 Aug 2006 02:45:03 +0000
Subject: [lm-sensors] [RFC-patch] pc87360 - unchecked
Message-Id: <20060818024503.GA12536@jupiter.solarsys.private>
List-Id: <lm-sensors.vger.kernel.org>
References: <44D2514B.2090202@gmail.com>
In-Reply-To: <44D2514B.2090202@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim:

> > On Thu, Aug 17, 2006 at 01:35:30PM -0600, Jim Cromie wrote:
> >> Um.. I just looked at asb100.c, and Im seeing static decls like:
> >>        static DEVICE_ATTR(..)
> >>
> >> Unless Im misunderstanding something, this is sufficient to preclude 
> >> supporting a 2nd device.
> >> IOW, to support multiple devices, drivers would need to create 
> >> attributes, groups, etc out of
> >> kalloc'd memory, sacrificing the (heavy) use of static initialization in 
> >> hwmon/*.c

> Greg KH wrote:
> > No, you are incorrect, it will work just fine.  The dynamic thing is the
> > struct device, not the functions that make up the file callbacks.

... nor the accompanying struct attributes, nor the struct attribute_group.

* Jim Cromie <jim.cromie at gmail.com> [2006-08-17 15:45:06 -0600]:
> Im not speaking of the callbacks themselves, rather the 
> device_attributes that
> keep references to them.  Assuming 2 'static DEVICE_ATTR()'s,
> that are init'd with names "in0_max", "in1_max". theyre separate 
> attributes,
> reusing the same show,store functions, thru separate refs.  Correct ?
> 
> Are you saying that I could reuse a statically defined group (ie the 
> device_attrs within it)
> to create another set of attr-files ?

I won't presume to speak for Greg, but yes I think that works fine too.

It's a reasonable question though.  I wondered about it for a little bit
when I saw that struct attribute_group seems to be missing two const
modifiers, i.e.:

--- linux-2.6.18-rc4-mm1.orig/include/linux/sysfs.h
+++ linux-2.6.18-rc4-mm1/include/linux/sysfs.h
@@ -24,7 +24,7 @@ struct attribute {
 
 struct attribute_group {
 	const char		* name;
-	struct attribute	** attrs;
+	const struct attribute	* const * attrs;
 };
 
But actually compiling a kernel with the above introduces a ton of warnings.
All those I examined could be fixed by adding const to struct attribute
declarations (AFAICT nobody is actually modifying any data through those
pointers), but I haven't looked at them all, and it's late here, blah...

Anyway, Jim if you look at the actual implementation of sysfs_add_group()
it should become apparent that the attribute structures can be shared.

Regards,

-- 
Mark M. Hoffman
mhoffman at lightlink.com



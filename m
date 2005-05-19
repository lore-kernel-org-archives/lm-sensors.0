From: dtor_core@ameritech.net (Dmitry Torokhov)
Date: Thu, 19 May 2005 06:25:57 +0000
Subject: [RFC PATCH 2.6.12-rc3] dynamic driver sysfs callbacks and RFC on
Message-Id: <200505082240.30726.dtor_core@ameritech.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <2538186705042422366584aff4@mail.gmail.com>
In-Reply-To: <2538186705042422366584aff4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Yani,

On Sunday 08 May 2005 21:10, Yani Ioannou wrote:
> Hi Dmitry,
> 
> Even for static attributes the void * can be very useful, there are
> many cases, maybe even most cases (I'm looking through all the sysfs
> attribute code looking to update it to take advantage of this patch
> now) where static attributes using the void * are fine and the
> attribute is not shared amongst different clients/instances of code.
> 
> For example, adm1026 we could use the index for that static attributes
> as my previous patch shows and we really need a macro in that case. Or
> look at net/core/net-sysfs.c, the macros NETDEVICE_SHOW,
> NETDEVICE_ATTR, etc are best replaced by static attributes using a
> single callback function and using the void *, for which we really
> need a macro to set the void *.
> 
> Perhaps declaring seperate macros for this (e.g.
> DEVICE_ATTRIBUTE_DATA, such as I defined in the adm1026 example patch)
> would be more clear?
>

Yes, I see what you mean. But I think what we might need is actually 2
void * pointers, something like "attribute_data" and "instance_data".
Macros would initialize "attribute_data" but not "instance_data". This
way their usage is clearly defined and there hopefully less confusion.

-- 
Dmitry

From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:50 +0000
Subject: seperate mallocs
Message-Id: <20040403205913.0ea3cc06.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <406E5CFB.6030309@penguincomputing.com>
In-Reply-To: <406E5CFB.6030309@penguincomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> >After taking a closer look at the code it seemed obvious that this
> >case just couldn't happen. The negative "kind" case is handled by the
> >"if(kind <= 0)" block right above, and all the other values are
> >handled in the swicth/case block. So why would we try to catch an
> >error that, by construction, cannot happen?
> >  
> Ahh, but that's just it.  "all" the other values are *not* handled in 
> the switch/case block.  The variable "kind" is passed in as an
> argument to the function.  As such, we have *no* control over the
> values it takes.  It is set by the i2c core code that parses the
> force_foo= arguments and sets "kind" as appropriate.  But if we got a
> version mismatch between part of the core and the driver, then perhaps
> kind could be set to a value we don't expect.

I don't get you. The various possible force parameters are defined by
the driver itself, through the line SENSORS_INSMOD_<N> call. There is no
chip-specific code in the core, so there can't be any version mismatch
as you suggest. The SENSORS_INSMOD_<N> call expands to express the
static struct i2c_force_data forces[], which in turns is pointed to by
static struct i2c_address_data addr_data. This is where i2c-core looks
at for how to convert force parameters to the driver's detect function.
Still the definition is part of the driver, so there is no version
mismatch possible.

What would possibly cause trouble is if you later add a new kind of chip
supported by an older driver, and incidentally forget to populate the
switch/case statement for this kind. In this case, I agree that the
default case, which I removed, would have triggered. But I estimate that
the correct solution is not to forget. If we start assuming that we
might have done something wrong at any point in the driver, we will end
up handling possible errors everywhere and the code will be plain
unreadable and unmaintainable.

Note that in most cases, the only thing that will happened in the faulty
case is that the client name would be an empty string, and, in some
cases, that the extra features of this specific chip would be disabled.
Nothing serious. I admit that it's a bit more dangerous for your drivers
because of the complex feature table merging mechanism you use. Not that
I criticize it, it's actually nice and saves code. But it's unusual.

> So better to detect that and bail out, rather than blindly carry on 
> without a "valid" chip type.  The rest of the code is going to make 
> decisions based on the 'data->type' field to which kind is eventually 
> copied, so the behavior of the driver would become "undefined" with
> an erroneous value in that variable.

This mostly applies to your driver only. BTW, I have been doing similar
changes (dropping default case because it couldn't happend) several
times these last weeks, mostly while porting new drivers.

> Defensive programming is never a bad idea.  'default' clauses in a 
> switch are almost always a good idea.

In most cases I would agree. But when it comes to handling errors that
cannot happen (if that's what it is) in kernel code, I don't. Kernel
code is supposed to be kept as simple as possible. Increasing the
driver's size with no benefit and possibly confuse the reader is no
good.

If you can really think of a possible scenario which would trigger the
default case, I'm listening.

Thanks.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

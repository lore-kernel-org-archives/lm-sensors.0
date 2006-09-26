From: jim.cromie@gmail.com (Jim Cromie)
Date: Tue, 26 Sep 2006 14:12:43 +0000
Subject: [lm-sensors] [RFC-patch 3/3] SuperIO locks coordinator - use in
Message-Id: <4519355B.3030801@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <450902B8.6040407@gmail.com>
In-Reply-To: <450902B8.6040407@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

David Hubbard wrote:
> Hi Jim,

hi David :-)
>
> This is a question about the w83627ehf driver, but it's nice and
> general, so I'm looking at the way you did the pc8736x_gpio driver.
> There's this line:
>
> static struct superio* gate;
>
> And the driver uses the global 'gate' to access the Super-I/O. Right
> now in the w83627ehf driver, there are several globals:
>
> /* The actual ISA address is read from Super-I/O configuration space */
> static unsigned short address;
>
> /*
> * Super-I/O constants and functions
> */
>
> static int REG;        /* The register to read/write */
> static int VAL;        /* The value to read/write */
>
those should go away I think, which is good.  The uppercase gives me 
heartburn.

>
> Later on in the file, there's another global:
>
> static struct i2c_driver w83627ehf_driver;
>
>
> Now, I'm not the most knowledgeable one about the I2C subsystem, but I
> believe that w83627ehf_driver is redeclared a little later with this:
>
> static struct i2c_driver w83627ehf_driver = {
>     .driver = {
>         .name    = "w83627ehf",
>     },
>     .attach_adapter    = w83627ehf_detect,
>     .detach_client    = w83627ehf_detach_client,
> };
>
>

I believe the 1st is a forward-decl, its there to make following refs to 
it work.
$ grep -n w83627ehf_driver drivers/hwmon/w83627ehf.c
784:static struct i2c_driver w83627ehf_driver;
816:                        w83627ehf_driver.driver.name)) {
831:    client->driver = &w83627ehf_driver;
904:static struct i2c_driver w83627ehf_driver = {
951:    return i2c_isa_add_driver(&w83627ehf_driver);
956:    i2c_isa_del_driver(&w83627ehf_driver);



> Jean mentioned that it might be a good idea to define .name at
> runtime, depending on whether a w83627ehf or a w83627dhg was detected.
> But the global stays, as part of the driver.
>
> In moving to a driver / device model, it's possible to put a struct
> superio inside struct w83627ehf_data, inside struct device, which is
> part of struct i2c_adapter. (If I understand the I2C structures...if
> not, I think this is on the right track.) While I'm at it, I can put
> unsigned short address in there too. Personally, I'd like to remove
> all the global variables. (But not the struct i2c_driver
> w83627ehf_driver, plus the sensor_device_attribute structs, because
> they are more like constants such as function callbacks.)
>
> So I'm sitting here thinking about it, and it seems it could be done
> that way. There are some parts I haven't worked out yet. Especially
> embedding struct superio inside struct device. Is that valid?
>
No.  struct superio contains the lock itself, which must be shared by all
drivers using that superio-port.  This precludes it being sucked into 
private data.

WRT the placement of the static struct superio *gate,
pc8736x_gpio uses the gate-> during runtime, and therefore in a bunch of 
functions.
In contrast, pc87360 needs the superio port only at initialization 
(__init pc87360_find)
so it has its gate-> as an automatic/stack variable, which is released

Regarding the i2c & hwmon device remodeling, Im in need of an LDD3 re-read,
and a careful read of some of the newer (platform) drivers, vt1211 forex.
I was kinda hoping to watch someone else convert their driver, and learn 
from their
mistakes rather than my own.

With Superio in the mix, my uncertainty goes up; maybe it too should 
formally be
added to platform_driver (or parhaps isa_driver).  Or maybe it should be 
a sub-class
(is that even possible ?)  Jean's been clear that he doesnt have the 
time to review it,
which complicates things a bit since hwmon has many superio users, and 
thus presents
a good context to evaluate superio-locks.

RERO (release early & often) suggests I push it to LKML, or (maybe 
KMentors 1st),
but Im not a great juggler, and Jean wants separate alarms next,
and RERO doesnt say release prematurely :-O
OTOH, the superio-locks API might survive a platform conversion unchanged.


> Hmmm,
> David
>

hth, and thanks,
jimc


From: jim.cromie@gmail.com (Jim Cromie)
Date: Fri, 15 Sep 2006 07:23:23 +0000
Subject: [lm-sensors] [RFC-patch 0/3] SuperIO locks coordinator
Message-Id: <450A54EB.1020305@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4508FF2F.5020504@gmail.com>
In-Reply-To: <4508FF2F.5020504@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

David Hubbard wrote:
> Hi Jim,
Hi Dave,
>
>> Some SuperIO devices implement a pseudo-locking scheme which
>> turns off the port unless an activation-sequence is used 1st.
>> Once a port is 'idled', it will ignore access until it is re-activated
>> by doing a specific sequence of operations.
>>
>> Those sequences vary per-device, and generally would require a callback
>> to accomodate the variations.  This implies that all drivers for a
>> superio device
>> would have to supply the (same) callbacks, with superio-locks 
>> remembering
>> only the 1st (they better all be the same anyway, so this by itself isnt
>> a limitation).
>>
>> w83627ehf.c:
>> static inline void superio_enter(void)
>> {
>>     outb(0x87, REG);
>>     outb(0x87, REG);
>> }
>> static inline void superio_exit(void)
>> {
>>     outb(0x02, REG);
>>     outb(0x02, VAL);
>> }
>>
>> w83627hf.c differs from above !!!
>>
>> static inline void superio_exit(void)
>> {
>>     outb(0xAA, REG);
>> }
>>
>>
>> The problem with these pseudo-locks is they dont really protect anyway;
>> if the sequences are used at all, every driver would have to unlock the
>> chip b4 doing anything else, and (I assume) activating an already 
>> active port will work,
>> allowing one driver to interfere with another.
>>
>> I therefore redefined those functions: superio_enter/exit() now do
>> mutex_lock/unlock() on the reserved mutex.  Perhaps the API should have
>> superio_lock/unlock() instead, and leave superio_enter/exit() for 
>> drivers to 
>> implement themselves if they need/want it.
>
> I'd be happy to see those changes in the w83627ehf driver. I'll apply
> the patches and see if I can get it working on my machine.
>
Thanks ! but (maybe) hold off on that. 

superio-find/get wont work properly for you cuz you've got  a 2-byte devid.
You could set it up to detect based on either byte of the devid, and you 
could
hack in a manual check on the other byte..  Kinda kludgy though.

Ill work up another version of patch 1 that has and uses a superio_inw()
if wanted devid is > 255.  I hope that no superio devices have a 2-byte 
id with msb=0

Im thinking about adding something like this, to simplify superio_find's 
arglist,
and get rid of the >255 cheesiness.  (arguably the width bit is still 
somewhat cheesy)

struct superio_port_probe {
    u16 *cmd_addrs;    /* null terminated */
    u16 *device_ids;    /* null terminated */
    u16 devid_mask;
    u8   width;   /* 0: bytewide, 1: wordwide */
};

BTW, are the idle/activate sequences doc'd in your datasheet ?
I ask this cuz pc87360 has a superio-exit defined (and used), but no 
superio-enter(),
and I couldnt find the idle/activate sequences docd in my datasheet.
With the long history of copy & modify in these drivers, its possible
that some cargo-cult features were inadvertently carried forward,
esp when drivers are written w/o actually having the hardare.

Could you disable your superio-enter(), and see if that breaks the 
functionality ?

> David
>
thanks again,
jimc



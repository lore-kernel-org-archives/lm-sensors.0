From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:25:26 +0000
Subject: Call for 2.9.0
Message-Id: <41B876E0.4000405@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041208224836.7794b56c.khali@linux-fr.org>
In-Reply-To: <20041208224836.7794b56c.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Jean Delvare wrote:

> 
>>2) i2c-virtual and pca954x are checked in but not in the Makefiles,
>>pending i2c-core changes required.
> 
> 
> Strange order, huh?
> 
> 

I thought I did exactly as we discussed on IRC a few weeks ago.
You didn't want i2c-core changes at that time because you were working on 2.9.0.
I said I'd work on the i2c-virtual code received from Brian.
I checked it in to sensors for review and comment.
I thought that's what we agreed to.


>>I can do the core changes before or after 2.9.0. Attached is the i2c-core
>>patch, slimmed down from that received from Brian Kuschak.
>>It's really only two changes:
>> - creating xxx_nolock versions of some calls
>> - working up the bus tree for busy checks, using i2c_virt_parent()
> 
> 
> Irk! How exactly is i2c-core supposed to know i2c_virt_parent when it's
> defined by lm_sensors? How is it even supposed to know about
> CONFIG_I2C_VIRTUAL (and what is CONFIG_I2C_VIRTUAL_MODULE?)? Looks like
> a circular dependency issue to me.
> 

i2c-core needs to include i2c-virtual.h to get the i2c_virt_parent() definition -
but that wasn't in the patch I posted.

> Also, i2c-core should NOT export nolock functions. These functions (much
> like
> __i2c_check_addr) are meant for internal use only (thus the leading
> underscores in the name, which should be used for the new functions as
> well). Locks are implementation details not supposed to be even known by
> the external users.
> 

What Brian discovered is that an i2c bus mux implementation requires a nolock version
of some functions. Think about how the bootstrap works:
	Bus gets added
	Mux chip found
	Sub busses get added (but can't because lock still held - hang)
So that's what the (first half of) i2c-core patch does. Get rid of the leading '__', rename to xxx_nolock,
and export them so that the virtual driver can implement the bootstrap.

It's not a big change. Maybe there's a way to avoid it, though... I don't know.

> 
>>Not sure I like the i2c_virt_parent() hack (see
>>kernel/include/i2c-virtual.h in sensors for the definition) and trying
>>to think of a better way to do it.
> 
> 
> How exactly is it a hack?
> 

Well, it's either a "hack" or "icky". You said "ick" which I can agree with.

> 
>>Anyway, comments on the patch and on the timing (before or after 2.9.0)
>>welcome.
> 
> 
> Definitely after. Doesn't sound correct to me at all, to say the truth.
> It looks like things that would need to belong to the i2c-core were
> added in lm_sensors instead.
> 

It could have gone either place, what's the difference? You were in the middle
of i2c changes so I put it in sensors. Again, I thought this was what
we agreed to - I wouldn't make any i2c changes. We can move i2c-virtual.c to i2c
if you want. pca954x.c can't move because it's a chip driver.


> Could you please summarize the approach that you are following, or point
> me to an up-to-date document covering this if such a document exists? I
> would like to understand how it would be implemented at the i2c-core
> level, what interface it would expose to the other kernel drivers, and
> if possible a real-world use case (an equivalent of i2c-amd756-s4882
> using i2c-virtual would be great, for example.)
> 

Brian's document is checked in doc/busses/i2c-virtual. He also has extensive
comments in i2c-virtual.c and pca954x.c. So that's a start.
I'll try and come up with additional documentation.

Your other questions:
	- the implentation at the i2c-core level is simply the patch I posted yesterday
	- The code in sensors CVS _is_ the equivalent of i2c-amd756-4882. The
	  "real-world use case" is "modprobe i2c-amd756; modprobe i2c-virtual; modprobe pca9556 [params]",
          where pca9556 looks alot like pca954x.

> I'm suspicious about how this approach is better than what I did for the
> S4882 motherboard, which didn't require any change to the i2c-core. As
> I understand it, even with Brian's virtual busses, one would still have
> to write a pseudo bus driver for each specific multiplexing design
> (since such designs cannot be easily guessed and multiplexer chips are
> hard to detect anyway). The only drawback of my approach is that I had
> to export the original bus driver's i2c_adapter structure. Even that
> might be worked around by simply providing a search-adapter-by-id
> function in i2c-core (although with a slight loss of performance.)
> 
> Remember that bus multiplexing is only needed for a very limited number
> of motherboards and a couple proprietary designs. This accounts for a
> very limited total number of users and as such isn't worth breaking
> working concepts or compatibility. I'm sorry to insist but I fear that
> what you (and Brian) are trying to implement would belong to Linux 2.6,
> not 2.4.
> 

Recall from our IRC discussion that you would work on xxxx_4882 and submit the patches,
I would work on Brian's implementation. Don't be 'suspicious' :)

My brief summary is that Brian's implementation separates the generic part
of bus muxing into a bus algorithm driver (i2c-virtual) and puts the chip-specific
part into a combination bus adapter driver and chip driver (pca954x).
This parallels i2c-algo-bit and the numerous big-banging bus adapters,
and fits well into our architecture.

The code I got from Brian was for 2.4. So that's where I put it.
Not sure what you are "insisting" - what's wrong with getting it working
on 2.4 first before porting to 2.6?

Anyway, happy to discuss further on IRC if you like, let me know.
mds




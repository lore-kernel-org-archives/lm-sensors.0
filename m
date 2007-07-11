From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Wed, 11 Jul 2007 05:23:39 +0000
Subject: Re: [lm-sensors] [PATCH] First cut of a adt7470 driver
Message-Id: <4694695B.3070300@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070706211144.GI3435@tree.beaverton.ibm.com>
In-Reply-To: <20070706211144.GI3435@tree.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Darrick J. Wong wrote:
> On Sat, Jul 07, 2007 at 10:21:57AM +0200, Hans de Goede wrote:
> 
>> Why all the base defines? Why not put the base address directly in the () 
>> macros? You do not seem to use them anywhere else.
> 
> I prefer to put all the register and bit-field definitions in one place
> so that later I can construct a map of all known registers after I've
> forgotten which ones the driver talks to and which ones it doesn't.  The
> accessor macros that come after that are merely sugar, which is why I
> don't like encoding the base register address directly into the macro.
> 

Ok, leave them in then.

>> Are you sure you only want to support revision 2? What are the differences? 
>> Shouldn't the driver be able to support other revisions too? Maybe only 
>> print a warning when its used with an untested revision?
> 
> I don't have a data sheet for other revisions, so the safest thing to do is
> to reject that which we don't know about; an interested user can always
> bypass those safety checks with force_adt7470= at a later point in time
> and post a patch if the driver still works ok.
> 

Good point about using the force parameter, ok.

>> Why use read_byte twice in read16, but write_word in write16?
> 
> A "16 bit" register is really two 8 bit register reads/writes, and the
> register with the lower address has to be read/written first.  Hence the
> weird helper functions.
> 




>>> +		/* delay is 200ms * number of tmp05 sensors */
>>> +		udelay(TEMP_COLLECTION_TIME);
>> ugh, sleep here please.
> 
> Would msleep_interruptible() work here?  Some informal testing shows
> that it seems to work ok, though I've not subjected it to a rigorous ^C
> test to see if I can hit weird crash conditions.
> 

Well msleep_interruptible() can be interrupted (you check the return value for 
this) so if a user presses control-C, then your sleep will be cut short. So 
either you must be prepared to handle this, or sleep uninterruptible. I would 
sleep uninterruptible if I were you, using regular msleep.


Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

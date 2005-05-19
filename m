From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:58 +0000
Subject: Dead code in i2c
Message-Id: <3EDC018D.7010106@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3EDAEE68.9010407@penguincomputing.com>
In-Reply-To: <3EDAEE68.9010407@penguincomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

What Kyosti did is remove the command functions (so now the function pointer is NULL)
but add the i2c_client_command() call that checks for a NULL pointer before
it calls *command(). So it leaves the capability of commands there without
forcing each driver to have a command call that simply returns.
So it was a cleanup that left the capability there.

Philip Pokorny wrote:
> Ahh, but didn't Kyosti or Greg delete all the command functions from all 
> the chip driver modules?
> 
> I think that all the drivers had "command" functions that said "None at 
> this time", but removing that code was one of the things I had to do to 
> make my 2.7.0 driver "cvs"...  So I don't think any of drivers even have 
> a command function any more.
> 
> Which is not an argument for removing the function to access them, but 
> it seems odd that it would be an inline function in that case...
> 
> :v)
> 
> Mark D. Studebaker wrote:
> 
>> This was not in 2.7.0.
>> Kyosti put it in before the branch so it's in both branches.
>> Nothing in our trees use the driver->command function but it may be 
>> worthwhile in
>> the future. Adding an inline function to make it more accessible is 
>> fine too.
>> How about just adding #include <linux/errno.h> to i2c.h?
>>
>> Philip Pokorny wrote:
>>
>>> I'm trying to compile i2c-cvs on a Red Hat beta kernel.
>>>
>>> I'm getting an error due to EINVAL not being defined.  But the 
>>> reference to EINVAL is in a function that apears to be dead code.  
>>> The function is not referenced in any other i2c or lm_sensors files...
>>>
>>> The following patch removes the offending function...
>>>
>>> Index: kernel/i2c.h
>>> =================================>>> RCS file: /home/cvs/i2c/kernel/i2c.h,v
>>> retrieving revision 1.68
>>> diff -u -r1.68 i2c.h
>>> --- kernel/i2c.h    21 Jan 2003 08:08:16 -0000    1.68
>>> +++ kernel/i2c.h    2 Jun 2003 06:21:27 -0000
>>> @@ -318,15 +318,6 @@
>>>          struct i2c_client_address_data *address_data,
>>>          i2c_client_found_addr_proc *found_proc);
>>>
>>> -static inline int i2c_client_command(struct i2c_client *client,
>>> -                  unsigned int cmd, void *arg)
>>> -{
>>> - if (client->driver && client->driver->command)
>>> -     return client->driver->command(client, cmd, arg);
>>> - else
>>> -     return -EINVAL;
>>> -}
>>> -
>>>  /* An ioctl like call to set div. parameters of the adapter.
>>>   */
>>>  extern int i2c_control(struct i2c_client *,unsigned int, unsigned 
>>> long);
>>>
>>
> 
> 
> 

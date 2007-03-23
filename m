From: j.w.r.degoede@hhs.nl (Hans de Goede)
Date: Fri, 23 Mar 2007 09:06:10 +0000
Subject: [lm-sensors] Sensors-detect with DMI detection
Message-Id: <46039882.4060002@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <00c901c7568f$60a3ad40$0801a8c0@pinkeltje>
In-Reply-To: <00c901c7568f$60a3ad40$0801a8c0@pinkeltje>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Ivo,
> 
> On Thu, 22 Mar 2007 11:09:14 +0100, Ivo Manca wrote:
>> Just a quick question (again ;)). Is it necesary for us to even think about 
>> supporting the 2.4 kernels?
>> I'm asking this, because if our addition doesn't get included before 
>> libsensors 3.x, it seems like we only get to work with 2.6, isn't it?
> 
> Side note: we are already at libsensors 3.x (unfortunately.) What you
> refer to is lm-sensors 3.x, for which the libsensors version will be
> 4.x. Actually I think we should jump to lm-sensors 4.x directly to sync
> the lib version with the package version again - but Mark seems to like
> lm-sensors 3.x.
> 
>> If that is so, we can drop a table in our database. This is because we want 
>> to add the kernel versions a configuration is working for. The easiest way 
>> to implement this, is to just modify the minimum kernel version for that 
>> configuration. If there's no support for 2.4, we can just add a field with 
>> the minimum working 2.6 kernel verson, like 2.6.10. Else, we must also 
>> register the minimum 2.4 version, either as a field, or with a 
>> table/relationship.
>>
>> Just wondering :)
> 
> We don't really care about 2.4 anymore. If you can support it for free,
> alright. If it has a cost, just don't do it.
> 
> One thing which you will have to handle though are the syntax changes
> to sensors.conf. Two things are going to happen in a (more or less)
> near future:
> 
> * Mark Hoffman will add support for the "include" statement. Obviously,
> the user will need libsensors 4.x if they download a configuration file
> which uses such a statement. OTOH, I can't see any reason why an
> include statement would be used in the configuration files for
> motherboards, so maybe all you have to do is strip any include
> statement before storing the configuration file in the database.
> 
> * Once the library discovers the device features autmatically,
> sensors.conf will have to use the standard feature names, instead of
> the custom ones. This means we'll have to fork sensors.conf.eg into an
> old-style version and a new-style version. The configuration files
> stored in your database will have the same problem - they will work
> with either the old library, or the new one, but not both.
> 
> Note that it should be possible to translate old-style configuration
> files to the new style automatically, using the same translation
> rules which are used by libsensors today. A perl script would do. The
> other way around is much more difficult, though, as you would need to
> write an extensive reverse mapping table for every supported chip.
> 

Wouldn't it be wise to target only 3.x / 4.x with the dmi-detect code, and thus 
assume dynamic chip support and the new syntax? I haven't been doing much 
lm-sensors related work myself lately, but I can make some time free to get the 
dyn chip support into the 3.0 branch asap, if that helps the dmi detect code to 
become future proof. I think only support 3.x / 4.x is easiest / best otherwise 
the code becomes convoluted with compatibility muck from the day it was written.

Regards,

Hans





From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:52 +0000
Subject: sysfs support in lm_sensors
Message-Id: <3E937EC3.3030502@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E8B7D42.4030300@penguincomputing.com>
In-Reply-To: <3E8B7D42.4030300@penguincomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greg,
Thank you very much for starting from my /proc document and
for posting the sensors-sysfs document for comments.
Do you have an updated version to send out?
I see you posted it on 3/27 but got a lot of comments after that.
I would like to comment but seems like I should start from the latest.
thanks
mds

Philip Pokorny wrote:
> Greg KH wrote:
> 
>> On Sun, Mar 30, 2003 at 02:47:24PM +0200, Martin Schlemmer wrote:
>>
>>> This should have a working w83781d driver updated for 2.5.66-bk4.
>>> Currently sysfs support is working, and are according to the spec
>>> (sensors-sysfs) in the 'lm sensors sysfs file structure' thread.
>>> Thus I used 'temp_input[1-3]', as there was not final decision
>>> on having them temp_input[0-2] as well, for example.
> 
> 
> Hey...
> 
> Just thinking, about this some more.
> 
> Can you still use sysctl() against sysfs values, or is that also 
> deprecated?  Could a sysctl call return the value and magnitude where 
> the proc/sysfs interface did a decimal point conversion of the value?
> 
> What are your thoughts on creating *directories* for each sensor and 
> putting the multiple values associated with that sensor in the 
> sub-directory.
> 
> Thus, instead of in0, in0_max (or in_max0), etc. we would have 
> in0/current, in0/max, in0/min, in0/offset.
> 
> My thoughts are
> * This keeps the directory size a little more compact
> * Common helper functions used to create the subdirectory contents
> * Organization of the entries match the libsensors "related" field.
> * Different parameters (min vs current) could have different scaling
> * Filename wildcards and entry sorting are better.
> 
> I think floating point is the best solution to the fractional values 
> that lm_sensors deals in.  These values aren't integers.  And we can try 
> and standardize on milli-volts and milli-degC, but for many  sensors, 
> that's unnecessary and wastes range, and what about the values that 
> *are* integers.  How do you distinguish between them and these scaled 
> values?  The decimal point solves this and releases the requirement that 
> all values be expressed in milli-somethings.
> 
> Further, if we restrict ourselves to scaling magnitudes that are greater 
> than or equal to 1, I think the conversions in and out of lm_sensors to 
> sysfs could be made simpler.  But much of the code in i2c_*real is 
> dealing with the multiple values that can be found.  With sysfs, we're 
> only allowed one value so these conversion functions would be much simpler.
> 
> :v)
> 

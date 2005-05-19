From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:59 +0000
Subject: Call for 2.8.0 soon
Message-Id: <3EE92866.1040704@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3EE7C67A.4040703@paradyne.com>
In-Reply-To: <3EE7C67A.4040703@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

One reason not to have the version numbers track is that we should
advance the major number of the library when there is an incompatibility introduced
within the library.

We generally advance the middle number of the sensors and i2c packages when there
is support removed for a certain kernel version.

In other words the guidelines for the two numbering systems are independent.

Philip Pokorny wrote:
> Jean Delvare wrote:
> 
>>>> - libsensors numbering because of binary incompatibility..... go to 
>>>> 1.5.0 or 2.0.0?
>>>
>>>
>>> What about going with 2.8.0...  Then track the lm_sensors version.
>>
>>
>>
>> Why that? There is no reason we number the lib version according to the
>> package version. The lib compatibility is unlikely to change that often.
> 
> 
> Actually, it is.
> 
> Anytime a driver is added to the library, the library version needs to 
> change.  This is because the library has compiled in code for every chip 
> that it knows about.  And the sensors executable has references to every 
> chip that is supported by the matching libsensors.
> 
> I think the chances are high that at each release of lm_sensors, at 
> least one new driver will be added...
> 
> This is also part of my motivation for trying to remove this coupling in 
>  the "rewrite" of libsensors...
> 
> :v)
> 

From: Hans de Goede <j.w.r.degoede@hhs.nl>
Date: Sat, 14 Jul 2007 20:17:34 +0000
Subject: Re: [lm-sensors] [PATCH] First cut of a adt7470 driver
Message-Id: <46992F5E.5030002@hhs.nl>
List-Id: <lm-sensors.vger.kernel.org>
References: <20070706211144.GI3435@tree.beaverton.ibm.com>
In-Reply-To: <20070706211144.GI3435@tree.beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> Hi Hans,
> 
> On Fri, 13 Jul 2007 14:08:53 +0200, Hans de Goede wrote:
>> Notice that I use simple_strtoul, so val will never be < 0, if you write -4096 
>> strtoul will not recognize the - and return 0.
>>
>> I know it looks strange to store the return value in an int then, but in some 
>> of the other store methods I need val to be signed, and for consistency I've 
>> thus stored it into an int everywhere.
> 
> But wouldn't then a large input value (fitting in a long but not in an
> int) be silently turned into a negative value, possibly doing crazy
> things in the rest of the code?
> 

Yes,

That could happen, but then people are _really_ asking for it. Notice that most 
hwmon drivers store functions do even less checking then this. We really need 
to discuss this and make a decision on it for all hwmon drivers, starting with 
the question wether or not to check if the user input actually is a number?

Currently a user can do:
echo -n foo > /sys/class/hwmon/hwmon0/in0_max
and not get an error (instead in0_max typically gets set to 0

Regards,

Hans

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

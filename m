From: phil@netroedge.com (Philip Edelbrock)
Date: Thu, 19 May 2005 06:23:43 +0000
Subject: 2.7.0 testings
Message-Id: <3DEE5FED.6090205@netroedge.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20021127213903.5b84866d.khali@linux-fr.org>
In-Reply-To: <20021127213903.5b84866d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


I'm a little confused about the reference to the running kernel?  In any 
case, just a quick comment which may or may not conflict with what is 
being discussed:

The kernel which the system happens to be running at the time we are 
building lm-sensors is completely unrelated to what we are building 
/against/ (or where we should install the resulting modules), right?


Phil

Jean Delvare wrote:

>>I see. Well, MODPREF controls where the modules get installed.
>>That should be the same as the kernel that we compiled against,
>>which is the one defined in LINUX:= .
>>So don't you think MODPREF should do the "-L" thing?
>>But I don't know what happens if we default to /usr/src/linux...
>>    
>>
>
>If we default to /usr/src/linux, it means that we don't use the release
>of the currently running version of Linux. So, KERNELVERSION is useless.
>The only way we have to know where the modules should be installed is to
>look in /usr/src/linux and see where this kernel has installed its
>modules. This is exactly what is done right now.
>
>If we didn't default to /usr/src/linux, it means that we know where to
>install the modules, and we could use KERNELVERSION. But, on the other
>hand, we built LINUX from KERNELVERSION (through the build symlink), so
>the method above will also work.
>
>I don't see the point in creating a complex expression that does
>different things for these two cases when the first one will work for
>both (and has obviously proven to work well for years).
>
>  
>

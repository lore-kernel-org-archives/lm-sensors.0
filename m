From: mds@paradyne.com (Mark Studebaker)
Date: Thu, 19 May 2005 06:23:45 +0000
Subject: remove 2.2 support?
Message-Id: <3E1F8579.4070205@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <3E0E709B.5000900@paradyne.com>
In-Reply-To: <3E0E709B.5000900@paradyne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Due to the recent discussions re: kernel 2.5.54, and
the lack of any critical problems with 2.7.0,
I declare the two weeks over in record time :)

If you intend to do any of the 2.4 cleanup you may wish
to let people know.

I'll start by backporting the drivers from 2.5.54 back to CVS.

Remember, don't do any refcount changes yet as that will break
2.4 compatibility.

Mark Studebaker wrote:
> OK, it's unanimous.
> 
> Let's wait until mid-January to see if any critical problems appear in
> 2.7.0 (it appears that the sensors segfaults are caused by old libraries
> in /usr/lib, I put a note on the home page, we'll see... there may be a
> libc 2.3 problem as well, not sure yet).
> 
> In about 2 weeks I'll send out another message, and then
> we can remove the 2.2 support, and the next release will be 2.8.0.
> 
> Jean Delvare wrote:
> 
>>> (...)  I'm trying
>>> to imagine why people might be using 2.2.x kernels still (...)
>>
>>
>>
>> I'm still using some, guess for what? Testing lm_sensors before release
>> ;))
>>
> 

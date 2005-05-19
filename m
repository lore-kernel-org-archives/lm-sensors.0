From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:24:15 +0000
Subject: ASUS P4C800 Deluxe - W83627THF
Message-Id: <3F523671.1050706@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <1062239759.1074.30.camel@hansi>
In-Reply-To: <1062239759.1074.30.camel@hansi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thanks.
I took your patch as a starting point and then fixed things up some more.
The THF datasheet wasn't available last time I looked but I have it now and
that helped a lot as well.

Johann Glaser wrote:
> Hi!
> 
> 
>>As you saw, we've already added support for the ICH5 in 2.8.0.
>>The w83627hf driver supports the thf as well, and we would
>>rather enhance the support there than in w83781d.c, which is hopelessly cluttered.
>>If you can give us a patch against CVS for that driver that would be most helpful.
> 
> 
> I made a patch agains the current 2.8.0 sources downloaded from the
> homepage.
> 
> Bye
>   Hansi
> 
> 

From: Karl Schmidt <karl@xtronics.com>
Date: Sun, 06 Sep 2009 18:05:58 +0000
Subject: Re: [lm-sensors] Creating alarm for fans
Message-Id: <4AA3FA06.3070602@xtronics.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A9823A2.2010907@xtronics.com>
In-Reply-To: <4A9823A2.2010907@xtronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
> On Sat, 05 Sep 2009 17:13:01 -0500, Karl Schmidt wrote:
>> Jean Delvare wrote:
>>
>>> You forgot to rmmod dme1737 beforehand, which makes the output
>>> uninteresting.
>> once again attached
> 
> As you can see it never suggests loading the lm85 driver. So I don't
> know where this line came from in your /etc/modules file. A legacy from
> a previous installation maybe?
> 

Yes - from 2005 - used to work with that kludge - no longer needed - but that isn't the source of 
the problem.

--------------------------------------------------------------------------------
Karl Schmidt                                  EMail Karl@xtronics.com
Transtronics, Inc.                              WEB http://xtronics.com
3209 West 9th Street                             Ph (785) 841-3089
Lawrence, KS 66049                              FAX (785) 841-0434

42.7% of all statistics are made up on the spot.

--------------------------------------------------------------------------------

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

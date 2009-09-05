From: Karl Schmidt <karl@xtronics.com>
Date: Sat, 05 Sep 2009 19:16:15 +0000
Subject: Re: [lm-sensors] Creating alarm for fans
Message-Id: <4AA2B8FF.3090909@xtronics.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4A9823A2.2010907@xtronics.com>
In-Reply-To: <4A9823A2.2010907@xtronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Jean Delvare wrote:
>> This is a Tyan S2865


I figured you would want a new listing of this:


> #i2cdump 1 0x2e
> No size specified (using byte-data access)
> Error: Could not open file `/dev/i2c-1' or `/dev/i2c/1': No such file or directory



oops?? Not what I expected.

When this is all over - I will document it up and have a sensors3.conf file to share. Is there a web 
site for sharing these? (I will also send a copy to Tyan).

Really appreciate your help. Let me know if you need anything -




--------------------------------------------------------------------------------
Karl Schmidt                                  EMail Karl@xtronics.com
Transtronics, Inc.                              WEB http://xtronics.com
3209 West 9th Street                             Ph (785) 841-3089
Lawrence, KS 66049                              FAX (785) 841-0434

Man is the only animal that blushes - or needs to. -- Mark Twain

--------------------------------------------------------------------------------


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors

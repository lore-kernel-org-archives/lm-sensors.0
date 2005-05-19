From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:23:55 +0000
Subject: [CVS PATCH] Sync cvs tree with latest 2.5 bk tree
Message-Id: <3EAB6EDA.1030401@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20030425183641.GB2257@kroah.com>
In-Reply-To: <20030425183641.GB2257@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I'd personally like to see my lm85 patch make it into 2.7.x...

Also, I've recently compiled i2c on a 64-bit Opteron and there are several 
type conversion issues that are not 64-bit clean.  I looked into it a little 
bit and the conversions seemed wrong even in a 32-bit environment (ints to void *)

If you haven't already encountered these problems, then I'll work up a patch 
and post it.

:v)

Jean Delvare wrote:

>>Namely, do we do another 2.4-compatible release.
>>I'm in favor of at least one more, because I would like to
>>clear up some problems in 2.7.0. The problems are really on the i2c
>>side though.
>>
> 
> I'm clearly in favor of one more, too. I've been telling people far too
> many times to try previous versions of LM Sensors because 2.7.0 wasn't
> working for them... (Though it did not always worked then). Having one
> "clear" release would be great.



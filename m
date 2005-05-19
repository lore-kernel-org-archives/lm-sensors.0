From: ppokorny@penguincomputing.com (Philip Pokorny)
Date: Thu, 19 May 2005 06:24:40 +0000
Subject: sysfs names
Message-Id: <40232889.3010407@penguincomputing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040126230447.09700886.khali@linux-fr.org>
In-Reply-To: <20040126230447.09700886.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Greg KH wrote:

>>I know this is quite an important change, but precisely, we'd better
>>change before porting the missing 30 chip drivers than after. I know how
>>much work it will be - especially since I'll obviously be the one to
>>cope with it - still I think we should do it.
>>
>>Comments, thunder and rocks welcome ;)
>>Thanks.
>>
>>NB: May I know the name of the brilliant chooser of the new naming
>>scheme? Not to blame him/her (oh well... ;)) but to know the reasons of
>>his/her choice.
>>    
>>
>
>That would be me.  See the archives for what I propsed, and why I did
>it.  Of course I can't remember what I said back then, and no one seemed
>to disagree...
>  
>
I think I did.

I believe that Jean is proposing switching from:

  temp_max1
  temp_min1
  temp1

to

   temp1_max
   temp1_min
   temp1

So there still won't be multiple values in one "file", but the filenames 
will sort naturally into groupings similar to the way they were before.

:v)


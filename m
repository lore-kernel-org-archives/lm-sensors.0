From: grant_lkml@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:56 +0000
Subject: [RFC PATCH 2.6.12-rc3] dynamic driver sysfs callbacks and RFC on
Message-Id: <ad6j71hs5fscnnug2s3vnm42q6u9sjhe7k@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <2538186705042422366584aff4@mail.gmail.com>
In-Reply-To: <2538186705042422366584aff4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Yani,
On Wed, 4 May 2005 23:29:47 -0400, Yani Ioannou <yani.ioannou@gmail.com> wrote:

>                                      It was decided presenting the
>specific information per file was a much simpler and more sensible
>interface. I tend to agree.
Okay, I see that.  also did a 'cat <eeprom>' oops, pipe through xxd 
'cos it returned binary data :)  

>> Secondly is there a design document I've missed for this?  What does
>> dynamic sysfs look like to user?  sub-directory per device/block or
>> in the same directory level namespace?  I damaged the patches somewhere,
>> one didn't apply so couldn't 'see' it yet.
>
>This patch just changes the way device attributes are created, it does
>not change the external sysfs interface at all.
Okay

<snip>
Okay, I'm an interested observer then, 'cos I make cross-reference 
script to see which driver uses what sysfs name, still learning.

Thanks,
--Grant.

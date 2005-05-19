From: grant_nospam@dodo.com.au (Grant Coady)
Date: Thu, 19 May 2005 06:25:44 +0000
Subject: PATCH RFC fix adm1025 vid reporting
Message-Id: <rb7o3110echbj7aidbpqd9jskcvjho837v@4ax.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <6a3o319k8q774n0dgmj2q98u18rum7t2hs@4ax.com>
In-Reply-To: <6a3o319k8q774n0dgmj2q98u18rum7t2hs@4ax.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 19 Mar 2005 13:15:06 +0100, Jean Delvare <khali@linux-fr.org> wrote:
. . 
>I like it much. Especially keeping the old file in place is very smart.
Been reading lkml since redhat 6.x era, osmosis? :)
>
>> My query is do we need to give notification of feature change 
>> or removal as some other kernel sections are doing?  Trying to 
>> tread very gently...
>
>I don't think we have to. Here you are simply fixing an interface which
>was not following the standard. You are not changing a standard.
>
>> Compile tested, patch tested, but no run test :(  
>
>The patch is quite simple, looks all OK to me.
>
>Could you please provide a patch to libsensors, such that cpu0_vid will
                                     ^^^^^^^^^^
Now I'm lost, I keep hoping I'll pick what that is from context. :(

>be accessed instead of in1_ref for the adm1025/ne1619 chips? We might
>not apply it immediately so as to not break compatibility, but at least
>let's have it ready.
>
>As a side note, I noticed that the adm9240 support in libsensors uses
>in1_ref as well. Since your driver obviously won't use it, but cpu0_vid
>instead, this should be fixed as well (and without a delay).

Just aim me at the file :)  Another day, just gone midnight here.

Cheers,
Grant.

From: sylvain@gomjabbar.ath.cx (Sylvain Jeaugey)
Date: Mon, 15 May 2006 18:37:33 +0000
Subject: [lm-sensors] W83627EHF driver enhancements
Message-Id: <Pine.LNX.4.62.0605152033570.6485@gomjabbar>
List-Id: <lm-sensors.vger.kernel.org>
References: <442ED616.4070109@sh.cvut.cz>
In-Reply-To: <442ED616.4070109@sh.cvut.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

@Rudolf & Jean : 2.6.17-rc4 did the job. Thanks guys !

@David : the w83627ehf.c file you sent seems to be working fine (ASUS 
P5S800-VM here) and there are in[0-10]_{input,min,max} in /sys, which seem 
to show good results.
I didn't upgrade userland tools yet, so I can't show you the result in 
sensors.

Sylvain

On Mon, 15 May 2006, Jean Delvare wrote:

>> Trying to build against 2.6.16.16, I ran into undefined references to
>> SENSOR_ATTR arrays. After a quick search it looks like it was introduced
>> little time ago.
>>
>> Do I need to upgrade to 2.6.17-rc4 or is there another separate patch to
>> apply ?
>
> That would be this patch:
> http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff_plain;hBd3b83fecb7b576d477244347982baa02fa4f44
>
> Now I can't promise that it'll be enough.
>
> -- 
> Jean Delvare
>

